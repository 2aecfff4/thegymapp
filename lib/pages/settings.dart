import 'package:flutter/material.dart';
import 'package:thegymapp/config.dart';

import 'package:settings_ui/settings_ui.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          PreferredSize(preferredSize: APP_BAR_PREFERRED_SIZE, child: AppBar()),
      body: SettingsList(
        sections: [
          SettingsSection(
            title: Text('Common'),
            tiles: <SettingsTile>[
              SettingsTile.navigation(
                leading: Icon(Icons.language),
                title: Text('Language'),
                value: Text('English'),
              ),
              SettingsTile.switchTile(
                onToggle: (value) {},
                initialValue: true,
                leading: Icon(Icons.format_paint),
                title: Text('Enable custom theme'),
              ),
            ],
          ),
        ],
      ),
      // const Center(
      //   child: Text("Settings"),
      // ),
    );
  }
}

Route settingsRoute() {
  return MaterialPageRoute(builder: (_) {
    return const SettingsPage();
  });
}
