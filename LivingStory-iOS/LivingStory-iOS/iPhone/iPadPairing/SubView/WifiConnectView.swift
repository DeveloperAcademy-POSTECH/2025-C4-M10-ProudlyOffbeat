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
            LottieView(filename: "Wifi", loopModel: .loop)
                .frame(width: 200)
            ConnectButtonView(viewModel: viewModel)
                .padding(.bottom, 78)
        }
        .frame(width: 331, height: 668)
    }
}
