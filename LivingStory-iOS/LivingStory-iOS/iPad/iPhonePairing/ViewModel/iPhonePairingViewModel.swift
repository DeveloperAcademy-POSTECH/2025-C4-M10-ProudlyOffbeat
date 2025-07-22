//
//  iPhonePairingViewModel.swift
//  LivingStory-iOS
//
//  Created by 문창재 on 7/17/25.
//

import SwiftUI

final class iPhonePairingViewModel: ObservableObject {
    
    private let bookType: BookType
    private let multipeerManager: MultipeerManager
    
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
    
    @MainActor
    func startFairyTale(coordinator: AppCoordinator) {
        if isConnected {
            print("\(selectedBook.title) 동화 시작")
            coordinator.push(.iPadFairyTale(book: bookType))
        } else {
            print(" 연결되지 않아서 동화를 시작할 수 없습니다.")
        }
    }
    
    @MainActor
    func goBackToLibrary(coordinator: AppCoordinator) {
        coordinator.pop()
    }
    
}
