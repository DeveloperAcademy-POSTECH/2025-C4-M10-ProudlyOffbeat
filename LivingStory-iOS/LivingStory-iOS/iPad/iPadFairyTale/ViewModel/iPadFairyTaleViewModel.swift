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
    
    let allBooks: [StoryBook] = [
            StoryBook(type: .oz, pages: [
                StoryPage(backgroundImageName: "Oz1", script: "오즈의 첫 장면"),
                StoryPage(backgroundImageName: "Oz2", script: "오즈의 두 번째 장면"),
            ]),
            StoryBook(type: .pig, pages: [
                StoryPage(backgroundImageName: "Pig1", script: "돼지 첫 장면")
            ])
        ]
    
    var currentBackground: String {
        selectedBook?.pages[currentPage].backgroundImageName ?? "DefaultBackground"
    }

    var currentScript: String {
        selectedBook?.pages[currentPage].script ?? ""
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
