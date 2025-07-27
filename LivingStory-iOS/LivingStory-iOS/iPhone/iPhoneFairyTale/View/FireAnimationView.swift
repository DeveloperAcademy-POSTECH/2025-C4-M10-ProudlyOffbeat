//
//  Fire.swift
//  LivingStory-iOS
//
//  Created by jihanchae on 7/23/25.
//

import SwiftUI

struct FireAnimationView: View {
    @ObservedObject var viewModel:iPhoneFairyTaleViewModel
    @ObservedObject var audioManager: AudioInputModel
    
    var body: some View {
        VStack {
            VStack(alignment: .center, spacing: 10) {
                Text("마이크에")
                    .font(LSFont.fairyTaleFont)
                Text("바람을 불어주세요")
                    .font(LSFont.fairyTaleFont)
            }
            .padding(.bottom, 315)
            
            LottieView(filename: "Fire", loopModel: .loop)
                .frame(width: 100, height: 120)
                .padding(.bottom, 244)
                .opacity(audioManager.isBlowingDetected ? 0 : 1)
                .animation(.easeInOut, value: audioManager.isBlowingDetected)
        }
        .onAppear {
            audioManager.startMonitoring() {
                viewModel.sendLanternInteractionCompleted()  // ✅ 바람 불기 완료 시 iPad로 메시지 전송
            }
        }
    }
}
