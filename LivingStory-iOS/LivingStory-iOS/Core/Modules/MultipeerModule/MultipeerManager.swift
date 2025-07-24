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
    @Published internal var connectedDevices: [PeerDevice] = []
    
    
    // MARK: - Core Components
    private(set) var session: MCSession
    private var advertiser: MCNearbyServiceAdvertiser?
    private var browser: MCNearbyServiceBrowser?
    
    // 총 연결된 디바이스 수
    var connectedDeviceCount: Int {
        return connectedDevices.count
    }
    
    private override init() {
        let peerID = MCPeerID(displayName: UIDevice.current.name)
        self.session = MCSession(peer: peerID, securityIdentity: nil, encryptionPreference: .required)
        super.init()
        session.delegate = self
    }
    
    //MARK: 개별 연결 관리
    
    /// 특정 기기가 연결되어 있는지 확인
    func isDeviceConnected(_ peerID: MCPeerID) -> Bool {
        return connectedDevices.contains { $0.mcPeerID == peerID }
    }
    
    /// 특정 기기를 연결된 목록에 추가
    public func addConnectedDevice(_ peerID: MCPeerID) {
        let device = PeerDevice(mcPeerID: peerID, discoveredAt: Date(), eachDeviceConnectionState: .connected)
        
        DispatchQueue.main.async {
            if !self.connectedDevices.contains(where: { $0.mcPeerID == peerID }) {
                self.connectedDevices.append(device)
                print("연결된 기기 추가: \(peerID.displayName) (총 \(self.connectedDevices.count)개")
            }
            self.updateOverallConnectionState()
        }
    }
    
    /// 특정 기기를 연결된 목록에서 제거
    public func removeConnectedDevice(_ peerID: MCPeerID) {
        DispatchQueue.main.async {
            if let index = self.connectedDevices.firstIndex(where: { $0.mcPeerID == peerID }) {
                let removeDevice = self.connectedDevices.remove(at: index)
                print("❌ 연결된 기기 제거: \(peerID.displayName) (남은 \(self.connectedDevices.count) 개")
            }
            
        }
    }
    
    /// 전체 연결 상태 업데이트
    public func updateOverallConnectionState() {
        if connectedDevices.isEmpty {
            connectionState = discoveredDevices.isEmpty ? .disconnected : .deviceFound
        } else {
            connectionState = .connected
        }
    }
    
    // MARK: iPad
    
    /// iPad에서 iPhone 검색
    func startBrowsing() {
        browser = MCNearbyServiceBrowser(peer: session.myPeerID, serviceType: "living-story")
        browser?.delegate = self
        browser?.startBrowsingForPeers()
        connectionState = .browsing
        print("🔍 기기 검색 시작")
    }
    
    /// iPad에서 iPhone으로 연결 시도
    func connectTo(_ peerID: MCPeerID) {
        connectionState = .connecting
        browser?.invitePeer(peerID, to: session, withContext: nil, timeout: 10)
        print("🔄 연결 시도: \(peerID.displayName)")
    }
    
    /// iPad: 특정 iPhone과 연결 해제
    func iPadDisconnectiPhone(_ peerID: MCPeerID) {
        session.cancelConnectPeer(peerID)
        removeConnectedDevice(peerID)
        print("🔌 개별 기기 연결 해제: \(peerID.displayName)")
    }
    
    // MARK: iPhone
    
    /// iPhone에서 광고 시작
    func startAdvertising() {
        advertiser = MCNearbyServiceAdvertiser(peer: session.myPeerID, discoveryInfo: nil, serviceType: "living-story")
        advertiser?.delegate = self
        advertiser?.startAdvertisingPeer()
        connectionState = .advertising
        print("📡 iPad 광고 시작")
    }
    
    /// iPhone 자기자신만 연결 해제
    func iPhoneDisconnectSelf() {
        let deviceName = session.myPeerID.displayName
        print("\(deviceName)가 연결 해제 요청 - 광고 중단")
        
        advertiser?.stopAdvertisingPeer()
        advertiser = nil
        
        DispatchQueue.main.async {
            self.connectionState = .disconnected
        }
        
    }
    
    //MARK: 메세지 전송
    
    /// 특정 기기에게만 메세지 전송
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
