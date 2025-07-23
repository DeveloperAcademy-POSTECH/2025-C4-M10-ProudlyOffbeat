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
    
    @Published var isBrowsing = false
    @Published var isConnected = false
    
    init(multipeerManager: MultipeerManager) {
        self.multipeerManager = multipeerManager
        setupConnectionObserver()
    }
    
    var connectedDevice: PeerDevice? {
        multipeerManager.connectedDevice
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
                    self?.isBrowsing = false
                    // 로그출력
                    self?.logConnectedDevice()
                case .browsing:
                    self?.isBrowsing = true
                case .disconnected:
                    self?.isConnected = false
                    self?.isBrowsing = false
                    print("연결이 끊어졌습니다.")
                default:
                    break
                }
            }
            .store(in: &cancellables)
    }
    
    private func logConnectedDevice() {
        if let device = connectedDevice {
            print("🎉 연결 완료!")
            print("📱 연결된 디바이스: \(device.mcPeerID.displayName)")
            print("🔗 연결 상태: \(multipeerManager.connectionState.message)")
        }
    }
    
    func handleConnectionButtonAction() {
        if isConnected {
            disconnect()
        } else {
            toggleBrowsing()
        }
    }
    
    func toggleBrowsing() {
        if isBrowsing {
            stopBrowsing()
        } else {
            startAdvertising()
        }
    }
    
    private func startAdvertising() {
        print("iPhone에서 iPad 검색 시작")
        multipeerManager.startAdvertising()
        isBrowsing = true
    }
    
    private func stopBrowsing() {
        print("iPhone에서 iPad 검색 중단")
        multipeerManager.disconnect()
        isBrowsing = false
    }
    
    private func disconnect() {
        print("연결 해제")
        multipeerManager.disconnect()
        isConnected = false
        isBrowsing = false
    }
    
}
