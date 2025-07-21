//
//  ButtonView.swift
//  LivingStory-iOS
//
//  Created by 문창재 on 7/20/25.
//

import SwiftUI

struct FairyTaleButtonView: View {
    let script:String
    var body: some View {
        VStack{
            HStack{
                Button{
                    // 홈으로 가는 로직
                }label: {
                    Image("HomeButton")
                        .padding()
                }
                Spacer()
            }
            Spacer()
            HStack{
                Button{
                    // 이전으로 가는 로직
                }label: {
                    Image("PreviousButton")
                        .padding()
                }
                Spacer()
                FairyTaleScriptView(script: script)
                Spacer()
                Button{
                    // 다음으로 가는 로직
                }label: {
                    Image("NextButton")
                        .padding()
                }
            }
        }
    }
}

#Preview {
    FairyTaleButtonView(script: "스크립트 들어갈 자리")
}
