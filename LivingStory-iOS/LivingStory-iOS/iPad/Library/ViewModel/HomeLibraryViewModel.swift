//
//  HomeLibraryViewModel.swift
//  LivingStory-iOS
//
//  Created by Demian Yoo on 7/17/25.
//

import SwiftUI
import MultipeerConnectivity

final class HomeLibraryViewModel: ObservableObject {
    
    private let multipeerManager: MultipeerManager
    private let homeKitManager: HomeKitManager
    
    init(multipeerManager: MultipeerManager, homeKitManager: HomeKitManager) {
        self.multipeerManager = multipeerManager
        self.homeKitManager = homeKitManager
    }
    
    func onLibraryApper() {
        // 연결된 기기가 있을 때만 disconnectAll 실행
        if !multipeerManager.connectedDevices.isEmpty {
            print("🔌 연결된 기기 발견, 연결 해제 시작")
            multipeerManager.disconnectAll()
        } else {
            print("✅ 연결된 기기 없음, 연결 해제 건너뜀")
        }
        // HomeKit이 준비될 때까지 기다렸다가 조명 설정
        if homeKitManager.isHomeKitReady {
            homeKitManager.setDefaultLighting()
        } else {
            print("⚠️ [HomeLibrary] HomeKit이 아직 준비되지 않음, 1초 후 재시도")
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                if self.homeKitManager.isHomeKitReady {
                    self.homeKitManager.setDefaultLighting()
                } else {
                    print("❌ [HomeLibrary] HomeKit 준비 실패")
                }
            }
        }
    }
    
    
    
    
    @MainActor
    func pushToiPhonePairingView(coordinator: AppCoordinator, bookType: BookType) {
        print("go to iPhone Pairing")
        print("send to \(bookType)")
        coordinator.push(.iPhonePairing(book: bookType))
    }
}
