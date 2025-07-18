//
//  RootNavigationView.swift
//  LivingStory-iOS
//
//  Created by Demian Yoo on 7/16/25.
//

import SwiftUI

struct RootNavigationView: View {
    @EnvironmentObject private var coordinator: AppCoordinator
    @EnvironmentObject private var deviceInfo: DeviceInfo
    private let factory: FactoryProtocol
    
    
    init(factory: FactoryProtocol) {
        self.factory = factory
    }
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            // 공통 진입점인 intro
            Group {
                if deviceInfo.deviceType == .iPad {
                    factory.makeIntroViewForiPad()
                } else {
                    factory.makeIntroViewForiPhone()
                }
            }
            .navigationDestination(for: AppRoute.self) { route in
                switch route {
                    // iPad iPhone분기
                case .intro:
                    if deviceInfo.deviceType == .iPad {
                        factory.makeIntroViewForiPad()
                    } else {
                        factory.makeIntroViewForiPhone()
                    }
                    // iPad
                case .iPadLibrary:
                    factory.makeHomeLibraryView()
                    
                case .iPhonePairing:
                    factory.makeiPhonePairingView()
                    
                    // iPhone
                case .iPadPairing:
                    factory.makeiPadPairingView()
                }
                
            }
        }
    }
    
}
