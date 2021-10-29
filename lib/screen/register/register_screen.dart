import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:qstar/constant.dart';
import 'package:qstar/screen/register/Privacypolicy.dart';
import 'package:qstar/screen/register/TermofService.dart';
import 'package:qstar/screen/register/widget/register_button.dart';
import 'package:qstar/screen/register/widget/register_form.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        mainAxisAlignment:
            MainAxisAlignment.center, //Center Column contents vertically,
        children: <Widget>[
          Text(
            "Sign Up",
            style: TextStyle(
              // we use the [TextStyle] widget to customize text
              color: mPrimaryColor, // set the color
              fontSize: 32.0,
              fontFamily: 'font1', // and the font size
            ),
          ),
          SizedBox(height: 20),
          RegisterForm(),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 45,
              vertical: 16,
            ),
            alignment: Alignment.center,
            child: RichText(
              text: TextSpan(style: TextStyle(color: Colors.grey), children: [
                TextSpan(
                    text:
                        'By tapping Next  & accept you acknowledge that you have read the'),
                TextSpan(
                  text: ' Privacy policy',
                  style: TextStyle(
                    color: mPrimaryColor,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation1, animation2) {
                            return Privacypolicy();
                          },
                        ),
                      );
                    },
                ),
                TextSpan(text: ' and agree to the'),
                TextSpan(
                  text: ' Term of Service',
                  style: TextStyle(
                    color: mPrimaryColor,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation1, animation2) {
                            return TermofService();
                          },
                        ),
                      );
                    },
                ),
              ]),
            ),
          ),
          RegisterButton(),
        ],
      ),
    );
  }
}
