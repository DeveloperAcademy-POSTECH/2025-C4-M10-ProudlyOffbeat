//
//  ConnectRightPageView.swift
//  LivingStory-iOS
//
//  Created by 문창재 on 7/21/25.
//

import SwiftUI

struct ConnectRightPageView: View {
    let action: () -> Void
    var body: some View {
        VStack{
            Spacer()
            Text("아이폰과 연결")
                .font(LSFont.iPhoneConnectFont)
                .padding(.top, 40)
            Spacer()
            ConnectListView(action: action)
            Spacer()
        }.padding(.trailing, 78)
    }
}
