//
//  iPhoneFairyTaleViewModel.swift
//  LivingStory-iOS
//
//  Created by 문창재 on 7/27/25.
//

import Foundation


final class iPhoneFairyTaleViewModel: ObservableObject{
    internal let audioManager: AudioInputModel
    
    @Published var interactionStatus: InteractionStatus = .notDone
    
    var isDone: Bool {
        switch interactionStatus {
        case .done:
            return true
        case .notDone:
            return false
        }
    }
    
    init(audioManager:AudioInputModel) {
        self.audioManager = audioManager
    }
    
}
