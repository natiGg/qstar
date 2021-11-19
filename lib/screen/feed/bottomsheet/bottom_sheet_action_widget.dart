import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:qstar/constant.dart';
import 'package:qstar/controllers/editprofilecontroller.dart';
import 'package:qstar/controllers/postcontroller.dart';
import 'package:qstar/screen/login/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bottom_sheet_action.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:qstar/screen/profilesetting/setting.dart';

class BottomSheetActionWidget extends StatelessWidget {
  final BottomSheetAction action;
  PostController postController = Get.find();
  // ignore: use_key_in_widget_constructors
  BottomSheetActionWidget(this.action);

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
              postController.changePostype("public");
              Navigator.pop(context);
            }
            break;

          case "1":
            {
              postController.changePostype("friends");
              Navigator.pop(context);
            }

            break;

          case "2":
            {
              postController.changePostype("stars");
              Navigator.pop(context);
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
