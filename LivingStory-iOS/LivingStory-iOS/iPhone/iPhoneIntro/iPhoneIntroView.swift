//
//  iPhoneIntroView.swift
//  LivingStory-iOS
//
//  Created by Demian Yoo on 7/17/25.
//

import SwiftUI

struct iPhoneIntroView: View {
    @EnvironmentObject var coordinator: AppCoordinator
    @ObservedObject var viewModel: iPhoneIntroViewModel
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Image("iPhoneIntro")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea(edges: .all)
            Text("시작하려면 아무곳이나 눌러주세요")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundStyle(.blue)
                .padding(.bottom, 180)
        }
        .onTapGesture {
            viewModel.pushToiPadParingView(coordinator: coordinator)
        }
    }
}
