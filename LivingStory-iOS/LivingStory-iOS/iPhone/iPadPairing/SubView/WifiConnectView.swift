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
    
    var body: some View {
        VStack(alignment: .center){
            Spacer()
            if viewModel.isConnected{
                ConnectedBookView(connectedDeviceName: viewModel.connectedDeviceName, bookCoverImageString: viewModel.bookCoverImageString(book: viewModel.book ?? .pig))
            }else{
                LottieView(filename: "Wifi", loopModel: .loop)
                    .frame(width: 200, height: 200)
            }
            Spacer()
            ConnectButtonView(viewModel: viewModel)
               .padding(.bottom, 78)
        }
        .frame(width: 331, height: 668)
    }
}

#Preview {
    WifiConnectView(viewModel: iPadPairingViewModel(multipeerManager: MultipeerManager.shared))
        .border(.black)
}
