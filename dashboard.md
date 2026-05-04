---
title: "위키 대시보드"
type: system
created: 2026-04-24
---

# 📊 지식 위키 대시보드 (Dataview)

> **안내**: 이 대시보드는 Obsidian의 `Dataview` 플러그인이 설치되어 있어야 정상 작동합니다. 
> `설정 > 커뮤니티 플러그인`에서 **Dataview**를 검색하여 설치하고 활성화해 주세요.

## 📥 최근 수집된 소스 (Recent Sources)
```dataview
TABLE 
  created AS "수집일", 
  tags AS "태그"
FROM "wiki/sources"
SORT created DESC
LIMIT 5
```

## 🧠 최근 생성된 개념 (Recent Concepts)
```dataview
TABLE 
  created AS "생성일", 
  sources AS "관련 소스"
FROM "wiki/concepts"
SORT created DESC
LIMIT 5
```

## 👤 최근 추가된 개체 (Recent Entities)
```dataview
TABLE 
  created AS "생성일",
  sources AS "관련 소스"
FROM "wiki/entities"
SORT created DESC
LIMIT 5
```

## 💡 분석 및 통찰 (Analyses)
```dataview
TABLE 
  created AS "작성일",
  tags AS "태그"
FROM "wiki/analyses"
SORT created DESC
LIMIT 5
```

## 🔗 고아 문서 (Orphan Pages)
> 어디에서도 링크되지 않은 고립된 문서 목록입니다. Lint 과정에서 연결을 보완할 때 유용합니다.
```dataview
TABLE
FROM "wiki"
WHERE length(file.inlinks) = 0 AND file.name != "index" AND file.name != "dashboard"
```
