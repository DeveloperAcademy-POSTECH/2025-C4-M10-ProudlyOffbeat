//
//  ConncetLeftPageView.swift
//  LivingStory-iOS
//
//  Created by 문창재 on 7/21/25.
//

import SwiftUI

struct ConncetLeftPageView: View {
    var body: some View {
        VStack{
            Spacer()
            Text("시작하기!")
                .font(LSFont.iPhoneConnectFont)
            Spacer()
            iPhoneNoticeView()
                .padding(.leading, 53)
            Spacer()
        }.padding(.leading, 73)
        .padding(.trailing, 78)
            .frame(width: 327, height: 404)
    }
}
