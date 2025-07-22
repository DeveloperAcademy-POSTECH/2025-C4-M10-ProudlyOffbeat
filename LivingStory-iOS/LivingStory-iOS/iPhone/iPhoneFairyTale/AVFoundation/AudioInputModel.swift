//
//  AudioInputModel.swift
//  LivingStory-iOS
//
//  Created by jihanchae on 7/23/25.
//

import AVFoundation

class AudioInputModel: ObservableObject {
    private var audioRecorder: AVAudioRecorder?
    private var timer: Timer?
    private let threshold: Float = -16.0 // 바람 인식 기준

    @Published var isBlowingDetected = false

    func startMonitoring() {
        let audioSession = AVAudioSession.sharedInstance()
                do {
                    try audioSession.setCategory(.playAndRecord, mode: .default, options: [.defaultToSpeaker])
                    try audioSession.setActive(true)
                } catch {
                    print("❌ AVAudioSession 설정 실패: \(error)")
                }
        
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
                        self.stopMonitoring() // ✅ 한 번 감지되면 바로 중단
                    }
                }
            }
        } catch {
            print("❌ 오디오 레코더 초기화 실패: \(error)")
        }
    }

    func stopMonitoring() {
        audioRecorder?.stop()
        timer?.invalidate()
        timer = nil
    }
}

