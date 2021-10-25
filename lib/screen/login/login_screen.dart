import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:qstar/constant.dart';
import 'package:qstar/screen/login/widget/login_button.dart';
import 'package:qstar/screen/login/widget/login_form.dart';
import 'package:qstar/screen/login/widget/welcome_back.dart';
import 'package:qstar/screen/register/register_screen.dart';

import 'forgotpassword.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          WelcomeBack(),
          LoginForm(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) {
                      return Forgotpassword();
                    },
                  ),
                );
              },
              child: Text(
                'Forgot password?',
                style: TextStyle(color: mPrimaryColor),
              ),
            ),
          ),
          SizedBox(
            height: 60,
          ),
          LoginButton(),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
              vertical: 16,
            ),
            alignment: Alignment.center,
            child: RichText(
              text: TextSpan(style: TextStyle(color: Colors.grey), children: [
                TextSpan(text: 'Don\'t you have an account? '),
                TextSpan(
                  text: 'Signup',
                  style: TextStyle(
                    color: mPrimaryColor,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation1, animation2) {
                            return RegisterScreen();
                          },
                        ),
                      );
                    },
                ),
              ]),
            ),
          )
        ],
      ),
    );
  }

  // AppBar buildAppBar(BuildContext context) {
  //   return AppBar(
  //     backgroundColor: mBackgroundColor,
  //     elevation: 0,
  //     centerTitle: true,
  //     title: Text(
  //       'Login',
  //       style: TextStyle(
  //         color: mPrimaryTextColor,
  //       ),
  //     ),
  //     leading: IconButton(
  //       icon: Icon(
  //         Icons.arrow_back_ios,
  //         color: mPrimaryTextColor,
  //       ),
  //       onPressed: () {
  //         Navigator.pop(context);
  //       },
  //     ),
  //   );
  // }
}
