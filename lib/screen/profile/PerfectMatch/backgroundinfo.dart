import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:qstar/constant.dart';
import 'package:qstar/screen/profile/PerfectMatch/personalinfoform2.dart';
import 'package:qstar/screen/register/phonevarification.dart';
import 'package:qstar/screen/register/widget/register_button.dart';
import 'package:qstar/screen/register/widget/register_form.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:qstar/screen/register/password.dart';
import 'package:email_validator/email_validator.dart';
import 'package:qstar/screen/profile/widgets/textfield_widget.dart';

class BackgroundInfo extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<BackgroundInfo> {
  @override
  Widget build(BuildContext context) {
    String? dropdownvalue = 'Education';
    String newValue;
    var items = [
      'Education',
      'Muslim',
      'Protestant',
      'catolic',
      'Others',
    ];

    String? dropdownvalue2 = 'Employmnet';
    String newValue2;
    var items2 = [
      'Employmnet',
      'Arabic ',
      'Somali',
      'Amahric',
      'French',
    ];

    String? dropdownvalue3 = 'occupation';
    String newValue3;
    var items3 = [
      'occupation',
      'Art ',
      'Sport',
      'Reading',
      'Walking',
    ];

    const textStyle = const TextStyle(
      color: Colors.white,
    );
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: Container(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 15,
              ),
              Center(
                  child: Text(
                "Background Information",
                style: TextStyle(
                  // we use the [TextStyle] widget to customize text
                  color: mPrimaryColor, // set the color
                  fontSize: 25.0,
                  fontFamily: 'font1', // and the font size
                ),
              )),
              SizedBox(height: 24),
              Container(
                  width: 400.0,
                  padding: const EdgeInsets.all(8),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      hint: Text("Education"),
                      value: dropdownvalue,
                      icon: Icon(Icons.keyboard_arrow_down),
                      items: items.map((String items) {
                        return DropdownMenuItem(
                            value: items, child: Text(items));
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          dropdownvalue = newValue as String;
                        });
                      },
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  )),
              const SizedBox(height: 24),
              Container(
                  width: 400.0,
                  padding: const EdgeInsets.all(8),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      hint: Text("Employemnet"),
                      value: dropdownvalue2,
                      icon: Icon(Icons.keyboard_arrow_down),
                      items: items2.map((String items2) {
                        return DropdownMenuItem(
                            value: items2, child: Text(items2));
                      }).toList(),
                      onChanged: (newValue2) {
                        setState(() {
                          dropdownvalue2 = newValue2 as String;
                        });
                      },
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  )),
              Container(
                padding: const EdgeInsets.all(8),
                alignment: Alignment.center,
                child: RichText(
                  text:
                      TextSpan(style: TextStyle(color: Colors.grey), children: [
                    TextSpan(text: "Choose your employement type please"),
                  ]),
                ),
              ),
              const SizedBox(height: 24),
              Container(
                  width: 400.0,
                  padding: const EdgeInsets.all(8),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      hint: Text("Occupation"),
                      value: dropdownvalue3,
                      icon: Icon(Icons.keyboard_arrow_down),
                      items: items3.map((String items3) {
                        return DropdownMenuItem(
                            value: items3, child: Text(items3));
                      }).toList(),
                      onChanged: (newValue3) {
                        setState(() {
                          dropdownvalue3 = newValue3 as String;
                        });
                      },
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  )),
              Container(
                padding: const EdgeInsets.all(8),
                alignment: Alignment.center,
                child: RichText(
                  text:
                      TextSpan(style: TextStyle(color: Colors.grey), children: [
                    TextSpan(text: "Choose Your occupation"),
                  ]),
                ),
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(8),
                alignment: Alignment.center,
                child: RichText(
                  text:
                      TextSpan(style: TextStyle(color: Colors.grey), children: [
                    TextSpan(
                        text:
                            "please make sure to put your correct occupation.."),
                  ]),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(8),
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
                          return BackgroundInfo();
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
        ),
      ),
    );
  }
}
