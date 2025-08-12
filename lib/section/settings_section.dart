import 'package:flutter/material.dart';
import 'package:card_settings_ui/tile/abstract_settings_tile.dart';
import 'package:card_settings_ui/tile/settings_tile_info.dart';
import 'package:card_settings_ui/section/abstract_settings_section.dart';

class SettingsSection extends AbstractSettingsSection {
  const SettingsSection({
    required this.tiles,
    this.margin,
    this.title,
    this.bottomInfo,
    super.key,
  });

  final List<AbstractSettingsTile> tiles;
  final EdgeInsetsDirectional? margin;
  final Widget? title;
  final Widget? bottomInfo;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null)
            Padding(
              padding: const EdgeInsetsDirectional.only(
                start: 8,
                end: 8,
                bottom: 8,
              ),
              child: DefaultTextStyle(
                style: TextStyle(
                  fontSize: 15,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
                child: title!,
              ),
            ),
          tileList,
          if (bottomInfo != null)
            Padding(
              padding: const EdgeInsetsDirectional.only(
                start: 8,
                end: 8,
                top: 8,
              ),
              child: DefaultTextStyle(
                style: TextStyle(
                  fontSize: 15,
                  color: Theme.of(context).hintColor,
                ),
                child: bottomInfo!,
              ),
            ),
        ],
      ),
    );
  }

  Widget get tileList {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: tiles.length,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return SettingsTileInfo(
          isTopTile: index == 0,
          isBottomTile: index == tiles.length - 1,
          needDivider: index != tiles.length - 1,
          child: tiles[index],
        );
      },
    );
  }
}
