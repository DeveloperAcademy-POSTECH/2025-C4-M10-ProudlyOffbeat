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
    let loopMode: LottieLoopMode
    @Binding var isPlaying: Bool
    
    class Coordinator {
        var animationView: LottieAnimationView?
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    func makeUIView(context: Context) -> LottieAnimationView {
        let animationView = LottieAnimationView(name: filename)
        animationView.loopMode = loopMode
        animationView.contentMode = .scaleAspectFit
        animationView.translatesAutoresizingMaskIntoConstraints = true
        animationView.clipsToBounds = true
        
        context.coordinator.animationView = animationView
        return animationView
    }

    func updateUIView(_ uiView: LottieAnimationView, context: Context) {
        if isPlaying {
            uiView.play()
            } else {
            uiView.stop()
        }
    }
}

