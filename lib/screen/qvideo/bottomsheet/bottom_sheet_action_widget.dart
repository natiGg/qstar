import 'package:flutter/material.dart';
import 'package:qstar/constant.dart';
import 'app_context.dart';
import 'bottom_sheet_action.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:qstar/screen/profilesetting/setting.dart';

class BottomSheetActionWidget extends StatelessWidget {
  final BottomSheetAction action;

  BottomSheetActionWidget(this.action);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.blue.withOpacity(0.1),
      splashColor: Colors.blue.withOpacity(0.3),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Row(
          children: [
            Icon(
              action.iconData,
              color: mPrimaryColor,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              action.title,
              style: context.textTheme.subtitle1,
            )
          ],
        ),
      ),
      onTap: () {
        // Navigator.pop(context, action);

        switch (action.id.toString()) {
          case "0":
            {
              // Navigator.pushReplacement(
              //   context,
              //   PageRouteBuilder(
              //     pageBuilder: (context, animation1, animation2) =>
              //         SettingsScreen(),
              //     transitionDuration: Duration.zero,
              //   ),
              // );
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

          default:
            {
              print("Invalid Date");
            }
            break;
        }
      },
    );
  }
}
