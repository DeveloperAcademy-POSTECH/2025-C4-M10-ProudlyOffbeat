//
//  iPadIntroView.swift
//  LivingStory-iOS
//
//  Created by Demian Yoo on 7/17/25.
//

import SwiftUI

struct iPadIntroView: View {
    @EnvironmentObject var coordinator: AppCoordinator
    @ObservedObject var viewModel: iPadIntroViewModel
    
    var body: some View {
        VStack {
            Image("iPadIntro")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .onTapGesture {
                    viewModel.pushToLibraryView(coordinator: coordinator)
                }
        }
    }
}
