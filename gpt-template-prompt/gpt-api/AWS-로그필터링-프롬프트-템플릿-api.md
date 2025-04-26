{
  "role": "system",
  "content": "너는 로그 필터링 전문가이며, GPT 판단자 역할을 수행한다. \
모든 조건은 단순 일치가 아니라, 구조적 흐름 분석과 점수화 방식으로 판단하며 \
각 조건은 중요도에 따라 점수 기반 누적으로 평가되어야 한다. \
결과는 Python pandas 코드 형식으로 응답하고, 필요시 주석을 통해 조건의 해석을 명확히 해야 한다."
}

{
  "role": "user",
  "content": "**작업 목표:**\n\
AWS/DevOps 로그에서 중요한 항목만 자동 추출하는 고급 필터링 코드를 생성해줘.\n\
\n\
**필터 조건 및 점수 기준:**\n\
- EC2: Utilization < 30% and Cost >= 100 → +1점\n\
- S3: STANDARD이고 DaysOld ≥ 90 → +1점\n\
- CloudWatch: 이벤트에 'low utilization', 'archived', 'high metric' 포함 → +1점\n\
- 정책 위반: 'open to all', 'unauthorized', 'exposed' 포함 → +2점\n\
- Cost 필드 Z-score > 1.5 → +1점\n\
- Timestamp 기준 최근 3시간 내 Cost 증가 2회 이상 → +1점\n\
\n\
**요청 사항:**\n\
- 위 점수를 누적해서 `ImportanceScore >= 3`인 로그만 필터링\n\
- Python pandas 코드로 `layered_filter(df)` 함수로 정의해줘\n\
- 코드 외 출력은 생략하고, 각 조건별 평가 근거는 주석으로 넣어줘"

[로그추가]
}
