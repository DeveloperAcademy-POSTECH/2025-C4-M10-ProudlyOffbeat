//
//  ConnectListScrollView.swift
//  LivingStory-iOS
//
//  Created by Demian Yoo on 7/23/25.
//

import SwiftUI

struct ConnectListScrollView: View {
    @ObservedObject var viewModel: iPhonePairingViewModel
    
    var body: some View {
        ScrollView{
            if viewModel.discoveredDevices.isEmpty {
                VStack {
                    Text("iPhone을 찾고 있습니다...")
                        .foregroundColor(.gray)
                        .font(.system(size: 12))
                    
                    ProgressView()
                        .scaleEffect(0.8)
                        .padding(.top, 5)
                }
                .padding(.top, 50)
            } else {
                ForEach(viewModel.discoveredDevices, id: \.id) { device in
                    ConnectCellView(
                        deviceId: device.mcPeerID.displayName,
                        action: {
                            viewModel.sendConnectionToiPhone(to: device.mcPeerID)
                        }
                    )
                    .padding(.horizontal, 20)
                    .transition(.opacity.combined(with: .scale))
                }
            }
        }
        .padding(.top)
    }
}

#Preview {
    ConnectListScrollView(viewModel: iPhonePairingViewModel(bookType: .pig, multipeerManager: MultipeerManager.shared))
}
