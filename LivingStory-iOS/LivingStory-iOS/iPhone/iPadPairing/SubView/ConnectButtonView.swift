//
//  ConnectButtonView.swift
//  LivingStory-iOS
//
//  Created by jihanchae on 7/20/25.
//

import Foundation
import SwiftUI

//TODO: - MPC 광고 시작 여부에 따라 버튼 텍스트 변경하기, 폰트/버튼 컬러 변경

struct ConnectButtonView: View {
    //var startAdvertising: Bool
    var action: () -> Void
    
    var body: some View {
        Button(action:action) //광고 시작하기 기능 추가되어야 함.
        {
            Text("연결하기") //MCP 광고 시작 여부에 따라 텍스트 변환
                .font(.headline) //디자인 폰트로 변경하기
                .foregroundStyle(.white)
                .frame(width: 216, height: 43)
                .background(Color.green) //키컬러로 변경하기
                .cornerRadius(40)
        }
    }
}

//#Preview {
//    ConnectButtonView(action: {})
//}
