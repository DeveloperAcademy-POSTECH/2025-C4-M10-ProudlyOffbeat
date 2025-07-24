import Foundation
import HomeKit

// MARK: - HomeKitManager 클래스
final class HomeKitManager: NSObject, ObservableObject {
    // MARK: - HomeKit 프로퍼티
    private let homeManager = HMHomeManager()
    @Published var primaryHome: HMHome?
    @Published var lights: [HMAccessory] = []
    
    // MARK: - 초기화
    override init() {
        super.init()
        homeManager.delegate = self
    }
    
    // MARK: - 홈이 로드되면 액세서리(조명 등) 목록 가져오기
    private func updateAccessories() {
        guard let home = homeManager.primaryHome else { return }
        self.primaryHome = home
        // 조명만 필터링 (Lightbulb 서비스)
        self.lights = home.accessories.filter { accessory in
            accessory.services.contains { $0.serviceType == HMServiceTypeLightbulb }
        }
    }
    
    // MARK: - 조명 끄기 함수
    func turnOffAllLights() {
        for light in lights {
            setLight(light, on: false)
        }
    }
    
    // MARK: - 조명 켜기 함수
    func turnOnAllLights() {
        for light in lights {
            setLight(light, on: true)
        }
    }
    
    // MARK: - 개별 조명 on/off 제어
    func setLight(_ accessory: HMAccessory, on: Bool) {
        for service in accessory.services where service.serviceType == HMServiceTypeLightbulb {
            for characteristic in service.characteristics where characteristic.characteristicType == HMCharacteristicTypePowerState {
                characteristic.writeValue(on) { error in
                    if let error = error {
                        print("조명 제어 실패: \(error.localizedDescription)")
                    } else {
                        print("조명 \(on ? "켜짐" : "꺼짐") 성공")
                    }
                }
            }
        }
    }
}

// MARK: - HMHomeManagerDelegate
extension HomeKitManager: HMHomeManagerDelegate {
    func homeManagerDidUpdateHomes(_ manager: HMHomeManager) {
        updateAccessories()
    }
} 