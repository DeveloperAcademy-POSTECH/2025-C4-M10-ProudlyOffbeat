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
        let peerDevice = PeerDevice(mcPeerID: peerID, discoveredAt: Date())
        
        DispatchQueue.main.async {
            switch state {
            case .connected:
                self.connectedDevice = peerDevice
                self.connectionState = .connected
                self.reconnectionAttempts = 0
                print("✅ 연결 성공: \(peerID.displayName)")
            case .notConnected:
                self.connectedDevice = nil
                self.connectionState = .disconnected
                print("❌ 연결 끊어짐: \(peerID.displayName)")
                
                // 자동 재연결 시작
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    self.attemptReconnection()
                }
            case .connecting:
                self.connectionState = .connecting
            @unknown default:
                break
            }
        }
    }
    
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        if let message = String(data: data, encoding: .utf8) {
            print("📨 메시지 수신: \(message) from \(peerID.displayName)")
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
        invitationHandler(true, self.session as MCSession)
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
