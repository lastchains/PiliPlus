# PLUGIN MODULE

## OVERVIEW
自定义 MPV 视频播放器，基于 `media-kit` 封装。27 个文件，5 个子目录。

## STRUCTURE
```
plugin/pl_player/
├── models/            # 播放器数据模型 (15 files)
├── view/              # 播放器视图与手势系统
├── widgets/           # 播放器控件 (7 files)
├── utils/             # 播放器工具 (2 files)
└── pl_player.dart     # 播放器主入口
```

## WHERE TO LOOK
| 任务 | 位置 |
|------|------|
| 播放器初始化 | `pl_player.dart` |
| 手势控制 | `view/view.dart`（双击快进、垂直调节、水平进度） |
| 播放器模型 | `models/`（状态、配置、事件） |
| 全屏控制 | `utils/fullscreen.dart` |
| 控件组件 | `widgets/`（进度条、控制栏等） |

## CONVENTIONS
- **平台适配**: 通过 `PlatformUtils` 判断移动端/桌面端，不同平台使用不同手势配置
- **手势分层**: 垂直滑动（亮度/音量）和水平滑动（进度）使用不同手势识别器
- **MPV API**: 通过 `media-kit` 的 `NativePlayer` 调用 MPV 原生 API
- **Shader**: 支持 `anime4k` 等视频增强 shader，通过 MPV 的 `glsl-shaders` 属性加载

## ANTI-PATTERNS
1. **TODO 遗留**: `view/view.dart:541` 有未完成的 TODO，涉及播放器特定行为
2. **手势冲突风险**: 多手势识别器并存（双击、长按、滑动），手势优先级处理复杂
3. **全屏逻辑分散**: 全屏/退出全屏逻辑分布在 `view.dart` 和 `utils/fullscreen.dart` 两处

## NOTES
1. MPV API 版本通过 `NativePlayer.apiVersion` 获取，格式为 `{major}.{minor}`
2. 播放器支持多种视频比例模式：适应、填充、包含等
3. 桌面端和移动端共享同一播放器核心，UI 适配层分离
