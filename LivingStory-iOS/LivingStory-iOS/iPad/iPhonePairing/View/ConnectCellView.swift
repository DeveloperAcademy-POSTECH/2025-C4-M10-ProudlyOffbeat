//
//  ConnectCellView.swift
//  LivingStory-iOS
//
//  Created by 문창재 on 7/19/25.
//
import SwiftUI

struct ConnectCellView: View {
    let deviceId: String
    //let action:() -> Void
    
    var body: some View {
        HStack{
            Text(deviceId)
                .font(.system(size: 11))
                .padding(10)
            Spacer()
            Button{
                //action()
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
        }.background(Color.white.cornerRadius(5))
    }
}

#Preview{
    ConnectCellView(deviceId: "Echo's iPhone")
}
