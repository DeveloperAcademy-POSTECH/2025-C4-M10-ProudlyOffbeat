//
//  FairyTaleEnddingView.swift
//  LivingStory-iOS
//
//  Created by 문창재 on 7/23/25.
//

import SwiftUI

struct FairyTaleEnddingView: View {
    var body: some View {
        ZStack{
            Image("PigBand")
                .padding(.trailing, 380)
            Image("Wolf")
                .padding(.leading, 800)
        }.frame(width: UIScreen.main.bounds.width)
    }
}

#Preview {
    FairyTaleEnddingView()
}
