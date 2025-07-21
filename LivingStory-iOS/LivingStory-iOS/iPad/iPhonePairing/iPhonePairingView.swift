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
    let book: BookType
    
    var body: some View {
        ZStack {
            iPhonePairingBackgroundView()
            PairingBookView(action: {}) // Peer 연결 로직 들어가는 곳
            ControllNavigationButtonView(nextView: .intro)
            //iPadFairyTaleView로 아직 factory 구현 안됐음
        }
    }
}


#Preview {
    iPhonePairingView(viewModel: iPhonePairingViewModel(), book: .pig)
        .environmentObject(AppCoordinator())
}


