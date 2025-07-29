//
//  FairyTaleEnddingView.swift
//  LivingStory-iOS
//
//  Created by 문창재 on 7/23/25.
//

import SwiftUI

struct FairyTaleEnddingView: View {
    let bookType: BookType
    
    var body: some View {
        VStack{
            Image("EndingText")
                .padding(.top, 135)
            Spacer()
            if bookType == .pig{
                HStack{
                    Image("PigBand")
                        .resizable()
                        .frame(width: 700, height: 700)
                    Image("Wolf")
                        .resizable()
                        .frame(width: 600, height: 600)
                }
            }else{
                Image("HeungEnding")
            }
            
            
        }
    }
}

#Preview {
    FairyTaleEnddingView(bookType: .pig)
}
