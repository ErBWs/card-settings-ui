[English](README.md)

## 概述

一个基于 `Card` 的 flutter 设置 UI，受到 [settings_ui](https://pub.dev/packages/settings_ui) 的启发

我不喜欢原生安卓 UI，而且上面提到的这个插件有软件平台判断(没法支持 ohos)，所以我删除了所有平台实现并用 `Card` 进行包裹

> 这是一个纯 dart 库且没有平台判断，因此适配所有平台，包括 ohos

## 安装:

1. 在 `pubspec.yaml` 文件中添加依赖

```yaml
dependencies:  
  card_settings_ui: ^1.0.0
 ```  

2. 导入 `card_settings_ui`

```dart
import 'package:card_settings_ui/card_settings_ui.dart';
```

## 使用方法:

用法与 [settings_ui](https://pub.dev/packages/settings_ui) 基本一致

```dart
SettingsList(
  sections: [
    SettingsSection(
      title: Text('Common'),
      tiles: <SettingsTile>[
        SettingsTile.navigation(
          leading: Icon(Icons.language),
          title: Text('Language'),
          value: Text('English'),
        ),
        SettingsTile.switchTile(
          onToggle: (value) {},
          initialValue: true,
          leading: Icon(Icons.format_paint),
          title: Text('Enable custom theme'),
        ),
      ],
    ),
  ],
),
```