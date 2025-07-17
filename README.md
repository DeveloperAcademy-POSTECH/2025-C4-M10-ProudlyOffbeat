# 기꺼이 비주류 ( ProudlyOffbeat ) - 유일무이 HomeKit

<img width="1024" height="1024" alt="기꺼이 비주류 사진" src="https://github.com/user-attachments/assets/bee9e1aa-23a2-438b-b54a-21b8ab7bed32" />

![Xcode](https://img.shields.io/badge/Xcode-16.4-blue?logo=xcode&logoColor=white) ![iOS](https://img.shields.io/badge/Minimum_iOS-17.5+-lightgrey?logo=apple&logoColor=white) ![Swift](https://img.shields.io/badge/Swift-6.0.2-orange?logo=swift&logoColor=white) ![Version](https://img.shields.io/badge/Version-1.0.0-green)


**당연한 선택을 의심하며, 사용자가 머무르고 싶은 몰입의 공간을 설계합니다.**

> "감각을 깨우는 동화, 기술로 이뤄낸 세계."


## 🔎 아키텍처 & 소프트웨어 기술 비교, 그리고 선택 이유

### 🛠️ UI 프레임워크 UIKit VS SwiftUI

| 항목         | UIKit (명령형)                  | SwiftUI (선언형)                         |
|--------------|----------------------------------|-------------------------------------------|
| **선언방식** | 명령형 (Imperative)              | 선언형 (Declarative)                      |
| **유지보수** | 상태와 이벤트 분리 어려움         | 상태 기반 UI 바인딩으로 구조가 간결       |
| **러닝 커브**| 팀 대부분 미숙                   | 내부 학습 완료, 최신 기술 도입 적합       |
| **Agile 대응성** | 구조 변경 시 비용이 큼          | 빠른 반복 개발 및 대응 가능               |

- SwiftUI 도입 이유

    - 팀원의 UIKit 경험 부족과 SwiftUI의 빠른 프로토타이핑 이점 고려

    - 팀원들의 SwiftData 경험

### 🧱 아키텍처 비교: MVC vs MVP vs MVVM vs TCA

| 항목                 | MVC                              | MVP                                  | MVVM (+Coordinator)                                        | TCA (The Composable Architecture)          |
|----------------------|-----------------------------------|---------------------------------------|-------------------------------------------------------------|---------------------------------------------|
| **View 역할**        | View에 비즈니스 로직 혼재될 가능성        | Presenter에 이벤트 전달               | ViewModel에 상태/로직 위임                                  | View는 Store에 바인딩                         |
| **결합도**           | Controller-View 간 결합도 높음    | View-Presenter 간 분리(1:1)                | View ↔ ViewModel 바인딩 (낮은 결합도)                        | View ↔ Store 분리. 상태 관리에 집중            |
| **테스트 용이성**    | ❌ 테스트 어려움                  | ⭕ Presenter 단위 테스트 가능         | ⭕ ViewModel 단위 테스트 용이                               | ⭕ Reducer 단위 테스트 가능                     |
| **SwiftUI 호환성**   | ❌ UIKit 기반                     | ❌ UIKit 기반                          | ⭕ SwiftUI 친화적                                      | ⭕ SwiftUI 최적화 구조                                  |
| **학습 난이도**      | 하 (쉽게 접할수 있음)         | 중 (View-Logic 분리 개념 필요)        | 중상 (ADA에서 가장 많이 언급)                        | 상 (복잡한 구조와 DSL 필요)                   |
| **Agile 대응성**     | ❌ 변경 시 코드 영향도 큼          | 보통                                  | ⭕ 구조적 유연성 & 빠른 프로토타이핑 가능                   | ⭕ 상태 기반 앱에서 구조적 대응 가능             |
| **도입 이유**        | 단순한 앱에 적합                  | 뷰 로직 분리가 필요한 경우            | SwiftUI와의 궁합 + 유지보수/역할 분리가 필요한 경우        | 일관된 상태 관리 및 대규모 앱에 적합             |

### 🔥 MVVM - Coordinator - Factory 도입 이유
- SRP, DIP 등 SOLID 원칙 기반 설계

    - View / ViewModel / Coordinator 역할 분리로 책임 분산

    - 외부 주입을 통한 낮은 결합도와 테스트 용이성 확보

- Coordinator 도입 이유

    - 화면 흐름 전환(네비게이션) 책임을 별도 객체로 위임

    - SwiftUI에서 NavigationStack 중첩/조건 분기 복잡도 해소

- Factory Pattern 도입 이유

    - View/ViewModel 생성 흐름을 일관화

    - 테스트, 유지보수 용이성 확보


### 결론
- 우리팀의 여러 조건들과 다양한 모듈이 필요한 상황에서는 MVVM + Coordinator + Factory 조합이 가장 적합했습니다.
- 상태 기반의 선언형 UI에 어울리는 구조
- 의존성 주입을 통한 테스트 편의성
- View와 화면 흐름의 분리 → 유지보수 용이
- 팀원의 학습 수준과 실무에 가까운 경험 니즈 고려

> TCA는 훌륭한 선택이 될 수 있으나, 러닝커브와 진입장벽이 높고 프로젝트 초기 페이즈의 애자일에 맞지 않아 제외되었습니다.

---

## 📦 모듈화 전략

| 전략 | 설명 | 장점 | 단점 | 전환 이유 |
|------|------|------|------|-----------|
| **멀티 타겟**<br>(Multi Target) | iPhone, iPad 각각을 Target으로 구분하여 관리 | - 각 플랫폼에 맞춘 구성 가능<br>- 빌드 분리로 플랫폼 단위 디버깅 수월 | - 설정 복잡<br>- 공통 코드 중복 위험<br>- 타겟 간 의존성 관리 어려움 | 공유 기능이 많고 화면 구조가 유사하여 불필요한 중복 발생 |
| **외부 프레임워크 모듈화**<br>(SPM / XCFramework) | 기능 모듈을 별도 Framework로 나누고 SPM으로 의존성 관리 | - 재사용성 증가<br>- 의존성 분리 명확<br>- 분업 가능 | - 초기 설정 복잡<br>- 디버깅 어려움<br>- 변경사항 반영 지연 | 자주 변경되는 로직에 대해 오히려 유지보수 비용 증가<br>작은 팀에게는 과한 구조 |
| **내부 폴더 기반 모듈화**<br>(Current) | Presentation, Interaction 등 기능 기준으로 폴더 단위 분리 | - 구조 단순<br>- 변경사항 빠르게 반영 가능<br>- 빌드 속도 빠름 | - 강제 의존성 분리 어려움<br>- 순환 참조 주의 필요 | SwiftUI + MVVM 구조와 자연스럽게 맞물리며<br>빠른 실험과 구조 변경에 유리 |

---

### ✅ 내부 폴더 선택한 이유

- **초기 유연한 설계 및 빠른 반영 주기**가 중요했기 때문에, 내부 폴더 기반 모듈화 채택
- SPM은 **재사용성과 프레임워크화**가 필요한 경우 적합하지만, 이번 프로젝트는 **기기 간 유기적 연결과 빠른 반복 개발**이 핵심
- `MVVM + Coordinator + Factory` 구조와 맞물려 **명확한 폴더링과 역할 분리**가 가능해짐
