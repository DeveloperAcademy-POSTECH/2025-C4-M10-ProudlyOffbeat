//
//  DeviceInfo.swift
//  LivingStory-iOS
//
//  Created by Demian Yoo on 7/17/25.
//
import Foundation
import SwiftUI

enum DeviceType {
    case iPhone
    case iPad
}

final class DeviceInfo: ObservableObject {
    let deviceType: DeviceType
    
    init() {
        #if os(iOS)
        self.deviceType = UIDevice.current.userInterfaceIdiom == .pad ? .iPad : .iPhone
        #else
        self.deviceType = .iPhone
        #endif
    }
}
