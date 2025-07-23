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
            if viewModel.currentPage != (viewModel.selectedBook?.pages.count)! - 1{
                FairyTaleButtonView(homeButtonaction: {viewModel.returnToHome(coordinator: coordinator)}, leftaction:{
                    if viewModel.currentPage == 0{
                      viewModel.goToPreviousView(coordinator: coordinator)
                    }else{
                        viewModel.decreaseIndex()
                    }
                } , rightaction: viewModel.increaseIndex)
            }else{
                FairyTaleLastPageButtonView(leftaction: viewModel.decreaseIndex)
            }
            FairyTaleScriptView(script: viewModel.currentScript)
            if viewModel.currentPage == 2{
                FairyTaleInteractionView(action: viewModel.triggerInteraction)
            }
            if viewModel.currentPage == (viewModel.selectedBook?.pages.count)! - 1{
                FairyTaleEnddingView()
            }
            
        }
    }
}


#Preview {
    iPadFairyTaleView(viewModel: iPadFairyTaleViewModel(bookType: .pig), book: .pig)
}
