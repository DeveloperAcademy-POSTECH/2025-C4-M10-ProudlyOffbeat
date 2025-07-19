//
//  Mulipeer.swift
//  LivingStory-iOS
//
//  Created by Demian Yoo on 7/18/25.
//

import Foundation
import MultipeerConnectivity

// MARK: Apple Delegate 사용하려면 NSObject 프로토콜 필요 + 실시간 상태 트래킹 위해서 ObservableObject 프로토콜 채택
final class MultipeerManager: NSObject, ObservableObject {
    
    // MARK: 싱글톤
    static let shared = MultipeerManager()
    
    // MARK: - Published States (ObservableObject 사용 이유), 외부에선 읽기만 가능.
    @Published private(set) var connectionState: ConnectionState = .disconnected
    @Published private(set) var discoveredDevices: [PeerDevice] = []
    @Published private(set) var connectedDevice: PeerDevice?
    
    // MARK: - Services (SRP 준수) 
    private let sessionService: SessionService
    private let advertisingService: AdvertisingService
    private let browsingService: BrowsingService
    private let heartbeatService: HeartbeatService
    private let reconnectionService: ReconnectionService
    private let dataTransmissionService: DataTransmissionService
    
    private override init() {
        let deviceName = UIDevice.current.name
        self.sessionService = SessionService(displayName: deviceName)
        
        self.advertisingService = AdvertisingService(session: sessionService.session)
        self.browsingService = BrowsingService(session: sessionService.session)
        self.heartbeatService = HeartbeatService(session: sessionService.session)
        self.reconnectionService = ReconnectionService(browsingService: browsingService)
        self.dataTransmissionService = DataTransmissionService(session: sessionService.session)
        
        super.init()
        
        setupDelegatesAndHandlers()
    }
    
    private func setupDelegatesAndHandlers() {
        sessionService.delegate = self
        
        browsingService.setPeerFoundHandler { [weak self] peerDevice in
            self?.handlePeerFound(peerDevice)
        }
        
        browsingService.setPeerLostHandler { [weak self] peerDevice in
            self?.handlePeerLost(peerDevice)
        }
        
        heartbeatService.setHeartbeatTimeoutHandler { [weak self] in
            self?.handleHeartbeatTimeout()
        }
        
        reconnectionService.setReconnectionHandlers(
            onSuccess: { [weak self] in
                self?.connectionState = .connected
            },
            onFailed: { [weak self] in
                self?.connectionState = .connectionFailed(NSError(domain: "ReconnectionFailed", code: -1))
            }
        )
    }
    
    // MARK: - Public Interface
    func startAdvertisingAsLibrary() {
        advertisingService.startAdvertising()
        connectionState = .advertising
    }
    
    func startBrowsingForLibrary() {
        browsingService.startBrowsing()
        connectionState = .browsing
    }
    
    func establishConnection(with peerID: MCPeerID) {
        connectionState = .connecting
        browsingService.invitePeer(peerID)
    }
    
    func startHeartbeatMonitoring() {
        heartbeatService.startHeartbeatMonitoring()
    }
    
    func attemptReconnection() {
        guard let lastPeerID = connectedDevice?.mcPeerID else { return }
        connectionState = .reconnecting
        reconnectionService.attemptReconnection(to: lastPeerID)
    }
    
    func terminateConnection() {
        heartbeatService.stopHeartbeatMonitoring()
        advertisingService.stopAdvertising()
        browsingService.stopBrowsing()
        sessionService.disconnect()
        
        connectionState = .disconnected
        connectedDevice = nil
        discoveredDevices.removeAll()
    }
    
    func sendStoryInteraction(_ interaction: StoryInteraction) {
        try? dataTransmissionService.sendStoryInteraction(interaction)
    }
    
    // MARK: - Private Handlers
    private func handlePeerFound(_ peerDevice: PeerDevice) {
        if !discoveredDevices.contains(peerDevice) {
            discoveredDevices.append(peerDevice)
        }
        connectionState = .deviceFound
    }
    
    private func handlePeerLost(_ peerDevice: PeerDevice) {
        discoveredDevices.removeAll { $0 == peerDevice }
    }
    
    private func handleHeartbeatTimeout() {
        attemptReconnection()
    }
}

extension MultipeerManager: MultipeerSessionDelegate {
    func sessionDidConnect(_ peerDevice: PeerDevice) {
        connectedDevice = peerDevice
        connectionState = .connected
        startHeartbeatMonitoring()
    }
    
    func sessionDidDisconnect(_ peerDevice: PeerDevice) {
        connectedDevice = nil
        connectionState = .disconnected
        heartbeatService.stopHeartbeatMonitoring()
    }
    
    func sessionDidReceiveData(_ data: Data, from peerDevice: PeerDevice) {
        // 데이터 처리 로직
        if let interaction = try? JSONDecoder().decode(StoryInteraction.self, from: data) {
            // Handle story interaction
        }
    }
}
Smart, efficient model for everyday use 자세히 알아보기

아티팩트

MultipeerModule 완전 분리 구조
