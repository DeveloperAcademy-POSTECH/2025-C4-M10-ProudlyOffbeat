//
//  FairyTaleModel.swift
//  LivingStory-iOS
//
//  Created by 문창재 on 7/20/25.
//


struct StoryPage {
    let backgroundImageName: String
    let script: String
    let interaction: InteractionType?
}

struct StoryBook {
    let type: BookType
    let pages: [StoryPage]
}

enum InteractionType: Codable, Equatable {
    case none
    case lantern // 등불 터치
    // 필요시 case throw, case shake 등 추가
}
