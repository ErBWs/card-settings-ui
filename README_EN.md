[中文](README.md)

## Overview

A `card` based settings ui for flutter. Inspired by [settings_ui](https://pub.dev/packages/settings_ui)

> This is a pure dart package, so it supports all platforms, including ohos.

## Installing:

1. Add the dependency in your `pubspec.yaml` file.

```yaml
dependencies:
  card_settings_ui: ^1.0.0
 ```  

2. Import the `card_settings_ui` package.

```dart
import 'package:card_settings_ui/card_settings_ui.dart';
```

## Basic Usage:

The usage is almost the same as [settings_ui](https://pub.dev/packages/settings_ui)

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