//
//  HomeKitManager+Extension.swift
//  LivingStory-iOS
//
//  Created by Demian Yoo on 7/28/25.
//

import HomeKit

extension HomeKitManager: HMHomeManagerDelegate {
    func homeManagerDidUpdateHomes(_ manager: HMHomeManager) {
        print("홈 정보 업데이트 됨.")
        updateAccessoriesAndScenes()
    }
}
