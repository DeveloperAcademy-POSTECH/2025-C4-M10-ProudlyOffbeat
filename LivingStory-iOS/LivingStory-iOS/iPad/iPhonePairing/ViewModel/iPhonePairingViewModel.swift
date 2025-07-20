//
//  iPhonePairingViewModel.swift
//  LivingStory-iOS
//
//  Created by 문창재 on 7/17/25.
//

import SwiftUI

final class iPhonePairingViewModel: ObservableObject {
    init() { }
    
    
    func whatBook(book: BookType) -> Book {
        return Book(title: "", bookCoverImage: "", bookType: .pig)
    }
    
}
