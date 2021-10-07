import 'package:flutter/material.dart';
import 'package:qstar/constant.dart';
import 'package:qstar/screen/home/widget/login_and_register.dart';
import 'package:qstar/screen/home/widget/login_with_facebook.dart';
import 'package:qstar/screen/home/widget/slider_dot.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsetsDirectional.all(20),
        margin: EdgeInsets.only(top: 100),
        child: Column(
          
          children: <Widget>[
            SizedBox(
              height: 80,
            ),
            Image.asset('assets/images/q.png',height: 200,width: 200,),

            
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

