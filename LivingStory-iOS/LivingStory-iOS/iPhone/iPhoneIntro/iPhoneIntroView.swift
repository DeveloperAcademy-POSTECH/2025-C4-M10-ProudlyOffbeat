//
//  iPhoneIntroView.swift
//  LivingStory-iOS
//
//  Created by Demian Yoo on 7/17/25.
//

import SwiftUI

struct iPhoneIntroView: View {
    @EnvironmentObject var coordinator: AppCoordinator
    @ObservedObject var viewModel: iPhoneIntroViewModel
    
    var body: some View {
        VStack {
            Text("아이폰 페어링 뷰")
            Button("다음") {
                viewModel.pushToiPadParingView(coordinator: coordinator)
            }
        }
    }
}
