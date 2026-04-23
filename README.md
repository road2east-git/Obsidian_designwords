# 🧠 Neural Network — Personal Knowledge Wiki

> LLM이 점진적으로 구축하고 유지보수하는 개인 지식 위키  
> 패턴 원문: [Karpathy's Knowledge Base Pattern](https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f)

## 아키텍처

```
Knowledge_01/
├── raw/            ← 원본 소스 (불변, LLM이 읽기만 함)
│   └── assets/     ← 이미지, 첨부파일
├── wiki/           ← LLM이 생성/유지하는 구조화된 지식
│   ├── entities/   ← 사람, 조직, 도구 등 개체 페이지
│   ├── concepts/   ← 개념, 이론, 방법론 페이지
│   ├── sources/    ← 소스별 요약 페이지
│   └── analyses/   ← 비교, 분석, 종합 페이지
├── index.md        ← 위키 전체 카탈로그 (내용 중심)
├── log.md          ← 작업 이력 (시간 중심)
└── AGENTS.md       ← 스키마: LLM 행동 지침
```

## 작업 흐름

| 작업 | 설명 |
|------|------|
| **Ingest** | 새 소스 추가 → LLM이 요약 + 위키 전반 업데이트 |
| **Query** | 위키 기반 질문 → 좋은 답변은 위키에 저장 |
| **Lint** | 주기적 건강 점검 (모순, 고아 페이지, 누락 링크) |

## 자동 동기화

이 위키는 파일 변경 시 자동으로 GitHub에 동기화됩니다.
