import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:qstar/constant.dart';
import 'package:qstar/screen/home/widget/login_and_register.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: EdgeInsetsDirectional.all(20),
        margin: EdgeInsets.only(top: 100),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 80,
            ),
            Image.asset(
              'assets/images/q.png',
              height: 200,
              width: 200,
            ),
            SizedBox(
              height: 60,
            ),
            LoginAndRegister(),
          ],
        ),
      ),
    );
  }
}
