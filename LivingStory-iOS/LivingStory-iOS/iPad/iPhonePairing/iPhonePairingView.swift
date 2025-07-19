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
            PairingBookView()
        }
    }
}

#Preview {
    iPhonePairingView(viewModel: iPhonePairingViewModel(), book: .pig)
        .environmentObject(AppCoordinator())
}
