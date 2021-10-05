import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:qstar/constant.dart';
import 'package:qstar/screen/register/widget/register_button.dart';
import 'package:qstar/screen/register/widget/register_form.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:qstar/screen/register/username.dart';


class BirthDay extends StatelessWidget {
    const BirthDay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
        const textStyle = const TextStyle(
              color: Colors.white,
            );
    return Scaffold(

      body: Column(
mainAxisAlignment: MainAxisAlignment.center, //Center Column contents vertically,
        children:  <Widget>[
          Text("When's Your Birthday?",style: TextStyle( // we use the [TextStyle] widget to customize text
            color: mPrimaryColor, // set the color
            fontSize: 32.0, // and the font size
          ),),
          SizedBox(height: 20),

          TableCalendar(
            firstDay: DateTime.utc(1900, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: DateTime.now(),
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
                return Username();
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
