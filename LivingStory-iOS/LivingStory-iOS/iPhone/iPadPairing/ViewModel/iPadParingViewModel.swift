//
//  iPadParingViewModel.swift
//  LivingStory-iOS
//
//  Created by Demian Yoo on 7/17/25.
//

import SwiftUI
import Combine

final class iPadPairingViewModel: ObservableObject {
    
    private let multipeerManager: MultipeerManager
    private var iPadCancellables = Set<AnyCancellable>()
    private var wasConnectedBefore = false
    
    @Published var isAdvertising = false
    @Published var isConnected = false
    @Published var showConnectedAlert = false
    @Published var book: BookType?
    @Published var selectedBookType: FairyTaleID?
    @Published var isFairyTaleViewShown = false  // ✅ 추가
    
    init(multipeerManager: MultipeerManager) {
        self.multipeerManager = multipeerManager
        self.setupConnectionObserver()
        self.setupBookTypeObserver()
    }
    
    // iPad를 의미
    var connectedDevice: PeerDevice? {
        multipeerManager.connectedDevices.first
    }
    
    func bookCoverImageString(book:BookType) -> String {
        switch book {
        case .pig: return "PigCover"
        case .oz: return "OzCover"
        case .heung: return "HeungCover"
        }
    }
    
    var receivedBookCoverImageString: String {
        switch selectedBookType {
        case .pig: return "PigCover"
        case .oz: return "OzCover"
        case .heung: return "HeungCover"
        case .none: return "PigCover" // 기본값
        }
    }
    
    var connectedDeviceName: String {
        if let device = connectedDevice {
            return device.mcPeerID.displayName
        } else {
            return "연결된 기기 없음"
        }
    }
    // 책 타입 관찰
    private func setupBookTypeObserver() {
        multipeerManager.$selectedBookType
            .receive(on: DispatchQueue.main)
            .sink { [weak self] bookType in
                self?.selectedBookType = bookType
                print("📚 iPhone에서 받은 책 타입: \(bookType?.rawValue ?? "없음")")
            }
            .store(in: &iPadCancellables)
    }
    
    private func setupConnectionObserver() {
        multipeerManager.$connectedDevices
            .receive(on: DispatchQueue.main)
            .sink { [weak self] devices in
                guard let self = self else { return }
                
                // 현재 iPhone이 연결된 기기 목록에 있는지 확인
                let isCurrentlyConnected = !devices.isEmpty
                
                // ✅ 연결 상태가 변했을 때만 처리
                if !self.wasConnectedBefore && isCurrentlyConnected {
                    // 처음 연결된 경우에만 Alert 표시
                    print("🎉 [\(self.multipeerManager.session.myPeerID.displayName)] 새로 연결됨 - Alert 표시")
                    self.showConnectedAlert = true
                } else if self.wasConnectedBefore && !isCurrentlyConnected {
                    // 연결 해제된 경우
                    print("❌ [\(self.multipeerManager.session.myPeerID.displayName)] 연결 해제됨")
                }
                
                // 연결되면 광고 중단
                if isCurrentlyConnected {
                    self.isAdvertising = false
                }
                
                // 상태 업데이트
                self.isConnected = isCurrentlyConnected
                self.wasConnectedBefore = isCurrentlyConnected
            }
            .store(in: &iPadCancellables)
        
        // connectionState 관찰에서는 advertising만 처리
        multipeerManager.$connectionState
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                switch state {
                case .advertising:
                    self?.isAdvertising = true
                case .disconnected:
                    self?.isAdvertising = false
                case .connected:
                    self?.isAdvertising = false
                default:
                    break
                }
            }
            .store(in: &iPadCancellables)
    }
    
    private func logConnectedDevice() {
        if let device = connectedDevice {
            print("🎉 iPad와 연결 완료!")
            print("📱 연결된 디바이스: \(device.mcPeerID.displayName)")
            print("🔗 연결 상태: \(multipeerManager.connectionState.message)")
        }
    }
    
    func handleConnectionButtonAction() {
        if isConnected {
            // 연결 취소 자신만 연결 해제
            disconnect()
        } else if isAdvertising {
            // 연결중 advertising
            stopAdvertising()
        } else {
            startAdvertising()
        }
    }
    
    private func startAdvertising() {
        print("iPhone에서 iPad 광고 시작")
        multipeerManager.startAdvertising()
    }
    
    private func stopAdvertising() {
        print("iPhone에서 iPad 광고 중단")
        multipeerManager.iPhoneDisconnectSelf()
    }
    
    private func disconnect() {
        print("iPhone 연결 해제")
        multipeerManager.iPhoneDisconnectSelf()
    }
    
    func dismissConnectAlert() {
        showConnectedAlert = false
    }
    
    @MainActor
    func goToFairyTaleView(coordinator: AppCoordinator, bookType: FairyTaleID) {
        // ViewModel 상태만 체크 (더 간단하고 안전)
        // 즉시 상태 체크 및 업데이트
        if isFairyTaleViewShown {
            print("📱 이미 동화 인터랙션 화면이 표시 중입니다")
            return
        }
        
        // 상태를 먼저 업데이트 (동시 호출 방지)
        isFairyTaleViewShown = true
        print("📱 상태 업데이트: isFairyTaleViewShown = true")
        
        coordinator.push(.iPhoneFairyTale(bookType: bookType))
        print("📱 동화 인터랙션 화면으로 이동: \(bookType.rawValue)")
    }
    
}
