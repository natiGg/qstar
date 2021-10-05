import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:qstar/constant.dart';
import 'package:qstar/screen/register/widget/register_button.dart';
import 'package:qstar/screen/register/widget/register_form.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:qstar/screen/register/email.dart';


class Username extends StatelessWidget {
    const Username({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const textStyle = const TextStyle(
              color: Colors.white,
            );
    return Scaffold(

      body: Column(
mainAxisAlignment: MainAxisAlignment.center, //Center Column contents vertically,
        children:  <Widget>[
          Text("Your username",style: TextStyle( // we use the [TextStyle] widget to customize text
            color: mPrimaryColor, // set the color
            fontSize: 25.0, // and the font size
            
          ),),
          SizedBox(height: 20),
          Text("Your username is how friends add you on Q star",style: TextStyle( // we use the [TextStyle] widget to customize text
            color: mPrimaryColor, // set the color
            fontSize: 10.0, // and the font size
          ),),
          Container(
            padding: const EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 30,
      ),
            child: Material(
            
                elevation: 20.0,
                shadowColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(25.0) ),
                            child: TextFormField(
                  obscureText: true,
                  autofocus: false,
                  decoration: InputDecoration(
                      hintText: 'username',
                      fillColor: Colors.white,
                      filled: true,
                      contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      enabledBorder: OutlineInputBorder(borderRadius:BorderRadius.circular(25.0),
                      borderSide: BorderSide(color: Colors.white, width: 3.0))
                  ),
                ),
              ),
          ), 
          
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 45,
              vertical: 16,
            ),
            alignment: Alignment.center,
            child: RichText(
              text: TextSpan(style: TextStyle(color: Colors.grey), children: [
                TextSpan(text: 'By tapping sign up & accept you acknowledge that you have read the privacy policy and agree to the Term of Service.'),
                TextSpan(
                  text: 'Next',
                  style: TextStyle(
                    color: mPrimaryColor,
                  ),
                
                  recognizer: TapGestureRecognizer()..onTap = () {
                    Navigator.pop(context);
                  },
                ),
              ]),
            ),
          ),
          Container(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(36),
        ),
        color: mPrimaryColor,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return Email();
              },
            ),
          );
        },
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 16),
          alignment: Alignment.center,
          child: Text(
            'Next',
            style: textStyle,
          ),
        ),
      ),
    ),
        ],
      ),
    );
  }

}
