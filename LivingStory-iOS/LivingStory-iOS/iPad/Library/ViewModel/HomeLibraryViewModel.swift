//
//  HomeLibraryViewModel.swift
//  LivingStory-iOS
//
//  Created by Demian Yoo on 7/17/25.
//

import SwiftUI

final class HomeLibraryViewModel: ObservableObject {
    init() { }
    
    @MainActor
    func pushToiPhonePairingView(coordinator: AppCoordinator) {
        print("go to iPhon Pairing")
        coordinator.push(.iPhonePairing)
    }
}
