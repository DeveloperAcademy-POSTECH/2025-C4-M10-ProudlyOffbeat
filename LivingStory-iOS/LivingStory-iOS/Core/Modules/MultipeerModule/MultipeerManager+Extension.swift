//
//  MultipeerManager+Extension.swift
//  LivingStory-iOS
//
//  Created by Demian Yoo on 7/21/25.
//
import Foundation
import MultipeerConnectivity

// MARK: - MCSession Delegate
extension MultipeerManager: MCSessionDelegate {
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        DispatchQueue.main.async {
            switch state {
            case .connected:
                print("✅ [Session] 연결 성공: \(peerID.displayName)")
                self.addConnectedDevice(peerID)
                self.connectionState = .connected
                
            case .notConnected:
                print("❌ [Session] 연결 끊어짐: \(peerID.displayName)")
                self.removeConnectedDevice(peerID)
                self.updateOverallConnectionState()
                
            case .connecting:
                print("🔄 [Session] 연결 중: \(peerID.displayName)")
                self.connectionState = .connecting
                
            @unknown default:
                print("🤔 [Session] 알 수 없는 상태: \(state)")
                break
            }
        }
    }
    
    /// [iPad ↔ iPhone 공통] 메시지 수신 처리
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        if let message = String(data: data, encoding: .utf8) {
            print("�� 메시지 수신: \(message) from \(peerID.displayName)")
            
            // ✅ 연결 해제 메시지 먼저 처리
            if message == "DISCONNECT_REQUEST" {
                print("📱 [iPhone] DISCONNECT_REQUEST 처리 시작!")
                DispatchQueue.main.async {
                    print("�� [iPhone] iPhoneDisconnectSelf() 호출!")
                    self.iPhoneDisconnectSelf()
                }
                return
            }
            
            // 🆕 새로운 "::" 방식 파싱
            let components = message.components(separatedBy: "::")
            
            if components.count == 2 {
                // ✅ 책 선택 메시지 파싱 추가
                if let fairyID = FairyTaleID(rawValue: components[0]),
                   let signal = BookSelectionSignal(rawValue: components[1]) {
                    
                    handleBookSelectionMessage(fairyID: fairyID, signal: signal)
                }
                // 기존 인터랙션 메시지 파싱
                else if let fairyID = FairyTaleID(rawValue: components[0]),
                        let signal = FairyInteractionSignal(rawValue: components[1]) {
                    
                    handleInteractionMessage(fairyID: fairyID, signal: signal, from: peerID)
                }
                else {
                    print("⚠️ 알 수 없는 메시지: \(message)")
                }
            }
        }
    }
    
    
    //  메시지 타입별 처리 메서드
    private func handleInteractionMessage(fairyID: FairyTaleID, signal: FairyInteractionSignal, from peerID: MCPeerID) {
        DispatchQueue.main.async {
            switch (fairyID, signal) {
            case (.pig, .triggered):
                print("🐷 [iPhone] 돼지 삼형제 인터렉션 시작!")
                NotificationCenter.default.post(name: .pigInteractionStart, object: nil) // ✅ NotificationCenter만 사용
                
            case (.pig, .done):
                print("✅ [iPad] 돼지 인터렉션 완료!")
                NotificationCenter.default.post(name: .pigInteractionCompleted, object: nil) // ✅ NotificationCenter만 사용
                
            case (.heung, .triggered):
                print("🏠 [iPhone] 흥부전 인터렉션 시작!")
                NotificationCenter.default.post(name: .heungInteractionStart, object: nil)
                
            case (.oz, .triggered):
                print("🌪️ [iPhone] 오즈 인터렉션 시작!")
                NotificationCenter.default.post(name: .ozInteractionStart, object: nil)
                
            default:
                print("⚠️ 처리되지 않은 인터렉션: \(fairyID)::\(signal)")
            }
        }
    }
    
    // 책 선택 메서드
    private func handleBookSelectionMessage(fairyID: FairyTaleID, signal: BookSelectionSignal) {
        DispatchQueue.main.async {
            switch signal {
            case .selected:
                self.selectedBookType = fairyID
                print("�� [iPhone] 선택된 책: \(fairyID)")
                // Notification 발송으로 iPhone 앱에 알림
                NotificationCenter.default.post(name: .bookSelected, object: fairyID)
            }
        }
    }
    
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {}
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {}
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {}
}

// MARK: - 광고 델리게이트
extension MultipeerManager: MCNearbyServiceAdvertiserDelegate {
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
        print("📡 연결 요청 받음: \(peerID.displayName)")
        // ✅ 이미 연결된 기기인지 확인
        if session.connectedPeers.contains(peerID) {
            print("⚠️ [iPhone] 이미 연결된 기기입니다: \(peerID.displayName)")
            invitationHandler(false, nil)  // 거부
            return
        }
        
        invitationHandler(true, self.session)
    }
    
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didNotStartAdvertisingPeer error: Error) {
        DispatchQueue.main.async {
            self.connectionState = .disconnected
        }
        print("❌ 광고 실패: \(error)")
    }
}

// MARK: - 브라우저 델리게이트
extension MultipeerManager: MCNearbyServiceBrowserDelegate {
    func browser(_ browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String: String]?) {
        let peerDevice = PeerDevice(mcPeerID: peerID, discoveredAt: Date())
        
        DispatchQueue.main.async {
            if !self.discoveredDevices.contains(peerDevice) {
                self.discoveredDevices.append(peerDevice)
                self.connectionState = .deviceFound
                print("📱 기기 발견: \(peerID.displayName)")
            }
        }
    }
    
    func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
        DispatchQueue.main.async {
            self.discoveredDevices.removeAll { $0.mcPeerID == peerID }
            print("📱 기기 사라짐: \(peerID.displayName)")
        }
    }
    
    func browser(_ browser: MCNearbyServiceBrowser, didNotStartBrowsingForPeers error: Error) {
        DispatchQueue.main.async {
            self.connectionState = .disconnected
        }
        print("❌ 검색 실패: \(error)")
    }
}
