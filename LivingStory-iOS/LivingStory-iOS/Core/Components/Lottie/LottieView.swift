//
//  LottieView.swift
//  LivingStory-iOS
//
//  Created by jihanchae on 7/23/25.
//

import SwiftUI
import Lottie

struct LottieView: UIViewRepresentable {
    let filename: String
    let loopModel: LottieLoopMode
    
    func makeUIView(context: Context) -> Lottie.LottieAnimationView {
        let animationView = LottieAnimationView(name: filename)
        //loop 재생
        animationView.loopMode = loopModel
        animationView.contentMode = .scaleAspectFit
        animationView.translatesAutoresizingMaskIntoConstraints = true // 💡 프레임 기반 레이아웃 사용
        animationView.clipsToBounds = true
        animationView.play()
        
        return animationView
    }
    
    func updateUIView(_ uiView: Lottie.LottieAnimationView, context: Context) {
        
    }
}

