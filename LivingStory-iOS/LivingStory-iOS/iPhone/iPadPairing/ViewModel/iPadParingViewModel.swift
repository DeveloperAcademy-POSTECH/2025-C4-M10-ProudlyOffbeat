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
    
    init(multipeerManager: MultipeerManager) {
        self.multipeerManager = multipeerManager
        self.setupConnectionObserver()
    }
    
    // iPad를 의미
    var connectedDevice: PeerDevice? {
        multipeerManager.connectedDevices.first
    }
    
    
    var connectedDeviceName: String {
        if let device = connectedDevice {
            return device.mcPeerID.displayName
        } else {
            return "연결된 기기 없음"
        }
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
                
                // 상태 업데이트
                self.isConnected = isCurrentlyConnected
                self.wasConnectedBefore = isCurrentlyConnected
            }
            .store(in: &iPadCancellables)
        
        // ✅ connectionState 관찰에서는 advertising만 처리
        multipeerManager.$connectionState
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                switch state {
                case .advertising:
                    self?.isAdvertising = true
                    self?.isConnected = false
                case .disconnected:
                    self?.isAdvertising = false
                    // isConnected는 connectedDevices에서 처리
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
    
}
