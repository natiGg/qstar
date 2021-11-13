import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:language_picker/languages.dart';
import 'package:language_picker/languages.g.dart';
import 'package:qstar/constant.dart';

import 'package:country_picker/country_picker.dart';
import 'package:language_picker/language_picker.dart';
import 'package:qstar/screen/profile/PerfectMatch/profile.dart';

class PersonalInfo extends StatefulWidget {
  const PersonalInfo({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<PersonalInfo> {
  int currentStep = 0;
  String? _gender, _hob, _edu, _emp;
  String? list2 = "Counrty";
  String? lan = "Language";
  RangeValues _currentRangeValues = const RangeValues(18, 65);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: mPrimaryColor,
            onPressed: () {
              Navigator.pushNamed(context, '/home');
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
      body: Theme(
        data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
          primary: mPrimaryColor,
        )),
        child: Stepper(
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
                              _scaffoldKey.currentState!
                                  // ignore: deprecated_member_use
                                  .showSnackBar(SnackBar(
                                duration: const Duration(seconds: 4),
                                content: Row(
                                  children: const <Widget>[
                                    CircularProgressIndicator(),
                                    Text("    Loading...")
                                  ],
                                ),
                              ));
                              _ondelay();
                            },
                            child: const Text('Submit'))
                        : const Text(
                            'Next',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: mPrimaryColor,
                            ),
                          )),
                const SizedBox(
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
      ),
    );
  }

  List<Step> getSteps() {
    return [
      Step(
        title: const Text('Genral Info'),
        content: Column(
          children: <Widget>[
            TextFormField(
              decoration: const InputDecoration(labelText: 'Full name'),
            ),
            const SizedBox(
              height: 15,
            ),
            DropdownButton<String>(
              value: _gender,
              isExpanded: true,
              style: const TextStyle(color: Colors.black),
              items: <String>[
                'Male',
                'Female',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              hint: const Text(
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
            const SizedBox(
              height: 15,
            ),
            GestureDetector(
              onTap: () {
                showCountryPicker(
                  context: context,
                  countryListTheme: CountryListThemeData(
                    flagSize: 25,
                    backgroundColor: Colors.white,
                    textStyle:
                        const TextStyle(fontSize: 16, color: Colors.blueGrey),
                    //Optional. Sets the border radius for the bottomsheet.
                    borderRadius: const BorderRadius.only(
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
                    list2 = country.displayName;
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
            const SizedBox(
              height: 15,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'City'),
            ),
            const SizedBox(
              height: 15,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Phone Number'),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        isActive: currentStep >= 0,
        state: currentStep == 0 ? StepState.editing : StepState.complete,
      ),
      Step(
        title: const Text('Personal Details'),
        content: Column(
          children: <Widget>[
            TextFormField(
              decoration: const InputDecoration(labelText: 'Religion'),
            ),
            const SizedBox(
              height: 15,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'height'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(
              height: 15,
            ),
            LanguagePickerDropdown(
                initialValue: Languages.english,
                onValuePicked: (Language language) {
                  lan = language.name;
                }),
            const SizedBox(
              height: 15,
            ),
            DropdownButton<String>(
              value: _hob,
              isExpanded: true,
              style: const TextStyle(color: Colors.black),
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
              hint: const Text(
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
        title: const Text("BackGround Info"),
        content: Column(
          children: <Widget>[
            DropdownButton<String>(
              value: _edu,
              isExpanded: true,
              style: const TextStyle(color: Colors.black),
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
              hint: const Text(
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
            const SizedBox(
              height: 15,
            ),
            DropdownButton<String>(
              value: _emp,
              isExpanded: true,
              style: const TextStyle(color: Colors.black),
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
              hint: const Text(
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
            const SizedBox(
              height: 15,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Occupation'),
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
        title: const Text("Match Perference"),
        content: Column(
          children: <Widget>[
            TextFormField(
              decoration:
                  const InputDecoration(labelText: 'Location preference'),
            ),
            const SizedBox(
              height: 15,
            ),
            TextFormField(
              decoration:
                  const InputDecoration(labelText: 'Natinality preference'),
            ),
            const SizedBox(
              height: 15,
            ),
            DropdownButton<String>(
              value: _gender,
              isExpanded: true,
              style: const TextStyle(color: Colors.black),
              items: <String>[
                'Male',
                'Female',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              hint: const Text(
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
            const SizedBox(
              height: 15,
            ),
            const Padding(
              padding: EdgeInsets.only(right: 208.0),
              child: Text('Age preference'),
            ),
            const SizedBox(
              height: 5,
            ),
            RangeSlider(
              values: _currentRangeValues,
              min: 18,
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

  _ondelay() {
    Future.delayed(const Duration(seconds: 3), () {
      // Navigator.popUntil(context, (route) {
      //   return count++ == 2;
      // });
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const ProfileImageAppbarRoute()),
      );
    });
  }
}
