import 'package:flutter/material.dart';
import 'package:card_settings_ui/card_settings_ui.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blue, brightness: Brightness.light),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blue, brightness: Brightness.dark),
      ),
      debugShowCheckedModeBanner: false,
      home: const SettingsPage(),
    );
  }
}

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isEnabled = true;
  bool? selectAll = false;
  List<bool?> securityItem = [false, false, false];

  void updateSelectAll() {
    if (securityItem.every((item) => item == true)) {
      selectAll = true;
    } else if (securityItem.every((item) => item == false)) {
      selectAll = false;
    } else {
      selectAll = null;
    }
  }

  double size = 10.0;
  String density = densityList[0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Center(
        child: SizedBox(
          width: (MediaQuery.of(context).size.width > 800) ? 800 : null,
          child: SettingsList(
            sections: [
              SettingsSection(
                title: Text('Common'),
                tiles: <SettingsTile>[
                  SettingsTile.navigation(
                    onPressed: (_) =>
                        showToast(context, 'Navigate to history page'),
                    leading: Icon(Icons.history),
                    title: Text('History'),
                  ),
                ],
              ),
              SettingsSection(
                title: Text('Email density'),
                tiles: densityList
                    .map((e) => SettingsTile<String>.radioTile(
                          title: Text(e),
                          radioValue: e,
                          groupValue: density,
                          onChanged: (String? value) {
                            if (value != null) {
                              setState(() {
                                density = value;
                              });
                            }
                          },
                        ))
                    .toList(),
              ),
              SettingsSection(
                title: Text('Security'),
                tiles: <SettingsTile>[
                  SettingsTile.navigation(
                    onPressed: (_) => showToast(
                        context, 'Click checkbox in front to select all'),
                    leading: Checkbox(
                      value: selectAll,
                      onChanged: (_) {
                        if (selectAll == null || selectAll == true) {
                          selectAll = false;
                          securityItem.fillRange(0, securityItem.length, false);
                        } else {
                          selectAll = true;
                          securityItem.fillRange(0, securityItem.length, true);
                        }
                        setState(() {});
                      },
                      tristate: true,
                    ),
                    title: Text('Select all'),
                  ),
                ],
              ),
              SettingsSection(
                tiles: <SettingsTile>[
                  SettingsTile.checkboxTile(
                    onToggle: (value) {
                      securityItem[0] = value ?? !securityItem[0]!;
                      updateSelectAll();
                      setState(() {});
                    },
                    initialValue: securityItem[0],
                    leading: Icon(Icons.dialpad),
                    title: Text('PIN'),
                    description: Text('Allow user log in with PIN'),
                  ),
                  SettingsTile.checkboxTile(
                    onToggle: (value) {
                      securityItem[1] = value ?? !securityItem[1]!;
                      updateSelectAll();
                      setState(() {});
                    },
                    initialValue: securityItem[1],
                    leading: Icon(Icons.password_rounded),
                    title: Text('Password'),
                    description: Text('Allow user log in with password'),
                  ),
                  SettingsTile.checkboxTile(
                    onToggle: (value) {
                      securityItem[2] = value ?? !securityItem[2]!;
                      updateSelectAll();
                      setState(() {});
                    },
                    initialValue: securityItem[2],
                    leading: Icon(Icons.fingerprint),
                    title: Text('Fingerprint'),
                    description: Text('Allow user log in with fingerprint'),
                  ),
                ],
              ),
              SettingsSection(
                title: Text('Subtitle'),
                tiles: <SettingsTile>[
                  SettingsTile.switchTile(
                    onToggle: (value) {
                      isEnabled = value ?? !isEnabled;
                      setState(() {});
                    },
                    initialValue: isEnabled,
                    leading: Icon(Icons.subtitles),
                    title: Text('Enable subtitle'),
                  ),
                  SettingsTile.navigation(
                    onPressed: (_) => subtitleSizeDialog(context),
                    enabled: isEnabled,
                    leading: Icon(Icons.format_size),
                    title: Text('Subtitle size'),
                    value: Text('$size'),
                  ),
                ],
              ),
              SettingsSection(
                bottomInfo: Text('Upload settings to cloud'),
                tiles: <SettingsTile>[
                  SettingsTile(
                    onPressed: (_) => showToast(context, 'Upload successfully'),
                    title: Text('Upload'),
                    trailing: Icon(Icons.cloud_upload_rounded),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future subtitleSizeDialog(BuildContext context) {
    return showDialog(
      builder: (context) {
        return AlertDialog(
          title: const Text('Subtitle font size'),
          content: StatefulBuilder(builder: (BuildContext context, _) {
            return Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final double i in subtitleSize) ...<Widget>[
                  if (i == size) ...<Widget>[
                    FilledButton(
                      onPressed: () async {
                        setState(() {
                          size = i;
                        });
                        Navigator.of(context).pop();
                      },
                      child: Text(i.toString()),
                    ),
                  ] else ...[
                    FilledButton.tonal(
                      onPressed: () async {
                        setState(() {
                          size = i;
                        });
                        Navigator.of(context).pop();
                      },
                      child: Text(i.toString()),
                    ),
                  ]
                ]
              ],
            );
          }),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Cancel',
                style: TextStyle(color: Theme.of(context).colorScheme.outline),
              ),
            ),
          ],
        );
      },
      context: context,
    );
  }

  void showToast(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
        ),
      );
  }
}

final List<double> subtitleSize = [
  10.0,
  11.0,
  12.0,
  13.0,
  14.0,
  15.0,
];

const List<String> densityList = [
  'Default',
  'Comfortable',
  'Compact',
];
