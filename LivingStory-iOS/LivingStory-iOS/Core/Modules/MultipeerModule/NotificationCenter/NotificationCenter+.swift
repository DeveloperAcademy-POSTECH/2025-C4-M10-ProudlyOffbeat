//
//  NotificationCenter_.swift
//  LivingStory-iOS
//
//  Created by Demian Yoo on 7/27/25.
//

import Foundation

// 🔔 NotificationCenter 확장 (파일 맨 아래 추가)
extension Notification.Name {
    
    // MARK: - 돼지 삼형제
    static let pigInteractionStart = Notification.Name("PigInteractionStart")
    static let pigInteractionCompleted = Notification.Name("PigInteractionCompleted")
    
    // MARK: - 흥부전
    static let heungInteractionStart = Notification.Name("HeungInteractionStart")
    static let heungInteractionCompleted = Notification.Name("HeungInteractionCompleted")
    
    // MARK: - 오즈의 마법사
    static let ozInteractionStart = Notification.Name("OzInteractionStart")
    static let ozInteractionCompleted = Notification.Name("OzInteractionCompleted")
    
    // 책선택
    
    static let bookSelected = Notification.Name("BookSelected")
    
}
