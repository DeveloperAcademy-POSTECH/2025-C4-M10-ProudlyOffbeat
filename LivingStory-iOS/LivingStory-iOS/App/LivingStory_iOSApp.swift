//
//  LivingStory_iOSApp.swift
//  LivingStory-iOS
//
//  Created by Demian Yoo on 7/15/25.
//

import SwiftUI
//import HomeKitModule
//import MultiPeerModule

@main
struct LivingStory_iOSApp: App {
    @StateObject private var coordinator = AppCoordinator()
    @StateObject private var deviceInfo = DeviceInfo()
    
    
    var body: some Scene {
        WindowGroup {
            RootNavigationView(factory: ModuleFactory.shared)
                .environmentObject(coordinator)
                .environmentObject(deviceInfo)
        }
    }
}
