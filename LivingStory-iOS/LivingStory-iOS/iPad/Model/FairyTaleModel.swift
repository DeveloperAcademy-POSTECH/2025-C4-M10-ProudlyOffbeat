//
//  FairyTaleModel.swift
//  LivingStory-iOS
//
//  Created by 문창재 on 7/20/25.
//


struct StoryPage {
    let backgroundImageName: String
    let script: String
}

struct StoryBook {
    let type: BookType
    let pages: [StoryPage]
}
