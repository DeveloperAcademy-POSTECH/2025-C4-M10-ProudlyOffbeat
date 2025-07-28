//
//  Mulipeer.swift
//  LivingStory-iOS
//
//  Created by Demian Yoo on 7/18/25.
//

import Foundation
import MultipeerConnectivity
import Combine
import Darwin

final class MultipeerManager: NSObject, ObservableObject {
    static let shared = MultipeerManager()
    
    // MARK: - Published States (뷰에서 실시간 감지)
    @Published internal var connectionState: ConnectionState = .disconnected
    @Published internal var discoveredDevices: [PeerDevice] = []
    @Published internal var connectedDevices: [PeerDevice] = []
    
    @Published var selectedBookType: FairyTaleID?
    
    
    // MARK: - Core Components
    private(set) var session: MCSession
    private var advertiser: MCNearbyServiceAdvertiser?
    private var browser: MCNearbyServiceBrowser?
    
    // 총 연결된 디바이스 수
    var connectedDeviceCount: Int {
        return connectedDevices.count
    }
    
    private override init() {
        let deviceName = Self.getSimpleDeviceName()
        let peerID = MCPeerID(displayName: deviceName)
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
            self.updateOverallConnectionState()
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
        let disconnectMessage = "DISCONNECT_REQUEST"
        if let data = disconnectMessage.data(using: .utf8) {
            do {
                try session.send(data, toPeers: [peerID], with: .reliable)
                print("📤 [iPad] \(peerID.displayName)에게 연결 해제 요청 전송")
            } catch {
                print("❌ [iPad] 연결 해제 메시지 전송 실패: \(error)")
            }
        }
        
        // ✅ 2. 로컬에서 즉시 제거 (UI 반응성을 위해)
        removeConnectedDevice(peerID)
        updateOverallConnectionState()
        
        print("🔌 개별 기기 연결 해제 요청: \(peerID.displayName)")
    }
    
    func disconnectAll() {
        print("🔌 모든 연결 해제 시작")
        
        // 1. 브라우저 중단 (iPad)
        browser?.stopBrowsingForPeers()
        browser?.delegate = nil
        browser = nil
        
        // 2. 연결된 기기가 있으면 메시지 전송
        if !session.connectedPeers.isEmpty {
            let disconnectMessage = "DISCONNECT_REQUEST"
            if let data = disconnectMessage.data(using: .utf8) {
                do {
                    try session.send(data, toPeers: session.connectedPeers, with: .reliable)
                    print("📤 모든 연결된 기기에게 해제 요청 전송")
                } catch {
                    print("❌ 해제 메시지 전송 실패: \(error)")
                }
            }
            
            // ✅ 0.3초 후 완전 정리
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.session.disconnect()
                self.connectedDevices.removeAll()
                self.discoveredDevices.removeAll()
                self.connectionState = .disconnected
                print("🔌 [iPad] 세션 연결 완전 해제")
            }
        } else {
            // ✅ 연결된 기기가 없어도 즉시 상태 정리
            self.connectedDevices.removeAll()
            self.discoveredDevices.removeAll()
            self.connectionState = .disconnected
            print("🔌 [iPad] 상태만 초기화")
        }
        
        print("✅ 모든 연결 해제 완료")
    }
    
    
    // MARK: iPhone
    
    /// iPhone에서 광고 시작
    func startAdvertising() {
        advertiser = MCNearbyServiceAdvertiser(peer: session.myPeerID, discoveryInfo: nil, serviceType: "living-story")
        advertiser?.delegate = self
        advertiser?.startAdvertisingPeer()
        connectionState = .advertising
        print("📡 iPhone에서 iPad 광고 시작")
    }
    
    /// iPhone 자기자신만 연결 해제
    func iPhoneDisconnectSelf() {
        let deviceName = session.myPeerID.displayName
        print("\(deviceName)가 연결 해제 요청 - 광고 중단")
        
        advertiser?.stopAdvertisingPeer()
        advertiser?.delegate = nil
        advertiser = nil
        
        session.disconnect()
        
        // 2. ✅ 안전한 세션 해제
        DispatchQueue.main.async {
            self.connectionState = .disconnected
            self.connectedDevices.removeAll()
            self.selectedBookType = nil
        }
        
    }
    
    //MARK: 메세지 전송
    
    //MARK: iPad
    func sendSelectedBookToiPhone(bookType: FairyTaleID) {
        let message = "\(bookType.rawValue)::\(BookSelectionSignal.selected.rawValue)"
        guard let data = message.data(using: .utf8) else { return }
        
        do {
            try session.send(data, toPeers: session.connectedPeers, with: .reliable)
            print(" 책 선택 메시지 전송 완료: \(message)")
        } catch {
            print("❌ 메시지 전송 실패: \(error)")
        }
    }
    
    
    /// 연결된 모든 아이폰에게 전달
    func sendInteractionMessage(fairyID: FairyTaleID, signal: FairyInteractionSignal) {
        let message = "\(fairyID.rawValue)::\(signal.rawValue)"
        guard let data = message.data(using: .utf8) else { return }
        try? session.send(data, toPeers: session.connectedPeers, with: .reliable)
        print("📤 [SEND] \(message)")
    }
    
    // MARK: - 기기 이름 관리
    
    /// 간단한 기기명만 반환
    private static func getSimpleDeviceName() -> String {
        let modelName = getDeviceModel()
        print("🔍 간단한 기기명: '\(modelName)'")
        return modelName
    }
    
    /// 실제 모델명 가져오기
    private static func getDeviceModel() -> String {
        var systemInfo = utsname()
        uname(&systemInfo)
        
        // ✅ 안전하고 간단한 방식
        let identifier = withUnsafePointer(to: &systemInfo.machine) {
            $0.withMemoryRebound(to: CChar.self, capacity: 1) {
                String(cString: $0)
            }
        }
        
        print("🔍 기기 식별자: '\(identifier)'")
        
        return mapToSimpleModel(identifier: identifier)
    }
    
    /// 간단한 모델명 매핑
    private static func mapToSimpleModel(identifier: String) -> String {
        switch identifier {
            // iPhone
        case "iPhone14,7": return "iPhone 13 mini"
        case "iPhone14,8": return "iPhone 13"
        case "iPhone15,2": return "iPhone 14 Pro"
        case "iPhone15,3": return "iPhone 14 Pro Max"
        case "iPhone16,1": return "iPhone 15"
        case "iPhone16,2": return "iPhone 15 Plus"
        case "iPhone17,1": return "iPhone 16 Pro"
        case "iPhone17,2": return "iPhone 16 Pro Max"
        case "iPhone17,3": return "iPhone 16"
            
            // iPad
        case "iPad13,1", "iPad13,2": return "iPad Air 5"
        case "iPad14,1", "iPad14,2": return "iPad Pro 11"
        case "iPad14,3", "iPad14,4": return "iPad Pro 12.9"
        case "iPad16,3": return "iPad Pro 11"
            
            // 시뮬레이터나 알 수 없는 기기
        case let identifier where identifier.contains("86") || identifier.contains("arm64"):
            return "시뮬레이터"
        default:
            // 알 수 없는 기기는 고유 ID 추가
            let uniqueId = String(UIDevice.current.identifierForVendor?.uuidString.prefix(4) ?? "0000")
            return "\(UIDevice.current.model) \(uniqueId)"
        }
    }
    
    // MARK: - 상태 체크
    var isConnected: Bool {
        if case .connected = connectionState { return true }
        return false
    }
}
