import 'package:flutter/material.dart';
import 'package:card_settings_ui/section/abstract_settings_section.dart';

class SettingsList extends StatelessWidget {
  const SettingsList({
    required this.sections,
    this.shrinkWrap = false,
    this.physics,
    this.contentPadding,
    super.key,
  });

  final bool shrinkWrap;
  final ScrollPhysics? physics;
  final EdgeInsetsGeometry? contentPadding;
  final List<AbstractSettingsSection> sections;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      child: LayoutBuilder(
        builder: (context, layout) {
          return ListView.builder(
            physics: physics,
            shrinkWrap: shrinkWrap,
            itemCount: sections.length,
            padding: contentPadding ?? const EdgeInsets.symmetric(vertical: 20),
            itemBuilder: (BuildContext context, int index) {
              return sections[index];
            },
          );
        },
      ),
    );
  }
}
