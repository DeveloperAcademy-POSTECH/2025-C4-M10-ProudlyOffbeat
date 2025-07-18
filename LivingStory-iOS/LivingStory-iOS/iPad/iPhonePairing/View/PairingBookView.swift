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
            Image("PairingBook")
            HStack{
                Spacer()
                ConnectListView()
                Spacer()
                Rectangle()
                    .frame(width: 219, height: 295)
                Spacer()
            }
        }
            
    }
}
