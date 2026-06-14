# Graph Report - Alpha-SuperApp  (2026-06-14)

## Corpus Check
- 34 files · ~15,434 words
- Verdict: corpus is large enough that graph structure adds value.

## Summary
- 345 nodes · 493 edges · 27 communities
- Extraction: 98% EXTRACTED · 2% INFERRED · 0% AMBIGUOUS · INFERRED: 10 edges (avg confidence: 0.8)
- Token cost: 0 input · 0 output

## Graph Freshness
- Built from commit: `556ba91c`
- Run `git rev-parse HEAD` and compare to check if the graph is stale.
- Run `graphify update .` after code changes (no API cost).

## Community Hubs (Navigation)
- [[_COMMUNITY_Community 0|Community 0]]
- [[_COMMUNITY_Community 1|Community 1]]
- [[_COMMUNITY_Community 2|Community 2]]
- [[_COMMUNITY_Community 3|Community 3]]
- [[_COMMUNITY_Community 4|Community 4]]
- [[_COMMUNITY_Community 5|Community 5]]
- [[_COMMUNITY_Community 6|Community 6]]
- [[_COMMUNITY_Community 7|Community 7]]
- [[_COMMUNITY_Community 8|Community 8]]
- [[_COMMUNITY_Community 9|Community 9]]
- [[_COMMUNITY_Community 10|Community 10]]
- [[_COMMUNITY_Community 11|Community 11]]
- [[_COMMUNITY_Community 12|Community 12]]
- [[_COMMUNITY_Community 13|Community 13]]
- [[_COMMUNITY_Community 14|Community 14]]
- [[_COMMUNITY_Community 15|Community 15]]
- [[_COMMUNITY_Community 16|Community 16]]
- [[_COMMUNITY_Community 17|Community 17]]
- [[_COMMUNITY_Community 18|Community 18]]
- [[_COMMUNITY_Community 19|Community 19]]
- [[_COMMUNITY_Community 20|Community 20]]
- [[_COMMUNITY_Community 21|Community 21]]

## God Nodes (most connected - your core abstractions)
1. `BudgetViewModel` - 26 edges
2. `SbrControlViewModel` - 18 edges
3. `Alpha SuperApp` - 16 edges
4. `BudgetRepository` - 12 edges
5. `BillPhotoManager` - 9 edges
6. `BudgetScreen()` - 9 edges
7. `String` - 9 edges
8. `AppSettings` - 9 edges
9. `AlphaNavGraph()` - 9 edges
10. `Security Policy` - 9 edges

## Surprising Connections (you probably didn't know these)
- `AlphaNavGraph()` --calls--> `BudgetScreen()`  [INFERRED]
  app/src/main/java/com/alpha/ui/navigation/NavGraph.kt → app/src/main/java/com/alpha/features/budget/BudgetScreen.kt
- `AlphaNavGraph()` --calls--> `CalculatorScreen()`  [INFERRED]
  app/src/main/java/com/alpha/ui/navigation/NavGraph.kt → app/src/main/java/com/alpha/features/calculator/CalculatorScreen.kt
- `AlphaNavGraph()` --calls--> `SbrControlScreen()`  [INFERRED]
  app/src/main/java/com/alpha/ui/navigation/NavGraph.kt → app/src/main/java/com/alpha/features/sbrcontrol/SbrControlScreen.kt
- `AlphaNavGraph()` --calls--> `SettingsScreen()`  [INFERRED]
  app/src/main/java/com/alpha/ui/navigation/NavGraph.kt → app/src/main/java/com/alpha/features/settings/SettingsScreen.kt
- `AlphaNavGraph()` --calls--> `WebSearchScreen()`  [INFERRED]
  app/src/main/java/com/alpha/ui/navigation/NavGraph.kt → app/src/main/java/com/alpha/features/websearch/WebSearchScreen.kt

## Import Cycles
- None detected.

## Communities (27 total, 0 thin omitted)

### Community 0 - "Community 0"
Cohesion: 0.10
Nodes (15): BudgetState, ByteArray, Double, Int, JSONObject, List, Long, StateFlow (+7 more)

### Community 1 - "Community 1"
Cohesion: 0.08
Nodes (24): MainActivity, androidx, String, String, Boolean, Boolean, Boolean, Bundle (+16 more)

### Community 2 - "Community 2"
Cohesion: 0.11
Nodes (12): android, String, Int, StateFlow, String, HandLandmarker, HandLandmarkerResult, ImageProxy (+4 more)

### Community 3 - "Community 3"
Cohesion: 0.16
Nodes (22): Boolean, BudgetState, Double, Long, String, Transaction, TransactionCategory, AddTransactionSheet() (+14 more)

### Community 4 - "Community 4"
Cohesion: 0.09
Nodes (21): Acknowledgments, Alpha SuperApp, Build Configuration, Building the Project, Changelog, Code Style, Contributing, Dependencies (+13 more)

### Community 5 - "Community 5"
Cohesion: 0.25
Nodes (8): BudgetState, Double, Flow, List, String, Transaction, BudgetRepository, CategoryBudget

### Community 6 - "Community 6"
Cohesion: 0.14
Nodes (9): Any, Boolean, ByteArray, Int, StateFlow, String, ViewModel, WebSearchUiState (+1 more)

### Community 7 - "Community 7"
Cohesion: 0.12
Nodes (15): [1.1.0] - 2026-03-22, Added, Added, Changed, Changed, Changelog, Deprecated, Deprecated (+7 more)

### Community 8 - "Community 8"
Cohesion: 0.12
Nodes (15): Android Security, API Security, Build Security, Code Security, Compliance, Dependency Management, Dependency Vulnerabilities, How to Report (+7 more)

### Community 9 - "Community 9"
Cohesion: 0.28
Nodes (6): Boolean, Context, Flow, Int, String, AppSettings

### Community 10 - "Community 10"
Cohesion: 0.32
Nodes (4): ByteArray, String, Bitmap, BillPhotoManager

### Community 11 - "Community 11"
Cohesion: 0.26
Nodes (7): Context, Int, String, TransactionCategory, Uri, EsewaXlsParser, XlsParseResult

### Community 12 - "Community 12"
Cohesion: 0.21
Nodes (9): Boolean, Context, Int, Result, String, BluetoothSocket, BufferedOutputStream, BluetoothComm (+1 more)

### Community 13 - "Community 13"
Cohesion: 0.30
Nodes (7): GeminiClient, Boolean, ByteArray, Int, JsonObject, Result, String

### Community 14 - "Community 14"
Cohesion: 0.20
Nodes (7): AndroidViewModel, Boolean, Int, StateFlow, String, SettingsViewModel, UiState

### Community 15 - "Community 15"
Cohesion: 0.40
Nodes (3): Boolean, String, DriveSync

### Community 16 - "Community 16"
Cohesion: 0.29
Nodes (9): Long, BudgetState, CategoryBudget, currentMonthStartMs(), remainingBudget(), spentByCategory(), totalBudgetLimit(), totalSpentThisMonth() (+1 more)

### Community 17 - "Community 17"
Cohesion: 0.33
Nodes (5): Long, String, Transaction, TransactionCategory, GmailParser

### Community 18 - "Community 18"
Cohesion: 0.33
Nodes (6): androidx, List, String, CalcMode, CalculatorScreen(), ModeRow()

### Community 19 - "Community 19"
Cohesion: 0.38
Nodes (4): Int, List, String, GestureLogic

### Community 20 - "Community 20"
Cohesion: 0.29
Nodes (5): Int, List, String, NormalizedLandmark, HandGestureProcessor

### Community 21 - "Community 21"
Cohesion: 0.50
Nodes (3): Transaction, TransactionCategory, TransactionSource

## Knowledge Gaps
- **111 isolated node(s):** `Bundle`, `Result`, `JsonObject`, `Bitmap`, `Flow` (+106 more)
  These have ≤1 connection - possible missing edges or undocumented components.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `AlphaNavGraph()` connect `Community 1` to `Community 18`, `Community 3`?**
  _High betweenness centrality (0.033) - this node is a cross-community bridge._
- **Why does `BudgetViewModel` connect `Community 0` to `Community 14`?**
  _High betweenness centrality (0.032) - this node is a cross-community bridge._
- **Why does `SbrControlViewModel` connect `Community 2` to `Community 14`?**
  _High betweenness centrality (0.027) - this node is a cross-community bridge._
- **What connects `Bundle`, `Result`, `JsonObject` to the rest of the system?**
  _111 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `Community 0` be split into smaller, more focused modules?**
  _Cohesion score 0.10476190476190476 - nodes in this community are weakly interconnected._
- **Should `Community 1` be split into smaller, more focused modules?**
  _Cohesion score 0.07661290322580645 - nodes in this community are weakly interconnected._
- **Should `Community 2` be split into smaller, more focused modules?**
  _Cohesion score 0.11330049261083744 - nodes in this community are weakly interconnected._