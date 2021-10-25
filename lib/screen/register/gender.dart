import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:qstar/constant.dart';
import 'package:qstar/screen/register/birthday.dart';
import 'package:qstar/screen/register/phonevarification.dart';
import 'package:qstar/screen/register/widget/register_button.dart';
import 'package:qstar/screen/register/widget/register_form.dart';

import 'package:qstar/screen/register/password.dart';
import 'package:email_validator/email_validator.dart';
import 'package:gender_picker/source/enums.dart';
import 'package:gender_picker/source/gender_picker.dart';

class GenderClass extends StatelessWidget {
  const GenderClass({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const textStyle = const TextStyle(
      color: Colors.white,
    );
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        mainAxisAlignment:
            MainAxisAlignment.center, //Center Column contents vertically,
        children: <Widget>[
          Text(
            "Select gender",
            style: TextStyle(
              // we use the [TextStyle] widget to customize text
              color: mPrimaryColor, // set the color
              fontSize: 25.0,
              fontFamily: 'font1', // and the font size
            ),
          ),
          SizedBox(height: 20),
          GenderPickerWithImage(
            showOtherGender: true,
            verticalAlignedText: false,
            selectedGender: Gender.Male,
            selectedGenderTextStyle: TextStyle(
                color: Color(0xFF8b32a8), fontWeight: FontWeight.bold),
            unSelectedGenderTextStyle:
                TextStyle(color: Colors.white, fontWeight: FontWeight.normal),
            onChanged: (Gender? gender) {
              print(gender);
            },
            equallyAligned: true,
            animationDuration: Duration(milliseconds: 300),
            isCircular: true,
            // default : true,
            opacityOfGradient: 0.4,
            padding: const EdgeInsets.all(3),
            size: 50, //default : 40
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 45,
              vertical: 16,
            ),
            alignment: Alignment.center,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) {
                      return Phonevarification();
                    },
                  ),
                );
              },
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
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) {
                      return BirthDay();
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
