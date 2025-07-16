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
        VStack {
            Text("홈 라이브러리 뷰")
        }
    }
}
