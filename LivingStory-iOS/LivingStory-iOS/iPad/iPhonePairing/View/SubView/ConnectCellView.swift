//
//  ConnectCellView.swift
//  LivingStory-iOS
//
//  Created by 문창재 on 7/19/25.
//
import SwiftUI

struct ConnectCellView: View {
    let device: PeerDevice
    @ObservedObject var viewModel: iPhonePairingViewModel
    
    private var isConnected: Bool {
        viewModel.connectedDevices.contains { $0.mcPeerID == device.mcPeerID }
    }
    
    private var onConnect: () -> Void {
        { viewModel.sendConnectionToiPhone(to: device.mcPeerID) }
    }
    
    private var onDisconnect: () -> Void {
        { viewModel.disconnectiPhone(device.mcPeerID) }
    }
    
    var body: some View {
        HStack{
            Text(device.mcPeerID.displayName)
                .font(.system(size: 11))
                .padding(10)
            Spacer()
            PeerConnectButtonView(
                isConnected: isConnected,
                action: isConnected ? onDisconnect : onConnect
            )
        }.background(Color.white.cornerRadius(5))
    }
}

