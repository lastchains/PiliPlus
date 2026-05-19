# UTILS MODULE

## OVERVIEW
工具函数和辅助类集合。68 个文件，3 个子目录。包含路径处理、平台检测、存储、主题、网络、账号等独立工具。

## STRUCTURE
```
utils/
├── accounts/              # 账号管理 (7 files)
│   └── account_manager/   # 多账号切换管理器
├── extension/             # Dart 扩展方法 (15 files)
├── *.dart                 # 独立工具函数 (48 files)
│   ├── storage.dart       # Hive 存储封装
│   ├── storage_key.dart   # 存储键定义
│   ├── storage_pref.dart  # 偏好设置读写
│   ├── platform_utils.dart# 平台检测
│   ├── theme_utils.dart   # 主题工具
│   ├── date_utils.dart    # 日期格式化
│   ├── request_utils.dart # 请求工具
│   ├── path_utils.dart    # 路径工具
│   └── ...                # 其他工具
```

## WHERE TO LOOK
| 任务 | 位置 |
|------|------|
| 用户认证 | `accounts/` |
| 多账号管理 | `accounts/account_manager/` |
| 本地存储 | `storage*.dart` |
| 偏好设置 | `storage_pref.dart` |
| 平台检测 | `platform_utils.dart` |
| 主题颜色 | `theme_utils.dart` |
| 日期处理 | `date_utils.dart` |
| 扩展方法 | `extension/` |
| 路径处理 | `path_utils.dart` |
| 网络签名 | `wbi_sign.dart`, `app_sign.dart` |
| 缓存管理 | `cache_manager.dart` |

## CONVENTIONS
- **独立函数**: 每个 `.dart` 文件导出一个或多个顶层函数或工具类
- **存储封装**: 通过 `GStorage`（Hive 封装）统一读写，不直接操作 Hive Box
- **平台检测**: 优先使用 `PlatformUtils` 的 `isMobile/isDesktop/isWindows` 等方法
- **扩展方法**: 放在 `extension/` 目录下，文件名为 `*_ext.dart`

## ANTI-PATTERNS
1. **账号管理位置不当**: `accounts/` 包含业务逻辑应移至 `lib/services/`
2. **扩展方法位置**: `extension/` 应为 `lib/extensions/`（项目根更常见）
3. **TODO 残留**: `accounts/api_type.dart:5` 有 `TODO: grpc api type`；`extension/three_dot_ext.dart:89` 有调试代码 TODO
4. **deprecated API**: `theme_utils.dart` 使用 2 处已废弃 API

## NOTES
1. 存储键分为 `SettingBoxKey` 和其他 Box 键，定义在 `storage_key.dart`
2. `storage_pref.dart` 提供类型安全的偏好读写（`Pref.xxx` 静态访问模式）
3. `request_utils.dart` 处理请求签名、Cookie 同步等网络层逻辑
4. `wbi_sign.dart` 和 `app_sign.dart` 实现 Bilibili 的 WBI 签名和 APP 签名算法
