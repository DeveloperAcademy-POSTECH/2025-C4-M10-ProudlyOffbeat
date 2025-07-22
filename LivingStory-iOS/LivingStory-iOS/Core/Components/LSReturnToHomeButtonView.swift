//
//  LSReturnToHomeButtonView.swift
//  LivingStory-iOS
//
//  Created by 문창재 on 7/22/25.
//

import SwiftUI

struct LSReturnToHomeButtonView: View {
    let action: () -> Void
    var body: some View {
        Button{
            action()
        }label: {
            Image("HomeButton")
                .padding()
        }
    }
}
