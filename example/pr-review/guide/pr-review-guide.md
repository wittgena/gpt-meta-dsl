# ✅ PR 리뷰 자동화 실행 가이드 (최신 통합 구조 기준)

---

## 🧰 사전 준비

### 1. 필수 도구 설치 확인
- `gh` (GitHub CLI)
- `jq` (JSON 파서)
- `git` (PR 커밋 비교용)

```bash
brew install gh jq git
```

### 2. 고정 리뷰 템플릿 파일 설치
```bash
mkdir -p ~/bin
cp pr-review-template-prompt.md ~/bin/pr-review-template-prompt.md
```

> 해당 파일에는 `{{PR_INFO}}` 자리표시자가 반드시 포함되어야 합니다.

---

## 🚀 실행 방법

### 🔁 단일 명령 실행

```bash
./run-pr-review.sh <PR_NUMBER>
```

예:
```bash
./run-pr-review.sh 675
```

---

## 🔧 수행 동작 요약

| 단계 | 설명 | 생성 결과 |
|------|------|------------|
| PR 정보 추출 | PR 제목, 본문, URL, 변경 커밋 범위 | `template_prompt_<PR>.md` *(임시)* |
| 템플릿 병합 | `{{PR_INFO}}` 자리에 동적 정보 삽입 | `pr-review-prompt-<PR>.md` |
| 변경 파일 zip | PR 변경 파일만 압축 | `pr-review-files-<PR>.zip` |
| 임시 정리 | PR 정보 임시 템플릿 삭제 | -- |

---

## 📂 결과물 정리

| 파일명 | 설명 |
|--------|------|
| `pr-review-prompt-<PR>.md` | GPT에게 붙여넣을 최종 템플릿 |
| `pr-review-files-<PR>.zip` | 분석 대상 코드 파일 묶음 |

---

## 🤖 GPT 리뷰 요청 방식

1. **ChatGPT 웹에 접속**
2. `pr-review-prompt-<PR>.md`의 전체 내용을 붙여넣기
3. `pr-review-files-<PR>.zip` 파일 업로드
4. 다음 메시지 입력:

```
이 템플릿을 기준으로 이 PR에 대한 리뷰를 생성해주세요.
```

---

## 🧠 GPT 명령어 확장 흐름 (선택적 사용)

| 명령어 | 의미 |
|--------|------|
| `+critic:` | 특정 구조 비판 |
| `+eval:` | 정합성/성능/안정성 평가 |
| `+refactor:` | 리팩토링 제안 |
| `+simulation:` | 시나리오 기반 테스트 |
| `+val:` | 설계 가치 분석 |
| `+update:` | 반영 후 재검토 요청 |

---

## ✅ 예시 명령

```
+critic: ProductController의 책임 과다 여부 분석
+refactor: KeywordFetcher를 전략 패턴으로 전환
+simulation: fallback 실패 시 흐름 검증
```

---

## 📌 유의사항

- 템플릿 내 `{{PR_INFO}}` 위치가 누락되면 최종 prompt 파일이 비어 있을 수 있습니다.
- PR에 변경된 파일이 없으면 zip 파일도 생성되지 않습니다.
- GitHub 인증 필요 시 `gh auth login`으로 사전 인증 필요.
