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
    private var cancellables = Set<AnyCancellable>()
    
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
        multipeerManager.$connectionState
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                switch state {
                case .connected:
                    self?.isConnected = true
                    self?.isAdvertising = false
                    // 로그출력
                    self?.logConnectedDevice()
                    self?.showConnectedAlert = true
                case .advertising:
                    self?.isAdvertising = true
                    self?.isConnected = false
                case .disconnected:
                    self?.isConnected = false
                    self?.isAdvertising = false
                    print("[iPhone \(UIDevice.current.name)] iPad와의 연결이 끊어졌습니다.")
                default:
                    break
                }
            }
            .store(in: &cancellables)
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
