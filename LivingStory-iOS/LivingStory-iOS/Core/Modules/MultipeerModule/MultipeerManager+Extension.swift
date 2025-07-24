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
    
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        if let message = String(data: data, encoding: .utf8) {
            print("📨 메시지 수신: \(message) from \(peerID.displayName)")
            // ✅ iPad로부터 연결 해제 요청을 받으면 자체 연결 해제
            if message == "DISCONNECT_REQUEST" {
                print("🔌 [iPhone] iPad로부터 연결 해제 요청 수신 - 자체 연결 해제 실행")
                DispatchQueue.main.async {
                    self.iPhoneDisconnectSelf()
                }
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
