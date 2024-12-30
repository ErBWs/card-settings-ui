import 'package:flutter/material.dart';
import 'package:card_settings_ui/tile/settings_tile_info.dart';
import 'package:card_settings_ui/tile/abstract_settings_tile.dart';

class CustomSettingsTile extends AbstractSettingsTile {
  const CustomSettingsTile({
    required this.child,
    super.key,
  });

  final Widget Function(SettingsTileInfo info) child;

  @override
  State<StatefulWidget> createState() => _CustomSettingsTileState();
}

class _CustomSettingsTileState extends State<CustomSettingsTile> {
  @override
  Widget build(BuildContext context) {
    final settingsTileInfo = SettingsTileInfo.of(context);
    return widget.child(settingsTileInfo);
  }
}
