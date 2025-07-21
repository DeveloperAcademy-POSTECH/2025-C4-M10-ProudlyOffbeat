//
//  iPhoneNoticeView.swift
//  LivingStory-iOS
//
//  Created by 문창재 on 7/20/25.
//

import SwiftUI

struct iPhoneNoticeView:View{
    var body: some View{
        HStack(spacing: 17){
            Image("iPhoneNotice")
            iPhoneNoticeTextView()
        }.frame(width: 400, height: 404)
    }
}

#Preview {
    iPhoneNoticeView()
}
