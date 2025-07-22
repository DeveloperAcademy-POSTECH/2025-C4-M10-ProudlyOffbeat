//
//  FairyTaleStatusView.swift
//  LivingStory-iOS
//
//  Created by jihanchae on 7/22/25.
//

import SwiftUI



//TODO: Button 연결하기, 연결취소 상태 다르게 set(isConnect bool 값에 따라 변경하게끔?)
struct FairyTaleStatusView: View {
    
    var body: some View {
        
        ZStack{
            //화면 내 iPhone 이미지
            Image("iPhoneBackground")
            
            VStack(alignment: .center){
                //연결되는 기기 정보 출력 줄
                Text("Connected Device's info")
                    .font(LSFont.bookTitleFont)
                //동화 책 커버
                Image("PigCover") //이미지
                    .padding(.top, 160)
                    .padding(.bottom,162)
                
                //TODO: Button Component화 -> 연결하기, 연결취소 상태 다르게 set(isConnect bool 값에 따라 변경하게끔?)
                ConnectButtonView(action: {}) //일단은 연결하기로 뜨게 해둠
            }
            .frame(width: 331, height: 668)
        }
    }
}

//#Preview {
//    FairyTaleStatusView()
//}
