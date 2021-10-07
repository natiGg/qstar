import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

import 'languages_screen.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool lockInBackground = true;
  bool notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Settings'),
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
          child: buildSettingsList(),
        ));
  }

  Widget buildSettingsList() {
    return SettingsList(
      sections: [
        SettingsSection(
          tiles: [
            SettingsTile(
                title: 'Personal Information', leading: Icon(Icons.person)),
            SettingsTile(title: 'Saved', leading: Icon(Icons.save)),
            SettingsTile(
                title: 'Swicth to professional account',
                leading: Icon(Icons.account_balance)),
          ],
        ),
        SettingsSection(
          tiles: [
            SettingsTile(title: 'Password', leading: Icon(Icons.password)),
            SettingsTile(title: 'Login Activity', leading: Icon(Icons.login)),
            SettingsTile(title: 'Sign out', leading: Icon(Icons.exit_to_app)),
          ],
        ),
        SettingsSection(
          tiles: [
            SettingsTile(
                title: 'Terms of Service', leading: Icon(Icons.description)),
            SettingsTile(
                title: 'Open source licenses',
                leading: Icon(Icons.collections_bookmark)),
          ],
        ),
        // SettingsSection(
        //   title: 'Security',
        //   tiles: [
        //     SettingsTile.switchTile(
        //       title: 'Lock app in background',
        //       leading: Icon(Icons.phonelink_lock),
        //       switchValue: lockInBackground,
        //       onToggle: (bool value) {
        //         setState(() {
        //           lockInBackground = value;
        //           notificationsEnabled = value;
        //         });
        //       },
        //     ),
        //     SettingsTile.switchTile(
        //       title: 'Use fingerprint',
        //       subtitle: 'Allow application to access stored fingerprint IDs.',
        //       leading: Icon(Icons.fingerprint),
        //       onToggle: (bool value) {},
        //       switchValue: false,
        //     ),
        //     SettingsTile.switchTile(
        //       title: 'Change password',
        //       leading: Icon(Icons.lock),
        //       switchValue: true,
        //       onToggle: (bool value) {},
        //     ),
        //     SettingsTile.switchTile(
        //       title: 'Enable Notifications',
        //       enabled: notificationsEnabled,
        //       leading: Icon(Icons.notifications_active),
        //       switchValue: true,
        //       onToggle: (value) {},
        //     ),
        //   ],
        // ),
        SettingsSection(
          tiles: [
            SettingsTile(
              title: 'Language',
              leading: Icon(Icons.language),
              onPressed: (context) {
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) =>
                        LanguagesScreen(),
                    transitionDuration: Duration.zero,
                  ),
                );
              },
            ),
            SettingsTile(
              title: 'Help',
              leading: Icon(Icons.help),
              onPressed: (context) {},
            ),
            SettingsTile(
              title: 'about',
              leading: Icon(
                Icons.info,
              ),
              onPressed: (context) {},
            ),
          ],
        ),
        CustomSection(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 22, bottom: 8),
                child: Image.asset(
                  'assets/images/settings.png',
                  height: 50,
                  width: 50,
                  color: Color(0xFF777777),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
