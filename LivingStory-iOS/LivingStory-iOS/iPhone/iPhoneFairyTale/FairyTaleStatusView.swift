//
//  FairyTaleStatusView.swift
//  LivingStory-iOS
//
//  Created by jihanchae on 7/22/25.
//

import SwiftUI

//TODO: Button 연결하기, 연결취소 상태 다르게 set(isConnect bool 값에 따라 변경하게끔?)
struct FairyTaleStatusView: View {
    
    @ObservedObject var viewModel: iPadPairingViewModel

    var body: some View {
        
        ZStack{
            //화면 내 iPhone 이미지
            Image("iPhoneBackground")
            
            VStack(alignment: .center){
                Text(viewModel.connectedDeviceName)
                    .font(LSFont.bookTitleFont)
                    .foregroundColor(viewModel.isConnected ? .lsPrimary : .gray)
                
                Image("PigCover")
                    .padding(.top, 160)
                    .padding(.bottom,162)
                
                ConnectButtonView(viewModel: viewModel)
            }
            .frame(width: 331, height: 668)
        }
    }
}

//#Preview {
//    FairyTaleStatusView()
//}
