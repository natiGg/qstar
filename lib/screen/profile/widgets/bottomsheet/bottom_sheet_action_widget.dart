import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:qstar/constant.dart';
import 'package:qstar/controllers/editprofilecontroller.dart';
import 'package:qstar/controllers/feedcontroller.dart';
import 'package:qstar/controllers/followcontroller.dart';
import 'package:qstar/screen/login/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../changepassword.dart';

import 'bottom_sheet_action.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:qstar/screen/profilesetting/setting.dart';

class BottomSheetActionWidget extends StatelessWidget {
  final BottomSheetAction action;

  // ignore: use_key_in_widget_constructors
  const BottomSheetActionWidget(this.action);

  @override
  Widget build(BuildContext context) {

    return InkWell(
      highlightColor: Colors.blue.withOpacity(0.1),
      splashColor: Colors.blue.withOpacity(0.3),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Row(
          children: [
            Icon(
              action.iconData,
              color: mPrimaryColor,
            ),
            const SizedBox(
              width: 16,
            ),
            Text(
              action.title,
            )
          ],
        ),
      ),
      onTap: () async {
        // Navigator.pop(context, action);

        switch (action.id.toString()) {
          case "0":
            {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) =>
                      const SettingsScreen(),
                  transitionDuration: Duration.zero,
                ),
              );
            }
            break;

          case "1":
            {
             
                  Fluttertoast.showToast(
                  msg: "1",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
              
            
            }

            break;

          case "2":
            {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) =>
                      const ChangePassword(),
                  transitionDuration: Duration.zero,
                ),
              );
            }

            break;

          case "7":
            {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Are you sure?'),
                  content: const Text('Do you want to Logout'),
                  actions: <Widget>[
                    // ignore: deprecated_member_use
                    FlatButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: const Text('No'),
                    ),
                    // ignore: deprecated_member_use
                    FlatButton(
                      onPressed: () {
                        _logout(context);
                      },
                      child: const Text('Yes'),
                    ),
                  ],
                ),
              );
            }
            break;
          default:
            {
              // ignore: avoid_print
              print("Invalid Date");
            }
            break;
        }
      },
    );
  }

  void _logout(BuildContext context) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.remove('token');
    Get.delete<EditprofileController>();

    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) => const LoginScreen(),
        transitionDuration: Duration.zero,
      ),
    );
  }
}


class BottomSheetActionWidget2 extends StatelessWidget {
  final BottomSheetAction2 action;

  // ignore: use_key_in_widget_constructors
  const BottomSheetActionWidget2(this.action);

  @override
  Widget build(BuildContext context) {
      FeedController feedController=Get.find();

       Followcontroller followcontroller = Get.find();

    return InkWell(
      highlightColor: Colors.blue.withOpacity(0.1),
      splashColor: Colors.blue.withOpacity(0.3),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Row(
          children: [
            Icon(
              action.iconData,
              color: mPrimaryColor,
            ),
            const SizedBox(
              width: 16,
            ),
            Text(
              action.title,
            )
          ],
        ),
      ),
      onTap: () async {
        // Navigator.pop(context, action);

        switch (action.id.toString()) {
          case "0":
            {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) =>
                      const SettingsScreen(),
                  transitionDuration: Duration.zero,
                ),
              );
            }
            break;

          case "1":
            {
              if(action.title.toString()=="unfollow"){
                followcontroller.unfollow(action.unFlwid);
                Navigator.of(context).pop();
                followcontroller.check(action.unFlwid.toString(),feedController.uid.toString(),);
              }
              else{
                  Fluttertoast.showToast(
                  msg: "1",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
              }
            
            }

            break;

          case "2":
            {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) =>
                      const ChangePassword(),
                  transitionDuration: Duration.zero,
                ),
              );
            }

            break;

          case "7":
            {
         
            }
            break;
          default:
            {
              // ignore: avoid_print
              print("Invalid Date");
            }
            break;
        }
      },
    );
  }

}
