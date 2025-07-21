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
    
    // 인터랙션 완료 여부
    @Published var isInteractionCompleted: Bool = false
    
    let allBooks: [StoryBook] = [
            StoryBook(type: .pig, pages: [
                StoryPage(backgroundImageName: "Pig1", script: "돼지 첫 장면", interaction: nil)
            ])
        ]
    
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
    
    init() { }
    
    func increaseIndex(){
        //다음 버튼 로직
    }
    
    func decreaseIndex(){
        //이전 버튼 로직
    }
    
    func returnToHome(){
        //홈 버튼 로직
    }
    
    func selectBook(by type: BookType) {
        // 예시: 미리 정의된 책 리스트에서 선택
        if let book = allBooks.first(where: { $0.type == type }) {
            selectedBook = book
            currentPage = 0
        }
    }
    
}
