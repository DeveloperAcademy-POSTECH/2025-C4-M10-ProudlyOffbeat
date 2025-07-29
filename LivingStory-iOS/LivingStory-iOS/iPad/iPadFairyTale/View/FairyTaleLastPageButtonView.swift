//
//  FairyTaleLastPageButtonVIew.swift
//  LivingStory-iOS
//
//  Created by 문창재 on 7/23/25.
//

import SwiftUI

struct FairyTaleLastPageButtonView: View {
    let leftaction:() -> Void
    let homeAction:() -> Void
    
    var body: some View {
        VStack{
            HStack{
                LSReturnToHomeButtonView(action: homeAction)
                Spacer()
            }
            Spacer()
            HStack{
                LSLeftButtonView(action: leftaction)
                Spacer()
            }
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    }
}

#Preview {
    ZStack{
        FairyTaleLastPageButtonView(leftaction: {},homeAction: {})
        FairyTaleEnddingView(bookType: .pig)
    }
    
}
