//
//  iPhonePairingViewModel.swift
//  LivingStory-iOS
//
//  Created by 문창재 on 7/17/25.
//

import SwiftUI
import MultipeerConnectivity


final class iPhonePairingViewModel: ObservableObject {
    
    private let bookType: BookType
    private let multipeerManager: MultipeerManager
    
    @Published var showConnectedAlert = false
    @Published var showNonconnectionAlert = false
    
    var selectedBook: Book {
        bookType.book
    }
    
    var connectionState: ConnectionState {
        multipeerManager.connectionState
    }
    
    var discoveredDevices: [PeerDevice] {
        multipeerManager.discoveredDevices
    }
    
    var connectedDevice: PeerDevice? {
        multipeerManager.connectedDevice
    }
    
    var isConnected: Bool {
        multipeerManager.isConnected
    }
    
    
    init(bookType: BookType, multipeerManager: MultipeerManager) {
        self.bookType = bookType
        self.multipeerManager = multipeerManager
    }
    
    // MARK: - MultipeerConnectivity Actions
    func startAdvertising() {
        print("iPad에서 광고 시작 - \(selectedBook.title)")
        multipeerManager.startAdvertising()
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
