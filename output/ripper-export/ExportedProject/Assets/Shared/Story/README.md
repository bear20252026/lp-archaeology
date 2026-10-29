# Story（剧情交互系统）

各场景共用的剧情交互：对白、剧情节拍、任务与完成条件、星球内的剧情状态（标记）。开发分支 `claude/story-interaction`。

和 `Shared/Core` 的分工：`Core/Scripts/Runtime/Interaction/`（`Interactable`、`PlayerInteractor`、`ChairSeat`）只负责“靠近—提示—按键”这一层；本目录在它之上组织剧情——某次交互触发哪段对白、推进哪个节拍、满足什么条件后场景完成。

和 `Shared/Journey` 的分工：星球之间的地图、转场、跨星球进度存档和「启程」归 Journey（见 `scenes/shared/design/JOURNEY_MAP.md`）。本目录只管星球内部的剧情；一颗星球的剧情做完时调用 `LittlePrince.Journey.JourneyDeparture.CompletePlanet()`（星球表里该星球的完成条件选 `Story`），由 Journey 接手。

## 剧情依据

具体剧情以各场景的 `design/` 为准（都在 `main`），本目录只实现，不另写剧情：

| 场景 | 文档 |
| --- | --- |
| 全游戏规则与验收 | `scenes/shared/design/PRD.md` |
| B-612 家园 | `scenes/b612/design/DIALOGUE.md` |
| 国王王庭 | `scenes/royal-court/design/STORY.md`、`ARRIVAL_DEPARTURE.md` |
| 爱虚荣者剧场 | `scenes/theater/design/STORY.md` |
| 酒鬼旧酒馆 | `scenes/bar/design/STORY.md` |
| 商人计数所 | `scenes/counting-house/design/STORY.md` |
| 点灯人星球 | `scenes/lamplighter/design/STORY.md` |
| 地理学家地图馆 | `scenes/geography/design/STORY.md` |

## 目录约定

按 `docs/REPO_STRUCTURE.md` 5.2 节：代码放 `Scripts/Runtime/`、`Scripts/Editor/`，各自建 asmdef（运行时引用 `B612.Core`、`LittlePrince.Journey`）。只属于某一个场景的剧情数据和脚本放该场景的 `Assets/Levels/<Scene>/`，不放这里。

本目录属于共享部分：改动按 `docs/COLLABORATION.md` 先进 `main`，并通知各场景负责人。
