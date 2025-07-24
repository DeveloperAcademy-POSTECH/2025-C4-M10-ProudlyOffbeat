//
//  iPhonePairingView.swift
//  LivingStory-iOS
//
//  Created by Demian Yoo on 7/17/25.
//

import SwiftUI

struct iPhonePairingView: View {
    @EnvironmentObject var coordinator: AppCoordinator
    @ObservedObject var viewModel: iPhonePairingViewModel
    
    var body: some View {
        ZStack {
            iPhonePairingBackgroundView()
            PairingBookView(viewModel: viewModel) // Peer 연결 로직 들어가는 곳
            LSBottonButtonStackView(
                leftaction: {
                    print("페어링 뷰에서 홈으로 이동")
                    viewModel.goBackToLibrary(coordinator: coordinator)
                },
                rightaction: {
                    viewModel.onNextButtonTapped(coordinator: coordinator)
                }
            )
            if viewModel.showNonconnectionAlert {
                Color.black.opacity(0.5)
                    .ignoresSafeArea()
                
                NonconnectionAlert(
                    onConfirm: {
                        viewModel.dismissNonconnectionAlert()
                    }
                )
            }
        }
        .onAppear {
            print("iPhonePairingView 생성")
            viewModel.startSearchingiPhone()
        }
    }
}
