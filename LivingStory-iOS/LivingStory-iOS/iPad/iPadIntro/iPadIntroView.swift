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
        ZStack(alignment: .bottom) {
            Image("iPadIntro")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea(edges: .all)
            Text("시작하려면 아무곳이나 눌러주세요")
                .font(.title)
                .fontWeight(.bold)
                .foregroundStyle(.blue)
                .padding(.bottom, 100)
        }
        .onTapGesture {
            viewModel.pushToLibraryView(coordinator: coordinator)
        }
    }
}

#Preview {
    iPadIntroView(viewModel: iPadIntroViewModel())
}
