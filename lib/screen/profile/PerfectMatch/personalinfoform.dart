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
      appBar: AppBar(
        leadingWidth: 100,
        backgroundColor: Colors.white,
        leading: Container(
          padding: EdgeInsets.only(left: 20, top: 15),
          width: 150,
          child: Text(
            "Match prefernces",
            style: TextStyle(
              color: mPrimaryColor,
              fontSize: 23,
              fontFamily: 'font1',
            ),
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {}, icon: Icon(Icons.menu), color: mPrimaryColor)
        ],
      ),
      body:  SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 16, top: 25, right: 16),
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Column(
              children: [
                SizedBox(
                  height: 15,
                ),
                Center(
                  child:Text(
              "General Information",
              style: TextStyle(
                // we use the [TextStyle] widget to customize text
                color: mPrimaryColor, // set the color
                fontSize: 25.0,
                fontFamily: 'font1', // and the font size
              ),
            )
                ),
                
                SizedBox(
                  height: 35,
                ),
                const SizedBox(height: 24),
                TextFieldWidget(
                  label: 'Full Name',
                  text: "nati",
                  onChanged: (name) {},
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  alignment: Alignment.center,
                  child: RichText(
                    text:
                        TextSpan(style: TextStyle(color: Colors.grey), children: [
                      TextSpan(
                          text:
                              "Help people disocver your account by using the name you're known by: either your full name,nickname or business name"),
                    ]),
                  ),
                ),
                const SizedBox(height: 2),
                Container(
                  padding: EdgeInsets.all(8),
                  alignment: Alignment.centerLeft,
                  child: RichText(
                    text:
                        TextSpan(style: TextStyle(color: Colors.grey), children: [
                      TextSpan(
                          text:
                              "you can only change your name twice within 14 days"),
                    ]),
                  ),
                ),
                const SizedBox(height: 24),
                TextFieldWidget(
                  label: 'Gender',
                  text: "natiG",
                  onChanged: (email) {},
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  alignment: Alignment.center,
                  child: RichText(
                    text:
                        TextSpan(style: TextStyle(color: Colors.grey), children: [
                      TextSpan(
                          text:
                              "Choose Your gender"),
                    
                    ]),
                  ),
                ),
                const SizedBox(height: 24),
                TextFieldWidget(
                  label: 'location',
                  text: "sheger",
                  onChanged: (email) {},
                ),
                const SizedBox(height: 24),
                TextFieldWidget(
                  label: 'Birth day',
                  text: "mnshe nw",
                  onChanged: (email) {},
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  alignment: Alignment.center,
                  child: RichText(
                    text:
                        TextSpan(style: TextStyle(color: Colors.grey), children: [
                      TextSpan(
                          text:
                              "please make sure to put your correct birth date.."),
                    ]),
                  ),
                ),
                SizedBox(
                  height: 35,
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
          ),
        ),
      )  );
    

  }
}
