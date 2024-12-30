import 'package:flutter/material.dart';

class SettingsTileInfo extends InheritedWidget {
  const SettingsTileInfo({
    super.key,
    required this.needDivider,
    required this.isTopTile,
    required this.isBottomTile,
    required super.child,
  });

  final bool needDivider;
  final bool isTopTile;
  final bool isBottomTile;

  @override
  bool updateShouldNotify(SettingsTileInfo oldWidget) => true;

  static SettingsTileInfo of(BuildContext context) {
    final SettingsTileInfo? result =
        context.dependOnInheritedWidgetOfExactType<SettingsTileInfo>();
    // assert(result != null, 'No IOSSettingsTileAdditionalInfo found in context');
    return result ??
        const SettingsTileInfo(
          needDivider: true,
          isBottomTile: true,
          isTopTile: true,
          child: SizedBox(),
        );
  }
}
