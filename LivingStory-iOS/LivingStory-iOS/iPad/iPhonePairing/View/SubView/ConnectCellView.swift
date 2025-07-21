//
//  ConnectCellView.swift
//  LivingStory-iOS
//
//  Created by 문창재 on 7/19/25.
//
import SwiftUI

struct ConnectCellView: View {
    let deviceId: String
    let action:() -> Void
    
    var body: some View {
        HStack{
            Text(deviceId)
                .font(.system(size: 11))
                .padding(10)
            Spacer()
            PeerConnectButtonView(action: action)
        }.background(Color.white.cornerRadius(5))
    }
}

#Preview{
    ConnectCellView(deviceId: "Echo's iPhone", action: {})
}
