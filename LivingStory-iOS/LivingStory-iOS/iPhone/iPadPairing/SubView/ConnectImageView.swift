//
//  ConnectImageView.swift
//  LivingStory-iOS
//
//  Created by jihanchae on 7/21/25.
//

import Foundation
import SwiftUI

//연결 완료 시 체크 표시 구현 SubView
struct ConnectImageView: View {
    var body : some View {
        ZStack {
            // 외곽 정사각형 영역 (투명 or border로 테스트 가능)
            Rectangle()
                .foregroundColor(.black)
                .aspectRatio(1, contentMode: .fit)
                .padding(160)
            
            // 실제 콘텐츠
            Image("ConnectCheck")
        }
    }
}

//#Preview {
//    ConnectImageView()
//}
