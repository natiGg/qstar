// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:qstar/constant.dart';

class RegisterButton extends StatelessWidget {
  const RegisterButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
      color: Colors.white,
    );
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(36),
        ),
        color: mPrimaryColor,
        onPressed: () {
          // Navigator.push(
          //   context,
          //   PageRouteBuilder(
          //     pageBuilder: (context, animation1, animation2) {
          //       return BirthDay();
          //     },
          //   ),
          // );
        },
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 16),
          alignment: Alignment.center,
          child: const Text(
            'Next',
            style: textStyle,
          ),
        ),
      ),
    );
  }
}
