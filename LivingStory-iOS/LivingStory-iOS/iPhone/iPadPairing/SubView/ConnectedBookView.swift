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
    
    var bookTypeMessage: String {
        switch bookCoverImageString {
        case "PigCover": return "돼지 삼형제"
        case "OzCover": return "오즈의 마법사"
        case "HeungCover": return "흥부와 놀부"
        default: return ""
        }
    }
    
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
