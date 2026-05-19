# PILIPLUS PROJECT KNOWLEDGE BASE

**Generated:** 2026-05-19
**Commit:** f439c5d74
**Branch:** main

## OVERVIEW
PiliPlus 是一款基于 Flutter 的第三方 Bilibili 客户端，支持 Android/iOS/Windows/Linux/macOS 平台，功能涵盖视频播放、弹幕、直播流、用户账户管理和社交互动。

## STRUCTURE
```
PiliPlus/
├── lib/                    # Main Dart source (1257 files, ~390K lines)
│   ├── common/             # 共享组件 (125 files, 22 subdirs)
│   ├── grpc/               # protobuf 生成 gRPC 客户端 (108 files)
│   ├── http/               # HTTP API 客户端 (29 files, flat)
│   ├── models/             # 旧数据模型 (90 files, 19 subdirs)
│   ├── models_new/         # 新数据模型 (363 files, 114 subdirs)
│   ├── pages/              # UI 页面 (440 files, 232 subdirs)
│   ├── plugin/             # 自定义 MPV 视频播放器 (27 files)
│   ├── router/             # GetX 命名路由配置
│   ├── services/           # 业务服务层 (8 files)
│   ├── tcp/                # 直播 TCP 通信
│   └── utils/              # 工具函数 (68 files, 3 subdirs)
├── assets/                 # 静态资源 (images, fonts, shaders)
├── windows/                # Windows 平台实现
├── linux/                  # Linux 平台实现
├── macos/                  # macOS 平台实现
├── android/                # Android 平台实现
├── ios/                    # iOS 平台实现
└── .fvmrc                 # Flutter 版本管理 (3.41.9)
```

## WHERE TO LOOK
| 任务 | 位置 | 说明 |
|------|------|------|
| 视频播放逻辑 | `lib/plugin/pl_player/` | 自定义 MPV 视频播放器 |
| 视频手势/视图 | `lib/plugin/pl_player/view/` | 双击、长按、滑动等手势系统 |
| 账户管理 | `lib/utils/accounts/` | 用户认证与会话管理 |
| HTTP API 客户端 | `lib/http/` | Bilibili REST API (Dio) |
| gRPC 服务 | `lib/grpc/` | protobuf 生成，禁止手动修改 |
| UI 共享组件 | `lib/common/widgets/` | 可复用组件和自定义控件 |
| 应用路由 | `lib/router/app_pages.dart` | 60+ 命名路由配置 |
| 状态管理 | 各页面的 `controller.dart` | GetX Controller 模式 |
| 持久化存储 | `lib/utils/storage*.dart` | Hive CE 本地数据库 |
| 构建配置 | `lib/build_config.dart` | 构建时常量和标志 |
| 本地化 | `lib/main.dart:295-297` | zh_CN, en_US |
| 主题系统 | `lib/common/style.dart` | 动态颜色 + 自定义配色方案 |
| 服务初始化 | `lib/services/service_locator.dart` | 音频服务初始化 |
| 异常捕获 | `lib/main.dart:203-234` | Catcher2 错误报告 |
| Flutter 补丁 | `lib/scripts/*.patch` | 修复 Flutter 框架 bug |
| 构建脚本 | `lib/scripts/build.ps1` | 版本号计算与发布配置 |

## CODE MAP
*LSP analysis unavailable - 无 LSP 环境*

## CONVENTIONS
- **状态管理**: GetX（`package:get/get.dart`）- `Get.put()`/`Get.find()`/`Get.lazyPut()`
- **页面结构**: 每个功能目录含 `view.dart` + `controller.dart`
- **依赖注入**: `main.dart` 中 `Get.lazyPut(Service.new)` 注册服务
- **导航**: GetX 命名路由（`Get.toNamed()`），`lib/router/app_pages.dart` 定义
- **持久化**: Hive CE（`package:hive_ce/hive.dart`）本地数据库
- **网络**: Dio HTTP 客户端 + HTTP/2 适配器
- **本地化**: Flutter 内置，中文（默认）+ 英文，API 硬编码 'zh_CN'
- **主题**: 动态颜色（`dynamic_color`）+ Material 3 + Material Color Utilities v0.7
- **Linter**: `flutter_lints` + 42 条自定义规则，排除 `lib/grpc/bilibili/**`
- **命名**: 文件名 snake_case，类名 PascalCase，控制器 `*Controller`，页面 `*Page`
- **构建参数**: `dart-define-from-file=pili_release.json` 传递构建时配置
- **屏幕适配**: `ScaledWidgetsFlutterBinding` 实现 UI 缩放

## ANTI-PATTERNS (THIS PROJECT)
1. **双模型结构**: `lib/models/` (90 files) + `lib/models_new/` (363 files) 并存，应合并
2. **零测试覆盖**: 项目无 `test/` 目录，没有任何单元/widget/集成测试
3. **13 处 TODO**: 分布在关键文件中，含调试代码 (`three_dot_ext.dart`)
4. **11 处 deprecated API 使用**: `ignore: deprecated_member_use` 散落各处
5. **文件位置不合理**:
   - `lib/build_config.dart` 应在 `lib/config/`
   - `lib/utils/accounts/` 应移至 `lib/services/`
   - `lib/tcp/` 单文件目录过度设计
   - `lib/utils/extensions/` 应为 `lib/extensions/`
6. **Flutter 框架补丁系统**: `lib/scripts/*.patch` 修补上游源码，影响可维护性
7. **功能限制**: 部分弹幕类型（reverse, code）被禁用；部分网络社交功能受限
8. **生成文件警告**: `*.g.dart` / `*.pb.dart` / `*.pbjson.dart` 禁止手动修改

## UNIQUE STYLES
- **平台检测**: `PlatformUtils.isMobile/isDesktop/isWindows` 等统一助手
- **弹幕系统**: 基于 `canvas_danmaku` 的自定义 Canvas 渲染弹幕
- **视频播放器**: 基于 `media-kit` 的 MPV 播放器，支持 shader（anime4k 等）
- **手势系统**: 复杂多手势识别（双击快进/暂停、垂直亮度/音量、水平进度）
- **构建风味**: 通过 `build_config.dart` 和 `dart-define-from-file` 多环境配置
- **上游同步**: GitHub Actions 自动同步上游 fork，冲突自动创建 Issue
- **包管理**: 大量使用 git 依赖（自定义 fork）而非 pub.dev 版本

## COMMANDS
```bash
# Flutter 版本
flutter --version                   # 3.41.9 (see .fvmrc)

# 依赖管理
flutter pub get                     # 获取依赖
flutter pub outdated                # 检查依赖更新

# 代码分析
flutter analyze                     # 静态分析（排除 grpc/）

# 生成本地化
flutter gen-l10n                    # 生成 ARB 翻译文件

# Android 发布构建
flutter build apk --release --split-per-abi --dart-define-from-file=pili_release.json --pub

# iOS 发布构建
flutter build ios --release --no-codesign --dart-define-from-file=pili_release.json

# macOS 发布构建
flutter build macos --release --dart-define-from-file=pili_release.json

# Linux 发布构建
flutter build linux --release -v --pub --dart-define-from-file=pili_release.json

# Windows 发布构建（需 fastforge）
fastforge package --platform windows --targets exe `
  --flutter-build-args="dart-define-from-file=pili_release.json"

# 自定义构建脚本
pwsh lib/scripts/build.ps1 android -Suffix "-短哈希" -VersionSuffix "-special-v{N}"

# 应用 Flutter 补丁
pwsh lib/scripts/patch.ps1 android  # 可选: ios/linux/macos/windows

# 运行（无测试可用）
flutter run                          # 启动调试
# flutter test                      # 无测试文件，命令不可用
```

## NOTES
1. **gRPC 生成代码**: `lib/grpc/bilibili/` 所有 `*.pb.dart` 均为 protobuf 自动生成，禁止手动修改
2. **模型迁移中**: `models_new/` 是 `models/` 的替代，两者目前并存，迁移尚未完成
3. **零测试**: 项目完全没有测试基础设施，需要从零建立测试体系
4. **Flutter 补丁**: `lib/scripts/*.patch` 来自上游，修复 tooltip/overscroll/navigator 等框架问题
5. **版本号策略**: `build.ps1` 基于 git commit count 生成 `{version}+{commitCount}` 格式版本
6. **多语言**: API 请求硬编码 'zh_CN'，本地化仅支持 zh_CN + en_US
7. **屏幕方向**: 支持横竖屏切换，含自定义旋转逻辑
8. **PiP 画中画**: 支持 Android 和桌面端 PiP 模式
9. **后台播放**: 可配置后台音频播放 (`Pref.continuePlayInBackground`)
10. **视频缓存**: 支持离线下载和缓存播放
11. **Shader 支持**: 自定义 MPV shader（anime4k 等视频增强滤镜）
12. **直播处理**: 直播流的特殊处理（低延迟、特殊弹幕、SuperChat）