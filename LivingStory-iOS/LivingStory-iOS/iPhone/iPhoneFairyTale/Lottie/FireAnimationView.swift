//
//  Fire.swift
//  LivingStory-iOS
//
//  Created by jihanchae on 7/23/25.
//

import SwiftUI

struct FireAnimationView: View {
    @StateObject private var monitor = AudioInputModel()
    @State private var isDone = false
    
    var body: some View {
        VStack {
            VStack(alignment: .center, spacing: 10) {
                Text("마이크에")
                    .font(LSFont.fairyTaleFont)
                Text("바람을 불어주세요")
                    .font(LSFont.fairyTaleFont)
            }
            .padding(.bottom, 315)
            
            if !isDone {
                LottieView(filename: "Fire", loopModel: .loop)
                    .frame(width: 100, height: 120)
                    .padding(.bottom, 244)
                    .transition(.opacity)
            }
        }
        //일단은 효과를 보여주기 위해 onTapGesture로 구현.
        //AVFoundation에서 데시벨 기반으로 바람 불었음 유무 판단해야할 것 같음.
        .onAppear {
                    monitor.startMonitoring()
                }
                .onChange(of: monitor.isBlowingDetected) { newValue in
                    if newValue {
                        withAnimation {
                            isDone = true
                        }
                    }
                }
            }
        }


#Preview {
    FireAnimationView()
}
