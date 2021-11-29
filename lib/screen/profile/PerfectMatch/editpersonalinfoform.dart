// ignore_for_file: unused_field, prefer_const_constructors

import 'dart:io';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_icons/flutter_icons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:language_picker/language_picker.dart';
import 'package:language_picker/languages.dart';
import 'package:language_picker/languages.g.dart';
import 'package:qstar/controllers/editprofilecontroller.dart';
import 'package:qstar/controllers/hobbiescontroller.dart';
import 'package:qstar/controllers/perfectmatchcontroller.dart';
import 'package:qstar/screen/profile/usernamedit.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:qstar/constant.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'dart:convert';
import 'dart:ui';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:qstar/screen/register/model/hobbies.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditPersonalInfo extends StatefulWidget {
  const EditPersonalInfo({Key? key}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditPersonalInfo> {
  String? lan = "Language";
  PerfectMatchController pfcontroller = Get.find();
  var isLastStep;

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    _fetchUser();
    super.initState();
  }

  var body;
  void _fetchUser() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('user');

    if (token != null) {
      var body = json.decode(token);
      pfcontroller.fetchPf();
    }
  }

  List<XFile>? _imageFileList;

  @override
  void deactivate() {
    EasyLoading.dismiss();
    super.deactivate();
  }

  final PerfectMatchController editprofileController =
      Get.put(PerfectMatchController());
  HobbiesController hobbiesController = Get.put(HobbiesController());
  // ignore: prefer_typing_uninitialized_variables
  var _items;
  //List<Animal> _selectedAnimals = [];
  List<Hobbies> _selectedItems2 = [];
  final List<String> _tobeSent = [];
  List<Hobbies> _selectedItems3 = [];
  static final List<Hobbies> _initial = [];

  String Preligion = "Hobbies";

  double? _height;
  double? _width;
  final _formKey = GlobalKey<FormState>();
  late String _setTime, _setDate;
  bool isLoading = false;
  late String _hour, _minute, _time;

  late String dateTime;

  DateTime selectedDate = DateTime.now();

  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);

  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  var user;

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leadingWidth: 40,
          backgroundColor: Colors.white,
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              icon: const Icon(Icons.arrow_back),
              color: mPrimaryColor),
          title: SizedBox(
            child: const Text(
              "Edit Perfect Match Form",
              style: TextStyle(
                color: mPrimaryColor,
                fontSize: 23,
                fontFamily: 'font1',
              ),
            ),
          ),
        ),
        body: editprofileController.obx(
            (editForm) => Form(
                  key: pfcontroller.Form,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Container(
                    padding: EdgeInsets.only(left: 16, top: 25, right: 16),
                    child: GestureDetector(
                        onTap: () {
                          FocusScope.of(context).unfocus();
                        },
                        child: ListView(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            SizedBox(height: 24),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: const [
                                Text(
                                  "Genral Information",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            TextFormField(
                              controller: pfcontroller.fullname,
                              decoration:
                                  const InputDecoration(labelText: 'Full name'),
                              validator: (value) {
                                return pfcontroller.validateName(value!);
                              },
                            ),
                            SizedBox(height: 24),
                            const SizedBox(height: 8),
                            // DropdownButtonFormField<String>(
                            //   decoration:
                            //       const InputDecoration(labelText: 'Gender'),
                            //   value: pfcontroller.gender,
                            //   isExpanded: true,
                            //   style: const TextStyle(color: Colors.black),
                            //   items: <String>[
                            //     'male',
                            //     'female',
                            //   ].map<DropdownMenuItem<String>>((String value) {
                            //     return DropdownMenuItem<String>(
                            //       value: value,
                            //       child: Text(value),
                            //     );
                            //   }).toList(),
                            //   hint: Text(
                            //     pfcontroller.gender,
                            //     style: TextStyle(
                            //         color: Colors.black,
                            //         fontSize: 16,
                            //         fontWeight: FontWeight.w300),
                            //   ),
                            //   onChanged: (value) {
                            //     setState(() {
                            //       pfcontroller.gender = value!;
                            //     });
                            //   },
                            // ),

                            SizedBox(height: 24),
                            const Text(
                              'Country',
                              style: TextStyle(color: Colors.black38),
                            ),
                            GestureDetector(
                              onTap: () {
                                showCountryPicker(
                                  context: context,
                                  countryListTheme: CountryListThemeData(
                                    flagSize: 25,

                                    backgroundColor: Colors.white,
                                    textStyle: const TextStyle(
                                        fontSize: 16, color: Colors.blueGrey),
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
                                          color: const Color(0xFF8C98A8)
                                              .withOpacity(0.2),
                                        ),
                                      ),
                                    ),
                                  ),
                                  onSelect: (Country country) => setState(() {
                                    pfcontroller.country.value =
                                        country.displayName;
                                  }),
                                );
                              },
                              child: AbsorbPointer(
                                child: TextFormField(
                                  decoration: InputDecoration(
                                      labelText: pfcontroller.country.value
                                                  .toString() ==
                                              "Counrty"
                                          ? pfcontroller.country.value =
                                              pfcontroller.fetched.country
                                          : pfcontroller.country.value
                                              .toString()),
                                ),
                              ),
                            ),
                            SizedBox(height: 24),
                            TextFormField(
                              controller: pfcontroller.city,
                              decoration:
                                  const InputDecoration(labelText: 'City'),
                              validator: (value) {
                                return pfcontroller.validatecity(value!);
                              },
                            ),
                            const SizedBox(height: 30),
                            TextFormField(
                              controller: pfcontroller.phone,
                              decoration: const InputDecoration(
                                  labelText: 'Phone Number'),
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                return pfcontroller.validatephone(value!);
                              },
                            ),
                            SizedBox(
                              height: 35,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: const [
                                Text(
                                  "Personal Details",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ],
                            ),
                            TextFormField(
                              controller: pfcontroller.religion,
                              decoration:
                                  const InputDecoration(labelText: 'Religion'),
                              validator: (value) {
                                return pfcontroller.validatereligion(value!);
                              },
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            TextFormField(
                              controller: pfcontroller.height,
                              decoration:
                                  const InputDecoration(labelText: 'height'),
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

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: const [
                                Text(
                                  "BackGround Information",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            const Text(
                              'Education',
                              style: TextStyle(color: Colors.black38),
                            ),
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
                                'Degree',
                              ].map<DropdownMenuItem<String>>((String edu) {
                                return DropdownMenuItem<String>(
                                  value: edu,
                                  child: Text(edu),
                                );
                              }).toList(),
                              hint: Text(
                                pfcontroller.fetched.education,
                                style: const TextStyle(
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

                            const Text(
                              'employment',
                              style: TextStyle(color: Colors.black38),
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
                              hint: Text(
                                pfcontroller.fetched.employment,
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
                              decoration: const InputDecoration(
                                  labelText: 'occupation'),
                              validator: (value) {
                                return pfcontroller.validateOccupation(value!);
                              },
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: const [
                                Text(
                                  "Match Perference",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            const Text(
                              'Match Preference country',
                              style: TextStyle(color: Colors.black38),
                            ),
                            GestureDetector(
                              onTap: () {
                                showCountryPicker(
                                  context: context,
                                  countryListTheme: CountryListThemeData(
                                    flagSize: 25,

                                    backgroundColor: Colors.white,
                                    textStyle: const TextStyle(
                                        fontSize: 16, color: Colors.blueGrey),
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
                                          color: const Color(0xFF8C98A8)
                                              .withOpacity(0.2),
                                        ),
                                      ),
                                    ),
                                  ),
                                  onSelect: (Country country) => setState(() {
                                    pfcontroller.matchcountry.value =
                                        country.displayName;
                                  }),
                                );
                              },
                              child: AbsorbPointer(
                                child: TextFormField(
                                  decoration: InputDecoration(
                                      labelText: pfcontroller.matchcountry.value
                                                  .toString() ==
                                              "Counrty"
                                          ? pfcontroller.matchcountry.value =
                                              pfcontroller.fetched.country
                                          : pfcontroller.matchcountry.value
                                              .toString()),
                                ),
                              ),
                            ),

                            const SizedBox(
                              height: 20,
                            ),

                            const Text(
                              'Match Preference Gender',
                              style: TextStyle(color: Colors.black38),
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
                              hint: Text(
                                pfcontroller.macthgender,
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
                            Text(
                              'Age preference',
                              style: TextStyle(color: Colors.black38),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(pfcontroller.agestart.toString() +
                                " to " +
                                pfcontroller.ageend.toString()),
                            const SizedBox(
                              height: 15,
                            ),
                            RangeSlider(
                              values: pfcontroller.currentRangeValues,
                              min: 18,
                              max: 100,
                              divisions: 10,
                              labels: RangeLabels(
                                // pfcontroller.agestart.toString(),
                                // pfcontroller.ageend.toString(),
                                pfcontroller.currentRangeValues.start
                                    .round()
                                    .toString(),
                                pfcontroller.currentRangeValues.end
                                    .round()
                                    .toString(),
                              ),
                              onChanged: (RangeValues values) {
                                setState(() {
                                  pfcontroller.currentRangeValues = values;
                                });
                              },
                            ),
                            const SizedBox(
                              height: 35,
                            ),
                            // ignore: deprecated_member_use
                            RaisedButton.icon(
                              onPressed: () {
                                Get.delete<PerfectMatchController>();
                                editprofileController.seteditInfo();
                              },
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0))),
                              label: const Text(
                                'Update Profile',
                                style: TextStyle(color: Colors.white),
                              ),
                              icon: const Icon(
                                Icons.update,
                                color: Colors.white,
                              ),
                              textColor: mPrimaryColor,
                              splashColor: Colors.white,
                              color: mPrimaryColor,
                            ),
                          ],
                        )),
                  ),
                ),
            onLoading: Center(child: loadData()),
            onEmpty: const Text("Can't fetch data"),
            onError: (error) => Center(child: Text(error.toString()))));
  }

  final ImagePicker _picker = ImagePicker();
  ImagePicker picker = ImagePicker();

  loadData() {
    // Here you can write your code for open new view
    EasyLoading.show();
    Future.delayed(const Duration(milliseconds: 500), () {
// Here you can write your code

      EasyLoading.dismiss();
    });
  }
}
