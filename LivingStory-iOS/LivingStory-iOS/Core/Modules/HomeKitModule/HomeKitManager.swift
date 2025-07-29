//
//  HomeKitManager.swift
//  LivingStory-iOS
//
//  Created by 문창재 on 7/24/25.
//

import Foundation
import HomeKit

final class HomeKitManager: NSObject, ObservableObject {
    private var homeManager = HMHomeManager()
    static let shared = HomeKitManager()
    
    @Published var isHomeKitReady = false
    
    private override init() {
        super.init()
        print("HomeKitManager 초기화 시작")
        homeManager.delegate = self
    }
    
    // Scene 실행 함수 (통합)
    func executeScene(named sceneName: String) {
        guard isHomeKitReady else {
            print("⚠️ HomeKit이 아직 준비되지 않았습니다")
            return
        }
        
        guard let academyHome = homeManager.homes.first(where: { $0.name == "아카데미" }) else {
            print("❌ '아카데미' 홈을 찾을 수 없습니다")
            return
        }
        
        guard let scene = academyHome.actionSets.first(where: { $0.name == sceneName }) else {
            print("❌ '\(sceneName)' Scene을 찾을 수 없습니다")
            print("📝 사용 가능한 Scene 목록:")
            for actionSet in academyHome.actionSets {
                print("  - \(actionSet.name)")
            }
            return
        }
        
        academyHome.executeActionSet(scene) { error in
            DispatchQueue.main.async {
                if let error = error {
                    print("❌ Scene '\(sceneName)' 실행 실패: \(error.localizedDescription)")
                } else {
                    print("✅ Scene '\(sceneName)' 실행 성공")
                }
            }
        }
    }
    
    // 기존 함수들을 Scene 실행으로 변경
    func setPigLighting(pageIndex: Int) {
        let scene = PigFairyTaleScene(rawValue: pageIndex) ?? .page0
        executeScene(named: scene.shortcutName)
        print("돼지 동화 \(pageIndex)페이지 조명 설정: \(scene.shortcutName)")
    }
    
    func setHeungLighting(pageIndex: Int) {
        let scene = HeungFairyTaleScene(rawValue: pageIndex) ?? .page0
        executeScene(named: scene.shortcutName)
        print("흥부 동화 \(pageIndex)페이지 조명 설정: \(scene.shortcutName)")
    }
    
    func setDefaultLighting() {
        executeScene(named: AppDefaultLighting.defaultShortCut)
        print("🏠 기본 조명 설정: \(AppDefaultLighting.defaultShortCut)")
    }
    
}
