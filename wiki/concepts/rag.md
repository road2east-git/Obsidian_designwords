---
title: "RAG (Retrieval-Augmented Generation)"
type: concept
created: 2026-04-24
updated: 2026-04-24
tags: [AI, 검색, LLM, 아키텍처]
sources: [karpathy-llm-knowledge-base-pattern.md]
---

# RAG (Retrieval-Augmented Generation)

검색 증강 생성. 질문 시 관련 문서 조각을 검색하여 LLM에 컨텍스트로 제공하는 방식.

## 한계 (Karpathy의 비판)

- 매 질문마다 처음부터 지식을 재발견해야 함
- **지식의 축적이 없음** — 교차 참조, 모순 발견, 종합이 누적되지 않음
- 5개 문서를 종합해야 하는 미묘한 질문에는 매번 조각을 찾아 맞춰야 함
- NotebookLM, ChatGPT 파일 업로드 등 대부분의 시스템이 이 방식

## 대안: LLM 위키 패턴

→ [[karpathy-llm-knowledge-base-pattern|Karpathy의 LLM 위키 패턴]]은 RAG 대신 **영속적 위키**를 점진적으로 구축하는 방식을 제안

## 관련 개념

- [[Memex]] — RAG보다 위키 패턴에 더 가까운 초기 비전
