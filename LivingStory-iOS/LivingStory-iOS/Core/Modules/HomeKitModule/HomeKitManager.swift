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
    
    private override init() {
        super.init()
        homeManager.delegate = self
        
    }
    
    //MARK: - 단축어 실행 함수
    
    func actionSet(scene: FairyTaleSceneProtocol) {
        executeScene(named: scene.shortcutName)
    }
    
    // 기본 조명 설정
    func setDefaultLighting() {
        executeScene(named: AppDefaultLighting.defaultShortCut)
        print("🏠 기본 조명 설정: \(AppDefaultLighting.defaultShortCut)")
    }
    
    
    //MARK: 돼지 동화 조명
    
    // 돼지 동화 특정 페이지 조명 설정
    func setPigInteractionLighting(page: Int) {
        let scene = PigFairyTaleScene(rawValue: page) ?? .page0
        executeScene(named: scene.shortcutName)
        print("돼지 동화 \(page)페이지 조명 설정: \(scene.shortcutName)")
    }
    
    private func executeScene(named sceneName: String) {
        guard let home = homeManager.homes.first else {
            print("❌ 홈을 찾을 수 없습니다")
            return
        }
        
        guard let scene = home.actionSets.first(where: {$0.name == sceneName }) else {
            print("❌ 해당 이름의 Scene(모드)를 찾을 수 없습니다: \(sceneName)")
            return
        }
        
        home.executeActionSet(scene) { error in
            if let error = error {
                print("❌ Scene 실행 실패: \(error.localizedDescription)")
            } else {
                print("✅ Scene 실행 성공: \(sceneName)")
            }
        }
    }
    
    // MARK: - 홈 정보 업데이트 (디버깅용)
    func updateAccessoriesAndScenes() {
        guard let home = homeManager.homes.first else { return }
        
        print("🏠 홈 이름: \(home.name)")
        print(" 사용 가능한 Scene(모드) 목록:")
        
        for scene in home.actionSets {
            print("- \(scene.name)")
        }
    }
}
