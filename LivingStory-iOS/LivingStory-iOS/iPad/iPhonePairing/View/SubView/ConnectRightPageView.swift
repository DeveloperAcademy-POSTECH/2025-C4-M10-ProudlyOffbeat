//
//  ConnectRightPageView.swift
//  LivingStory-iOS
//
//  Created by 문창재 on 7/21/25.
//

import SwiftUI

struct ConnectRightPageView: View {
    @ObservedObject var viewModel: iPhonePairingViewModel
    
    var body: some View {
        VStack{
            Spacer()
            Text("아이폰과 연결")
                .font(LSFont.iPhoneConnectFont)
                .padding(.top, 40)
            Spacer()
            ConnectListView(viewModel: viewModel)
            Spacer()
        }.padding(.trailing, 78)
    }
}

#Preview {
    ConnectRightPageView(viewModel: iPhonePairingViewModel(bookType: .pig, multipeerManager: MultipeerManager.shared))
}
