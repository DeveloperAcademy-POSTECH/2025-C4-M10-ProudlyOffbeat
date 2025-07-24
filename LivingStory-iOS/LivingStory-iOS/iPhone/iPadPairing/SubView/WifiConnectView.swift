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
            Image("MPCimage")
                .padding(.top, 204)
                .padding(.bottom,162)
            ConnectButtonView(viewModel: viewModel)//클로저로 버트
        }
        .frame(width: 331, height: 668)
    }
}

//#Preview {
//    WifiConnectView()
//}
