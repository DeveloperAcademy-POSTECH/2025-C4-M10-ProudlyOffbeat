//
//  Untitled.swift
//  LivingStory-iOS
//
//  Created by 문창재 on 7/18/25.
//

import SwiftUI

struct ConnectListView: View {
    @ObservedObject var viewModel: iPhonePairingViewModel
    
    var body: some View {
        ZStack{
            Image("ConnectListBackground")
            GeometryReader{ geometry in
                VStack{
                    FindYouriPhoneTextView()
                    ConnectListScrollView(viewModel: viewModel)
                }
            }
            
        }.frame(width: 327, height: 404)
    }
}

#Preview {
    ConnectListView(viewModel: iPhonePairingViewModel(bookType: .pig, multipeerManager: MultipeerManager.shared))
}
