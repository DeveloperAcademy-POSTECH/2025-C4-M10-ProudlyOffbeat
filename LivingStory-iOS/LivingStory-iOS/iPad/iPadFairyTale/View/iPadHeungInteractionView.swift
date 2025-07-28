//
//  HeungInteractionView.swift
//  LivingStory-iOS
//
//  Created by 문창재 on 7/28/25.
//

import SwiftUI

struct iPadHeungInteractionView: View {
    let action: () -> Void
    @State var isScaled: Bool = false
    
    var body: some View {
        Button{
            withAnimation(.easeOut(duration: 0.15)) {
                isScaled = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                withAnimation(.easeIn(duration: 0.15)) {
                    isScaled = false
                }
            }
            action() //multipeer send 메소드
            print("아이폰으로 흥부 인터랙션 메시지 전송")
        }label: {
            Image("Saw")
                .scaleEffect(isScaled ? 1.2 : 1.0)
        }
    }
}

#Preview {
    ZStack{
        Image("Heung3")
            .resizable()
            .ignoresSafeArea()
        iPadHeungInteractionView(action: {}, isScaled: false)
    }
    
}
