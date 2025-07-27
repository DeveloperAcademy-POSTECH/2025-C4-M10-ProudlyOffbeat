//
//  iPhoneFairyTaleView.swift
//  LivingStory-iOS
//
//  Created by jihanchae on 7/22/25.
//

import SwiftUI

struct iPhoneFairtailView: View {
    @EnvironmentObject var coordinator: AppCoordinator
    @ObservedObject var viewModel: iPhoneFairyTaleViewModel
    
    var body: some View {
        iPhoneInteractionView(viewModel: viewModel)
    }
}
