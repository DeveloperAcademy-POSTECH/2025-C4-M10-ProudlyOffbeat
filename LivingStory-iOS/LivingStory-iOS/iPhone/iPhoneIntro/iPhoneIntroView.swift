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
        ZStack {
            Image("iPhoneIntro")
                .resizable()
                .ignoresSafeArea(edges: .all)
            
            Button(action:{}){
                Text("넘어가는 멘트 들어갈 자리") //버튼 처리 or 그냥 Lottie로만 처리?
                    .font(.headline)
            }
            .padding(.top, 600)
        }
    }
}

#Preview {
    iPhoneIntroView()
}
