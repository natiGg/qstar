// ignore_for_file: deprecated_member_use, duplicate_ignore

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
    Future<bool> _onBackPressed() async {
      // This dialog will exit your app on saying yes
      return (await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Are you sure?'),
              content: const Text('Do you want to exit an App'),
              actions: <Widget>[
                // ignore: deprecated_member_use
                FlatButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('No'),
                ),
                FlatButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text('Yes'),
                ),
              ],
            ),
          )) ??
          false;
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: WillPopScope(
        onWillPop: _onBackPressed,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const WelcomeBack(),
            const LoginForm(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) {
                        return const Forgotpassword();
                      },
                    ),
                  );
                },
                child: const Text(
                  'Forgot password?',
                  style: TextStyle(color: mPrimaryColor),
                ),
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            const LoginButton(),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 16,
              ),
              alignment: Alignment.center,
              child: RichText(
                text: TextSpan(
                    style: const TextStyle(color: Colors.grey),
                    children: [
                      const TextSpan(text: 'Don\'t you have an account? '),
                      TextSpan(
                        text: 'Signup',
                        style: const TextStyle(
                          color: mPrimaryColor,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (context, animation1, animation2) {
                                  return const RegisterScreen();
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
