//
//  iPhonePairingViewModel.swift
//  LivingStory-iOS
//
//  Created by 문창재 on 7/17/25.
//

import SwiftUI
import MultipeerConnectivity
import Combine


final class iPhonePairingViewModel: ObservableObject {
    
    private let bookType: BookType
    private let multipeerManager: MultipeerManager
    private var cancellabes = Set<AnyCancellable>()
    
    @Published var showConnectedAlert = false
    @Published var showNonconnectionAlert = false
    
    //MARK: 실시간 상태를 위한 프로퍼티 래퍼
    @Published var currentDiscoveredDevices: [PeerDevice] = []
    @Published var currentConnectedDevices: [PeerDevice] = []
    @Published var currentConnectionState: ConnectionState = .disconnected
    @Published var currentIsConnected: Bool = false
    
    var selectedBook: Book {
        bookType.book
    }
    
    var connectionState: ConnectionState {
        multipeerManager.connectionState
    }
    
    var discoveredDevices: [PeerDevice] {
        multipeerManager.discoveredDevices
    }
    
    var connectedDevice: [PeerDevice] {
        multipeerManager.connectedDevices
    }
    
    var isConnected: Bool {
        multipeerManager.isConnected
    }
    
    
    init(bookType: BookType, multipeerManager: MultipeerManager) {
        self.bookType = bookType
        self.multipeerManager = multipeerManager
    }
    
    // MARK: - MultipeerConnectivity Actions
    func startSearchingiPhone() {
        print("iPad에서 iPhone 검색 시작 - \(selectedBook.title)")
        multipeerManager.startBrowsing()
    }
    
    
    func sendConnectionToiPhone(to peerID: MCPeerID) {
        multipeerManager.connectTo(peerID)
    }
    
    // MARK: - 알러트 액션
    func dismissConnectedAlert() {
        showConnectedAlert = false
    }
    
    func checkConnectedAlert() {
        if isConnected {
            showConnectedAlert = true
        } else {
            showNonconnectionAlert = true
        }
    }
    
    func dismissNonconnectionAlert() {
        showNonconnectionAlert = false
    }
    
    @MainActor
    func onNextButtonTapped(coordinator: AppCoordinator) {
        if isConnected {
            coordinator.push(.iPadFairyTale(book: bookType))
        } else {
            showNonconnectionAlert = true
        }
    }
    
    @MainActor
    func goBackToLibrary(coordinator: AppCoordinator) {
        coordinator.pop()
    }
    
}
