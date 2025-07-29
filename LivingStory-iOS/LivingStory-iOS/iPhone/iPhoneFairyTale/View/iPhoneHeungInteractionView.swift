//
//  iPhoneHeungInteractionView.swift
//  LivingStory-iOS
//
//  Created by 문창재 on 7/28/25.
//

import SwiftUI

struct iPhoneHeungInteractionView: View {
    @State private var shakeCount = 0
       let targetShakeCount = 20
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
                    ProgressView(value: Double(shakeCount) / Double(targetShakeCount))
                        .progressViewStyle(LinearProgressViewStyle(tint: .red))
                        .padding()
                }.frame(width: 700,height: 10)
                    .padding(.bottom, 300)
                
                Spacer()
            }.rotationEffect(.degrees(90))
                .frame(width: UIScreen.main.bounds.width)
        }
        .onAppear {
            CoreMotionManager.shared.onShake = {
                            if shakeCount < targetShakeCount {
                                shakeCount += 1
                                if shakeCount >= targetShakeCount {
                                            viewModel.sendLanternInteractionCompleted()
                                    DispatchQueue.main.async {
                                        print("인터랙션 완료")
                                        CoreMotionManager.shared.stopMotionUpdates()
                                        AudioInputModel().playGoldSound()
                                    }   
                                        }
                            }
                        }
            if !CoreMotionManager.shared.motionManager.isAccelerometerActive {
                CoreMotionManager.shared.startMotionUpdates()
            }
        }
        .onDisappear {
            CoreMotionManager.shared.onShake = nil // 메모리 누수 방지
        }
    }
}

#Preview {
    iPhoneHeungInteractionView(viewModel: iPhoneFairyTaleViewModel(multipeerManager: MultipeerManager.shared, bookType: .heung))
}
