목표: AWS/DevOps 로그에서 score 기반으로 중요한 로그만 추출하는 Python 코드 생성

조건:
- EC2: Utilization < 30% and Cost ≥ 100 → +1
- S3: STANDARD and DaysOld ≥ 90 → +1
- CloudWatch: 'low utilization', 'archived', 'high metric' 포함 → +1
- 정책 위반: 'open to all', 'unauthorized', 'public s3', 'exposed' → +2
- 비용 이상치: Z-score > 1.5 → +1
- 시간 패턴: 최근 3시간 내 Cost 증가 2회 이상 → +1

누적 점수 ≥ 3인 행만 추출  
함수 형태: `layered_filter(df)`  
결과는 pandas 코드로만 출력 (조건별 주석 포함, 코드 외 출력 금지)

[뒤에 로그 DataFrame 또는 샘플 로그 붙이기]
