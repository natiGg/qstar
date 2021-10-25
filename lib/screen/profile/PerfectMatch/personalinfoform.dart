import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:qstar/constant.dart';
import 'package:qstar/screen/feed/feed.dart';
import 'package:qstar/screen/profile/PerfectMatch/personalinfoform2.dart';
import 'package:qstar/screen/register/phonevarification.dart';
import 'package:qstar/screen/register/widget/register_button.dart';
import 'package:qstar/screen/register/widget/register_form.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:qstar/screen/register/password.dart';
import 'package:email_validator/email_validator.dart';
import 'package:qstar/screen/profile/widgets/textfield_widget.dart';
import 'package:country_picker/country_picker.dart';

class PersonalInfo extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<PersonalInfo> {
  int currentStep = 0;
  String? _gender;
  String? list2 = "Counrty";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: mPrimaryColor,
            onPressed: () {
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) => UsersFeed(),
                  transitionDuration: Duration.zero,
                ),
              );
            }),
        // ignore: prefer_const_constructors
        title: Text(
          "Perfect Match Form",
          style: const TextStyle(
            color: mPrimaryColor,
            fontSize: 27,
            fontFamily: 'font1',
          ),
        ),
      ),
      body: Stepper(
        steps: getSteps(),
        currentStep: currentStep,
        onStepTapped: (int step) {
          setState(() {
            currentStep = step;
          });
        },
        onStepCancel: () {
          currentStep > 0 ? setState(() => currentStep -= 1) : null;
        },
        onStepContinue: () {
          currentStep < 3 ? setState(() => currentStep += 1) : null;
        },
      ),
    );
  }

  List<Step> getSteps() {
    return [
      Step(
        title: new Text('Genral Info'),
        content: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: 'Full name'),
            ),
            DropdownButton<String>(
              value: _gender,
              isExpanded: true,
              style: TextStyle(color: Colors.black),
              items: <String>[
                'Male',
                'Female',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              hint: Text(
                "Gender",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w300),
              ),
              onChanged: (value) {
                setState(() {
                  _gender = value!;
                });
              },
            ),
            GestureDetector(
              onTap: () {
                showCountryPicker(
                  context: context,
                  countryListTheme: CountryListThemeData(
                    flagSize: 25,
                    backgroundColor: Colors.white,
                    textStyle: TextStyle(fontSize: 16, color: Colors.blueGrey),
                    //Optional. Sets the border radius for the bottomsheet.
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                    ),
                    //Optional. Styles the search field.
                    inputDecoration: InputDecoration(
                      labelText: 'Search',
                      hintText: 'Start typing to search',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: const Color(0xFF8C98A8).withOpacity(0.2),
                        ),
                      ),
                    ),
                  ),
                  onSelect: (Country country) => setState(() {
                    list2 = "${country.displayName}";
                  }),
                );
              },
              child: AbsorbPointer(
                child: TextFormField(
                  decoration: InputDecoration(
                      labelText: list2.toString() == "Counrty"
                          ? list2 = "Counrty"
                          : list2.toString()),
                ),
              ),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'City'),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Phone Number'),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        isActive: currentStep >= 0,
        state: currentStep == 0 ? StepState.editing : StepState.complete,
      ),
      Step(
        title: new Text('Personal Details'),
        content: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: 'Home Address'),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Mobile No'),
            ),
          ],
        ),
        isActive: currentStep >= 1,
        state: currentStep == 1
            ? StepState.editing
            : currentStep < 1
                ? StepState.disabled
                : StepState.complete,
      ),
      Step(
        title: new Text("BackGround Info"),
        content: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: 'Account No'),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'IFSC Code'),
            ),
          ],
        ),
        isActive: currentStep >= 2,
        state: currentStep == 2
            ? StepState.editing
            : currentStep < 2
                ? StepState.disabled
                : StepState.complete,
      ),
      Step(
        title: new Text("Match Perference"),
        content: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: 'Account No'),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'IFSC Code'),
            ),
          ],
        ),
        isActive: currentStep >= 3,
        state: currentStep == 3
            ? StepState.editing
            : currentStep < 3
                ? StepState.disabled
                : StepState.complete,
      ),
    ];
  }
}
