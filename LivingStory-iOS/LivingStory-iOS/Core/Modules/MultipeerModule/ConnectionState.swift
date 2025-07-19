//
//  ConnectionState.swift
//  LivingStory-iOS
//
//  Created by Demian Yoo on 7/19/25.
//
enum ConnectionState: CaseIterable {
    case disconnected
    case advertising
    case browsing
    case deviceFound
    case connecting
    case connected
    case heartbeatActive
    case reconnecting
    case connectionFailed(Error)
    
    var displayMessage: String {
        switch self {
        case .disconnected: return "연결이 끊어졌습니다"
        case .advertising: return "다른 기기를 기다리는 중..."
        case .browsing: return "도서관을 찾는 중..."
        case .deviceFound: return "기기를 발견했습니다"
        case .connecting: return "연결하는 중..."
        case .connected: return "연결되었습니다"
        case .heartbeatActive: return "연결 상태 양호"
        case .reconnecting: return "재연결 시도 중..."
        case .connectionFailed(let error): return "연결 실패: \(error.localizedDescription)"
        }
    }
}
