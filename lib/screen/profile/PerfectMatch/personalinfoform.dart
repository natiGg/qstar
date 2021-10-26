import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:language_picker/languages.dart';
import 'package:language_picker/languages.g.dart';
import 'package:qstar/constant.dart';
import 'package:qstar/screen/feed/feed.dart';

import 'package:qstar/screen/profile/PerfectMatch/searching.dart';
import 'package:qstar/screen/register/phonevarification.dart';
import 'package:qstar/screen/register/widget/register_button.dart';
import 'package:qstar/screen/register/widget/register_form.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:qstar/screen/register/password.dart';
import 'package:email_validator/email_validator.dart';
import 'package:qstar/screen/profile/widgets/textfield_widget.dart';
import 'package:country_picker/country_picker.dart';
import 'package:language_picker/language_picker.dart';

class PersonalInfo extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<PersonalInfo> {
  int currentStep = 0;
  String? _gender, _hob, _edu, _emp, _occ;
  String? list2 = "Counrty";
  String? lan = "Language";
  RangeValues _currentRangeValues = const RangeValues(0, 100);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
        controlsBuilder: (BuildContext context,
            {VoidCallback? onStepContinue,
            VoidCallback? onStepCancel,
            VoidCallback? onStpeFinish}) {
          final isLastStep = currentStep == getSteps().length - 1;
          return Row(
            children: <Widget>[
              OutlinedButton(
                  onPressed: onStepContinue,
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0))),
                  ),
                  child: (isLastStep)
                      ? GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation1, animation2) =>
                                        UsersFeed(),
                                transitionDuration: Duration.zero,
                              ),
                            );
                          },
                          child: const Text('Submit'))
                      : const Text(
                          'Next',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: mPrimaryColor,
                          ),
                        )),
              SizedBox(
                width: 15,
              ),
              OutlinedButton(
                  onPressed: onStepCancel,
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0))),
                  ),
                  child: const Text(
                    'Go back',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: mPrimaryColor,
                    ),
                  )),
            ],
          );
        },
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
            SizedBox(
              height: 15,
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
            SizedBox(
              height: 15,
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
            SizedBox(
              height: 15,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'City'),
            ),
            SizedBox(
              height: 15,
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
              decoration: InputDecoration(labelText: 'Religion'),
            ),
            SizedBox(
              height: 15,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'height'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(
              height: 15,
            ),
            LanguagePickerDropdown(
                initialValue: Languages.english,
                onValuePicked: (Language language) {
                  lan = language.name;
                }),
            SizedBox(
              height: 15,
            ),
            DropdownButton<String>(
              value: _hob,
              isExpanded: true,
              style: TextStyle(color: Colors.black),
              items: <String>[
                'Music',
                'Sport',
                'Reading',
                'Gaming',
                'Art / Drawing / Painting ',
                'Watch TV',
                'Fitness',
                'Cooking',
                'Singing',
                'Dancing',
                'Gambling',
                'Swimming',
                'Writing ',
                'Traveling ',
              ].map<DropdownMenuItem<String>>((String hob) {
                return DropdownMenuItem<String>(
                  value: hob,
                  child: Text(hob),
                );
              }).toList(),
              hint: Text(
                "Hobbies",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w300),
              ),
              onChanged: (value) {
                setState(() {
                  _hob = value!;
                });
              },
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
            DropdownButton<String>(
              value: _edu,
              isExpanded: true,
              style: TextStyle(color: Colors.black),
              items: <String>[
                'Preschool',
                'Primary School',
                'Middle School',
                'Highschool',
                'Undergraduate school',
                'Graduate school',
                'Doctorate',
                'Dipilma',
                'Masters',
              ].map<DropdownMenuItem<String>>((String edu) {
                return DropdownMenuItem<String>(
                  value: edu,
                  child: Text(edu),
                );
              }).toList(),
              hint: Text(
                "Educaition",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w300),
              ),
              onChanged: (value) {
                setState(() {
                  _edu = value!;
                });
              },
            ),
            SizedBox(
              height: 15,
            ),
            DropdownButton<String>(
              value: _emp,
              isExpanded: true,
              style: TextStyle(color: Colors.black),
              items: <String>[
                'Employed',
                'Self-employed',
                'Out of wor',
                'Homemaker',
                'Student',
                'Retired',
                'Unable to work',
              ].map<DropdownMenuItem<String>>((String emp) {
                return DropdownMenuItem<String>(
                  value: emp,
                  child: Text(emp),
                );
              }).toList(),
              hint: Text(
                "Employment",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w300),
              ),
              onChanged: (value) {
                setState(() {
                  _emp = value!;
                });
              },
            ),
            SizedBox(
              height: 15,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Occupation'),
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
              decoration: InputDecoration(labelText: 'Location preference'),
            ),
            SizedBox(
              height: 15,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Natinality preference'),
            ),
            SizedBox(
              height: 15,
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
                "Gender preference",
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
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 228.0),
              child: const Text('Age preference'),
            ),
            SizedBox(
              height: 5,
            ),
            RangeSlider(
              values: _currentRangeValues,
              min: 0,
              max: 100,
              divisions: 10,
              labels: RangeLabels(
                _currentRangeValues.start.round().toString(),
                _currentRangeValues.end.round().toString(),
              ),
              onChanged: (RangeValues values) {
                setState(() {
                  _currentRangeValues = values;
                });
              },
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
