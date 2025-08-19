import 'dart:io';
import 'package:flutter/material.dart';
import 'package:card_settings_ui/tile/abstract_settings_tile.dart';
import 'package:card_settings_ui/tile/settings_tile_info.dart';

enum SettingsTileType {
  simpleTile,
  switchTile,
  navigationTile,
  checkboxTile,
  radioTile,
}

class SettingsTile<T> extends AbstractSettingsTile {
  SettingsTile({
    this.leading,
    this.trailing,
    required this.title,
    this.description,
    this.onPressed,
    this.enabled = true,
    super.key,
  }) {
    onToggle = null;
    onChanged = null;
    initialValue = null;
    value = null;
    tileType = SettingsTileType.simpleTile;
  }

  SettingsTile.navigation({
    this.leading,
    this.trailing,
    this.value,
    required this.title,
    this.description,
    this.onPressed,
    this.enabled = true,
    super.key,
  }) {
    onToggle = null;
    onChanged = null;
    initialValue = null;
    tileType = SettingsTileType.navigationTile;
  }

  SettingsTile.switchTile({
    required this.initialValue,
    required this.onToggle,
    this.leading,
    this.trailing,
    required this.title,
    this.description,
    this.enabled = true,
    super.key,
  }) {
    onPressed = null;
    onChanged = null;
    value = null;
    tileType = SettingsTileType.switchTile;
  }

  SettingsTile.checkboxTile({
    required this.initialValue,
    required this.onToggle,
    this.leading,
    this.trailing,
    required this.title,
    this.description,
    this.enabled = true,
    super.key,
  }) {
    onPressed = null;
    onChanged = null;
    value = null;
    tileType = SettingsTileType.checkboxTile;
  }

  SettingsTile.radioTile({
    required this.radioValue,
    required this.groupValue,
    required this.onChanged,
    this.leading,
    this.trailing,
    required this.title,
    this.description,
    this.enabled = true,
    super.key,
  }) {
    onPressed = null;
    onToggle = null;
    value = null;
    tileType = SettingsTileType.radioTile;
  }

  /// The widget at the beginning of the tile
  final Widget? leading;

  /// The Widget at the end of the tile
  final Widget? trailing;

  /// The widget at the center of the tile
  final Widget title;

  /// The widget at the bottom of the [title]
  final Widget? description;

  /// A function that is called by tap on a tile
  late final Function(BuildContext)? onPressed;

  /// A function that is called by tap on a switch or checkbox
  /// !! Caution: bool value could be null, you may have to add null check
  late final Function(bool?)? onToggle;

  /// A function that is called by tap on a radio button
  late final Function(T?)? onChanged;

  /// The text displayed at the end of the tile
  late final Widget? value;

  /// The bool value used by switch
  late final bool? initialValue;

  /// The bool value used by switch
  late final T radioValue;

  /// The bool value used by switch
  late final T? groupValue;

  /// Whether this tile is clickable
  late final bool enabled;

  late final SettingsTileType tileType;

  final bool isDesktop =
      Platform.isMacOS || Platform.isLinux || Platform.isWindows;

  static const WidgetStateProperty<Icon> thumbIcon =
      WidgetStateProperty<Icon>.fromMap(
    <WidgetStatesConstraint, Icon>{
      WidgetState.selected: Icon(Icons.check_rounded),
      WidgetState.any: Icon(Icons.close_rounded),
    },
  );

  @override
  Widget build(BuildContext context) {
    final settingsTileInfo = SettingsTileInfo.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(settingsTileInfo.isTopTile ? 20 : 3),
            bottom: Radius.circular(settingsTileInfo.isBottomTile ? 20 : 3),
          ),
          child: buildTileContent(context),
        ),
        if (settingsTileInfo.needDivider) SizedBox(height: isDesktop ? 2 : 1.8),
      ],
    );
  }

  Widget buildLeading(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: IconTheme.merge(
        data: IconThemeData(
          color: enabled
              ? Theme.of(context).colorScheme.onSurface
              : Theme.of(context).disabledColor,
        ),
        child: leading!,
      ),
    );
  }

  Widget buildTitle(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.symmetric(
        vertical: description != null ? 17 : 24,
        horizontal: 16,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DefaultTextStyle(
            style: TextStyle(
              color: enabled
                  ? Theme.of(context).colorScheme.onSurface
                  : Theme.of(context).disabledColor,
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
            child: title,
          ),
          if (description != null) ...[
            const SizedBox(height: 2),
            DefaultTextStyle(
              style: TextStyle(
                color: enabled
                    ? Theme.of(context).hintColor
                    : Theme.of(context).disabledColor,
                fontWeight: FontWeight.w500,
                fontSize: 13,
              ),
              child: description!,
            ),
          ],
        ],
      ),
    );
  }

  Widget buildTrailing(BuildContext context) {
    return Row(
      children: [
        if (trailing != null)
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: trailing!,
          ),
        if (tileType == SettingsTileType.switchTile)
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Transform.scale(
              scale: 0.85,
              child: Switch(
                thumbIcon: thumbIcon,
                value: initialValue ?? true,
                onChanged: (enabled) ? onToggle : null,
              ),
            ),
          ),
        if (tileType == SettingsTileType.checkboxTile)
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Checkbox(
              tristate: true,
              value: initialValue,
              onChanged: (enabled) ? onToggle : null,
            ),
          ),
        if (tileType == SettingsTileType.radioTile)
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Radio<T>(
              value: radioValue,
              groupValue: groupValue,
              onChanged: (enabled) ? onChanged : null,
            ),
          ),
        if (value != null)
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: DefaultTextStyle(
              style: TextStyle(
                color: enabled
                    ? Theme.of(context).hintColor
                    : Theme.of(context).disabledColor,
                fontWeight: FontWeight.w500,
                fontSize: 13,
              ),
              child: value!,
            ),
          ),
      ],
    );
  }

  Widget buildTileContent(BuildContext context) {
    // You need to wrap Ink widgets with Material to clip it properly.
    return Material(
      color: Theme.of(context).brightness == Brightness.light
          ? Theme.of(context).colorScheme.surfaceContainerLowest
          : Theme.of(context).colorScheme.surfaceContainerHigh,
      child: InkWell(
        onTap: (enabled)
            ? () {
                if (onPressed != null) {
                  onPressed!.call(context);
                }
                if (onToggle != null) {
                  onToggle!.call(null);
                }
                if (onChanged != null) {
                  onChanged!.call(radioValue);
                }
              }
            : () {},
        mouseCursor: SystemMouseCursors.click,
        child: Row(
          children: [
            if (leading != null) buildLeading(context),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Expanded(child: buildTitle(context)),
                      buildTrailing(context),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
