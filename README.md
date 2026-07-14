# AI 미디어 스튜디오

브라우저에서 바로 실행되는 **단일 HTML 파일** AI 미디어 생성 웹앱. 텍스트 주제 하나로 이미지·영상·내레이션·자막을 만들고 하나의 최종 영상으로 합성한다.

> `ai-media-studio.html`을 브라우저로 열기만 하면 동작. 빌드·서버 불필요.

---

## 주요 기능

### 🖼️ 이미지 모드
- OpenAI 이미지 모델(`gpt-image-1`)로 이미지 생성
- 크기 선택(1024×1024 / 1536×1024 / 1024×1536)
- 미리보기 + 다운로드

### 🎬 영상 모드
- **대본 기획** — ChatGPT / Claude로 영상 개수만큼 장면 대본 생성(장면별 영어 비주얼 키워드 + 한국어 내레이션)
- **장면별 스톡 영상** — 대본 키워드로 Pexels 영상 검색, 5열 미리보기 그리드
- **장면별 내레이션** — ElevenLabs TTS
- **하단 자막** — 1행, 25자 이내 조각으로 순차 표시(생략 없음)
- **나레이션·자막·영상 동기** — AudioBuffer 타임라인 스케줄링으로 정확히 일치
- **최종 영상 합성** — Canvas + MediaRecorder(브라우저 네이티브, 외부 라이브러리 없음)
- 최종 파일명: `주제_YYYYMMDD_HHmmss.mp4`

### 공통
- 프롬프트 생성 엔진(ChatGPT/Claude) 토글 → 고품질 영문 프롬프트 + 한국어 번역
- 결과 갤러리(최종 영상만 누적)
- **Stripe 디자인 시스템** — 시그니처 퍼플(#635BFF) 그라디언트, 라이트/다크 모드 토글
- 로딩 스피너·진행 상태·한국어 오류 메시지

---

## 사용법

1. `ai-media-studio.html`을 브라우저로 연다.
2. 우측 상단 ⚙ **설정**에서 API 키 입력:
   - **OpenAI** — 이미지 생성, 프롬프트/대본(ChatGPT)
   - **Anthropic** — 프롬프트/대본(Claude)
   - **ElevenLabs** — 내레이션 오디오
   - **Pexels** — 스톡 영상 검색
3. 모드(이미지/영상) 선택 → 주제·옵션 설정
4. (영상) **대본 생성** → **제작하기** → 최종 영상 다운로드

키는 브라우저 `localStorage`에 저장되어 새로고침 후에도 유지된다.

---

## 필요한 API 키

| 서비스 | 용도 | 발급 |
|---|---|---|
| OpenAI | 이미지 · 프롬프트 · 대본 | https://platform.openai.com |
| Anthropic | 프롬프트 · 대본 | https://console.anthropic.com |
| ElevenLabs | 내레이션 오디오 | https://elevenlabs.io |
| Pexels | 스톡 영상 | https://www.pexels.com/api |

---

## 기술

- 순수 HTML/CSS/JavaScript 단일 파일 — 프레임워크·번들러 없음
- 미디어 합성: `Canvas.captureStream` + `MediaRecorder` + `AudioContext`
- 폰트: Inter(Google Fonts)

## 주의사항

- ⚠️ **API 키가 브라우저에 평문 저장**된다. 공용·공유 PC에서 사용 금지. 데모/개인용 한정.
- OpenAI·ElevenLabs·Pexels는 브라우저 직접 호출 시 **CORS 차단** 가능 → 그 경우 오류 안내 표시. 실제 운영은 프록시 서버 권장.
- 최종 영상 컨테이너는 **webm**(파일명은 `.mp4` 표기). 일부 플레이어에서 재생 안 되면 확장자를 `.webm`로 변경.
- `gpt-image-1`은 조직 인증(verification)이 필요할 수 있다.

## 라이선스

개인 학습·데모용.
