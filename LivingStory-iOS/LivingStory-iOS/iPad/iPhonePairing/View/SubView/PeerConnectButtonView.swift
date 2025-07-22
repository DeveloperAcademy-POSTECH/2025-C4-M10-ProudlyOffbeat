//
//  ConnectButtonView.swift
//  LivingStory-iOS
//
//  Created by 문창재 on 7/21/25.
//

import SwiftUI

struct PeerConnectButtonView: View {
    let action: () -> Void
    
    var body: some View {
        Button{
            action()
        }label: {
            ZStack{
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 52, height: 19)
                    .background(Color(red: 0.17, green: 0.4, blue: 0.96))
                    .cornerRadius(5)
                Text("Connect")
                    .font(.system(size: 11))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
            }.padding(10)
        }
    }
}
