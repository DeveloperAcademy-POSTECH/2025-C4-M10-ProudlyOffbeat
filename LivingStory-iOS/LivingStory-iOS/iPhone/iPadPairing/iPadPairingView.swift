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
        ZStack {
            Image("Room(cut)")
                .resizable()
                .ignoresSafeArea(edges:.all)
            Image("iPhoneBackground")
            WifiConnectView(viewModel: viewModel)
            
            if viewModel.showConnectedAlert {
                Color.black.opacity(0.3)
                    .ignoresSafeArea()
                FromiPadConnectedAlert(
                    connectedDeviceName: viewModel.connectedDeviceName,
                    onConfirm: {
                        viewModel.dismissConnectAlert()
                    }
                )
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: .pigInteractionStart)) { _ in
            if let bookType = viewModel.selectedBookType {
                viewModel.goToFairyTaleView(coordinator: coordinator, bookType: bookType)
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: .heungInteractionStart)) { _ in
            if let bookType = viewModel.selectedBookType {
                viewModel.goToFairyTaleView(coordinator: coordinator, bookType: bookType)
            }        }
        .onReceive(NotificationCenter.default.publisher(for: .ozInteractionStart)) { _ in
            if let bookType = viewModel.selectedBookType {
                viewModel.goToFairyTaleView(coordinator: coordinator, bookType: bookType)
            }        }
    }
}
