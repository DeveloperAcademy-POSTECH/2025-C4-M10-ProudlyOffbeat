//
//  iPadParingView.swift
//  LivingStory-iOS
//
//  Created by Demian Yoo on 7/17/25.
//

import SwiftUI

struct iPadPairingView: View {
    @EnvironmentObject var coordinator: AppCoordinator
    @ObservedObject var viewModel: iPadPairingViewModel
    
    var body: some View {
        ZStack{
            Image("iPhoneBackground")
            MPCimageView()
        }
    }
}


#Preview {
    iPadPairingView(viewModel: iPadPairingViewModel())
}
