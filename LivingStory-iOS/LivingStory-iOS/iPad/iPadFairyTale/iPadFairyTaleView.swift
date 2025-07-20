//
//  iPadFairyTaleView.swift
//  LivingStory-iOS
//
//  Created by 문창재 on 7/20/25.
//

import SwiftUI

struct iPadFairyTaleView: View {
    @EnvironmentObject var coordinator: AppCoordinator
    @ObservedObject var viewModel: iPadFairyTaleViewModel
    let book: BookType
    
    var body: some View {
        ZStack {
            FairyTaleBackgroundView(scene: "pig1")
            //현재 인덱스에 따라 배경 바뀜.
            FairyTaleButtonView(script: "북 타입에 맞는 스크립트")
            //현재 인덱스에 따라 스크립트 바뀜
        }
    }
}


#Preview {
    iPadFairyTaleView(viewModel: iPadFairyTaleViewModel(), book: .pig)
}
