//
//  ConnectButtonView.swift
//  LivingStory-iOS
//
//  Created by jihanchae on 7/21/25.
//

import Foundation
import SwiftUI

//"연결하기" 버튼 SubView
struct ConnectButtonView: View {
    var action: () -> Void
    //여기에 MultipeerManager를 StateObject로 받아야 할지, ObservedObject로 받아야 할지 고민임. 
    
    var body: some View {
        Button(action:action)
        {
            Text("연결하기") //MultipeerManager에서 isConnected으로 "연결하기", "연결취소" 변경 : ex) multipeerManager.isConnected ? "연결 취소" : "연결하기"
                .font(LSFont.bookTitleFont) //디자인 폰트로 변경 완료
                .foregroundStyle(.white)
                .frame(width: 216, height: 43)
                .background(Color.lsPrimary) //MultipeerManager에서 isConnected으로 색상 바꾸기. ex) multipeerManager.isConnected ? Color.red : Color.lsPrimary
                .cornerRadius(40)
        }
    }
}

//#Preview {
//    ConnectButtonView(action: {})
//}
