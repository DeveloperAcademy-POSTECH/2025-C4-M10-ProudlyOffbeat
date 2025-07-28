//
//  AppCoordinator.swift
//  LivingStory-iOS
//
//  Created by Demian Yoo on 7/16/25.
//

import SwiftUI

@MainActor
final class AppCoordinator: ObservableObject {
    
    /// 화면 전환 경로를 관리하는 Navigation Stack (LIFO 구조)
    @Published var path = NavigationPath()
    
    /// push - 다음 화면으로 넘어갈 때 사용하는 메서드 ( 실제 메서드 사용시 _route 인자부분에 전환하려하는 다음 화면 명시적으로 )
    func push(_ route: AppRoute) {
        path.append(route)
    }
    
    /// pop - 이전 화면으로 pop함
    func pop() {
        path.removeLast()
    }
    
    /// path 리스트에 쌓인 모든 화면을 지우고, 루트 (홈)으로 돌아가게하는 메서드
    func goToRoot() {
        path.removeLast(path.count)
        path.append(AppRoute.iPadLibrary)
        
    }
    
    func goToIPhoneRoot() {
        path.removeLast(path.count)
        path.append(AppRoute.iPadPairing)
    }
}
