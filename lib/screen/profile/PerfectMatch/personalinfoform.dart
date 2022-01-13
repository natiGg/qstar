// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:qstar/constant.dart';

import 'package:country_picker/country_picker.dart';

import 'package:qstar/controllers/perfectmatchcontroller.dart';

class PersonalInfo extends StatefulWidget {
  const PersonalInfo({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<PersonalInfo> {
  String? lan = "Language";
  PerfectMatchController pfcontroller = Get.put(PerfectMatchController());
  var isLastStep;

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
          key: Key(Random.secure().nextDouble().toString()),
          controlsBuilder: (BuildContext context,
              {VoidCallback? onStepContinue,
              VoidCallback? onStepCancel,
              VoidCallback? onStpeFinish}) {
            isLastStep =
                pfcontroller.currentStep.value == getSteps().length - 1;
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
                            onTap: () async {
                              Get.delete<PerfectMatchController>();
                              pfcontroller.setInfo();
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //       builder: (context) =>
                              //           const ProfileImageAppbarRoute()),
                              // );
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
          currentStep: pfcontroller.currentStep.value,
          onStepCancel: () {
            pfcontroller.currentStep.value > 0
                ? setState(() => pfcontroller.currentStep.value -= 1)
                : null;
          },
          onStepContinue: () {
            setState(() {
              pfcontroller.currentStep.value < 3
                  ? pfcontroller.currentStep.value
                  : null;
            });

            if (pfcontroller.currentStep.value == 0) {
              pfcontroller.create();
            }

            if (pfcontroller.currentStep.value == 1) {
              pfcontroller.create2();
            }

            if (pfcontroller.currentStep.value == 2) {
              pfcontroller.create3();
            }
            if (pfcontroller.currentStep.value == 3) {
              pfcontroller.create4();
            }

            // if (pfcontroller.currentStep.value == 2) {
            //   pfcontroller.create();
            // }
          },
        ),
      ),
    );
  }

  List<Step> getSteps() {
    return [
      Step(
        title: const Text('Genral Info'),
        content: Form(
          key: pfcontroller.Form,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: pfcontroller.fullname,
                decoration: const InputDecoration(labelText: 'Full name'),
                validator: (value) {
                  return pfcontroller.validateName(value!);
                },
              ),
              const SizedBox(
                height: 15,
              ),
              // DropdownButton<String>(
              //   value: pfcontroller.gender.value,
              //   isExpanded: true,
              //   style: const TextStyle(color: Colors.black),
              //   items: <String>[
              //     'Male',
              //     'Female',
              //   ].map<DropdownMenuItem<String>>((String value) {
              //     return DropdownMenuItem<String>(
              //       value: value,
              //       child: Text(value),
              //     );
              //   }).toList(),
              //   hint: const Text(
              //     "Gender",
              //     style: TextStyle(
              //         color: Colors.black,
              //         fontSize: 16,
              //         fontWeight: FontWeight.w300),
              //   ),
              //   onChanged: (value) {
              //     setState(() {
              //       pfcontroller.gender.value = value!;
              //     });
              //   },
              // ),
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
                      pfcontroller.country.value = country.displayName;
                    }),
                  );
                },
                child: AbsorbPointer(
                  child: TextFormField(
                    decoration: InputDecoration(
                        labelText:
                            pfcontroller.country.value.toString() == "Counrty"
                                ? pfcontroller.country.value = "Counrty"
                                : pfcontroller.country.value.toString()),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: pfcontroller.city,
                decoration: const InputDecoration(labelText: 'City'),
                validator: (value) {
                  return pfcontroller.validateName(value!);
                },
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: pfcontroller.phone,
                decoration: const InputDecoration(labelText: 'Phone Number'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  return pfcontroller.validatephone(value!);
                },
              ),
            ],
          ),
        ),
        isActive: pfcontroller.currentStep.value >= 0,
        state: pfcontroller.currentStep.value == 0
            ? StepState.editing
            : StepState.complete,
      ),
      Step(
        title: const Text('Personal Details'),
        content: Form(
          key: pfcontroller.Form2,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: pfcontroller.religion,
                decoration: const InputDecoration(labelText: 'Religion'),
                validator: (value) {
                  return pfcontroller.validatereligion(value!);
                },
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: pfcontroller.height,
                decoration: const InputDecoration(labelText: 'height'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  return pfcontroller.validateheight(value!);
                },
              ),
              const SizedBox(
                height: 15,
              ),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
        isActive: pfcontroller.currentStep.value >= 1,
        state: pfcontroller.currentStep.value == 1
            ? StepState.editing
            : pfcontroller.currentStep.value < 1
                ? StepState.disabled
                : StepState.complete,
      ),
      Step(
        title: const Text("BackGround Info"),
        content: Form(
          key: pfcontroller.Form3,
          child: Column(
            children: <Widget>[
              DropdownButton<String>(
                value: pfcontroller.edu,
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
                    pfcontroller.edu = value!;
                  });
                },
              ),
              const SizedBox(
                height: 15,
              ),
              DropdownButton<String>(
                value: pfcontroller.emp,
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
                    pfcontroller.emp = value!;
                  });
                },
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: pfcontroller.occ,
                decoration: const InputDecoration(labelText: 'Occupation'),
                validator: (value) {
                  return pfcontroller.validateOccupation(value!);
                },
              ),
            ],
          ),
        ),
        isActive: pfcontroller.currentStep.value >= 2,
        state: pfcontroller.currentStep.value == 2
            ? StepState.editing
            : pfcontroller.currentStep.value < 2
                ? StepState.disabled
                : StepState.complete,
      ),
      Step(
        title: const Text("Match Perference"),
        content: Form(
          key: pfcontroller.Form4,
          child: Column(
            children: <Widget>[
              TextFormField(
                  controller: pfcontroller.location,
                  decoration: const InputDecoration(
                      labelText: 'enter your match location Preference'),
                  validator: (value) {
                    return pfcontroller.validatelocation(value!);
                  }),
              const SizedBox(
                height: 15,
              ),
              const SizedBox(
                height: 15,
              ),
              DropdownButton<String>(
                value: pfcontroller.macthgender,
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
                    pfcontroller.macthgender = value!;
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
                values: pfcontroller.currentRangeValues,
                min: 18,
                max: 100,
                divisions: 10,
                labels: RangeLabels(
                  pfcontroller.currentRangeValues.start.round().toString(),
                  pfcontroller.currentRangeValues.end.round().toString(),
                ),
                onChanged: (RangeValues values) {
                  setState(() {
                    pfcontroller.currentRangeValues = values;
                  });
                },
              ),
            ],
          ),
        ),
        isActive: pfcontroller.currentStep.value >= 3,
        state: pfcontroller.currentStep.value == 3
            ? StepState.editing
            : pfcontroller.currentStep.value < 3
                ? StepState.disabled
                : StepState.complete,
      ),
    ];
  }
}