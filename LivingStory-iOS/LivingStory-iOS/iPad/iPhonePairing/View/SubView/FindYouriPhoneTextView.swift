//
//  FindYouriPhoneTextView.swift
//  LivingStory-iOS
//
//  Created by 문창재 on 7/21/25.
//
import SwiftUI

struct FindYouriPhoneTextView: View {
    var body: some View {
        HStack (alignment: .center){
            Text("당신의 아이폰 찾기")
                .font(.system(size: 13))
            Spacer()
            iPadAirPlayButtonView()
                .frame(width: 50, height: 50)
        }.padding(.top, 48)
            .padding(.leading, 20)
    }
}

#Preview {
    FindYouriPhoneTextView()
}
