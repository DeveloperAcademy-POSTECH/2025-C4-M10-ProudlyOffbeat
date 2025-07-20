//
//  Untitled.swift
//  LivingStory-iOS
//
//  Created by 문창재 on 7/18/25.
//

import SwiftUI

struct ConnectListView: View {
    let peerList:[Peer] = [Peer(deviceId: "Echo's iPhone"),Peer(deviceId: "Echo's iPhone")]
    
    var body: some View {
        ZStack{
            Image("ConnectListBackground")
            GeometryReader{ geometry in
                VStack{
                    HStack{
                        Text("당신의 아이폰 찾기")
                            .font(.system(size: 13))
                        Spacer()
                    }.padding(.top, 48)
                        .padding(.leading, 20)
                    ScrollView{
                        ForEach(peerList, id: \.deviceId){ peer in
                            ConnectCellView(deviceId: peer.deviceId)
                                .padding(.horizontal, 20)
                        }
                    }.padding(.top)
                    
                }
                
            }
            
        }.frame(width: 327, height: 404)
    }
}

#Preview {
    ConnectListView()
}
