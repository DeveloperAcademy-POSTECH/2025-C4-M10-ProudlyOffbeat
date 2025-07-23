//
//  iPadParingView.swift
//  LivingStory-iOS
//
//  Created by Demian Yoo on 7/17/25.
//

import SwiftUI

struct iPadPairingView: View {
    @EnvironmentObject var coordinator: AppCoordinator
    @ObservedObject var viewModel: iPadPairingViewModel 
    
    var body: some View {
        ZStack{
            Image("Room") //폰 배경화면 이미지 추가 완료
                .resizable()
                .scaledToFill()
                .offset(x: 300, y: 0)
                .ignoresSafeArea(edges: .all)
                .frame(width: 393, height: 852)
            Image("iPhoneBackground")
            WifiConnectView()
        }
        
        // MPC가 연결되면 ConnectCheck(체크 표시 SubView) 뜨는 부분 : 로직 구현 필요
//        if viewModel.isConnected {
//                       Image("ConnectCheck")
//                           .resizable()
//                           .frame(width: 100, height: 100)
//                           .transition(.scale)
//                           .animation(.easeInOut, value: viewModel.isConnected)
//                   }
    }
}

#Preview{
    iPadPairingView(viewModel: iPadPairingViewModel())
}
