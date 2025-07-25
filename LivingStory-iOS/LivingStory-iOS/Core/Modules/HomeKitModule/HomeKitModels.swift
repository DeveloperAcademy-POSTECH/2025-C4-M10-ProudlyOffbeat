//
//  HomeKitModels.swift
//  LivingStory-iOS
//
//  Created by 문창재 on 7/24/25.
//

enum PigFairyTaleScene: Int, FairyTaleSceneProtocol{
    case page1 = 1
    case page2 = 2
    case page3 = 3
    case page4 = 4
    case page5 = 5
    case page6 = 6

    var light1Setting: lightSetting {
        switch self {
        case .page1: return
            lightSetting(brigthness: 100, hue: 30, saturation: 100)
        case .page2: return
            lightSetting(brigthness: 100, hue: 30, saturation: 100)
        case .page3: return
            lightSetting(brigthness: 100, hue: 30, saturation: 100)
        case .page4: return
            lightSetting(brigthness: 100, hue: 30, saturation: 100)
        case .page5: return
            lightSetting(brigthness: 100, hue: 30, saturation: 100)
        case .page6: return
            lightSetting(brigthness: 100, hue: 30, saturation: 100)
        }
    }

    var light2Setting: lightSetting {
        switch self {
        case .page1: return
            lightSetting(brigthness: 100, hue: 30, saturation: 100)
        case .page2: return
            lightSetting(brigthness: 100, hue: 30, saturation: 100)
        case .page3: return
            lightSetting(brigthness: 100, hue: 30, saturation: 100)
        case .page4: return
            lightSetting(brigthness: 100, hue: 30, saturation: 100)
        case .page5: return
            lightSetting(brigthness: 100, hue: 30, saturation: 100)
        case .page6: return
            lightSetting(brigthness: 100, hue: 30, saturation: 100)
        }
    }
    
    var nanoleafSetting: lightSetting {
        switch self {
        case .page1: return
            lightSetting(brigthness: 100, hue: 30, saturation: 100)
        case .page2: return
            lightSetting(brigthness: 100, hue: 30, saturation: 100)
        case .page3: return
            lightSetting(brigthness: 100, hue: 30, saturation: 100)
        case .page4: return
            lightSetting(brigthness: 100, hue: 30, saturation: 100)
        case .page5: return
            lightSetting(brigthness: 100, hue: 30, saturation: 100)
        case .page6: return
            lightSetting(brigthness: 100, hue: 30, saturation: 100)
        }
    }

}
    

struct lightSetting{
    let brigthness: Int
    let hue: Float
    let saturation: Float
}

protocol FairyTaleSceneProtocol {
    var light1Setting: lightSetting { get }
    var light2Setting: lightSetting { get }
    var nanoleafSetting: lightSetting { get }
}
