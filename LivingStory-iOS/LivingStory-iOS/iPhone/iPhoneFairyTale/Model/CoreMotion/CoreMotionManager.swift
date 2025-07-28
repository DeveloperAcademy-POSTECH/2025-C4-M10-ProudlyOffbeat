//
//  CoreMotionManager.swift
//  LivingStory-iOS
//
//  Created by 문창재 on 7/28/25.
//
import AVFoundation
import CoreMotion

class CoreMotionManager {
    static let shared = CoreMotionManager()
    private var player: AVAudioPlayer?
    internal let motionManager = CMMotionManager()
    private var sawingSoundIndex = 0
    private let sawingSounds = ["Sawing1", "Sawing2"]
    
    func startMotionUpdates() {
        if motionManager.isAccelerometerAvailable {
            motionManager.accelerometerUpdateInterval = 0.1
            motionManager.startAccelerometerUpdates(to: .main) { data, error in
                guard let acceleration = data?.acceleration else { return }
                
                let threshold = 1.5
                if abs(acceleration.y) > threshold {
                    print("🙌 휘두름 감지됨")
                    DispatchQueue.main.async {
                        // 톱질 할 때마다 사용될 메소드들
                        self.playSound()
                        //mcService.send(message: "SHAKE_DETECTED")
                    }
                }
            }
        }
    }
    
//        .onAppear {
//            if !motionManager.isAccelerometerActive {
//                startMotionUpdates()
//            }
//        }
    
    func playSound() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("❌ AVAudioSession 설정 실패: \(error.localizedDescription)")
        }
        let soundName = sawingSounds[sawingSoundIndex]
        
        guard let url = Bundle.main.url(forResource: "\(soundName)", withExtension: "m4a") else {
            print("❌ 사운드 파일 없음")
            return
        }

        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
            print("재생!")
            sawingSoundIndex = (sawingSoundIndex + 1) % sawingSounds.count
        } catch {
            print("❌ 사운드 재생 오류: \(error.localizedDescription)")
        }
    }
}
