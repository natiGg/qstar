// ignore_for_file: unused_field, prefer_const_constructors, prefer_typing_uninitialized_variables

import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_icons/flutter_icons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qstar/controllers/editprofilecontroller.dart';
import 'package:qstar/controllers/hobbiescontroller.dart';
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

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  List<XFile>? _imageFileList;

  set _imageFile(XFile? value) {
    _imageFileList = value == null ? null : [value];
  }

  @override
  void deactivate() {
    EasyLoading.dismiss();
    super.deactivate();
  }

  final EditprofileController editprofileController =
      Get.put(EditprofileController());
  HobbiesController hobbiesController = Get.put(HobbiesController());

  var _items;
  //List<Animal> _selectedAnimals = [];
  List<Hobbies> _selectedItems2 = [];
  final List<String> _tobeSent = [];
  final List<Hobbies> _selectedItems3 = [];
  static final List<Hobbies> _initial = [];

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

    if (token != null) {
      body = json.decode(token);

      editprofileController.fetchProfile(body["id"]);
      editprofileController.fetchlinks(body["id"]);

      editprofileController.hobbyitems.forEach((element) {
        _initial.add(element);
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
          leadingWidth: 40,
          backgroundColor: Colors.white,
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              icon: const Icon(Icons.arrow_back),
              color: mPrimaryColor),
          title: SizedBox(
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
                                          color: mPrimaryColor, width: 12.0),
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
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Change Username",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17,
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        PageRouteBuilder(
                                          pageBuilder: (context, animation1,
                                                  animation2) =>
                                              unamedit(),
                                          transitionDuration: Duration.zero,
                                        ),
                                      );
                                    },
                                    child: Card(
                                      elevation: 1,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(left: 10),
                                            child: Text(
                                              editprofileController
                                                  .suggested.userName,
                                              style: TextStyle(fontSize: 16),
                                            ),
                                          ),
                                          IconButton(
                                              onPressed: () {},
                                              icon: const Icon(
                                                  FontAwesome.angle_right))
                                        ],
                                      ),
                                    ),
                                  )
                                ]),
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
                                      decoration: const InputDecoration(
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
                            const SizedBox(height: 30),
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
                                  MultiSelectBottomSheetField<Hobbies>(
                                    initialChildSize: 0.7,
                                    maxChildSize: 0.95,
                                    listType: MultiSelectListType.CHIP,
                                    checkColor: Colors.pink,
                                    selectedColor: mPrimaryColor,
                                    selectedItemsTextStyle: const TextStyle(
                                      fontSize: 25,
                                      color: Colors.white,
                                    ),
                                    unselectedColor:
                                        mPrimaryColor.withOpacity(.08),
                                    buttonIcon: const Icon(
                                      Icons.add,
                                      color: Colors.pinkAccent,
                                    ),
                                    searchHintStyle: const TextStyle(
                                      fontSize: 20,
                                    ),
                                    searchable: true,
                                    buttonText: Text(
                                      Preligion, //"????",
                                      style: const TextStyle(
                                        fontSize: 18,
                                        color: Colors.grey,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 5,
                                    ),
                                    title: const Text(
                                      "Hobbies",
                                      style: TextStyle(
                                        fontSize: 25,
                                        color: Colors.pink,
                                      ),
                                    ),
                                    items: hobbiesController.hobItem,
                                    onConfirm: (values) {
                                      setState(() {
                                        _selectedItems2 = values;
                                      });
                                      // ignore: avoid_print

                                      _selectedItems2.forEach((item) =>
                                          editprofileController.tobeSent
                                              .add("${item.name.toString()}"));
                                    },
                                    chipDisplay: MultiSelectChipDisplay(
                                      textStyle: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                      ),
                                      onTap: (value) {
                                        setState(() {
                                          _selectedItems2.remove(value);
                                          editprofileController.tobeSent
                                              .remove(value.toString());
                                        });

                                        _selectedItems2.forEach((item) =>
                                            editprofileController.tobeSent.add(
                                                "${item.name.toString()}"));
                                      },
                                    ),
                                  ),
                                  _selectedItems2 == null ||
                                          _selectedItems2.isEmpty
                                      ? MultiSelectChipDisplay(
                                          items: editprofileController.hobItem,
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
                            SizedBox(height: 24),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Youtube channel Link",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                const SizedBox(height: 8),
                                TextFormField(
                                  controller:
                                      editprofileController.youtubecontroller,
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
                                    editprofileController.link =
                                        value.toString();
                                  },
                                ),
                              ],
                            ),
                            SizedBox(height: 24),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Instagram  username",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                const SizedBox(height: 8),
                                TextFormField(
                                  controller:
                                      editprofileController.instacontroller,
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
                                    editprofileController.link =
                                        value.toString();
                                  },
                                ),
                              ],
                            ),
                            SizedBox(height: 24),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "TikTok  username",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                const SizedBox(height: 8),
                                TextFormField(
                                  controller:
                                      editprofileController.tiktokcontroller,
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
                                    editprofileController.link =
                                        value.toString();
                                  },
                                ),
                              ],
                            ),
                            SizedBox(height: 24),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "FaceBook  username",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                const SizedBox(height: 8),
                                TextFormField(
                                  controller:
                                      editprofileController.facebookcontroller,
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
                                    editprofileController.link =
                                        value.toString();
                                  },
                                ),
                              ],
                            ),
                            SizedBox(height: 24),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const SizedBox(
                                  height: 35,
                                ),
                                // ignore: deprecated_member_use
                                RaisedButton.icon(
                                  onPressed: () {
                                    editprofileController.editProf(body["id"]);
                                    // ignore: avoid_print
                                  },
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0))),
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
                                // ignore: deprecated_member_use

                                const SizedBox(
                                  height: 35,
                                ),
                              ],
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

  _imgFromCamera() async {
    try {
      final pickedFile = await _picker.pickImage(
        source: ImageSource.camera,
      );
      setState(() {
        _imageFile = pickedFile;
        File file = File(pickedFile!.path);

        editprofileController.image = file;
      });
    } catch (e) {
      setState(() {});
    }
  }

  _imgFromGallery() async {
    try {
      final pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
      );
      setState(() {
        _imageFile = pickedFile;
        File file = File(pickedFile!.path);

        editprofileController.image = file;
      });
    } catch (e) {
      setState(() {});
    }
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: Icon(Icons.photo_library),
                    title: Text('Photo Library'),
                    onTap: () {
                      _imgFromGallery();
                      Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: Icon(Icons.photo_camera),
                  title: Text('Camera'),
                  onTap: () {
                    _imgFromCamera();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }

  loadData() {
    // Here you can write your code for open new view
    EasyLoading.show();
    Future.delayed(const Duration(milliseconds: 500), () {
// Here you can write your code

      EasyLoading.dismiss();
    });
  }
}
