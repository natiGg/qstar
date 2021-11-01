import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:qstar/constant.dart';
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
          title: Text(
            "Setting",
            style: TextStyle(
              color: mPrimaryColor,
              fontSize: 27,
              fontFamily: 'font1',
            ),
          ),
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
          tiles: const [
            SettingsTile(
                title: 'Personal Information',
                leading: Icon(
                  Icons.person,
                  color: mPrimaryColor,
                )),
            SettingsTile(
              title: 'Saved',
              leading: Icon(
                Icons.save,
                color: mPrimaryColor,
              ),
            ),
            SettingsTile(
                title: 'Swicth to professional account',
                leading: Icon(
                  Icons.account_balance,
                  color: mPrimaryColor,
                )),
          ],
        ),
        SettingsSection(
          tiles: const [
            SettingsTile(
                title: 'Password',
                leading: Icon(
                  Icons.password,
                  color: mPrimaryColor,
                )),
            SettingsTile(
                title: 'Login Activity',
                leading: Icon(
                  Icons.login,
                  color: mPrimaryColor,
                )),
            SettingsTile(
                title: 'Sign out',
                leading: Icon(
                  Icons.exit_to_app,
                  color: mPrimaryColor,
                )),
          ],
        ),
        SettingsSection(
          tiles: const [
            SettingsTile(
                title: 'Terms of Service',
                leading: Icon(
                  Icons.description,
                  color: mPrimaryColor,
                )),
            SettingsTile(
                title: 'Open source licenses',
                leading: Icon(
                  Icons.collections_bookmark,
                  color: mPrimaryColor,
                )),
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
              leading: Icon(
                Icons.language,
                color: mPrimaryColor,
              ),
              onPressed: (context) {
                Navigator.push(
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
              leading: Icon(
                Icons.help,
                color: mPrimaryColor,
              ),
              onPressed: (context) {},
            ),
            SettingsTile(
              title: 'about',
              leading: Icon(
                Icons.info,
                color: mPrimaryColor,
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
                  color: mPrimaryColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
