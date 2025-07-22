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
    
    static let allBooks: [StoryBook] = [
            StoryBook(type: .pig, pages: [
                StoryPage(backgroundImageName: "pig1", script: "아기돼지 삼형제가\n자려고 누웠어요", interaction: nil),
                StoryPage(backgroundImageName: "pig2", script: "방에 불이 켜져있네요?", interaction: nil),
                StoryPage(backgroundImageName: "pig3", script: "취침소등 하겠습니다", interaction: nil),
                StoryPage(backgroundImageName: "pig4", script: "불이 꺼짐", interaction: nil),
                StoryPage(backgroundImageName: "pig5", script: "아기돼지는 잘 잔다", interaction: nil),
                StoryPage(backgroundImageName: "pig6", script: "", interaction: nil)
            ])
        ]
}

enum InteractionType: Codable, Equatable {
    case none
    case lantern // 등불 터치
    // 필요시 case throw, case shake 등 추가
}

