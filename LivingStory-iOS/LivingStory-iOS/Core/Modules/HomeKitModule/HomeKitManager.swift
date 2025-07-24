//
//  HomeKitManager.swift
//  LivingStory-iOS
//
//  Created by 문창재 on 7/24/25.
//

import Foundation
import HomeKit

final class HomeKitManager: NSObject, ObservableObject {
    // MARK: - HomeKit 프로퍼티
    private let homeManager = HMHomeManager()
    static let shared = HomeKitManager()
    @Published var academyHome: HMHome? //아카데미 홈과 연결
    @Published var accesoryList: [HMAccessory] = [] //아카데미 홈이 가지고 있는 기기 리스트
    @Published var light1: HMAccessory?
    @Published var light2: HMAccessory?
    @Published var nanoleaf: HMAccessory?
    
    // MARK: - 초기화
    override init() {
        super.init()
        homeManager.delegate = self //자기 자신에게 위임 HMHomeManager() 인스턴스를 처음 초기화할 때 delegate 함수가 실행됨
    }
    
    // MARK: - 홈이 로드되면 액세서리 목록 가져와서 프로퍼티에 넣는 함수
    internal func updateAccessories() {
        guard let home = homeManager.homes.filter({$0.name == "아카데미"}).first else { return }
        self.academyHome = home
        self.accesoryList = home.accessories
        
        guard let light1 = accesoryList.filter({$0.name == "전구1"}).first else { return }
        self.light1 = light1
        
        guard let light2 = accesoryList.filter({$0.name == "전구2"}).first else { return }
        self.light2 = light2
        
        guard let nanoleaf = accesoryList.filter({$0.name == "Nanoleaf"}).first else { return }
        self.nanoleaf = nanoleaf

    }
}


