#!/bin/bash

PR_NUMBER=$1

if [ -z "$PR_NUMBER" ]; then
  echo "❌ PR 번호를 입력해주세요."
  echo "사용 예: ./generate_pr_info_template.sh 123"
  exit 1
fi

# gh 로그인 확인
if ! gh auth status &> /dev/null; then
  echo "❗ GitHub CLI 인증이 필요합니다. 먼저 gh auth login 실행"
  exit 1
fi

# jq 설치 여부 확인
if ! command -v jq &> /dev/null; then
  echo "❗ jq가 설치되어 있어야 합니다. (예: brew install jq)"
  exit 1
fi

echo "🔍 PR 정보 조회 중..."

PR_INFO=$(gh pr view "$PR_NUMBER" --json title,body,baseRefOid,headRefOid,url -q \
  '{title: .title, body: .body, base: .baseRefOid, head: .headRefOid, url: .url}')

PR_TITLE=$(echo "$PR_INFO" | jq -r '.title')
PR_BODY_RAW=$(echo "$PR_INFO" | jq -r '.body')
PR_URL=$(echo "$PR_INFO" | jq -r '.url')
BASE_COMMIT=$(echo "$PR_INFO" | jq -r '.base')
HEAD_COMMIT=$(echo "$PR_INFO" | jq -r '.head')

CHANGED_FILES=$(git diff --name-only "$BASE_COMMIT" "$HEAD_COMMIT")

# 출력 템플릿 생성
echo "📄 PR 기본 정보 → template-pr-info.txt"

cat <<EOF > template-pr-info.txt
### PR 분석 템플릿 - Java/Kotlin 백엔드

#### 1. PR 기본 정보
- **PR 제목**: $PR_TITLE
- **PR 설명**:
$PR_BODY_RAW
- **관련 이슈**: ($PR_URL)
- **주요 변경 사항**:
$(for file in $CHANGED_FILES; do echo "  - $file"; done)
EOF

echo "✅ 생성 완료: template-pr-info.txt"