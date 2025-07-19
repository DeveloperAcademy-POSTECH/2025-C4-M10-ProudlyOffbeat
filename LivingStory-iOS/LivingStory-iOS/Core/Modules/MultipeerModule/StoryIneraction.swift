//
//  StoryIneraction.swift
//  LivingStory-iOS
//
//  Created by Demian Yoo on 7/19/25.
//

struct StoryInteraction: Codable {
    let id = UUID()
    let type: InteractionType
    let sceneIdentifier: String
    let homeKitParameters: [String: String]
    let timestamp = Date()
    
    enum InteractionType: String, CaseIterable, Codable {
        case lightingChange = "lighting_change"
        case soundEffect = "sound_effect"
        case temperatureAdjust = "temperature_adjust"
        case sceneTransition = "scene_transition"
        case ambientControl = "ambient_control"
    }
}
