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
            Image(systemName: "bolt.circle")//json 파일로 이미지 추가하기
            Button(action: {
                //MCP 연결 시 toggleOn으로 변경하기
            }){
                Text("연결하기") //MCP 연결 여부에 따라 텍스트 변환
                    .font(.headline) //디자인 폰트로 변경하기
                    .foregroundStyle(.white)
                    .frame(width: 216, height: 43)
                    .background(Color.green) //키컬러로 변경하기
                    .cornerRadius(40)
                    .padding() //디자인 에셋 추가 후 패딩값 조절 예정
            }
        }
    }
}
