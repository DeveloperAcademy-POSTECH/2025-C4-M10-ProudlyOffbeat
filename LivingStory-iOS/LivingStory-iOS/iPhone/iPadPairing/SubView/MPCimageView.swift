//
//  MPCimageView.swift
//  LivingStory-iOS
//
//  Created by jihanchae on 7/20/25.
//

import Foundation
import SwiftUI


//TODO: - MPC viewmodel로 상태 변화에 따라 버튼내 텍스트 변경 기능 추가하기?

struct MPCimageView: View {
    //ViewModel로 Advertise 키고 끄기 구현
    //private var viewModel = MCAdvertiserManager() //ViewModel에서 로직을 여기서 받아오면 되지 않을까 생각해서 적어놨습니다.
    
    var body: some View {
        VStack(alignment: .center){
            Image("MPCimage")
                .padding(.top, 204)
                .padding(.bottom,162)
            ConnectButtonView(action: {})//ViewModel에서 로직 받아오기 구현 필요
        }
        .frame(width: 331, height: 668)
    }
}
