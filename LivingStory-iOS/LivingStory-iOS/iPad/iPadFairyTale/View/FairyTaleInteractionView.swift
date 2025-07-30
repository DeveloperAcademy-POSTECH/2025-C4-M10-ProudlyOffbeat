//
//  FairyTaleInteractionView.swift
//  LivingStory-iOS
//
//  Created by 문창재 on 7/22/25.
//

import SwiftUI

struct FairyTaleInteractionView: View {
    let action: () -> Void
    let bookType: BookType
    
    var body: some View {
        switch bookType {
        case .oz:
            Text("오즈 인터랙션 뷰")
        case .pig:
            iPadPigInteractionView(action: action)
        case .heung:
            iPadHeungInteractionView(action: action)
        }
    }
}

