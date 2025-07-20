//
//  PairingBookView.swift
//  LivingStory-iOS
//
//  Created by 문창재 on 7/18/25.
//

import SwiftUI

struct PairingBookView: View {
    var body: some View {
        ZStack{
            GeometryReader{ geometry in
                Image("PairingBook")
                    .resizable()
            }
            HStack{
                iPhoneNoticeView()
                    .padding(.leading, 53)
                Spacer()
                VStack{
                    Spacer()
                    Text("아이폰과 연결")
                    Spacer()
                    ConnectListView()
                    Spacer()
                }.padding(.trailing, 78)
            }
        }.frame(width: 874, height: 644)
            
    }
}

#Preview {
    PairingBookView()
}
