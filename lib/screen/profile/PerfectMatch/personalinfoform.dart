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

class PersonalInfo extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<PersonalInfo> {
  @override
  Widget build(BuildContext context) {
    String? dropdownvalue = 'Afghanistan';
    String newValue;
    var items = [
      'Afghanistan',
      'Albania',
      'Algeria',
      'Andorra',
      'Angola',
      'Argentina'
    ];

    const textStyle = const TextStyle(
      color: Colors.white,
    );
    return Scaffold(
      body: Column(
        mainAxisAlignment:
            MainAxisAlignment.center, //Center Column contents vertically,
        children: <Widget>[
          Text(
            "General Information",
            style: TextStyle(
              // we use the [TextStyle] widget to customize text
              color: mPrimaryColor, // set the color
              fontSize: 25.0,
              fontFamily: 'font1', // and the font size
            ),
          ),
          SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 30,
            ),
            child: Material(
              elevation: 20.0,
              shadowColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0)),
              child: TextFormField(
                autofocus: false,
                decoration: InputDecoration(
                    hintText: 'Full name',
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide:
                            BorderSide(color: Colors.white, width: 3.0))),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 30,
            ),
            child: Material(
              elevation: 20.0,
              shadowColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0)),
              child: TextFormField(
                autofocus: false,
                decoration: InputDecoration(
                    hintText: 'Gender',
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide:
                            BorderSide(color: Colors.white, width: 3.0))),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 30,
            ),
            child: Material(
              elevation: 20.0,
              shadowColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0)),
              child: TextFormField(
                autofocus: false,
                decoration: InputDecoration(
                    hintText: 'Location',
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide:
                            BorderSide(color: Colors.white, width: 3.0))),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 30,
            ),
            child: Material(
              elevation: 20.0,
              shadowColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0)),
              child: TextFormField(
                autofocus: false,
                decoration: InputDecoration(
                    hintText: 'BirthDay',
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide:
                            BorderSide(color: Colors.white, width: 3.0))),
              ),
            ),
          ),
          Container(
              width: 400.0,
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 30,
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                  hint: Text("Live In"),
                  value: dropdownvalue,
                  icon: Icon(Icons.keyboard_arrow_down),
                  items: items.map((String items) {
                    return DropdownMenuItem(value: items, child: Text(items));
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      dropdownvalue = newValue as String;
                    });
                  },
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              )),
          Container(
              width: 400.0,
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 30,
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                  hint: Text("Live In"),
                  value: dropdownvalue,
                  icon: Icon(Icons.keyboard_arrow_down),
                  items: items.map((String items) {
                    return DropdownMenuItem(value: items, child: Text(items));
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      dropdownvalue = newValue as String;
                    });
                  },
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              )),
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 20,
            ),
            child: Material(
              elevation: 20.0,
              shadowColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0)),
              child: TextFormField(
                autofocus: false,
                decoration: InputDecoration(
                    hintText: 'Phone Number',
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide:
                            BorderSide(color: Colors.white, width: 3.0))),
              ),
            ),
          ),
          SizedBox(height: 10),
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
                      return PersonalInfo2();
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
