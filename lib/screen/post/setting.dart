import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:qstar/constant.dart';

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
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              color: mPrimaryColor,
              onPressed: () {
                Navigator.popUntil(context, (route) => route.isFirst);
              }),
          title: Text(
            "Setting",
            style: TextStyle(
              color: mPrimaryColor,
              fontSize: 27,
              fontFamily: 'font1',
            ),
          ),
          elevation: 0.0,
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
            SettingsTile.switchTile(
              title: 'Turn of commenting',
              leading: Icon(Icons.tv_off),
              onToggle: (bool value) {},
              switchValue: false,
            ),
          ],
        ),
      ],
    );
  }
}
