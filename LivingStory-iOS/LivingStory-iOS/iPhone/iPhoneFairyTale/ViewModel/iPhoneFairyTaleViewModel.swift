//
//  iPhoneFairyTaleViewModel.swift
//  LivingStory-iOS
//
//  Created by 문창재 on 7/27/25.
//

import Foundation
import Combine


final class iPhoneFairyTaleViewModel: ObservableObject{
    
    private let multipeerManager: MultipeerManager
    internal let bookType: FairyTaleID
    private var cancellables = Set<AnyCancellable>()
    
    init(multipeerManager: MultipeerManager, bookType: FairyTaleID) {
        self.multipeerManager = multipeerManager
        self.bookType = bookType
        setupDisconnectObserver()
    }
    // ✅ 연결 끊김 감지
    private func setupDisconnectObserver() {
        multipeerManager.$connectedDevices
            .receive(on: DispatchQueue.main)
            .sink { [weak self] devices in
                if devices.isEmpty {
                    // 연결이 끊어졌을 때
                    print("�� 연결이 끊어져서 홈으로 이동")
                    // coordinator가 필요하므로 Notification으로 처리
                    NotificationCenter.default.post(name: .goToIPhoneRoot, object: nil)
                }
            }
            .store(in: &cancellables)
    }
    
    func sendLanternInteractionCompleted() {
        let message = "\(bookType.rawValue)::\(FairyInteractionSignal.done.rawValue)"
        guard let data = message.data(using: .utf8) else { return }
        do {
            try multipeerManager.session.send(data, toPeers: multipeerManager.session.connectedPeers, with: .reliable)
            print("�� iPhone → iPad 인터랙션 완료 메시지 전송: \(message)")
            
            // ✅ 인터랙션 완료 후 홈으로 이동
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {  // 1초 후 이동
                NotificationCenter.default.post(name: .goToIPhoneRoot, object: nil)
            }
        } catch {
            print("❌ iPhone → iPad 인터랙션 완료 메시지 전송 실패: \(error)")
        }
    }
}
