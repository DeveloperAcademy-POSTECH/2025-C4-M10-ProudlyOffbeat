//
//  FairyTaleBackgroundView.swift
//  LivingStory-iOS
//
//  Created by 문창재 on 7/20/25.
//

import SwiftUI

struct FairyTaleBackgroundView: View {
    let scene: String
    
    var body: some View {
        Image(scene)
            .resizable()
            .scaledToFill()
            .ignoresSafeArea()
    }
}

#Preview {
    FairyTaleBackgroundView(scene: "pig1")
}
