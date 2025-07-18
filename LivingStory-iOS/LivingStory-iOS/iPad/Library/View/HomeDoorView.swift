//
//  HomeDoorView.swift
//  LivingStory-iOS
//
//  Created by 문창재 on 7/17/25.
//

import SwiftUI

struct HomeDoorView: View {
    let books: [Book] = Book.dummyBooks
    let action: () -> Void
    
    var body: some View {
        HStack(spacing: 40){
            ForEach(books, id: \.title){book in
                Button{
                    action()
                }label: {
                    Image(book.bookCoverImage)
                }
            }
        }.padding(.top, 70)
    }
}

