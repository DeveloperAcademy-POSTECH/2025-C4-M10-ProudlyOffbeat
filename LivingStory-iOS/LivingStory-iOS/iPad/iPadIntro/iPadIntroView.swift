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
            Text("아이패드 인트로")
            Button("다음") {
                viewModel.pushToLibraryView(coordinator: coordinator)
            }
        }
    }
}
