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
    func pushToiPhonePairingView(coordinator: AppCoordinator, bookType: BookType) {
        print("go to iPhon Pairing")
        print("send to \(bookType)")
        coordinator.push(.iPhonePairing(book: bookType))
    }
}
