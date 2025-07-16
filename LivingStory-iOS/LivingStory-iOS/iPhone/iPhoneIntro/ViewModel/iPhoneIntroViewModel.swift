//
//  iPhoneIntroViewModel.swift
//  LivingStory-iOS
//
//  Created by Demian Yoo on 7/17/25.
//

import SwiftUI

final class iPhoneIntroViewModel: ObservableObject {
    init() {}
    
    @MainActor
    func pushToiPadParingView(coordinator: AppCoordinator) {
        coordinator.push(.iPadPairing)
    }
}
