# 📝 Wiki Log

> 위키에 대한 모든 작업(수집, 질문, 검수)의 시간순 기록입니다.
> Append-only — 새 기록은 항상 맨 아래에 추가합니다.

---

## [2026-04-24] init | 위키 초기 구성
- Karpathy의 Knowledge Base 패턴에 따라 위키 구조를 생성했습니다.
- 디렉토리: `raw/`, `raw/assets/`, `wiki/sources/`, `wiki/entities/`, `wiki/concepts/`, `wiki/analyses/`
- 핵심 파일: `AGENTS.md`, `index.md`, `log.md`, `README.md`
- GitHub 자동 동기화 설정 완료 (`road2east-git/neural_network`)

## [2026-04-24] ingest | Karpathy — LLM 기반 개인 지식 베이스 구축 패턴
- 소스: `raw/karpathy-llm-knowledge-base-pattern.md`
- 생성된 페이지:
  - `wiki/sources/karpathy-llm-knowledge-base-pattern.md` — 소스 요약
  - `wiki/entities/andrej-karpathy.md` — 개체: Andrej Karpathy
  - `wiki/entities/obsidian.md` — 개체: Obsidian
  - `wiki/concepts/rag.md` — 개념: RAG
  - `wiki/concepts/memex.md` — 개념: Memex
- `index.md` 업데이트 완료
- 총 영향 받은 파일: 7개

## [2026-04-24] query | RAG 방식과 Karpathy 제안 패턴의 차이
- 질문: "RAG 방식과 Karpathy가 제안한 LLM 위키 패턴의 핵심적인 차이가 뭐야? 비교해서 정리해줘."
- 결과: 답변 생성 후 새로운 분석 페이지 도출
- 생성된 페이지: `wiki/analyses/rag-vs-llm-wiki.md`
- `index.md` 업데이트 완료

## [2026-04-24] lint | 위키 건강 점검 및 끊어진 링크 복구
- 발견 사항: `wiki/concepts/memex.md` 파일에서 `[[Vannevar Bush]]`가 언급만 되고 페이지가 존재하지 않는 고아 링크 상태 확인
- 조치: 누락된 개체 페이지 생성 (`wiki/entities/vannevar-bush.md`)
- `index.md` 업데이트 완료

## [2026-05-04] ingest | 디자인 필수 용어 99선
- 소스: `raw/design words 01.md`
- 생성된 페이지:
  - `wiki/sources/design-words-01.md` — 소스 요약
  - `wiki/concepts/composition-and-layout.md` — 개념: Composition & Layout
  - `wiki/concepts/typography.md` — 개념: Typography
  - `wiki/concepts/color-theory.md` — 개념: Color Theory
  - `wiki/concepts/image-file-formats.md` — 개념: Image File Formats
- 추가 조치: `raw/assets/`에 포함된 이미지들(avif 파일 등)이 위키 개념 문서에서 정상적으로 렌더링되도록 `![[파일명]]` 형식으로 연결함.
- `index.md` 업데이트 완료
- 총 영향 받은 파일: 6개

## [2026-05-04] lint | 전체 링크 무결성 점검
- 발견 사항: `wiki/sources/karpathy-llm-knowledge-base-pattern.md` 및 `wiki/entities/obsidian.md` 등에서 `[[Dataview]]`, `[[Marp]]`, `[[qmd]]` 링크가 고아(orphan) 상태로 방치되어 있는 것을 발견.
- 조치: 3개의 누락된 개체 페이지 생성 (`wiki/entities/dataview.md`, `wiki/entities/marp.md`, `wiki/entities/qmd.md`)
- `index.md` 엔티티 리스트에 위 항목들 업데이트 완료

## [2026-05-04] lint | 원본 소스 삭제에 따른 위키 클린업
- 발견 사항: 사용자가 `raw/karpathy-llm-knowledge-base-pattern.md`를 삭제함.
- 조치:
  - `wiki/sources/karpathy-llm-knowledge-base-pattern.md` 삭제
  - 해당 소스에만 의존하던 고아 페이지 6개 삭제 (`vannevar-bush.md`, `obsidian.md`, `andrej-karpathy.md`, `rag.md`, `memex.md`, `rag-vs-llm-wiki.md`)
  - `wiki/entities/qmd.md` 등에서 남아있는 참조 링크 제거
  - `index.md` 인덱스 갱신 (관련된 페이지 링크 모두 제거)

## [2026-05-04] ingest | 디자인 추가 용어 및 스타일
- 소스: `raw/50 design words to know.md`, `raw/51 Key words all designers should know.md`, `raw/design words 02.md`
- 생성된 페이지:
  - `wiki/sources/50-design-words-to-know.md`
  - `wiki/sources/51-key-words-all-designers-should-know.md`
  - `wiki/sources/design-words-02.md`
  - `wiki/concepts/branding.md` — 개념: Branding
  - `wiki/concepts/design-styles.md` — 개념: Design Styles
  - `wiki/concepts/print-design.md` — 개념: Print Design
  - `wiki/entities/canva.md` — 개체: Canva
  - `wiki/entities/adobe-express.md` — 개체: Adobe Express
- 기존 페이지 갱신: `typography.md`, `composition-and-layout.md`, `color-theory.md` 관련 소스 필드 업데이트
- `index.md` 업데이트 완료
