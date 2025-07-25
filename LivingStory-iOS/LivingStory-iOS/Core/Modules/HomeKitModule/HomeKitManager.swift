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
    
    // MARK: - actionSet  홈앱의 자동화처럼 할 수도 있지만 현재는 유연한 설계 위해 즉시 실행방식
    
    func actionSet(scene:FairyTaleSceneProtocol){
        if let light1 = light1{
            setBrightness(accessory: light1, brightness: scene.light1Setting.brigthness)
            setColor(accessory: light1, hue: scene.light1Setting.hue, saturation: scene.light1Setting.saturation)
            print("전구1이 페이지:\(scene)에 맞게 설정 됨")
        }
        
        if let light2 = light2{
            setBrightness(accessory: light2, brightness: scene.light2Setting.brigthness)
            setColor(accessory: light2, hue: scene.light2Setting.hue, saturation: scene.light2Setting.saturation)
            print("전구2가 페이지:\(scene)에 맞게 설정 됨")
        }
        
        if let nanoleaf = nanoleaf{
            setBrightness(accessory: nanoleaf, brightness: scene.nanoleafSetting.brigthness)
            setColor(accessory: nanoleaf, hue: scene.nanoleafSetting.hue, saturation: scene.nanoleafSetting.saturation)
            print("나노리프가 페이지:\(scene)에 맞게 설정 됨")
        }
    }
    
    
    // MARK: - 악세사리 서비스에서 Characteristic 가져오는 함수
    
    func getCharacteristic(accessory: HMAccessory, type: String) -> HMCharacteristic? {
        return accessory.services.flatMap { $0.characteristics }.first { $0.characteristicType == type }
        
    }
    
    // MARK: - 색상, 채도, 밝기 설정 함수
    
    func setBrightness(accessory:HMAccessory ,brightness value: Int) {
        guard let brightnessCharacteristic = getCharacteristic(accessory: accessory, type: HMCharacteristicTypeBrightness) else { return }
        brightnessCharacteristic.writeValue(value) { error in
                if let error = error {
                    print("오류 발생: \(error.localizedDescription)")
                } else {
                    print("brightness 설정 성공")
                }
        }
    }

    // 색상(Hue)과 채도(Saturation) 동시에 변경
    func setColor(accessory:HMAccessory, hue: Float, saturation: Float = 100) {
        guard let hueCharacteristic = getCharacteristic(accessory: accessory, type: HMCharacteristicTypeHue),
              let saturationCharacteristic = getCharacteristic(accessory: accessory, type: HMCharacteristicTypeSaturation)
        else { return }
        
        // Hue 먼저 변경
        hueCharacteristic.writeValue(hue) { error in
            if let error = error {
                print("오류 발생: \(error.localizedDescription)")
            } else {
                print("hue 설정 성공")
            }
        }
            // 그 다음 Saturation 변경
        saturationCharacteristic.writeValue(saturation){ error in
                if let error = error {
                    print("오류 발생: \(error.localizedDescription)")
                } else {
                    print("saturation 설정 성공")
                }
            }
        }
    }



