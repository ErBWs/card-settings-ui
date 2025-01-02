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
  bool useFingerprint = true;
  double size = 10.0;

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
                  SettingsTile.navigation(
                    onPressed: (_) =>
                        showToast(context, 'Navigate to extension page'),
                    leading: Icon(Icons.extension),
                    title: Text('Extension'),
                  ),
                ],
              ),
              SettingsSection(
                title: Text('Security'),
                bottomInfo: Text('Allow user log in with fingerprint'),
                tiles: <SettingsTile>[
                  SettingsTile.navigation(
                    onPressed: (_) =>
                        showToast(context, 'Navigate to email editing page'),
                    leading: Icon(Icons.email_rounded),
                    title: Text('Email'),
                  ),
                  SettingsTile.switchTile(
                    onToggle: (value) {
                      useFingerprint = value ?? !useFingerprint;
                      setState(() {});
                    },
                    initialValue: useFingerprint,
                    leading: Icon(Icons.fingerprint),
                    title: Text('Enable fingerprint'),
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
              SettingsSection(
                bottomInfo: Text('Download settings from cloud'),
                tiles: <SettingsTile>[
                  SettingsTile(
                    onPressed: (_) {
                      showToast(context, 'Download successfully');
                    },
                    title: Text('Download'),
                    trailing: Icon(Icons.cloud_download_rounded),
                  ),
                ],
              ),
              SettingsSection(
                tiles: <SettingsTile>[
                  SettingsTile.navigation(
                    onPressed: (_) =>
                        showToast(context, 'Log out successfully'),
                    leading: Icon(Icons.logout),
                    title: Text('Log out'),
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
