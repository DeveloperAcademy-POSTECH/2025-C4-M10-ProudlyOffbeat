//
//  Untitled.swift
//  LivingStory-iOS
//
//  Created by 문창재 on 7/18/25.
//

import SwiftUI

struct ConnectListView: View {
    var body: some View {
        Form {
            Section(header: Text("근처 아이폰 찾기").font(.headline)){
                HStack{
                    Text("Echo's iPhone")
                    Spacer()
                    Button{
                        //connect
                    }label: {
                        ZStack{
                            Rectangle()
                              .foregroundColor(.clear)
                              .frame(width: 52, height: 19)
                              .background(Color(red: 0.17, green: 0.4, blue: 0.96))
                              .cornerRadius(5)
                            Text("Connect")
                              .font(Font.custom("SF Pro", size: 11))
                              .multilineTextAlignment(.center)
                              .foregroundColor(.white)
                        }
                        
                    }
                }
                HStack{
                    Text("Echo's iPhone")
                    Spacer()
                    Button{
                        //connect
                    }label: {
                        ZStack{
                            Rectangle()
                              .foregroundColor(.clear)
                              .frame(width: 52, height: 19)
                              .background(Color(red: 0.17, green: 0.4, blue: 0.96))
                              .cornerRadius(5)
                            Text("Connect")
                              .font(Font.custom("SF Pro", size: 11))
                              .multilineTextAlignment(.center)
                              .foregroundColor(.white)
                        }
                        
                    }
                }
            }
            
        }
        .frame(width: 327, height: 404)
    }
}

#Preview {
    ConnectListView()
}
