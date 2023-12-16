[![pub package](https://img.shields.io/pub/v/flutter_wrap_content.svg)](https://pub.dev/packages/flutter_wrap_content)

# flutter_wrap_content

Flutter 实现 Android 中的 wrap_content 效果.

![screenshot](png/png.png)

## Installation

安装最新版本. [from pub](https://pub.dev/packages/flutter_wrap_content/install).

## Quick Start

导入对应的包, 使用 `wrapContent` 扩展方法包裹需要实现 `wrap_content` 效果的组件即可.

```dart
Widget(...).wrapContent();
```

支持的属性:

```dart
AlignmentDirectional alignment;
double? minWidth;
double? minHeight;
```