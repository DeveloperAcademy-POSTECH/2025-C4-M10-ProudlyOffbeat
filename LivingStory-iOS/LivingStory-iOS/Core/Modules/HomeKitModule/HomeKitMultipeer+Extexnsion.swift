//
//  HomeKit.swift
//  LivingStory-iOS
//
//  Created by 문창재 on 7/24/25.
//
import Foundation
import HomeKit

// MARK: - HMHomeManagerDelegate
extension HomeKitManager: HMHomeManagerDelegate {
    func homeManagerDidUpdateHomes(_ manager: HMHomeManager) {
        updateAccessories()
    }
}
