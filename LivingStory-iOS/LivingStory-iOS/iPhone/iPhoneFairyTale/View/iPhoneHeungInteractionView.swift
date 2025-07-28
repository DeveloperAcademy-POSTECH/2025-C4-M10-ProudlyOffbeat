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
                ProgressView(value: progress)
                    .progressViewStyle(LinearProgressViewStyle(tint: .red))
                    .frame(height: 10)
            }
        }
    }
}

#Preview {
    iPhoneHeungInteractionView(viewModel: iPhoneFairyTaleViewModel(multipeerManager: MultipeerManager.shared, bookType: .heung))
}
