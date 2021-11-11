import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';
import 'package:qstar/controllers/editprofilecontroller.dart';
import 'package:qstar/screen/feed/model/user.dart';
import 'package:qstar/screen/profile/widgets/textfield_widget.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:qstar/constant.dart';
import 'package:flutter/gestures.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'dart:convert';
import 'dart:ui';

import 'package:qstar/screen/register/phonevarification.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Animal {
  final int id;
  final String name;

  Animal({
    required this.id,
    required this.name,
  });
}

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  static final List<Animal> _animals = [
    Animal(id: 1, name: "Book clubs"),
    Animal(id: 2, name: "Running clubs"),
    Animal(id: 3, name: "Volunteering"),
    Animal(id: 4, name: "Adult sports leagues"),
    Animal(id: 5, name: "Improv classes"),
    Animal(id: 6, name: "Bowling"),
    Animal(id: 7, name: "Golfing"),
    Animal(id: 8, name: "Board games"),
    Animal(id: 9, name: "Content creation"),
    Animal(id: 10, name: "Yoga"),
    Animal(id: 11, name: "Cycling"),
    Animal(id: 12, name: "Video Games"),
    Animal(id: 13, name: "Fitness classes"),
    Animal(id: 14, name: "Group travel"),
    Animal(id: 15, name: "Watch TV"),
    Animal(id: 16, name: "Reading"),
    Animal(id: 17, name: "Fitness"),
    Animal(id: 18, name: "Journaling"),
    Animal(id: 19, name: "Gambling"),
    Animal(id: 20, name: "Yoga"),
  ];
  final EditprofileController editprofileController =
      Get.put(EditprofileController());
  final _items = _animals
      .map((animal) => MultiSelectItem<Animal>(animal, animal.name))
      .toList();
  //List<Animal> _selectedAnimals = [];
  List<Animal> _selectedItems2 = [];
  List<String> _tobeSent = [];
  List<Animal> _selectedItems3 = [];

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
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(1950),
        lastDate: DateTime(2022));
    if (picked != null) {
      setState(() {
        selectedDate = picked;
        _dateController.text = DateFormat.yMd().format(selectedDate);
      });
    }
  }

  final _multiSelectKey = GlobalKey<FormState>();
  @override
  void initState() {
    _dateController.text = DateFormat.yMd().format(DateTime.now());

    _timeController.text = formatDate(
        DateTime(2019, 08, 1, DateTime.now().hour, DateTime.now().minute),
        [hh, ':', nn, " ", am]).toString();
        setState(() {
                isLoading=true;
        });

    _fetchUser();
    super.initState();
  }

  void _fetchUser() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('user');

    print(token);
    if (token != null) {
      print(token.toString());
      var body = json.decode(token);
      print(body["id"]);
      editprofileController.fetchProfile(body["id"]);
      setState(() {
        isLoading = false;
      });

    }
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leadingWidth: 100,
        backgroundColor: Colors.white,
        leading: Container(
          padding: EdgeInsets.only(left: 20, top: 15),
          width: 100,
          child: Text(
            "User Name",
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
      body:  isLoading==false?Form(
        key: _multiSelectKey,
        child: Container(
          padding: EdgeInsets.only(left: 16, top: 25, right: 16),
          child: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: ListView(
                children: [
                  Center(
                    child: Stack(
                      children: [
                        Container(
                          width: 130,
                          height: 130,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 4,
                                  color: Theme.of(context)
                                      .scaffoldBackgroundColor),
                              boxShadow: [
                                BoxShadow(
                                    spreadRadius: 2,
                                    blurRadius: 10,
                                    color: Colors.black.withOpacity(0.1),
                                    offset: Offset(0, 10))
                              ],
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                    "https://images.pexels.com/photos/3307758/pexels-photo-3307758.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=250",
                                  ))),
                        ),
                        Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  width: 4,
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                ),
                                color: mPrimaryColor,
                              ),
                              child: Icon(
                                Icons.edit,
                                color: Colors.white,
                              ),
                            )),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(height: 24),
                  TextFieldWidget(
                    label: 'Name',
                    text: editprofileController.suggested.name,
                    onChanged: (name) {},
                  ),
                  SizedBox(height: 24),
                  TextFieldWidget(
                    label: 'Last Name',
                    text: editprofileController.suggested.name,
                    onChanged: (email) {},
                  ),
                  SizedBox(height: 24),
                  TextFieldWidget(
                    label: 'Username',
                    text: editprofileController.suggested.userName,
                    onChanged: (email) {},
                  ),
                  Column(
                    children: <Widget>[
                      SizedBox(height: 24),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Birthday",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          _selectDate(context);
                        },
                        child: Container(
                          width: _width! / 1.7,
                          height: _height! / 9,
                          margin: EdgeInsets.only(top: 30),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            border: Border.all(color: Colors.black, width: 0.0),
                            borderRadius:
                                BorderRadius.all(Radius.elliptical(20, 20)),
                          ),
                          child: TextFormField(
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'font1',
                            ),
                            textAlign: TextAlign.center,
                            enabled: false,
                            keyboardType: TextInputType.text,
                            controller: _dateController,
                            onSaved: (val) async {
                              _setDate = val!;
                            },
                            decoration: InputDecoration(
                                disabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide.none),
                                // labelText: 'Time',
                                contentPadding: EdgeInsets.only(top: 0.0)),
                            validator: (dateval) {
                              if (dateval!.isEmpty) {
                                return "Please put your birth date";
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24),
                  TextFieldWidget(
                    label: 'Email',
                    text:  editprofileController.suggested.email,
                    onChanged: (email) {},
                  ),
                  SizedBox(height: 30),
                  TextFieldWidget(
                    label: 'Password',
                    text: "*******",
                    onChanged: (email) {},
                  ),
                  SizedBox(height: 30),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white38,
                      border: Border.all(
                        color: mPrimaryColor,
                        width: 2,
                      ),
                    ),
                    child: Column(
                      children: <Widget>[
                        MultiSelectBottomSheetField<Animal>(
                          initialChildSize: 0.7,
                          maxChildSize: 0.95,
                          listType: MultiSelectListType.CHIP,
                          checkColor: Colors.pink,
                          selectedColor: mPrimaryColor,
                          selectedItemsTextStyle: TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                          ),
                          unselectedColor: mPrimaryColor.withOpacity(.08),
                          buttonIcon: Icon(
                            Icons.add,
                            color: Colors.pinkAccent,
                          ),
                          searchHintStyle: TextStyle(
                            fontSize: 20,
                          ),
                          searchable: true,
                          buttonText: Text(
                            '$Preligion', //"????",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 5,
                          ),
                          title: Text(
                            "Hobbies",
                            style: TextStyle(
                              fontSize: 25,
                              color: Colors.pink,
                            ),
                          ),
                          items: _items,
                          onConfirm: (values) {
                            setState(() {
                              _selectedItems2 = values;
                            });
                            print('selected : ${_selectedItems2}');
                            _selectedItems2.forEach((item) =>
                                _tobeSent.add("${item.name.toString()}"));

                            /*senduserdata(
                        'partnerreligion', '${_selectedItems2.toString()}');*/
                          },
                          chipDisplay: MultiSelectChipDisplay(
                            textStyle: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                            ),
                            onTap: (value) {
                              setState(() {
                                _selectedItems2.remove(value);
                                _tobeSent.remove(value.toString());
                              });

                              print('removed: ${_selectedItems2.toString()}');
                              _selectedItems2.forEach((item) =>
                                  _tobeSent.add("${item.name.toString()}"));
                            },
                          ),
                        ),
                        _selectedItems2 == null || _selectedItems2.isEmpty
                            ? MultiSelectChipDisplay(
                                onTap: (item) {
                                  setState(() {
                                    _selectedItems3.remove(item);
                                    print(
                                        'removed below: ${_selectedItems3.toString()}');
                                  });
                                  _multiSelectKey.currentState!.validate();
                                },
                              )
                            : MultiSelectChipDisplay(),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 35,
                      ),
                      // ignore: deprecated_member_use
                      RaisedButton.icon(
                        onPressed: () {},
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        label: Text(
                          'Update Profile',
                          style: TextStyle(color: Colors.white),
                        ),
                        icon: Icon(
                          Icons.update,
                          color: Colors.white,
                        ),
                        textColor: mPrimaryColor,
                        splashColor: Colors.white,
                        color: mPrimaryColor,
                      ),
                      // ignore: deprecated_member_use
                      RaisedButton.icon(
                        onPressed: () {},
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        label: Text(
                          'Cancel  ',
                          style: TextStyle(color: mPrimaryColor),
                        ),
                        icon: Icon(
                          Icons.cancel,
                          color: mPrimaryColor,
                        ),
                        textColor: mPrimaryColor,
                        splashColor: mPrimaryColor,
                        color: Colors.white,
                      ),
                      SizedBox(
                        height: 35,
                      ),
                    ],
                  ),
                ],
              )),
        ),
      ):Center(
        child: 
 CircularProgressIndicator(),
      ),
    );
  }
}
