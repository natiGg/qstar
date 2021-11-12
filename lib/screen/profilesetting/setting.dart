import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:qstar/constant.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final List locale = [
    {'name': 'English', 'locale': const Locale('en', 'US')},
    {'name': 'Hindi', 'locale': const Locale('hi', 'IN')},
    {'name': 'Arabic', 'locale': const Locale('ar', 'IN')},
    {'name': 'Amahric', 'locale': const Locale('am', 'IN')},
    {'name': 'deutch', 'locale': const Locale('de', 'IN')},
    {'name': 'Espaoal', 'locale': const Locale('es', 'IN')},
    {'name': 'French', 'locale': const Locale('fr', 'IN')},
    {'name': 'Indonesia', 'locale': const Locale('in', 'IN')},
    {'name': 'China', 'locale': const Locale('ch', 'IN')},
    {'name': 'Malaysia', 'locale': const Locale('ma', 'IN')},
    {'name': 'Turkia', 'locale': const Locale('tu', 'IN')},
    {'name': 'Italia', 'locale': const Locale('it', 'IN')},
    {'name': 'portugal', 'locale': const Locale('po', 'IN')},
    {'name': 'Somlia', 'locale': const Locale('so', 'IN')},
  ];
  updateLanguage(Locale locale) {
    Get.back();
    Get.updateLocale(locale);
  }

  bool lockInBackground = true;
  bool notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Setting".tr,
            style: const TextStyle(
              color: mPrimaryColor,
              fontSize: 27,
              fontFamily: 'font1',
            ),
          ),
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
          child: buildSettingsList(),
        ));
  }

  Widget buildSettingsList() {
    return SettingsList(
      sections: [
        SettingsSection(
          tiles: [
            SettingsTile(
                title: "Personalinformaion".tr,
                leading: const Icon(
                  Icons.person,
                  color: mPrimaryColor,
                )),
            SettingsTile(
                title: 'Swicth'.tr,
                leading: const Icon(
                  Icons.account_balance,
                  color: mPrimaryColor,
                )),
          ],
        ),
        SettingsSection(
          tiles: const [
            SettingsTile(
                title: 'Login Activity',
                leading: Icon(
                  Icons.login,
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
        SettingsSection(
          tiles: [
            SettingsTile(
              title: 'Language',
              leading: const Icon(
                Icons.language,
                color: mPrimaryColor,
              ),
              onPressed: (context) {
                buildLanguageDialog(context);
              },
            ),
            SettingsTile(
              title: 'Help',
              leading: const Icon(
                Icons.help,
                color: mPrimaryColor,
              ),
              onPressed: (context) {},
            ),
            SettingsTile(
              title: 'about',
              leading: const Icon(
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

  buildLanguageDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (builder) {
          return AlertDialog(
            title: const Text('Choose Your Language'),
            content: SizedBox(
              width: double.maxFinite,
              child: ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        child: Text(locale[index]['name']),
                        onTap: () {
                          updateLanguage(locale[index]['locale']);
                        },
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider(
                      color: mPrimaryColor,
                    );
                  },
                  itemCount: locale.length),
            ),
          );
        });
  }
}
