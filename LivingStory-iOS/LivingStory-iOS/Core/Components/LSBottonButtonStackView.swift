//
//  LSBottonButtonStackView.swift
//  LivingStory-iOS
//
//  Created by 문창재 on 7/22/25.
//

import SwiftUI

struct LSBottonButtonStackView: View {
    let leftaction: () -> Void
    let rightaction: () -> Void
    
    var body: some View {
        VStack{
            Spacer()
            HStack{
                LSLeftButtonView(action: leftaction)
                Spacer()
                LSRightButtonView(action: rightaction)
            }
        }
    }
}
