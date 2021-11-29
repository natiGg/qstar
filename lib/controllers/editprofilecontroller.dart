// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:qstar/constant.dart';
import 'package:qstar/screen/feed/model/user.dart';
import 'package:qstar/remote_services/service.dart';
import 'package:qstar/screen/register/model/hobbies.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:flutter/material.dart';

class EditprofileController extends GetxController with StateMixin {
  // ignore: non_constant_identifier_names
  final GlobalKey<FormState> EditProf = GlobalKey<FormState>();
  final GlobalKey<FormState> EditUname = GlobalKey<FormState>();
  late TextEditingController nameControl,
      unameControl,
      birthdayControl,
      emailControl,
      bioControl,
      passControl;
  var email = '';
  var name = '';
  var uname = '';
  var prevuname = '';
  var prevemail = '';
  var birthday = '';
  var bio = '';
  var pass = '';
  var isLoading = false.obs;
  var edited = "";
  // ignore: prefer_typing_uninitialized_variables
  var hobbies;
  // ignore: prefer_typing_uninitialized_variables
  var hobItem;
  // ignore: prefer_typing_uninitialized_variables
  var image;
  late String uid = "";
  var unamechecker, messages, errorMessages, emailchecker;
  late String unames = '', emailsInfo = '';
  List<Hobbies> hobbyitems = [];
  List<String> hobbiesSplit = [];
  List<String> tobeSent = [];

  // ignore: prefer_typing_uninitialized_variables
  var suggested;
  var suggestObjs = <User>[].obs;

  @override
  void onInit() {
    // ignore: todo
    // TODO: implement onInit
    // ignore: avoid_print
    print("controller initialized");
    nameControl = TextEditingController();
    birthdayControl = TextEditingController();
    unameControl = TextEditingController();
    bioControl = TextEditingController();
    passControl = TextEditingController();
    super.onInit();
  }

  void fetchProfile(var id) async {
    try {
      uid = id.toString();
      print(uid);
      suggested = await RemoteServices.fetchProfile(id);
      if (suggested.id != null) {
        nameControl.text = suggested.name;
        birthdayControl.text = suggested.date_of_birth;
        unameControl.text = suggested.userName;
        bioControl.text = suggested.bio;
        prevuname = suggested.userName;
        prevemail = suggested.email;

        hobbiesSplit = suggested.hobbies.toString().split(",");

        for (int i = 0; i < hobbiesSplit.length; i++) {
          Hobbies hobbies = Hobbies(id: i, name: hobbiesSplit[i].toString());
          hobbyitems.add(hobbies);
        }

        hobItem = hobbyitems
            .map((hobbies) => MultiSelectItem<Hobbies>(hobbies, hobbies.name))
            .toList();
        hobbyitems.clear();

        change(suggested, status: RxStatus.success());
      } else {
        change(null, status: RxStatus.empty());
      }
    } on Exception {
      change(null, status: RxStatus.error("Something went wrong"));
    }
  }

  void editProf(var id) async {
    try {
      final isValid = EditProf.currentState!.validate();

      if (isValid == true) {
        isLoading(true);
        EditProf.currentState!.save();
        await updateProf(id);
      }
    } finally {
      // TODO
    }
  }

  Future<void> updateProf(id) async {
    openAndCloseLoadingDialog();

    var uploaded = await RemoteServices.uploadImage(image, id.toString());

    if (uploaded) {
      if (tobeSent.length < 1) {
        tobeSent = hobbiesSplit;
      }

      var data = {
        "name": name,
        "website": "https://www.qstar.com",
        "bio": bio,
        "phone_number": 0945525252,
        "gender": "male",
        "country_code": "+251",
        "date_of_birth": birthdayControl.text,
        "current_location": "Addis Ababa",
        "account_type": "personal",
        "hobbies": tobeSent.join(",").toString(),
        "_method": "put"
      };

      edited = await RemoteServices.editprofile(data, id);

      if (edited == "200") {
        closeDialog(true, '');
        isLoading(false);
      } else {
        errorMessages = edited;
        closeDialog(false, errorMessages);
      }
    } else {
      if (tobeSent.length < 1) {
        tobeSent = hobbiesSplit;
      }

      var data = {
        "name": name,
        "website": "https://www.qstar.com",
        "bio": bio,
        "phone_number": 0945525252,
        "gender": "male",
        "country_code": "+251",
        "date_of_birth": birthdayControl.text,
        "current_location": "Addis Ababa",
        "account_type": "personal",
        "hobbies": tobeSent.join(",").toString(),
        "_method": "put"
      };

      edited = await RemoteServices.editprofile(data, id);

      if (edited == "200") {
        closeDialog(true, '');
        isLoading(false);
      } else {
        errorMessages = edited;
        closeDialog(false, errorMessages);
      }
    }
  }

  Future<void> openSnackBar() async {
    Get.snackbar("info", "profile updated",
        icon: Icon(Icons.person, color: mPrimaryColor.withOpacity(0.05)),
        snackPosition: SnackPosition.TOP);
  }

  Future<void> openAndCloseLoadingDialog() async {
    showDialog(
      context: Get.context!,
      barrierDismissible: false,
      barrierColor: Colors.grey.withOpacity(0.3),
      builder: (_) => WillPopScope(
        onWillPop: () async => false,
        child: const Center(
          child: SizedBox(
            width: 30,
            height: 30,
            child: CircularProgressIndicator(
              color: mPrimaryColor,
              strokeWidth: 8,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> closeDialog(bool stat, String data) async {
    await Future.delayed(const Duration(seconds: 3));
    // Dismiss CircularProgressIndicator
    Navigator.of(Get.context!).pop();
    if (stat == false) {
      Get.dialog(
        AlertDialog(
          title: const Text("info"),
          content: Text(data),
          actions: <Widget>[
            // ignore: deprecated_member_use
            FlatButton(
              child: const Text("close"),
              onPressed: () {
                Get.back();
              },
            )
          ],
        ),
        barrierDismissible: false,
      );
    } else {
      openSnackBar();
    }
  }

  @override
  void onClose() {
    // TODO: implement onClose

    super.onClose();
  }

  String? validateEmail(String value) {
    if (!GetUtils.isEmail(value)) {
      return "Provide a valid Email";
    }
    return null;
  }

  String? validateName(String value) {
    if (value.isEmpty) {
      return "please Provide a name";
    }
    return null;
  }

  String? validateBio(String value) {
    if (value.isEmpty) {
      return "please Provide a bio";
    }
    return null;
  }

  String? validateBd(String value) {
    if (value.isEmpty) {
      return "please Provide a birthday";
    }
    return null;
  }

  String? validatePass(String value) {
    if (!validateStructure(value)) {
      return "please Provide a valid password";
    }
    return null;
  }

  bool validateStructure(String value) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(value);
  }
}
