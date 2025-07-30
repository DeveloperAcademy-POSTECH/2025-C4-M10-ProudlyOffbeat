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
                StoryPage(backgroundImageName: "pig3", script: "취침소등 하겠습니다", interaction: .lantern),
                StoryPage(backgroundImageName: "pig4", script: "취침소등 하겠습니다", interaction: nil),
                StoryPage(backgroundImageName: "pig5", script: "아기돼지는 잘 잔다", interaction: nil),
                StoryPage(backgroundImageName: "pig6", script: "", interaction: nil)
            ]),
            //흥부놀부 화면 추가
            StoryBook(type: .heung, pages: [
                StoryPage(backgroundImageName: "Heung1", script: "봄이 되었어요.\n지난해 다쳤던 제비가 박 씨 하나를 물고 왔어요.\n흥부와 흥부의 아내는 박 씨를 울타리에 심었어요.\n박은 지붕까지 뻗어 무럭무럭 잘 자랐어요.", interaction: nil),
                StoryPage(backgroundImageName: "Heung2", script: "흥부와 흥부의 아내는 보름달만큼 커다란 박을 땄지요.\n'이 바가지 복 바가지 슬근슬근 톱질하세'\n두 사람은 노래를 부르며 박을 탔어요", interaction: nil),
                StoryPage(backgroundImageName: "Heung3", script: "", interaction: .saw),
                StoryPage(backgroundImageName: "Heung4", script: "이게 웬 금은보화람!!", interaction: nil),
                StoryPage(backgroundImageName: "Heung5", script: "흥부의 가족들은 부자가 되었어요.", interaction: nil),
                StoryPage(backgroundImageName: "Heung6", script: "", interaction: nil)
            ])
        ]
}

enum InteractionType: Codable, Equatable {
    case none
    case lantern // 등불 터치
    case saw
    
    var rawValue: String {
        switch self {
        case .none: return "none"
        case .lantern: return "lantern"
        case .saw: return "saw"
        }
    }
    
    // 🆕 문자열에서 InteractionType 생성
    init?(rawValue: String) {
        switch rawValue {
        case "none": self = .none
        case "lantern": self = .lantern
        case "saw": self = .saw
        default: return nil
        }
    }
}

