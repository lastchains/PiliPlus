# MODELS_NEW MODULE

## OVERVIEW
新数据模型目录，363 个文件，114 个子目录。是 `models/` 的替代/升级版本，迁移进行中。

## STRUCTURE
```
models_new/
├── video/              # 视频相关模型
├── user/               # 用户相关模型
├── live/               # 直播相关模型
├── search/             # 搜索相关模型
├── dynamic/            # 动态相关模型
├── ranking/            # 排名榜单模型
└── ...                 # 其他模型
```

## WHERE TO LOOK
| Task | Location | Notes |
|------|----------|-------|
| 视频详情 | `models_new/video/video_detail/` | 视频详细信息模型 |
| 用户信息 | `models_new/user/` | 用户资料、统计等 |
| 直播间 | `models_new/live/` | 直播间信息模型 |
| 搜索结果 | `models_new/search/` | 搜索相关模型 |
| 动态流 | `models_new/dynamic/` | 动态/时间线模型 |
| 排行榜 | `models_new/ranking/` | 各类榜单模型 |

## CONVENTIONS
- **模型结构**: 大多数模型使用 json_serializable 进行序列化/反序列化
- **命名规范**: 使用 PascalCase 类名，snake_case 文件名
- **字段注释**: 字段通常有详细的注释说明含义
- **枚举使用**: 使用 Dart 枚举类型表示固定值集合
- **生成文件**: *.g.dart 文件是自动生成的，不要手动修改

## ANTI-PATTERNS (THIS MODULE)
1. **与 models 目录重复**: 与 `lib/models/` 功能重复，迁移完成后应删除 `models/`
2. **模型过于庞大**: 某些模型文件包含过多字段，建议按功能拆分
3. **不一致的序列化**: 部分模型使用不同的序列化策略（json_serializable vs 手动 fromJson）
4. **生成代码遗漏**: 部分模型缺少对应的 `*.g.dart` 文件，需运行 `build_runner` 生成

## UNIQUE STYLES
- **视频模型**: 包含详细的视频信息，如分页、部分、番剧信息等
- **用户模型**: 包含等级、经验、硬币等B站特有属性
- **直播模型**: 包含直播间状态、观看人数、弹幕设置等
- **搜索模型**: 支持多种搜索类型和过滤条件

## NOTES
1. **与models目录关系**: 此目录似乎是models的替代或升级版本，两者目前并存
2. **生成代码警告**: *.g.dart 文件包含 "DO NOT MODIFY BY HAND" 警告
3. **枚举定义**: 某些枚举定义在单独的文件中，便于复用