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
    @ObservedObject var multipeerMananger = MultipeerManager.shared
    let book: BookType
    
    var body: some View {
        ZStack {
            iPhonePairingBackgroundView()
            PairingBookView(action: {}) // Peer 연결 로직 들어가는 곳
            LSBottonButtonStackView(
                leftaction: {
                    print("페어링 뷰에서 홈으로 이동")
                    viewModel.goBackToLibrary(coordinator: coordinator)
                },
                rightaction: {
                    viewModel.startFairyTale(coordinator: coordinator)
                }
            )
            //iPadFairyTaleView로 아직 factory 구현 안됐음
        }
        .onAppear {
            print("iPhonePairingView 생성")
            viewModel.startAdvertising()
        }
    }
}
