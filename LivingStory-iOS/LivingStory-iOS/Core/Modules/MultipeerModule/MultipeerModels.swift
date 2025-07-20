//
//  MultipeerModels.swift
//  LivingStory-iOS
//
//  Created by Demian Yoo on 7/21/25.
//

import Foundation
import MultipeerConnectivity

// MARK: - Connection State
enum ConnectionState {
    case disconnected, browsing, advertising, deviceFound, connecting, connected, reconnecting
    
    var message: String {
        switch self {
        case .disconnected: return "연결 끊어짐"
        case .browsing: return "기기 검색 중"
        case .advertising: return "연결 대기 중"
        case .deviceFound: return "기기 발견"
        case .connecting: return "연결 중"
        case .connected: return "연결됨"
        case .reconnecting: return "재연결 시도 중"
        }
    }
}

// MARK: - Peer Device
struct PeerDevice: Identifiable, Hashable {
    let id = UUID()
    let mcPeerID: MCPeerID
    let discoveredAt: Date
        
    static func == (lhs: PeerDevice, rhs: PeerDevice) -> Bool {
        lhs.mcPeerID == rhs.mcPeerID
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(mcPeerID)
    }
}
