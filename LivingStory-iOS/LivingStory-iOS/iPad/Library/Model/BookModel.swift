//
//  BookModel.swift
//  LivingStory-iOS
//
//  Created by 문창재 on 7/18/25.
//

import Foundation

struct Book{
    let title: String
    let bookCoverImage: String
    let bookType: BookType
    
    static let ozBook:Book = Book(title: "Oz", bookCoverImage: "OzDoor", bookType: .oz)
    static let pigBook:Book = Book(title: "Pig", bookCoverImage: "PigDoor", bookType: .pig)
    static let heungBook:Book = Book(title: "Heung", bookCoverImage: "HeungDoor", bookType: .heung)
    
}

enum BookType: String, Hashable {
    case oz, pig, heung
}
