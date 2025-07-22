//
//  FairyTaleScriptView.swift
//  LivingStory-iOS
//
//  Created by 문창재 on 7/20/25.
//

import SwiftUI

struct FairyTaleScriptView: View {
    let script: String
    
    var body: some View {
        VStack{
            Spacer()
            HStack{
                Spacer()
                Text(script)
                    .font(LSFont.fairyTaleFont)
                    .foregroundStyle(.white)
                Spacer()
            }
            .padding()
        }.padding()
    }
}

#Preview {
    FairyTaleScriptView(script: "스크립트 들어갈 자리")
}
