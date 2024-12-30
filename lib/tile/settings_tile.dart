import 'package:flutter/material.dart';
import 'package:card_settings_ui/tile/abstract_settings_tile.dart';
import 'package:card_settings_ui/tile/settings_tile_info.dart';

enum SettingsTileType { simpleTile, switchTile, navigationTile }

class SettingsTile extends AbstractSettingsTile {
  SettingsTile({
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
    initialValue = null;
    activeSwitchColor = null;
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
    initialValue = null;
    activeSwitchColor = null;
    tileType = SettingsTileType.navigationTile;
  }

  SettingsTile.switchTile({
    required this.initialValue,
    required this.onToggle,
    this.activeSwitchColor,
    this.leading,
    this.trailing,
    required this.title,
    this.description,
    this.onPressed,
    this.enabled = true,
    super.key,
  }) {
    value = null;
    tileType = SettingsTileType.switchTile;
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
  final Function(BuildContext)? onPressed;

  late final Color? activeSwitchColor;
  late final Widget? value;
  late final Function(bool?)? onToggle;
  late final SettingsTileType tileType;
  late final bool? initialValue;
  late final bool enabled;

  @override
  State<StatefulWidget> createState() => _SettingsTileState();
}

class _SettingsTileState extends State<SettingsTile> {
  @override
  Widget build(BuildContext context) {
    final settingsTileInfo = SettingsTileInfo.of(context);

    return InkWell(
      onTap: (widget.enabled)
          ? () {
              if (widget.onPressed != null) {
                widget.onPressed!.call(context);
              }
              if (widget.onToggle != null) {
                widget.onToggle!.call(null);
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
          color: widget.enabled
              ? Theme.of(context).colorScheme.onSurface
              : Theme.of(context).disabledColor,
        ),
        child: widget.leading!,
      ),
    );
  }

  Widget buildTitle(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DefaultTextStyle(
          style: TextStyle(
              color: widget.enabled
                  ? Theme.of(context).colorScheme.onSurface
                  : Theme.of(context).disabledColor,
              fontSize: 16),
          child: widget.title,
        ),
        if (widget.description != null)
          DefaultTextStyle(
            style: TextStyle(
              color: Theme.of(context).disabledColor,
              fontSize: 13,
            ),
            child: widget.description!,
          ),
      ],
    );
  }

  Widget buildTrailing(BuildContext context) {
    return Row(
      children: [
        if (widget.trailing != null) widget.trailing!,
        if (widget.tileType == SettingsTileType.switchTile)
          Transform.scale(
            scale: 0.8,
            child: Switch(
              value: widget.initialValue ?? true,
              onChanged: (widget.enabled) ? widget.onToggle : null,
            ),
          ),
        if (widget.tileType == SettingsTileType.navigationTile &&
            widget.value != null)
          DefaultTextStyle(
            style: TextStyle(
              color: widget.enabled
                  ? Theme.of(context).colorScheme.onSurface
                  : Theme.of(context).disabledColor,
              fontSize: 16,
            ),
            child: widget.value!,
          ),
        if (widget.tileType == SettingsTileType.navigationTile)
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 6, end: 2),
            child: Icon(
              Icons.keyboard_arrow_right,
              color: widget.enabled
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
      padding: EdgeInsetsDirectional.only(start: 13),
      child: Row(
        children: [
          if (widget.leading != null) buildLeading(context),
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
                  if (settingsTileInfo.needDivider) const Divider(height: 0, endIndent: 7),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
