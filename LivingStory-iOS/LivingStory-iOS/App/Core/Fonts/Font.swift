//
//  Font.swift
//  LivingStory-iOS
//
//  Created by 문창재 on 7/19/25.
//
import SwiftUI


enum LSFont{
    static let homeDoorFont:Font = .custom("BinggraeSamanco-Bold", size: 30) // 홈 문위 안내 폰트
    
    static let bookTitleFont:Font = .custom("BinggraeSamanco-Bold", size: 17) // 동화 이름 폰트
    
    static let fairyTaleFont:Font = .custom("BinggraeSamanco-Bold", size: 48) // 동화 폰트
    
    static let iPadConncetFont:Font = .system(size: 11).weight(.regular) // 커넥트 버튼
    
    // 아이폰 폰트
    
    static let iPhoneConnectFont:Font = .custom("BinggraeSamanco-Bold", size: 30) // 홈 문위 안내 폰트
}

#Preview(body: {
    // 사용방식
    Text("Test 테스트용 프리뷰")
        .font(LSFont.fairyTaleFont)
})
