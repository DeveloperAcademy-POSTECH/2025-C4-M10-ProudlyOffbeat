//
//  ButtonView.swift
//  LivingStory-iOS
//
//  Created by 문창재 on 7/20/25.
//

import SwiftUI

struct FairyTaleButtonView: View {
    let homeButtonaction:()->Void
    let leftaction:()->Void
    let rightaction:()->Void
    
    var body: some View {
        VStack{
            HStack{
               LSReturnToHomeButtonView(action: homeButtonaction)
                Spacer()
            }
            Spacer()
            LSBottonButtonStackView(leftaction: leftaction, rightaction: rightaction)
        }
    }
}
