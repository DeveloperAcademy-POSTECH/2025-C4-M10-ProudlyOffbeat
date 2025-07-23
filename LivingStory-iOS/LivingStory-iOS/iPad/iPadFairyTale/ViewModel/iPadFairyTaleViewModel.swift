//
//  iPadFairyTaleView.swift
//  LivingStory-iOS
//
//  Created by 문창재 on 7/20/25.
//

import SwiftUI

final class iPadFairyTaleViewModel: ObservableObject {
    @Published var currentPage: Int = 0
    @Published var selectedBook: StoryBook?
    
    // 인터랙션 완료 여부, 아직 사용 안 함
    @Published var isInteractionCompleted: Bool = false
    
    
    var currentBackground: String {
        selectedBook?.pages[currentPage].backgroundImageName ?? "DefaultBackground"
    }

    var currentScript: String {
        selectedBook?.pages[currentPage].script ?? ""
    }
    
    // 현재 페이지의 인터랙션 타입
    var currentInteraction: InteractionType {
        selectedBook?.pages[currentPage].interaction ?? .none
    }
    
    func triggerInteraction() {
        guard currentInteraction != .none else { return }
        // 예: 등불 터치 시
        //peerManager?.sendInteractionMessage(currentInteraction)
        isInteractionCompleted = false // iPhone에서 신호 오면 true로
    }
    
    init(bookType: BookType) {
        selectBook(by: bookType)
    }
    
    func increaseIndex(){
        //다음 버튼 로직
        guard let selectedBook, currentPage + 1 < selectedBook.pages.count else { return }
                currentPage += 1
    }
    
    func decreaseIndex() {
        guard let selectedBook, currentPage - 1 >= 0 else { return }
           currentPage -= 1
    }
    
    @MainActor
    func returnToHome(coordinator:AppCoordinator){
        coordinator.goToRoot()
    }
    
    @MainActor
    func goToPreviousView(coordinator:AppCoordinator){
        coordinator.pop()
    }
    
    func selectBook(by type: BookType) {
        // 예시: 미리 정의된 책 리스트에서 선택
        if let book = StoryBook.allBooks.first(where: { $0.type == type }) {
            selectedBook = book
            currentPage = 0
        }
    }
    
}
