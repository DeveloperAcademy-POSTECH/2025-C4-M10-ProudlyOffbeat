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
            .toolbar(.hidden, for: .navigationBar)
            .navigationDestination(for: AppRoute.self) { route in
                switch route {
                    // iPad iPhone분기
                case .intro:
                    if deviceInfo.deviceType == .iPad {
                        factory.makeIntroViewForiPad()
                            .toolbar(.hidden, for: .navigationBar)
                        
                    } else {
                        factory.makeIntroViewForiPhone()
                            .toolbar(.hidden, for: .navigationBar)
                    }
                    
                    // iPad
                case .iPadLibrary:
                    factory.makeHomeLibraryView()
                        .toolbar(.hidden, for: .navigationBar)
                    
                case .iPhonePairing(let book):
                    factory.makeiPhonePairingView(book: book)
                        .toolbar(.hidden, for: .navigationBar)
                    
                case .iPadFairyTale(let book):
                    factory.makeiPadFairyTaleView(book: book)
                        .toolbar(.hidden, for: .navigationBar)
                    
                    // iPhone
                case .iPadPairing:
                    factory.makeiPadPairingView()
                        .toolbar(.hidden, for: .navigationBar)
                }
                
            }
        }
    }
    
}
