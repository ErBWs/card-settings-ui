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

  double size = 12.0;
  String density = densityList[0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: SettingsList(
        maxWidth: 800,
        sections: [
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
            bottomInfo: Text('Change font size'),
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
                onPressed: (_) {},
                title: Text('Subtitle Language'),
                description: Text('English'),
              ),
              SettingsTile(
                title: Text('Subtitle size'),
                description: Slider(
                  year2023: false,
                  value: size,
                  min: 10,
                  max: 15,
                  divisions: 5,
                  label: '$size',
                  onChanged: (value) {
                    setState(() {
                      size = value;
                    });
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

const List<String> densityList = [
  'Default',
  'Compact',
];
