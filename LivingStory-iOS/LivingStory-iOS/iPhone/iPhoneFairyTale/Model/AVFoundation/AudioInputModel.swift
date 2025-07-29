//
//  AudioInputModel.swift
//  LivingStory-iOS
//
//  Created by jihanchae on 7/23/25.
//

import AVFoundation

class AudioInputModel: ObservableObject {
    private var audioRecorder: AVAudioRecorder?
    private var audioPlayer: AVAudioPlayer?
    private var timer: Timer?
    private let threshold: Float = -5.5 // 바람 인식 기준
    
    @Published var isBlowingDetected = false
    var onBlowingCompleted: (() -> Void)?
    
    
    deinit{
        print("블로우 타이머 정지")
        stopMonitoring()
    }
    
    
    func startMonitoring(onCompleted: @escaping () -> Void) {
        stopMonitoring()
        self.onBlowingCompleted = onCompleted
        
        let audioSession = AVAudioSession.sharedInstance()
        try? audioSession.setCategory(.playAndRecord, mode: .default, options: [.mixWithOthers, .allowAirPlay])
        try? audioSession.setActive(true)
        
        let settings: [String: Any] = [
            AVFormatIDKey: Int(kAudioFormatAppleLossless),
            AVSampleRateKey: 44100.0,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.min.rawValue
        ]
        
        let url = URL(fileURLWithPath: "/dev/null")
        
        do {
            audioRecorder = try AVAudioRecorder(url: url, settings: settings)
            audioRecorder?.isMeteringEnabled = true
            audioRecorder?.record()
            
            timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
                guard let self = self else { return }
                self.audioRecorder?.updateMeters()
                let level = self.audioRecorder?.averagePower(forChannel: 0) ?? -160
                
                print("🎤 current decibels: \(level)")
                
                if level > self.threshold {
                    DispatchQueue.main.async {
                        self.isBlowingDetected = true
                        self.stopMonitoring()
                        
                        self.playBlowSound()
                        
                        self.onBlowingCompleted?()
                    }
                }
            }
        } catch {
            print("❌ 오디오 레코더 초기화 실패: \(error)")
        }
    }
    
    private func playBlowSound() {
        let audioSession = AVAudioSession.sharedInstance()
        try? audioSession.setCategory(.playback, mode: .default, options: [.mixWithOthers, .allowAirPlay])
        try? audioSession.setActive(true)
        
        guard let soundURL = Bundle.main.url(forResource: "pigBlowEffect", withExtension: "wav") else {
            print("❌ pigBlowEffect.wav 파일을 찾을 수 없습니다")
            return
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            audioPlayer?.volume = 1.0
            audioPlayer?.play()
            print(" 바람 효과음 재생: pigBlowEffect")
        } catch {
            print("❌ 효과음 재생 실패: \(error)")
        }
    }
    
    internal func playGoldSound() {
        let audioSession = AVAudioSession.sharedInstance()
        try? audioSession.setCategory(.playback, mode: .default, options: [.mixWithOthers, .allowAirPlay])
        try? audioSession.setActive(true)
        
        guard let soundURL = Bundle.main.url(forResource: "HeungGold", withExtension: "wav") else {
            print("❌ HeungGold.wav 파일을 찾을 수 없습니다")
            return
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            audioPlayer?.volume = 1.0
            audioPlayer?.play()
            print(" 보물 효과음 재생: HeungGold")
        } catch {
            print("❌ 효과음 재생 실패: \(error)")
        }
    }
    
    func stopMonitoring() {
        audioRecorder?.stop()
        if let timer = timer {
            timer.invalidate()
            print("타이머 invalidate")
        }
        timer = nil
        audioPlayer?.stop()
        audioPlayer = nil
    }
}

