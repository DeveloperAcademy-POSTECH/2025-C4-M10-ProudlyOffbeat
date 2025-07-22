//
//  BookType+Extension.swift
//  LivingStory-iOS
//
//  Created by Demian Yoo on 7/22/25.
//

import Foundation

extension BookType {
    var book: Book {
        switch self {
        case .oz: return .ozBook
        case .pig: return .pigBook
        case .heung: return .heungBook
        }
    }
}
