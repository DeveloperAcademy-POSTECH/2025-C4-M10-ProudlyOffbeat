//
//  iPhoneFairyTaleView.swift
//  LivingStory-iOS
//
//  Created by jihanchae on 7/22/25.
//

import SwiftUI

struct iPhoneFairtailView: View {
    @EnvironmentObject var coordinator: AppCoordinator
    @ObservedObject var viewModel: iPadPairingViewModel
    
    var body: some View {
        VStack{
            FairyTaleStatusView(viewModel: viewModel)
        }
    }
}
