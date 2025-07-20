//
//  iPadParingView.swift
//  LivingStory-iOS
//
//  Created by Demian Yoo on 7/17/25.
//

import SwiftUI

struct iPadPairingView: View {
    @EnvironmentObject var coordinator: AppCoordinator
    @ObservedObject var viewModel: iPadPairingViewModel
    
    var body: some View {
        VStack {
            Image(systemName: "MPCimage")//json 파일로 이미지 추가하기
            //ConnectionButton(startAdvertising: viewModel.startAdvertising, action: viewModel.startAdvertisingToggle)
        }
    }
}

//TODO: - MPC 광고 시작 여부에 따라 버튼 텍스트 변경하기, 폰트/버튼 컬러 변경
//"연결하기" 버튼 SubView
struct ConnectionButton: View {
    var startAdvertising: Bool
    var action: () -> Void
    
    var body: some View {
        Button(action:action)
        {
            Text(startAdvertising ? "연결하기" : "연결 취소") //MCP 연결 여부에 따라 텍스트 변환 : startAdvertising에 따라 변경하기(viewModel내 구현 필요)
                .font(.headline) //디자인 폰트로 변경하기
                .foregroundStyle(.white)
                .frame(width: 216, height: 43)
                .background(Color.green) //키컬러로 변경하기
                .cornerRadius(40)
                .padding() //디자인 에셋 추가 후 패딩값 조절 예정
        }
    }
}

#Preview {
    iPadPairingView()
}
