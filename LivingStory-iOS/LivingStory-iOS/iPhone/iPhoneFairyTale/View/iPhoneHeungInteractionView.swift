//
//  iPhoneHeungInteractionView.swift
//  LivingStory-iOS
//
//  Created by 문창재 on 7/28/25.
//

import SwiftUI

struct iPhoneHeungInteractionView: View {
    @State private var progress: Double = 0.7
    @ObservedObject var viewModel: iPhoneFairyTaleViewModel
    
    var body: some View {
        ZStack{
            Image("iPhoneHeungInteraction")
                .resizable()
                .ignoresSafeArea()
            VStack{
                Spacer()
                ZStack{
                    RoundedRectangle(cornerRadius: 30)
                        .foregroundStyle(.white)
                        .frame(width: 700, height: 30)
                    ProgressView(value: progress)
                        .progressViewStyle(LinearProgressViewStyle(tint: .red))
                        .padding()
                }.frame(width: 700,height: 10)
                .padding(.bottom, 300)
                    
                Spacer()
            }.rotationEffect(.degrees(90))
                .frame(width: UIScreen.main.bounds.width)
        }
    }
}

#Preview {
    iPhoneHeungInteractionView(viewModel: iPhoneFairyTaleViewModel(multipeerManager: MultipeerManager.shared, bookType: .heung))
}
