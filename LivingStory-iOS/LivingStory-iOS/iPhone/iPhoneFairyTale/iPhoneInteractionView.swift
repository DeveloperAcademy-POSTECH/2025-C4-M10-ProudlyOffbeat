//
//  iPhoneInteractionView.swift
//  LivingStory-iOS
//
//  Created by jihanchae on 7/23/25.
//

import SwiftUI

struct iPhoneInteractionView: View {
    var body: some View {
        ZStack {
            Image("Lamp")
                .resizable()
                .edgesIgnoringSafeArea(.all)
            FireAnimationView()
        }
    }
}

#Preview {
    iPhoneInteractionView()
}
