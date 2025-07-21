//
//  ModuleFactory.swift
//  LivingStory-iOS
//
//  Created by Demian Yoo on 7/17/25.
//

import SwiftUI

protocol FactoryProtocol {
    //MARK: 아이패드
    func makeIntroViewForiPad() -> iPadIntroView
    func makeHomeLibraryView() -> HomeLibraryView
    func makeiPhonePairingView(book: BookType) -> iPhonePairingView
    
    //MARK: 아이폰
    func makeIntroViewForiPhone() -> iPhoneIntroView
    func makeiPadPairingView() -> iPadPairingView
}

final class ModuleFactory: FactoryProtocol {
    static let shared = ModuleFactory()
    private init() {}
    
    //MARK: 아이패드 함수 구현부
    func makeIntroViewForiPad() -> iPadIntroView {
        let viewModel = iPadIntroViewModel() // 필요 시
        return iPadIntroView(viewModel: viewModel)
    }
    
    func makeHomeLibraryView() -> HomeLibraryView {
        let viewModel = HomeLibraryViewModel()
        return HomeLibraryView(viewModel: viewModel)
    }
    
    func makeiPhonePairingView(book: BookType) -> iPhonePairingView {
        let viewModel = iPhonePairingViewModel()
        return iPhonePairingView(viewModel: viewModel, book: book)
    }
    
    //MARK: 아이폰 함수 구현부
    
    func makeIntroViewForiPhone() -> iPhoneIntroView {
        let viewModel = iPhoneIntroViewModel() // 필요 시
        return iPhoneIntroView(viewModel: viewModel)
    }
    
    func makeiPadPairingView() -> iPadPairingView {
        let viewModel = iPadPairingViewModel()
        return iPadPairingView(viewModel: viewModel)
    }
    
}
