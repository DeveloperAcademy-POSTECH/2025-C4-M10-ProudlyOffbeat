//
//  HomeLibraryViewModel.swift
//  LivingStory-iOS
//
//  Created by Demian Yoo on 7/17/25.
//

import SwiftUI
import MultipeerConnectivity

final class HomeLibraryViewModel: ObservableObject {
    
    private let multipeerManager: MultipeerManager
    private let homeKitManager: HomeKitManager
    
    init(multipeerManager: MultipeerManager, homeKitManager: HomeKitManager) {
        self.multipeerManager = multipeerManager
        self.homeKitManager = homeKitManager
    }
    
    func onLibraryApper() {
        multipeerManager.disconnectAll()
        homeKitManager.setDefaultLighting()
    }
    
    
    
    
    @MainActor
    func pushToiPhonePairingView(coordinator: AppCoordinator, bookType: BookType) {
        print("go to iPhone Pairing")
        print("send to \(bookType)")
        coordinator.push(.iPhonePairing(book: bookType))
    }
}
