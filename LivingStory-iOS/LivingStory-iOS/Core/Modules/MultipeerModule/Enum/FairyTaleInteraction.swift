//
//  FairyTaleInteraction.swift
//  LivingStory-iOS
//
//  Created by Demian Yoo on 7/27/25.
//

enum FairyTaleID: String {
    case pig = "PIG"
    case heung = "HEUNG"
    case oz = "OZ"
}

enum FairyInteractionSignal: String {
    case triggered = "INTERACTION_TRIGGERED"
    case done = "INTERACTION_DONE"
}


enum FairyMessageType: String {
    case bookSelected = "BOOK"
    case interaction = "INTERACT"
}
