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
    private var iPhoneCancellabes = Set<AnyCancellable>()
    
    @Published var showConnectedAlert = false
    @Published var showNonconnectionAlert = false
    
    @Published var discoveredDevices: [PeerDevice] = []
    @Published var connectedDevices: [PeerDevice] = []
    @Published var connectionState: ConnectionState = .disconnected
    @Published var isConnected: Bool = false
    
    var selectedBook: Book {
        bookType.book
    }
    
    
    init(bookType: BookType, multipeerManager: MultipeerManager) {
        self.bookType = bookType
        self.multipeerManager = multipeerManager
        setupiPhoneConnectionObserver()
    }
    
    private func setupiPhoneConnectionObserver() {
        multipeerManager.$discoveredDevices
            .receive(on: DispatchQueue.main)
            .sink { [weak self] devices in
                self?.discoveredDevices = devices  // 직접 할당
            }
            .store(in: &iPhoneCancellabes)
        
        multipeerManager.$connectedDevices
            .receive(on: DispatchQueue.main)
            .sink { [weak self] devices in
                self?.connectedDevices = devices  // 직접 할당
                self?.isConnected = !devices.isEmpty
            }
            .store(in: &iPhoneCancellabes)
        
        multipeerManager.$connectionState
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                self?.connectionState = state  // 직접 할당
                if state == .connected {
                    self?.showConnectedAlert = true
                    
                    //bookType 보내기
                    self?.sendSelectedBookToiPhone(self?.bookType)
                }
            }
            .store(in: &iPhoneCancellabes)
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
    
    func disconnectiPhone(_ peerID: MCPeerID) {
        multipeerManager.iPadDisconnectiPhone(peerID)
    }
    
    func sendSelectedBookToiPhone(_ bookType: BookType?) {
        guard let bookType = bookType else { return }
        
        let fairyID: FairyTaleID
        switch bookType {
        case .pig: fairyID = .pig
        case .heung: fairyID = .heung
        case .oz: fairyID = .oz
        }
        
        let message = "\(fairyID.rawValue)::\(BookSelectionSignal.selected.rawValue)"
        guard let data = message.data(using: .utf8) else { return }
        try? multipeerManager.session.send(data, toPeers: multipeerManager.session.connectedPeers, with: .reliable)
        print(" [iPad] 선택한 책 전송 완료: \(message)")
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
