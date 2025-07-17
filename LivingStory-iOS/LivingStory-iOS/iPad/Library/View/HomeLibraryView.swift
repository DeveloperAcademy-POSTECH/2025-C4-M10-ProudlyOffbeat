//
//  HomeLibraryView.swift
//  LivingStory-iOS
//
//  Created by Demian Yoo on 7/17/25.
//

import SwiftUI

struct HomeLibraryView: View {
    @EnvironmentObject var coordinator: AppCoordinator
    @ObservedObject var viewModel: HomeLibraryViewModel
    
    var body: some View {
        ZStack {
            HomeBackgroundView()
            HomeDoorView(action: {viewModel.pushToiPhonePairingView(coordinator: coordinator)})
        }
    }
}

#Preview{
    NavigationStack{
        HomeLibraryView(viewModel: HomeLibraryViewModel())
            .environmentObject(AppCoordinator())
    }
}
