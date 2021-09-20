import 'package:flutter/material.dart';
import 'package:qstar/constant.dart';
import 'package:qstar/screen/home/widget/login_and_register.dart';
import 'package:qstar/screen/home/widget/login_with_facebook.dart';
import 'package:qstar/screen/home/widget/slider_dot.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 80,
          ),
          Image.asset('assets/images/q.png'),

          SizedBox(
            height: 20,
          ),
          Text(
            'Have Fun\nin town!',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: mPrimaryTextColor,
              fontSize: 32,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: 60,
          ),
          LoginAndRegister(),
          LoginWithFacebook()
        ],
      ),
    );
  }
}

