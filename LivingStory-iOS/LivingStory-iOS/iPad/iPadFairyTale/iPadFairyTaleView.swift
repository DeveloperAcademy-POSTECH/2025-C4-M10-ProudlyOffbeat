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
    
    var body: some View {
        ZStack {
            FairyTaleBackgroundView(scene: viewModel.currentBackground)
            
            if let book = viewModel.selectedBook, viewModel.currentPage != book.pages.count - 1 {
                FairyTaleButtonView(
                    homeButtonaction: {
                        viewModel.returnToHome(coordinator: coordinator)
                    },
                    leftaction: {
                        if viewModel.currentPage == 0 {
                            viewModel.goToPreviousView(coordinator: coordinator)
                        } else {
                            viewModel.decreaseIndex()
                        }
                    },
                    rightaction: {
                        viewModel.increaseIndex()
                    }
                )
            } else if let book = viewModel.selectedBook, viewModel.currentPage == book.pages.count - 1 {
                FairyTaleLastPageButtonView(leftaction: {
                    viewModel.decreaseIndex()
                })
            }
            
            FairyTaleScriptView(script: viewModel.currentScript)
            
            if viewModel.currentPage == 2 {
                FairyTaleInteractionView(action: {
                    viewModel.iPadSendInteraction()
                }, bookType: viewModel.selectedBook?.type ?? .pig)
            }
            
            if let book = viewModel.selectedBook, viewModel.currentPage == book.pages.count - 1 {
                FairyTaleEnddingView()
            }
            // ✅ 인터랙션 완료 알림
            if viewModel.showInteractionCompleteAlert {
                Color.black.opacity(0.3)
                    .ignoresSafeArea()
                
                InteractionComplete {
                    viewModel.dismissInteractionCompleteAlert()
                }
            }
        }
    }
}
