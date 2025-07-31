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

    @ObservedObject var viewModel: iPadPairingViewModel
    @Binding var playLottie:Bool
    
    private var iPadConnectionButtonText: String {
        if viewModel.isConnected {
            return "연결취소"
        } else if viewModel.isAdvertising {
            return "연결중"
        } else {
            return "연결하기"
        }
    }
    
    private var iPadConnectionButtonColor: Color {
        if viewModel.isConnected {
            return .red
        } else if viewModel.isAdvertising {
            return .gray
        } else {
            return .lsPrimary
        }
    }
    
    var body: some View {
        Button(action: {
            viewModel.handleConnectionButtonAction()
            if viewModel.isConnected {
                playLottie = false
            }else{
                playLottie.toggle()
            }
        })
        {
            Text(iPadConnectionButtonText) //MCP 연결 여부에 따라 텍스트 변환
                .font(LSFont.bookTitleFont) //디자인 폰트로 변경 완료
                .foregroundStyle(.white)
                .frame(width: 216, height: 43)
                .background(iPadConnectionButtonColor) //키컬러로 변경 완료
                .cornerRadius(40)
        }
    }
}

//#Preview {
//    ConnectButtonView(action: {})
//}
