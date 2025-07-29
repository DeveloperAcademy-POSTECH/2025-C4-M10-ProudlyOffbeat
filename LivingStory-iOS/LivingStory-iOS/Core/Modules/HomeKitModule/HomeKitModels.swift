//
//  HomeKitModels.swift
//  LivingStory-iOS
//
//  Created by 문창재 on 7/24/25.
//

// 돼지 동화
enum PigFairyTaleScene: Int, FairyTaleSceneProtocol{
    case page0 = 0
    case page1 = 1
    case page2 = 2
    case page3 = 3
    case page4 = 4
    case page5 = 5
    
    var shortcutName: String {
        switch self {
        case .page0, .page1, .page2, .page4, .page5:
            return "PigLightOn"
        case .page3:
            return "PigLightOff"
        }
    }
    
}

// 흥부놀부 동화 씬
enum HeungFairyTaleScene: Int, FairyTaleSceneProtocol {
    case page0 = 0
    case page1 = 1
    case page2 = 2
    case page3 = 3
    case page4 = 4
    case page5 = 5
    
    var shortcutName: String {
        switch self {
        case .page0, .page1:
            return "HeungStart" // 흥부놀부용 조명 단축어
        case .page2:
            return "HeungInteraction"
        case .page3, .page4, .page5:
            return "HeungTreasure"
        }
    }
}

enum AppDefaultLighting {
    static let defaultShortCut = "LightDefault"
}


protocol FairyTaleSceneProtocol {
    var shortcutName: String { get }
}
