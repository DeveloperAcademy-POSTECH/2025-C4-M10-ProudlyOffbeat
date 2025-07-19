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
            VStack(alignment: .leading,spacing: 30){
                HStack(alignment: .top){
                    Text("①")
                    Text("아이폰에서 ‘연결하기'를 눌러주세요.")
                        .font(.system(size: 17))
                }
                
                HStack(alignment: .top){
                    Text("②")
                    Text("아이폰이 연결할 준비가 되면 아이패드에서 내 아이폰을 찾아 ‘Connet’를 눌러주세요.")
                        .font(.system(size: 17))
                        .lineLimit(3)
                }
                
            }
        }.frame(width: 400, height: 404)
    }
}

#Preview {
    iPhoneNoticeView()
}
