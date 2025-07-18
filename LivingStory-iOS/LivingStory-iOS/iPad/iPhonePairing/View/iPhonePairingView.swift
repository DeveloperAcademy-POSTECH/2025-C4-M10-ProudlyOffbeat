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
            PairingBookView()
        }
    }
}

#Preview{
    NavigationStack{
        iPhonePairingView(viewModel: iPhonePairingViewModel())
            .environmentObject(AppCoordinator())
    }
}
