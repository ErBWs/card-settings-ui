import 'package:flutter/material.dart';
import 'package:card_settings_ui/section/abstract_settings_section.dart';

class SettingsList extends StatelessWidget {
  const SettingsList({
    required this.sections,
    this.shrinkWrap = false,
    this.maxWidth,
    this.physics,
    this.contentPadding,
    super.key,
  });

  final bool shrinkWrap;
  final double? maxWidth;
  final ScrollPhysics? physics;
  final EdgeInsetsGeometry? contentPadding;
  final List<AbstractSettingsSection> sections;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: physics,
      shrinkWrap: true,
      itemCount: sections.length,
      padding: contentPadding ?? const EdgeInsets.symmetric(vertical: 20),
      itemBuilder: (BuildContext context, int index) {
        return Align(
          alignment: Alignment.center,
          child: Container(
            constraints: BoxConstraints(maxWidth: maxWidth ?? double.infinity),
            child: sections[index],
          ),
        );
      },
    );
  }
}
