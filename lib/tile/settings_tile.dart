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

  /// The widget displayed by the left of navigation icon
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

  @override
  Widget build(BuildContext context) {
    final settingsTileInfo = SettingsTileInfo.of(context);

    return InkWell(
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
      borderRadius: BorderRadius.vertical(
        top: settingsTileInfo.isTopTile
            ? const Radius.circular(12)
            : Radius.zero,
        bottom: settingsTileInfo.isBottomTile
            ? const Radius.circular(12)
            : Radius.zero,
      ),
      child: buildTileContent(context, settingsTileInfo),
    );
  }

  Widget buildLeading(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(end: 12.0),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DefaultTextStyle(
          style: TextStyle(
              color: enabled
                  ? Theme.of(context).colorScheme.onSurface
                  : Theme.of(context).disabledColor,
              fontSize: 16),
          child: title,
        ),
        if (description != null)
          DefaultTextStyle(
            style: TextStyle(
              color: Theme.of(context).disabledColor,
              fontSize: 13,
            ),
            child: description!,
          ),
      ],
    );
  }

  Widget buildTrailing(BuildContext context) {
    return Row(
      children: [
        if (trailing != null)
          Padding(
            padding: const EdgeInsetsDirectional.only(end: 4),
            child: trailing!,
          ),
        if (tileType == SettingsTileType.switchTile)
          Transform.scale(
            scale: 0.8,
            child: Switch(
              value: initialValue ?? true,
              onChanged: (enabled) ? onToggle : null,
            ),
          ),
        if (tileType == SettingsTileType.checkboxTile)
          Checkbox(
            tristate: true,
            value: initialValue,
            onChanged: (enabled) ? onToggle : null,
          ),
        if (tileType == SettingsTileType.radioTile)
          Radio<T>(
            value: radioValue,
            groupValue: groupValue,
            onChanged: (enabled) ? onChanged : null,
          ),
        if (value != null)
          DefaultTextStyle(
            style: TextStyle(
              color: enabled
                  ? Theme.of(context).hintColor
                  : Theme.of(context).disabledColor,
              fontSize: 15,
            ),
            child: value!,
          ),
        if (tileType == SettingsTileType.navigationTile)
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 2, end: 2),
            child: Icon(
              Icons.keyboard_arrow_right,
              color: enabled
                  ? Theme.of(context).colorScheme.onSurface
                  : Theme.of(context).disabledColor,
            ),
          ),
      ],
    );
  }

  Widget buildTileContent(
      BuildContext context, SettingsTileInfo settingsTileInfo) {
    return Container(
      padding: const EdgeInsetsDirectional.only(start: 13),
      child: Row(
        children: [
          if (leading != null) buildLeading(context),
          Expanded(
            child: Padding(
              padding: const EdgeInsetsDirectional.only(end: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsetsDirectional.only(
                            top: 13,
                            bottom: 13,
                          ),
                          child: buildTitle(context),
                        ),
                      ),
                      buildTrailing(context),
                    ],
                  ),
                  if (settingsTileInfo.needDivider)
                    const Divider(height: 0, endIndent: 7),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
