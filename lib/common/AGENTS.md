# COMMON MODULE

## OVERVIEW
共享组件层，包含可复用 UI 控件、骨架屏、主题样式和全局常量。125 个文件，22 个子目录。

## STRUCTURE
```
common/
├── widgets/           # 通用 UI 组件 (33+ widgets)
│   ├── flutter/       # Flutter 框架补丁（修改上游源码）
│   ├── gesture/       # 手势交互组件
│   ├── image/         # 图片组件
│   ├── image_viewer/  # 图片查看器
│   ├── video_card/    # 视频卡片
│   ├── appbar/        # 自定义 AppBar
│   ├── button/        # 按钮组件
│   ├── dialog/        # 对话框
│   ├── loading_widget/# 加载指示器
│   └── ...            # 其他组件
├── skeleton/          # 骨架屏（加载占位）
├── style.dart         # 主题与样式常量
├── constants.dart     # 全局常量
└── assets.dart        # 资源管理
```

## WHERE TO LOOK
| 任务 | 位置 |
|------|------|
| 主题颜色 | `style.dart` |
| 全局常量 | `constants.dart` |
| 手势交互 | `widgets/gesture/` |
| 图片查看 | `widgets/image_viewer/` |
| 弹窗组件 | `widgets/dialog/` |
| 加载占位 | `skeleton/` |
| 视频卡片 | `widgets/video_card/` |
| Flutter 补丁 | `widgets/flutter/` |

## CONVENTIONS
- **组件命名**: 同一 Widget 类型放同一子目录，每个子目录含独立 Widget 类
- **主题使用**: 优先使用 `Theme.of(context)` 和 `style.dart` 中的颜色变量
- **骨架屏**: 使用 `skeleton/` 中的 `Skeleton` 组件实现加载状态
- **Flutter 补丁**: `widgets/flutter/` 内文件是上游 Flutter 源码的拷贝/修改版，含 `ignore_for_file` 注释
- **导入方式**: 使用 `package:PiliPlus/common/...` 包导入

## ANTI-PATTERNS
1. **Flutter 源码拷贝**: `widgets/flutter/` 含 Flutter 框架文件的修改版，版本更新后需同步
2. **lint 忽略多**: `widgets/flutter/` 内大量 `ignore_for_file`，因代码来自上游
3. **部分组件未用常量**: 少数组件硬编码颜色/尺寸，应使用 `style.dart`

## NOTES
1. `widgets/flutter/` 内代码从上游 Flutter SDK 拷贝并修改，建议加注释标注修改点
2. 骨架屏组件通过 `skeleton/` 提供统一加载态，新页面优先使用
3. 手势组件 `widgets/gesture/` 包含自定义鼠标/触控手势处理
