# PAGES MODULE

## OVERVIEW
页面层，包含所有 UI 页面和导航相关代码。440 个文件，232 个子目录。

## STRUCTURE
```
pages/
├── video/              # 视频播放相关页面
├── setting/            # 设置页面
├── member_home/        # 会员首页
├── member_video/       # 会员视频
├── dynamics/           # 动态/时间线
├── later/              # 稍后再看
├── rcmd/               # 推荐页面
├── search/             # 搜索功能
├── subscription/       # 订阅管理
├── msg_feed_top/       # 消息提要
├── fav/                # 收藏夹
├── download/           # 下载管理
├── whis/               # 私聊功能
└── ...                 # 其他页面
```

## WHERE TO LOOK
| Task | Location | Notes |
|------|----------|-------|
| 视频播放页面 | `pages/video/view.dart` | 主视频播放界面 |
| 设置页面 | `pages/setting/view.dart` | 应用设置界面 |
| 动态页面 | `pages/dynamics/view.dart` | 时间线/动态流 |
| 搜索页面 | `pages/search/view.dart` | 搜索功能入口 |
| 收藏夹 | `pages/fav/view.dart` | 收藏管理界面 |
| 稍后再看 | `pages/later/view.dart` | 延迟观看列表 |
| 推荐页面 | `pages/rcmd/view.dart` | 首页推荐流 |
| 会员相关 | `pages/member_home/` | 会员首页和视频 |
| 私聊功能 | `pages/whisper/` | 私聊/会话功能 |

## CONVENTIONS
- **页面结构**: 大多数页面使用 StatefulWidget 或 GetX 控制器模式
- **导航**: 通过 GetX 命名路由进行页面跳转
- **状态管理**: 页面状态通常通过 GetX controllers 管理
- **布局**: 使用 Scaffold、CustomScrollView、ListView 等常见布局模式
- **错误处理**: 页面通常包含加载状态、错误状态和空状态处理

## ANTI-PATTERNS (THIS MODULE)
1. **页面过于庞大**: 某些页面文件过大（如 dynamics/view.dart），建议拆分为更小的组件
2. **重复代码**: 某些页面之间存在重复的 UI 组件和逻辑
3. **状态管理混合**: 部分页面同时使用 setState 和 GetX，导致状态管理不统一
4. **嵌套过深**: 某些页面布局嵌套层级过深，影响性能
5. **TODO 分散**: 约 10 处 TODO 分布在 pages/ 下，含未完成的 "dimension" 功能和 "refa" 引用

## UNIQUE STYLES
- **视频页面**: 集成了复杂的手势识别系统（双击、长按、滑动等）
- **动态页面**: 实现了无限滚动和内容预加载机制
- **搜索页面**: 集成了搜索建议、历史记录和热门搜索功能
- **设置页面**: 使用分层结构组织大量设置选项