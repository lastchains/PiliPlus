# PILIPLUS PROJECT KNOWLEDGE BASE

**Generated:** 2026-05-15
**Commit:** Unknown
**Branch:** main

## OVERVIEW
PiliPlus is a Flutter-based third-party Bilibili client supporting Android, iOS, Windows, Linux and macOS platforms with features including video playback, danmaku (bullet comments), live streaming, and user account management.

## STRUCTURE
```
PiliPlus/
├── lib/                  # Main Dart source code
├── assets/               # Static resources (images, fonts, shaders)
├── windows/              # Windows platform-specific code
├── linux/                # Linux platform-specific code
├── macos/                # macOS platform-specific code
├── android/              # Android platform-specific code
├── ios/                  # iOS platform-specific code
└── .fvmrc                # Flutter version manager config (3.41.9)
```

## WHERE TO LOOK
| Task | Location | Notes |
|------|----------|-------|
| Video playback logic | `lib/plugin/pl_player/` | Custom video player plugin |
| Account management | `lib/utils/accounts/` | User authentication and session handling |
| Network requests | `lib/http/` | HTTP API clients (video, danmaku, etc.) |
| gRPC services | `lib/grpc/` | Protobuf-generated gRPC clients |
| UI components | `lib/common/widgets/` | Reusable widgets and custom controls |
| Application routing | `lib/router/` | Page navigation configuration |
| Platform integrations | Platform folders (android/, ios/, etc.) | Native platform-specific implementations |
| Build configuration | `lib/build_config.dart` | Build-time constants and flags |
| Localization | `lib/main.dart` lines 293-297 | Supported locales: zh_CN, en_US |

## CODE MAP
*Skipped - LSP analysis unavailable in this environment*

## CONVENTIONS
- **State Management**: Uses GetX (`package:get/get.dart`) for reactive state management
- **Dependency Injection**: GetX service registration in `lib/main.dart` initState()
- **Navigation**: Named routes via GetX routing system
- **State Persistence**: Hive local database (`package:hive_ce/hive.dart`)
- **Networking**: Dio HTTP client (`package:dio/dio.dart`) with interceptors
- **Localization**: Flutter built-in localization with Chinese/English support
- **Theme**: Custom theme defined in `lib/common/style.dart`

## ANTI-PATTERNS (THIS PROJECT)
1. **Dual Models Structure**: 
   - `lib/models/` (~90 files) - Legacy models
   - `lib/models_new/` (~100+ files) - New models
   - **Issue**: Should consolidate into single models directory with versioning if needed

2. **Improper File Placement**:
   - `lib/build_config.dart` - Build config shouldn't be in lib root
   - `lib/utils/accounts/` - Account services belong in services/, not utils/
   - `lib/tcp/` - Single-file directory over-design
   - `lib/utils/extensions/` - Extension methods better in lib/extensions/

3. **Generated Code Warnings**:
   - Files in `lib/models/*.g.dart` contain "DO NOT MODIFY BY HAND" comments
   - These are automatically generated from JSON definitions

4. **Feature Restrictions**:
   - Certain danmaku types (reverse, code) are disabled per `lib/http/danmaku.dart`
   - Network features limited for social dependency reduction per extra_settings.dart

## UNIQUE STYLES
- **Platform Detection**: Uses `PlatformUtils.isMobile/PlatformUtils.isDesktop` helpers
- **Danmaku System**: Custom canvas-based danmaku rendering via canvas_danmaku package
- **Live Player**: Custom MPV-based video player with shader support
- **Gesture Handling**: Complex multi-gesture system in `lib/plugin/pl_player/view/view.dart`
- **Build Flavors**: Different configurations via build_config.dart flags

## COMMANDS
```bash
# Get Flutter version
flutter --version

# Run lint analysis
flutter analyze

# Get packages
flutter pub get

# Run app on device
flutter run

# Build release APK
flutter build apk --release

# Build iOS app
flutter build ios --release

# Build Windows exe
flutter build windows --release

# Generate localization
flutter gen-l10n

# Run unit tests
flutter test

# Watch files for changes
flutter watch
```

## NOTES
1. **gRPC Code**: Files in `lib/grpc/bilibili/` are protobuf-generated - do not modify manually
2. **Model Duplication**: The models_new/ directory appears to be a migration in progress
3. **Locale Settings**: API requests use hardcoded 'zh_CN' for c_locale/s_locale parameters
4. **Screen Orientation**: Handles both portrait and landscape with custom rotation logic
5. **Picture-in-Picture**: Supports PiP mode on Android and desktop platforms
6. **Background Play**: Configurable background audio playback (Pref.continuePlayInBackground)
7. **Danmaku Features**: Supports sending, filtering, and various danmaku interaction modes
8. **Video Caching**: Supports offline video download and caching
9. **Shader Support**: Custom MPV shaders for video enhancement (anime4k, etc.)
10. **Live Streaming**: Special handling for live streams (different latency, danmaku, etc.)