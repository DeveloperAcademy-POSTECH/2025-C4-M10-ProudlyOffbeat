//
//  Fire.swift
//  LivingStory-iOS
//
//  Created by jihanchae on 7/23/25.
//

import SwiftUI

struct FireAnimationView: View {
    @ObservedObject var viewModel:iPhoneFairyTaleViewModel

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
                .opacity(viewModel.isDone ? 0 : 1)
        }
        //AVFoundation에서 데시벨 기반으로 바람 불었음 유무 판단.
        //startMonitoring 선언 -> 데시벨 변화 관측
        .onAppear {
            viewModel.audioManager.startMonitoring()
        }
    }
}

#Preview {
    FireAnimationView(viewModel: iPhoneFairyTaleViewModel(audioManager: AudioInputModel()))
}
