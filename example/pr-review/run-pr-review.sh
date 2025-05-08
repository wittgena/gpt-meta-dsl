#!/bin/bash

# === 1. 입력 확인 ===
PR_NUMBER=$1

if [ -z "$PR_NUMBER" ]; then
  echo "❌ PR 번호를 입력해주세요. 예: ./run-pr-review.sh 123"
  exit 1
fi

TEMPLATE_FILE="template_prompt_${PR_NUMBER}.md"
ZIP_FILE="pr-review-files-${PR_NUMBER}.zip"
FINAL_PROMPT_FILE="pr-review-prompt-${PR_NUMBER}.md"
STATIC_TEMPLATE_FILE="$HOME/bin/pr-review-template-prompt.md"

# === 2. 사전 요구 조건 확인 ===
for cmd in gh jq git; do
  if ! command -v $cmd &> /dev/null; then
    echo "❌ '$cmd' 명령이 필요합니다. 설치 후 다시 시도해주세요."
    exit 1
  fi
done

if [ ! -f "$STATIC_TEMPLATE_FILE" ]; then
  echo "❌ 고정 템플릿 파일(${STATIC_TEMPLATE_FILE})이 존재하지 않습니다."
  exit 1
fi

# === 3. GitHub PR 정보 조회 ===
echo "🔍 PR 정보 조회 중..."
PR_INFO=$(gh pr view "$PR_NUMBER" --json title,body,baseRefOid,headRefOid,url -q \
  '{title: .title, body: .body, base: .baseRefOid, head: .headRefOid, url: .url}')

PR_TITLE=$(echo "$PR_INFO" | jq -r '.title')
PR_BODY_RAW=$(echo "$PR_INFO" | jq -r '.body')
PR_URL=$(echo "$PR_INFO" | jq -r '.url')
BASE_COMMIT=$(echo "$PR_INFO" | jq -r '.base')
HEAD_COMMIT=$(echo "$PR_INFO" | jq -r '.head')

# === 4. 변경 파일 목록 추출 ===
echo "📁 변경 파일 목록 추출 중..."
CHANGED_FILES=$(git diff --name-only "$BASE_COMMIT" "$HEAD_COMMIT")

# === 5. 동적 PR 요약 생성 ===
echo "📝 PR 요약 템플릿 생성 → $TEMPLATE_FILE"
cat <<EOF > "$TEMPLATE_FILE"
- **PR 제목**: $PR_TITLE
- **PR 설명**:
$PR_BODY_RAW
- **관련 이슈**: ($PR_URL)
- **주요 변경 사항**:
$(for file in $CHANGED_FILES; do echo "  - $file"; done)
EOF

# === 6. 최종 프롬프트 템플릿 병합 ===
echo "🧩 고정 템플릿과 동적 정보 병합 → $FINAL_PROMPT_FILE"
PR_INFO_BLOCK=$(cat "$TEMPLATE_FILE")
# sed "s|{{PR_INFO}}|$PR_INFO_BLOCK|" "$STATIC_TEMPLATE_FILE" > "$FINAL_PROMPT_FILE"
# awk -v pr_info="$(cat "$TEMPLATE_FILE")" '{gsub("{{PR_INFO}}", pr_info)} 1' "$STATIC_TEMPLATE_FILE" > "$FINAL_PROMPT_FILE"
awk '{
  if ($0 ~ /{{PR_INFO}}/) {
    while ((getline line < "'"$TEMPLATE_FILE"'") > 0) print line;
  } else {
    print $0;
  }
}' "$STATIC_TEMPLATE_FILE" > "$FINAL_PROMPT_FILE"

# === 7. zip 파일 생성 ===
echo "📦 변경 파일 압축 중 → $ZIP_FILE"

VALID_FILES=""
for file in $CHANGED_FILES; do
  if git ls-tree --name-only -r "$HEAD_COMMIT" | grep -qx "$file"; then
    VALID_FILES="$VALID_FILES $file"
  else
    echo "⚠️ '$file' 은(는) $HEAD_COMMIT 시점에 존재하지 않음. 제외됨."
  fi
done

if [ -z "$VALID_FILES" ]; then
  echo "❌ 유효한 파일이 없어 zip 생성 취소됨."
  exit 1
fi

git archive -o "$ZIP_FILE" "$HEAD_COMMIT" $VALID_FILES

# === 8. 안내 메시지 출력 ===
echo ""
echo "✅ PR 리뷰 준비 완료!"
echo "📄 최종 프롬프트 템플릿: $FINAL_PROMPT_FILE"
echo "📦 코드 압축: $ZIP_FILE"

# === 9. 임시 파일 삭제 ===
if [ -f "$TEMPLATE_FILE" ]; then
  echo "🧹 임시 템플릿 파일 삭제: $TEMPLATE_FILE"
  rm -f "$TEMPLATE_FILE"
fi

echo ""
echo "👉 아래 절차를 따라 리뷰 요청을 진행하세요:"
echo "1. GPT 웹창에 $FINAL_PROMPT_FILE 내용 복사"
echo "2. $ZIP_FILE 파일 업로드"
echo "3. 다음 명령 사용: '이 템플릿을 기준으로 리뷰 생성해주세요.'"
