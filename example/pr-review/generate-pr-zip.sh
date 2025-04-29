#!/bin/bash

# 사용 예: ./generate_pr_zip.sh <pr-number>
# 예: ./generate_pr_zip.sh 123

# 1. PR 번호 입력 확인
if [ -z "$1" ]; then
  echo "❌ 오류: PR 번호를 입력해주세요."
  echo "예: ./generate_pr_zip.sh 123"
  exit 1
fi

PR_NUMBER=$1
ZIP_FILE="review-pr-${PR_NUMBER}.zip"

# 2. GitHub CLI 사용 가능 여부 확인
if ! command -v gh &> /dev/null; then
  echo "❌ GitHub CLI(gh)가 설치되어 있지 않습니다."
  echo "https://cli.github.com/ 를 참고해 설치해주세요."
  exit 1
fi

# 3. PR 정보 가져오기 (base, head SHA)
echo "🔍 PR 정보 가져오는 중..."
PR_INFO=$(gh pr view "$PR_NUMBER" --json baseRefName,headRefName,headRefOid,baseRefOid -q '{base: .baseRefOid, head: .headRefOid}')

BASE_COMMIT=$(echo "$PR_INFO" | jq -r '.base')
HEAD_COMMIT=$(echo "$PR_INFO" | jq -r '.head')

echo "BASE_COMMIT=$BASE_COMMIT"
echo "HEAD_COMMIT=$HEAD_COMMIT"

# 4. 변경 파일 목록 추출
echo "📂 $BASE_COMMIT .. $HEAD_COMMIT 변경 파일 추출 중..."
CHANGED_FILES=$(git diff --name-only "$BASE_COMMIT" "$HEAD_COMMIT")

if [ -z "$CHANGED_FILES" ]; then
  echo "✅ 변경된 파일이 없습니다. zip을 생성하지 않습니다."
  exit 0
fi

# 5. 유효한 파일만 필터링
echo "🧹 유효한 파일 필터링 중..."
VALID_FILES=""
for file in $CHANGED_FILES; do
  if git ls-tree --name-only -r "$HEAD_COMMIT" | grep -qx "$file"; then
    VALID_FILES="$VALID_FILES $file"
  else
    echo "⚠️ 경고: '$file' 은(는) $HEAD_COMMIT 시점에 존재하지 않음. 건너뜀."
  fi
done

if [ -z "$VALID_FILES" ]; then
  echo "⚠️ 유효한 변경 파일이 없습니다. zip을 생성하지 않습니다."
  exit 0
fi

# 6. ZIP 생성
echo "📦 유효한 변경 파일을 zip으로 압축합니다: $ZIP_FILE"
git archive -o "$ZIP_FILE" "$HEAD_COMMIT" $VALID_FILES

echo "✅ 완료: $ZIP_FILE"
