//
//  MultipeerAdvertising.swift
//  LivingStory-iOS
//
//  Created by Demian Yoo on 7/19/25.
//

protocol MultipeerAdvertising {
    func startAdvertising()
    func stopAdvertising()
    var isAdvertising: Bool { get }
}

protocol MultipeerBrowsing {
    func startBrowsing()
    func stopBrowsing()
    func invitePeer(_ peerID: MCPeerID)
    var isBrowsing: Bool { get }
}

protocol MultipeerSessionDelegate: AnyObject {
    func sessionDidConnect(_ peerDevice: PeerDevice)
    func sessionDidDisconnect(_ peerDevice: PeerDevice)
    func sessionDidReceiveData(_ data: Data, from peerDevice: PeerDevice)
}
