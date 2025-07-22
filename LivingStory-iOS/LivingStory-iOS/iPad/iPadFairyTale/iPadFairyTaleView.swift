//
//  iPadFairyTaleView.swift
//  LivingStory-iOS
//
//  Created by 문창재 on 7/20/25.
//

import SwiftUI

struct iPadFairyTaleView: View {
    @EnvironmentObject var coordinator: AppCoordinator
    @ObservedObject var viewModel: iPadFairyTaleViewModel
    let book: BookType
    
    var body: some View {
        ZStack {
            FairyTaleBackgroundView(scene: viewModel.currentBackground)
            //현재 인덱스에 따라 배경 바뀜.
            FairyTaleButtonView(homeButtonaction: {viewModel.returnToHome(coordinator: coordinator)}, leftaction: viewModel.decreaseIndex, rightaction: viewModel.increaseIndex)
            //현재 인덱스에 따라 스크립트 바뀜
            FairyTaleScriptView(script: viewModel.currentScript)
            if viewModel.currentPage == 2{
                FairyTaleInteractionView(action: viewModel.triggerInteraction)
            }
            
        }
    }
}


#Preview {
    iPadFairyTaleView(viewModel: iPadFairyTaleViewModel(bookType: .pig), book: .pig)
}
