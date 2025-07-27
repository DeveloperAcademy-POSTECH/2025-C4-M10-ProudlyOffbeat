//
//  iPhoneFairyTaleView.swift
//  LivingStory-iOS
//
//  Created by jihanchae on 7/22/25.
//

import SwiftUI

struct iPhoneFairytailView: View {
    @EnvironmentObject var coordinator: AppCoordinator
    @ObservedObject var viewModel: iPhoneFairyTaleViewModel
    
    var body: some View {
        iPhoneInteractionView(viewModel: viewModel)
            .onReceive(NotificationCenter.default.publisher(for: .goToIPhoneRoot)) { _ in
                coordinator.goToIPhoneRoot()  // ✅ 홈으로 이동
            }
    }
}
