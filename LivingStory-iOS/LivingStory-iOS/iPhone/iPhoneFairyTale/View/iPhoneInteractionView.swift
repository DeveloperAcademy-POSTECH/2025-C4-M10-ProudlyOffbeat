//
//  iPhoneInteractionView.swift
//  LivingStory-iOS
//
//  Created by jihanchae on 7/23/25.
//

import SwiftUI

struct iPhoneInteractionView: View {
    @ObservedObject var viewModel: iPhoneFairyTaleViewModel
    
    var body: some View {
        ZStack {
            Image("Lamp")
                .resizable()
                .edgesIgnoringSafeArea(.all)
            FireAnimationView(viewModel: iPhoneFairyTaleViewModel(audioManager: AudioInputModel()))
        }
    }
}
