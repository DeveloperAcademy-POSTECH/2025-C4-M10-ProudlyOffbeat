//
//  BookModel.swift
//  LivingStory-iOS
//
//  Created by 문창재 on 7/17/25.
//

import Foundation

struct Book{
    let title: String
    let bookCoverImage: String
    
    static let dummyBooks: [Book] = [
        Book(title: "Oz", bookCoverImage: "OzDoor"),
        Book(title: "Pig", bookCoverImage: "PigDoor"),
        Book(title: "Heung", bookCoverImage: "HeungDoor"),
    ]
}

