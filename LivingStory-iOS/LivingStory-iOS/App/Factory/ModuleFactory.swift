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
    func makeiPadFairyTaleView(book: BookType) -> iPadFairyTaleView
    
    //MARK: 아이폰
    func makeIntroViewForiPhone() -> iPhoneIntroView
    func makeiPadPairingView() -> iPadPairingView
}

final class ModuleFactory: FactoryProtocol {

    static let shared = ModuleFactory()
    
    private let multipeerManager = MultipeerManager.shared
    
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
        let viewModel = iPhonePairingViewModel(bookType: book, multipeerManager: multipeerManager)
        return iPhonePairingView(viewModel: viewModel)
    }
    
    func makeiPadFairyTaleView(book: BookType) -> iPadFairyTaleView {
        let viewModel = iPadFairyTaleViewModel(bookType: book)
        return iPadFairyTaleView(viewModel: viewModel)
    }
    
    //MARK: 아이폰 함수 구현부
    
    func makeIntroViewForiPhone() -> iPhoneIntroView {
        let viewModel = iPhoneIntroViewModel() // 필요 시
        return iPhoneIntroView(viewModel: viewModel)
    }
    
    func makeiPadPairingView() -> iPadPairingView {
        let viewModel = iPadPairingViewModel(multipeerManager: multipeerManager)
        return iPadPairingView(viewModel: viewModel)
    }
    
}
