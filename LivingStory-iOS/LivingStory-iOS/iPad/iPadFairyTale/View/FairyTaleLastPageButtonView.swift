//
//  FairyTaleLastPageButtonVIew.swift
//  LivingStory-iOS
//
//  Created by 문창재 on 7/23/25.
//

import SwiftUI

struct FairyTaleLastPageButtonView: View {
    let leftaction:()->Void
    
    var body: some View {
        VStack{
            Spacer()
            HStack{
                LSLeftButtonView(action: leftaction)
                Spacer()
            }
        }
    }
}

#Preview {
    ZStack{
        FairyTaleLastPageButtonView(leftaction: {})
        FairyTaleEnddingView()
    }
    
}
