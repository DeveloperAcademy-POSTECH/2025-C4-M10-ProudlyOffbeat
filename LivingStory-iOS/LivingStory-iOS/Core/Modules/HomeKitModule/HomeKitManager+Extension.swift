//
//  HomeKitManager+Extension.swift
//  LivingStory-iOS
//
//  Created by Demian Yoo on 7/28/25.
//

import HomeKit

extension HomeKitManager: HMHomeManagerDelegate {
    func homeManagerDidUpdateHomes(_ manager: HMHomeManager) {
        print("🏠 homeManagerDidUpdateHomes 호출됨!")
        print("🏠 홈 개수: \(manager.homes.count)")
        
        DispatchQueue.main.async {
            self.isHomeKitReady = true
            print("✅ HomeKit 준비 완료!")
        }
    }
}
