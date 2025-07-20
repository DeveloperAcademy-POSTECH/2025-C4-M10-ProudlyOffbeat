//
//  Mulipeer.swift
//  LivingStory-iOS
//
//  Created by Demian Yoo on 7/18/25.
//

import Foundation
import MultipeerConnectivity
import Combine

final class MultipeerManager: NSObject, ObservableObject {
    static let shared = MultipeerManager()
    
    // MARK: - Published States (뷰에서 실시간 감지)
    @Published internal var connectionState: ConnectionState = .disconnected
    @Published internal var discoveredDevices: [PeerDevice] = []
    @Published internal var connectedDevice: PeerDevice?
    
    // MARK: - Core Components
    private(set) var session: MCSession
    private var advertiser: MCNearbyServiceAdvertiser?
    private var browser: MCNearbyServiceBrowser?
    private var reconnectionTimer: Timer?
    internal var reconnectionAttempts = 0
    internal let maxReconnectionAttempts = 3
    
    private override init() {
        let peerID = MCPeerID(displayName: UIDevice.current.name)
        self.session = MCSession(peer: peerID, securityIdentity: nil, encryptionPreference: .required)
        super.init()
        session.delegate = self
    }
    
    // MARK: - 🔥 핵심 API (딱 필요한 것만!)
    
    /// iPad에서 광고 시작
    func startAdvertising() {
        let discoveryInfo = ["deviceType": "iPad", "role": "library"]
        advertiser = MCNearbyServiceAdvertiser(peer: session.myPeerID, discoveryInfo: discoveryInfo, serviceType: "living-story")
        advertiser?.delegate = self
        advertiser?.startAdvertisingPeer()
        connectionState = .advertising
        print("📡 iPad 광고 시작")
    }
    
    /// iPhone에서 검색 시작
    func startBrowsing() {
        browser = MCNearbyServiceBrowser(peer: session.myPeerID, serviceType: "living-story")
        browser?.delegate = self
        browser?.startBrowsingForPeers()
        connectionState = .browsing
        print("🔍 기기 검색 시작")
    }
    
    /// 기기에 연결 시도
    func connectTo(_ peerID: MCPeerID) {
        connectionState = .connecting
        browser?.invitePeer(peerID, to: session, withContext: nil, timeout: 10)
        print("🔄 연결 시도: \(peerID.displayName)")
    }
    
    /// 재연결 시도
    func attemptReconnection() {
        guard let lastPeer = connectedDevice,
              reconnectionAttempts < maxReconnectionAttempts else {
            connectionState = .disconnected
            return
        }
        
        reconnectionAttempts += 1
        connectionState = .reconnecting
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [weak self] in
            self?.startBrowsing()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self?.connectTo(lastPeer.mcPeerID)
            }
        }
        print("🔄 재연결 시도 \(reconnectionAttempts)/\(maxReconnectionAttempts)")
    }
    
    /// 모든 연결 종료
    func disconnect() {
        advertiser?.stopAdvertisingPeer()
        browser?.stopBrowsingForPeers()
        session.disconnect()
        
        connectionState = .disconnected
        connectedDevice = nil
        discoveredDevices.removeAll()
        reconnectionAttempts = 0
        print("🔌 연결 종료")
    }
    
    /// 간단한 메시지 전송
    func sendMessage(_ message: String) {
        guard !session.connectedPeers.isEmpty else { return }
        
        if let data = message.data(using: .utf8) {
            do {
                try session.send(data, toPeers: session.connectedPeers, with: .reliable)
                print("✅ 메시지 전송: \(message)")
            } catch {
                print("❌ 전송 실패: \(error)")
            }
        }
    }
    
    // MARK: - 상태 체크
    var isConnected: Bool {
        if case .connected = connectionState { return true }
        return false
    }
}
