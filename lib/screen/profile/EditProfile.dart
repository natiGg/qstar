import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';
import 'package:image_picker/image_picker.dart';
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
  List<XFile>? _imageFileList;

  set _imageFile(XFile? value) {
    _imageFileList = value == null ? null : [value];
  }

  dynamic _pickImageError;
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
  var _items;
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
  var body;
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
    editprofileController.birthdayControl = _dateController;

    _dateController.text = DateFormat.yMd().format(DateTime.now());

    _timeController.text = formatDate(
        DateTime(2019, 08, 1, DateTime.now().hour, DateTime.now().minute),
        [hh, ':', nn, " ", am]).toString();

    _fetchUser();
    super.initState();
  }

  void _fetchUser() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('user');

    print(token);
    if (token != null) {
      print(token.toString());
      body = json.decode(token);
      print(body["id"]);
      editprofileController.fetchProfile(body["id"]);
         _items = editprofileController.suggested.hobbies.toList()
      .map((animal) => MultiSelectItem<Animal>(animal, animal.name))
      .toList();
    }
  }

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
          title: Container(
            width: 100,
            child: const Text(
              "Edit Profile",
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
                  key: editprofileController.EditProf,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Container(
                    padding: EdgeInsets.only(left: 16, top: 25, right: 16),
                    child: GestureDetector(
                        onTap: () {
                          FocusScope.of(context).unfocus();
                        },
                        child: ListView(
                          children: [
                            GestureDetector(
                              onTap: () {
                                _showPicker(context);
                              },
                              child: CircleAvatar(
                                radius: 40,
                                backgroundColor: mPrimaryColor,
                                child: _imageFileList != null
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(40),
                                        child: Image.file(
                                            File(_imageFileList![0].path),
                                            width: 70,
                                            height: 70,
                                            fit: BoxFit.cover),
                                      )
                                    : Container(
                                        decoration: BoxDecoration(
                                            color: Colors.grey[200],
                                            borderRadius:
                                                BorderRadius.circular(50)),
                                        width: 100,
                                        height: 100,
                                        child: Icon(
                                          Icons.camera_alt,
                                          color: Colors.grey[800],
                                        ),
                                      ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            SizedBox(height: 24),
                            TextFieldWidget(
                              label: 'Name',
                              controller: editprofileController.nameControl,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Name",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                const SizedBox(height: 8),
                                TextFormField(
                                  controller: editprofileController.nameControl,
                                  decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: mPrimaryColor, width: 2.0),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.white, width: 2.0),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  onSaved: (value) {
                                    editprofileController.name =
                                        value.toString();
                                  },
                                  validator: (value) {
                                    return editprofileController
                                        .validateName(value!);
                                  },
                                ),
                              ],
                            ),
                            SizedBox(height: 24),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Bio",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                const SizedBox(height: 8),
                                TextFormField(
                                  controller: editprofileController.bioControl,
                                  decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: mPrimaryColor, width: 2.0),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.white, width: 2.0),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  onSaved: (value) {
                                    editprofileController.bio =
                                        value.toString();
                                  },
                                  validator: (value) {
                                    return editprofileController
                                        .validateBio(value!);
                                  },
                                ),
                              ],
                            ),
                            SizedBox(height: 24),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Username",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                const SizedBox(height: 8),
                                TextFormField(
                                  controller:
                                      editprofileController.unameControl,
                                  decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: mPrimaryColor, width: 2.0),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.white, width: 2.0),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  onSaved: (value) {
                                    editprofileController.uname =
                                        value.toString();
                                  },
                                  validator: (value) {
                                    return editprofileController
                                        .validateunName(value!);
                                  },
                                ),
                              ],
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
                                    editprofileController.birthdayControl =
                                        _dateController;
                                  },
                                  child: Container(
                                    width: _width! / 1.7,
                                    height: _height! / 9,
                                    margin: EdgeInsets.only(top: 30),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      border: Border.all(
                                          color: Colors.black, width: 0.0),
                                      borderRadius: BorderRadius.all(
                                          Radius.elliptical(20, 20)),
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
                                          contentPadding:
                                              EdgeInsets.only(top: 0.0)),
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
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "email",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                const SizedBox(height: 8),
                                TextFormField(
                                  controller:
                                      editprofileController.emailControl,
                                  decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: mPrimaryColor, width: 2.0),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.white, width: 2.0),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  onSaved: (value) {
                                    editprofileController.email =
                                        value.toString();
                                  },
                                  validator: (value) {
                                    return editprofileController
                                        .validateEmail(value!);
                                  },
                                ),
                              ],
                            ),
                            SizedBox(height: 30),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Password",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                const SizedBox(height: 8),
                                TextFormField(
                                  controller: editprofileController.passControl,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: mPrimaryColor, width: 2.0),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.white, width: 2.0),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  onSaved: (value) {
                                    editprofileController.pass =
                                        value.toString();
                                  },
                                  validator: (value) {
                                    return editprofileController
                                        .validatePass(value!);
                                  },
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "new Password",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                const SizedBox(height: 8),
                                TextFormField(
                                  controller: editprofileController.passControl,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: mPrimaryColor, width: 2.0),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.white, width: 2.0),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  onSaved: (value) {
                                    editprofileController.pass =
                                        value.toString();
                                  },
                                  validator: (value) {
                                    return editprofileController
                                        .validatePass(value!);
                                  },
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Confirm new Password",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                const SizedBox(height: 8),
                                TextFormField(
                                  controller: editprofileController.passControl,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: mPrimaryColor, width: 2.0),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.white, width: 2.0),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  onSaved: (value) {
                                    editprofileController.pass =
                                        value.toString();
                                  },
                                  validator: (value) {
                                    return editprofileController
                                        .validatePass(value!);
                                  },
                                ),
                              ],
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
                                    unselectedColor:
                                        mPrimaryColor.withOpacity(.08),
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
                                          _tobeSent
                                              .add("${item.name.toString()}"));

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

                                        print(
                                            'removed: ${_selectedItems2.toString()}');
                                        _selectedItems2.forEach((item) =>
                                            _tobeSent.add(
                                                "${item.name.toString()}"));
                                      },
                                    ),
                                  ),
                                  _selectedItems2 == null ||
                                          _selectedItems2.isEmpty
                                      ? MultiSelectChipDisplay(
                                          onTap: (item) {
                                            setState(() {
                                              _selectedItems3.remove(item);
                                              print(
                                                  'removed below: ${_selectedItems3.toString()}');
                                            });
                                            _multiSelectKey.currentState!
                                                .validate();
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
                                  onPressed: () {
                                    editprofileController.editProf(body["id"]);
                                    print(editprofileController.isLoading);
                                    editprofileController.isLoading==true?Center(child: CircularProgressIndicator()):_showMessage();
                                        },
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0))),
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
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0))),
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
                ),
            onLoading: Center(
              child: CircularProgressIndicator(),
            ),
          
            onEmpty: Text("Can't fetch data"),
            onError: (error) => Center(child: Text(error.toString()))));
  }

  final ImagePicker _picker = ImagePicker();
  ImagePicker picker = ImagePicker();
  _imgFromCamera() async {
    try {
      final pickedFile = await _picker.pickImage(
        source: ImageSource.camera,
      );
      setState(() {
        _imageFile = pickedFile;
      });
    } catch (e) {
      setState(() {
        _pickImageError = e;
      });
    }
  }

  _imgFromGallery() async {
    try {
      final pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
      );
      setState(() {
        _imageFile = pickedFile;
      });
    } catch (e) {
      setState(() {
        _pickImageError = e;
      });
    }
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
  void _showMessage()
  {
     showDialog(
        context: context,
        builder: (context) => new AlertDialog(
                                            title: new Text('info'),
                                            content: new Text(json.decode(editprofileController.edited)["message"]),
                                            actions: <Widget>[
                                              new FlatButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop(true);
                                                
                                                },
                                                child: new Text('ok'),
                                              ),
                                            ],
                                          
                                     
       )  );
  }
}
