//
//  ConnectedBookView.swift
//  LivingStory-iOS
//
//  Created by 문창재 on 7/27/25.
//

import SwiftUI

struct ConnectedBookView: View {
    let connectedDeviceName: String
    let bookCoverImageString: String
    
    var body: some View {
        VStack{
            Text("\(connectedDeviceName)와 연결됨")
                .font(LSFont.iPhoneConnectFont)
                .padding(.top, 40)
            Spacer()
            Image(bookCoverImageString)
            Spacer()
        }
    }
}
