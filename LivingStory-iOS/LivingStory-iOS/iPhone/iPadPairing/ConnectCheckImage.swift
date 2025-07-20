//
//  ConnectCheckImage.swift
//  LivingStory-iOS
//
//  Created by jihanchae on 7/20/25.
//

import Foundation
import SwiftUI

struct ConnectImageView: View {
    var body : some View {
        ZStack {
            // 외곽 정사각형 영역 (투명 or border로 테스트 가능)
            Rectangle()
                .foregroundColor(.clear)
                .aspectRatio(1, contentMode: .fit)
                .padding(160)
            
            // 실제 이미지
            Image("ConnectCheck")
        }
    }
}

#Preview {
    ConnectImageView()
}
