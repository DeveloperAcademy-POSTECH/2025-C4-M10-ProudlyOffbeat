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
    
    var body: some View {
        Button(action:action)
        {
            Text("연결하기") //MCP 연결 여부에 따라 텍스트 변환
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
