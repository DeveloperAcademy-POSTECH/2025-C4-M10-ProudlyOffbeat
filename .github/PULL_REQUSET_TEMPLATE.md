## ✨ 이번 PR에서 공부하고 적용한 내용

- 📚 학습한 주제:
  - 예) HomeKit 자동화 흐름, Swift async/await 구조, BLE 장치 스캔 방식 등

- 🔍 참고한 자료:
  - 예) Apple Developer Doc 링크, 블로그 URL, 강의 노트 등

---

## 🛠️ 구현 내용 요약

- 어떤 기능을 구현했는지 간단히 서술
- 어떤 구조/패턴(MVVM, DI 등)을 적용했는지

---

## 🤔 리뷰어가 봐줬으면 하는 부분

- 예) 비동기 처리 방식 괜찮은지 확인해주세요
- 예) 하드웨어 시뮬레이션 테스트가 잘 되는지 궁금합니다

---

## ✅ 체크리스트

- [ ] 코드가 정상 동작함 (시뮬레이터 / 실기기 테스트 완료)
- [ ] 커밋 메시지 규칙 지킴 (`[Feat]`, `[Fix]`, `[Refactor]` 등)
- [ ] 불필요한 디버깅 코드 제거
- [ ] 관련 문서 또는 README 업데이트

---

## 💻 핵심 코드 예시 (직접 구현한 부분)

```swift
// HomeKit 액세서리 제어 예시
func toggleLight(_ accessory: HMAccessory) {
    guard let characteristic = accessory
        .findCharacteristic(type: .powerState) else { return }

    let newValue = !(characteristic.value as? Bool ?? false)
    characteristic.writeValue(newValue) { error in
        if let error = error {
            print("제어 실패: \(error)")
        } else {
            print("성공적으로 전등 상태 변경")
        }
    }
}

## 🧠 기타 메모 (선택)

- 앞으로의 개선 방향이나 고민 중인 내용
- 느낀 점, 마주친 에러와 해결법 등