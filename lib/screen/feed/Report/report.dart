import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:qstar/constant.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<ReportScreen> {
  bool lockInBackground = true;
  bool notificationsEnabled = true;
  late String strTitle;
  List<ReportScreen> arrSongList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              color: mPrimaryColor,
              onPressed: () {
                Navigator.popUntil(context, (route) => route.isFirst);
              }),
          title: const Text(
            "Report",
            style: TextStyle(
              color: mPrimaryColor,
              fontSize: 27,
              fontFamily: 'font1',
            ),
          ),
          elevation: 0.0,
        ),
        body: Column(children: [
          const Center(
            child: ListTile(
              title: Text("Why are you reporting this post?"),
              subtitle: Text('Your report is anonymous'),
            ),
          ),
          ListTile(
              title: const Text("Its spam"),
              onTap: () {
                Fluttertoast.showToast(
                    msg: "Succefully Reported",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0);
                Navigator.pop(context);
              }),
          ListTile(
              title: const Text("Hate speech"),
              onTap: () {
                Fluttertoast.showToast(
                    msg: "Succefully Reported",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0);
                Navigator.pop(context);
              }),
          ListTile(
              title: const Text(" Sextual activity"),
              onTap: () {
                Fluttertoast.showToast(
                    msg: "Succefully Reported",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0);
                Navigator.pop(context);
              }),
          ListTile(
              title: const Text(" False information"),
              onTap: () {
                Fluttertoast.showToast(
                    msg: "Succefully Reported",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0);
                Navigator.pop(context);
              }),
          ListTile(
              title: const Text(" Scum or fraud"),
              onTap: () {
                Fluttertoast.showToast(
                    msg: "Succefully Reported",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0);
                Navigator.pop(context);
              }),
          ListTile(
              title: const Text("I just dont like it "),
              onTap: () {
                Fluttertoast.showToast(
                    msg: "Succefully Reported",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0);
                Navigator.pop(context);
              }),
          ListTile(
              title: const Text("Self injury"),
              onTap: () {
                Fluttertoast.showToast(
                    msg: "Succefully Reported",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0);
                Navigator.pop(context);
              }),
          ListTile(
              title: const Text("Other"),
              onTap: () {
                Fluttertoast.showToast(
                    msg: "Succefully Reported",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0);
                Navigator.pop(context);
              }),
        ]));
  }
}
