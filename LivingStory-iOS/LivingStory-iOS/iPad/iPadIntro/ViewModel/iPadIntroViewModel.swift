//
//  iPadIntroViewModel.swift
//  LivingStory-iOS
//
//  Created by Demian Yoo on 7/17/25.
//

import SwiftUI

final class iPadIntroViewModel: ObservableObject {
    init(){}
    
    @MainActor
    func pushToLibraryView(coordinator: AppCoordinator) {
        coordinator.push(.iPadLibrary)
    }
}
