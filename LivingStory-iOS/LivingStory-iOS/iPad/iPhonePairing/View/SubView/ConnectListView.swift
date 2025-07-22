//
//  Untitled.swift
//  LivingStory-iOS
//
//  Created by 문창재 on 7/18/25.
//

import SwiftUI

struct ConnectListView: View {
    let peerList:[Peer] = [Peer(deviceId: "Echo's iPhone"),Peer(deviceId: "Ito's iPhone")]
    // 광고중인 아이폰 List
    
    let action:() -> Void
    
    var body: some View {
        ZStack{
            Image("ConnectListBackground")
            GeometryReader{ geometry in
                VStack{
                    FindYouriPhoneTextView()
                    ScrollView{
                        ForEach(peerList, id: \.deviceId){ peer in
                            ConnectCellView(deviceId: peer.deviceId, action: action)
                                .padding(.horizontal, 20)
                        }
                    }.padding(.top)
                }
            }
            
        }.frame(width: 327, height: 404)
    }
}

#Preview {
    ConnectListView(action: {})
}
