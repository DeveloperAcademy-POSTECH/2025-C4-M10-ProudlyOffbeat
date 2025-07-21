//
//  PairingBookView.swift
//  LivingStory-iOS
//
//  Created by 문창재 on 7/18/25.
//

import SwiftUI

struct PairingBookView: View {
    let action: () -> Void
    
    var body: some View {
        ZStack{
            GeometryReader{ geometry in
                Image("PairingBook")
                    .resizable()
            }
            HStack{
                ConncetLeftPageView()
                    .padding(.leading, 73)
                Spacer()
                ConnectRightPageView(action: action)
            }
        }.frame(width: 874, height: 644)
            
    }
}

#Preview {
    PairingBookView(action: {})
}
