//
//  FairyTaleEnddingView.swift
//  LivingStory-iOS
//
//  Created by 문창재 on 7/23/25.
//

import SwiftUI

struct FairyTaleEnddingView: View {
    var body: some View {
        VStack {
            Image("PigEndText")
                .padding(.top, 130)
            HStack {
                Image("PigBand")
                    .padding(.leading, 190)
                Image("Wolf")
                    .padding(.trailing, 30)
            }
            .padding(.bottom, 100)
        }
    }
}

#Preview {
    FairyTaleEnddingView()
}
