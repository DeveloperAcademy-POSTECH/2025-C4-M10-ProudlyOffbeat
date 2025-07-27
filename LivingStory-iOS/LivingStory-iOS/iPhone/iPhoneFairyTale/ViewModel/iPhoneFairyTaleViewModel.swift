//
//  iPhoneFairyTaleViewModel.swift
//  LivingStory-iOS
//
//  Created by 문창재 on 7/27/25.
//

import Foundation


final class iPhoneFairyTaleViewModel: ObservableObject{
    
    private let multipeerManager: MultipeerManager
    private let bookType: FairyTaleID
    
    init(multipeerManager: MultipeerManager, bookType: FairyTaleID) {
        self.multipeerManager = multipeerManager
        self.bookType = bookType
    }
    
}
