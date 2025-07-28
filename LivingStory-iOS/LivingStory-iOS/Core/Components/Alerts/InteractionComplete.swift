//
//  InteractionComplete.swift
//  LivingStory-iOS
//
//  Created by Demian Yoo on 7/28/25.
//

import SwiftUI

struct InteractionComplete: View {
    let onConfirm: () -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            Text("인터랙션을 마무리해주세요.")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.red)
            
            Text("아이폰에서 미션을 수행해주세요.")
                .multilineTextAlignment(.center)
            
            
            Button("확인") { onConfirm() }
                .buttonStyle(.borderedProminent)
        }
        .padding(24)
        .frame(maxWidth:300)
        .background(Color(.systemBackground))
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.2), radius: 12, x: 0, y: 6)
    }
}
