//
//  iPhoneFairyTaleViewModel.swift
//  LivingStory-iOS
//
//  Created by 문창재 on 7/27/25.
//

import Foundation


final class iPhoneFairyTaleViewModel: ObservableObject{
    
    private let multipeerManager: MultipeerManager
    private let bookType: FairyTaleID
    
    init(multipeerManager: MultipeerManager, bookType: FairyTaleID) {
        self.multipeerManager = multipeerManager
        self.bookType = bookType
    }
    
    func sendLanternInteractionCompleted() {
        let message = "\(bookType.rawValue)::\(FairyInteractionSignal.done.rawValue)"
        guard let data = message.data(using: .utf8) else { return }
        do {
            try multipeerManager.session.send(data, toPeers: multipeerManager.session.connectedPeers, with: .reliable)
            print("📱 iPhone → iPad 인터랙션 완료 메시지 전송: \(message)")
        } catch {
            print("❌ iPhone → iPad 인터랙션 완료 메시지 전송 실패: \(error)")
        }
    }
    
}
