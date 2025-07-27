//
//  AppRoute.swift
//  LivingStory-iOS
//
//  Created by Demian Yoo on 7/16/25.
//

import Foundation

// NavigationPath는 Hashable을 요구
enum AppRoute: Hashable {
    
    // 공통
    case intro
    
    // iPad 경로
    case iPadLibrary
    case iPhonePairing(book: BookType)
    case iPadFairyTale(book: BookType)
    
    // iPhone 경로
    case iPadPairing
    case iPhoneFairyTale(bookType: FairyTaleID)
    
}
