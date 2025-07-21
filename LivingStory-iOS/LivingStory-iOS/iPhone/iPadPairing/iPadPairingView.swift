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
