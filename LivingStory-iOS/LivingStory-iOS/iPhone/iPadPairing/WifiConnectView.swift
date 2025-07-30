//
//  WifiConnectView.swift
//  LivingStory-iOS
//
//  Created by jihanchae on 7/21/25.
//

import Foundation
import SwiftUI

// "연결하기" 버튼과 "WifiImage" 합치는 SubView
struct WifiConnectView: View {
    @ObservedObject var viewModel: iPadPairingViewModel
    @State private var playLottie = false
    
    var body: some View {
        VStack(alignment: .center){
            HStack {
                Spacer()
                iPhoneAirPlayButtonView()
                    .frame(width: 44, height: 44)
                    .padding(.top, 20)
                    .padding(.trailing, 20)
            }
            Spacer()
            if viewModel.isConnected{
                ConnectedBookView(
                    connectedDeviceName: viewModel.connectedDeviceName,
                    bookCoverImageString: viewModel.receivedBookCoverImageString
                )
            } else {
                LottieView(filename: "Wifi", loopMode: .loop, isPlaying: $playLottie)
                    .frame(width: 200, height: 200)
            }
            Spacer()
            ConnectButtonView(viewModel: viewModel, playLottie: $playLottie)
                .padding(.bottom, 78)
        }
        .frame(width: 331, height: 668)
    }
}

#Preview {
    WifiConnectView(viewModel: iPadPairingViewModel(multipeerManager: MultipeerManager.shared))
        .border(.black)
}
