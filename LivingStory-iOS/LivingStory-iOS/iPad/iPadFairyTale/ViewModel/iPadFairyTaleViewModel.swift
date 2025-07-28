//
//  iPadFairyTaleView.swift
//  LivingStory-iOS
//
//  Created by 문창재 on 7/20/25.
//

import SwiftUI
import AVFoundation

final class iPadFairyTaleViewModel: ObservableObject {
    private let multipeerManager: MultipeerManager
    private let homeKitManager: HomeKitManager
    private var backgroundAudioPlayer: AVAudioPlayer?
    private var lightingRetryCount = 0
    private let maxLightingRetries = 5
    
    @Published var currentPage: Int = 0
    @Published var selectedBook: StoryBook?
    
    // 인터랙션 완료 여부
    @Published var isInteractionCompleted: Bool = false
    @Published var isInteractionTriggered: Bool = false
    @Published var showInteractionCompleteAlert: Bool = false
    
    init(bookType: BookType, multipeerManager: MultipeerManager, homeKitManager: HomeKitManager) {
        self.multipeerManager = multipeerManager
        self.homeKitManager = homeKitManager
        selectBook(by: bookType)
        setupNotificationObserver()
        
    }
    
    deinit {
        stopPigBackgroundSound()
        NotificationCenter.default.removeObserver(self)
        
    }
    
    var currentBackground: String {
        selectedBook?.pages[currentPage].backgroundImageName ?? "DefaultBackground"
    }
    
    var currentScript: String {
        selectedBook?.pages[currentPage].script ?? ""
    }
    
    // 현재 페이지의 인터랙션 타입
    var currentInteraction: InteractionType {
        selectedBook?.pages[currentPage].interaction ?? .none
    }
    
    func setUpPigFairyTaleLighting() {
        guard let bookType = selectedBook?.type else { return }
        
        if bookType == .pig {
            // HomeKit이 준비될 때까지 기다렸다가 실행
            if homeKitManager.isHomeKitReady {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    self.homeKitManager.setPigLighting(pageIndex: 0)
                    print("🐷 돼지 동화 시작 - 조명 켜기")
                }
                lightingRetryCount = 0
            } else {
                // 재시도 횟수 제한
                if lightingRetryCount < maxLightingRetries {
                    lightingRetryCount += 1
                    print("🏠 HomeKit 재시도 \(lightingRetryCount)/\(maxLightingRetries)")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.setUpPigFairyTaleLighting()
                    }
                } else {
                    print("❌ HomeKit 조명 설정 실패 - 최대 재시도 횟수 초과")
                    lightingRetryCount = 0  // 카운트 리셋
                }
            }
        }
    }
    
    func turnOffLightsOnPage3() {
        guard let bookType = selectedBook?.type else { return }
        
        if bookType == .pig && currentPage == 3 {
            if homeKitManager.isHomeKitReady {
                homeKitManager.setPigLighting(pageIndex: 3)
                print(" 3번째 페이지 - 조명 끄기")
            } else {
                print("⚠️ HomeKit이 준비되지 않아 조명 제어를 건너뜁니다")
            }
        }
    }
    
    
    // interaction 보내기
    func iPadSendInteraction() {
        guard currentInteraction != .none else { return }
        
        guard !isInteractionTriggered else {
            print("⚠️ 인터랙션이 이미 트리거되었습니다")
            return
        }
        
        guard let bookType = selectedBook?.type else { return }
        
        let fairyID: FairyTaleID
        switch bookType {
        case .pig: fairyID = .pig
        case .heung: fairyID = .heung
        case .oz: fairyID = .oz
        }
        
        multipeerManager.sendInteractionMessage(fairyID: fairyID, signal: .triggered)
        print("📤 iPad에서 iPhone으로 인터랙션 메시지 전송: \(fairyID)::TRIGGERED")
        
        isInteractionTriggered = true
        isInteractionCompleted = false
    }
    
    // Notification 구독
    private func setupNotificationObserver() {
        guard let bookType = selectedBook?.type else { return }
        
        let notificationName: Notification.Name
        switch bookType {
        case .pig:
            notificationName = .pigInteractionCompleted
        case .heung:
            notificationName = .heungInteractionCompleted
        case .oz:
            notificationName = .ozInteractionCompleted
        }
        
        NotificationCenter.default.addObserver(
            forName: notificationName,
            object: nil,
            queue: .main
        ) { [weak self] _ in
            print("📟 [iPad] \(bookType) 인터렉션 완료 신호 받음!")
            self?.completeInteraction()
        }
    }
    
    // 인터렉션 완료 체크 후 완료 처리
    func completeInteraction() {
        DispatchQueue.main.async {
            self.isInteractionCompleted = true
            self.isInteractionTriggered = false
            print("✅ iPad: 인터렉션 완료!")
            
            self.afterInteractionGoToNextPage()
        }
    }
    
    private func afterInteractionGoToNextPage() {
        guard let selectedBook = selectedBook else { return }
        
        // 현재 페이지가 마지막 페이지가 아니면 다음 페이지로
        if currentPage + 1 < selectedBook.pages.count {
            currentPage += 1
            isInteractionCompleted = false
            isInteractionTriggered = false
            print("📖 자동으로 다음 페이지로 이동: \(currentPage + 1)페이지")
            
            if currentPage == 3 {
                print(" 3번째 페이지 도달! 조명 끄기 시도")
                turnOffLightsOnPage3()
            }
        } else {
            print("📖 마지막 페이지입니다")
        }
    }
    
    func increaseIndex(){
        //다음 버튼 로직
        guard let selectedBook else { return }
        
        // 3번째 페이지에서는 인터렉션 완료 체크
        if currentPage == 2 && !isInteractionCompleted {
            print("인터렉션 완료해야 다음 페이지로 넘어갈 수 있습니다 !")
            showInteractionCompleteAlert = true
            return
        }
        
        // 다음 페이지로 이동
        if currentPage + 1 < selectedBook.pages.count {
            currentPage += 1
            isInteractionCompleted = false
            isInteractionTriggered = false
        }
    }
    
    func decreaseIndex() {
        guard let selectedBook, currentPage - 1 >= 0 else { return }
        currentPage -= 1
        
        if currentPage != 2 {
            isInteractionTriggered = false
        }
    }
    
    func dismissInteractionCompleteAlert() {
        showInteractionCompleteAlert = false
    }
    
    @MainActor
    func returnToHome(coordinator:AppCoordinator){
        coordinator.goToRoot()
    }
    
    @MainActor
    func goToPreviousView(coordinator:AppCoordinator){
        coordinator.pop()
    }
    
    func selectBook(by type: BookType) {
        // 예시: 미리 정의된 책 리스트에서 선택
        if let book = StoryBook.allBooks.first(where: { $0.type == type }) {
            selectedBook = book
            currentPage = 0
        }
    }
    
    func setUpPigBackgroundSound() {
        guard let bookType = selectedBook?.type else { return }
        
        if bookType == .pig {
            // HomePod 관련 코드 제거 - iPad 스피커만 사용
            playBackgroundSound()
        }
    }
    
    func playBackgroundSound() {
        let session = AVAudioSession.sharedInstance()
        try? session.setCategory(.playback, mode: .default, options: [.mixWithOthers, .allowAirPlay])
        try? session.setActive(true)
        
        guard let url = Bundle.main.url(forResource: "pigBackgroundMusic", withExtension: "wav") else {
            print("❌ pigBackgroundMusic.wav 파일을 찾을 수 없습니다")
            return
        }
        
        do {
            // backgroundAudioPlayer 프로퍼티에 저장
            backgroundAudioPlayer = try AVAudioPlayer(contentsOf: url)
            backgroundAudioPlayer?.numberOfLoops = -1  // 무한 반복
            backgroundAudioPlayer?.volume = 1.0        // 최대 볼륨
            backgroundAudioPlayer?.play()
            
            print("🔊 홈팟이든 뭐든 지금 출력 경로로 소리 나감")
            
            // 재생 상태 확인 (디버깅용)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                if self.backgroundAudioPlayer?.isPlaying == true {
                    print("✅ [iPad] 백그라운드 음악 재생 중")
                } else {
                    print("❌ [iPad] 백그라운드 음악 재생 안 됨")
                }
            }
            
        } catch {
            print("❌ 재생 실패: \(error)")
        }
    }
    
    func stopPigBackgroundSound() {
        backgroundAudioPlayer?.stop()
        backgroundAudioPlayer = nil
        print("🎵 돼지 동화 백그라운드 음악 중지")
    }
    
}
