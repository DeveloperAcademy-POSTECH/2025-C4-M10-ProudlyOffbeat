//
//  PeerDevice.swift
//  LivingStory-iOS
//
//  Created by Demian Yoo on 7/19/25.
//

import MultipeerConnectivity

struct PeerDevice: Identifiable, Hashable {
    let id = UUID()
    let mcPeerID: MCPeerID
    let deviceType: DeviceType
    let discoveredAt: Date
    var connectionTimestamp: Date?
    
    var displayName: String { mcPeerID.displayName }
    
    enum DeviceType: String, CaseIterable {
        case iPadLibrary = "iPad"
        case iPhoneReader = "iPhone"
        case unknown = "Unknown"
        
        var roleDescription: String {
            switch self {
            case .iPadLibrary: return "스토리 도서관"
            case .iPhoneReader: return "스토리 리더"
            case .unknown: return "알 수 없는 기기"
            }
        }
    }
    
    static func == (lhs: PeerDevice, rhs: PeerDevice) -> Bool {
        lhs.mcPeerID == rhs.mcPeerID
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(mcPeerID)
    }
}
