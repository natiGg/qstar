// ignore_for_file: prefer_typing_uninitialized_variables, duplicate_ignore, prefer_is_empty

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:qstar/constant.dart';
import 'package:qstar/screen/feed/model/user.dart';
import 'package:qstar/remote_services/service.dart';
import 'package:qstar/screen/register/model/hobbies.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:flutter/material.dart';

// ignore: duplicate_ignore, duplicate_ignore, duplicate_ignore
class EditprofileController extends GetxController with StateMixin {
  // ignore: non_constant_identifier_names
  final GlobalKey<FormState> EditProf = GlobalKey<FormState>();
  final GlobalKey<FormState> changePass = GlobalKey<FormState>();

  // ignore: non_constant_identifier_names
  final GlobalKey<FormState> EditUname = GlobalKey<FormState>();
  late TextEditingController nameControl,
      unameControl,
      birthdayControl,
      emailControl,
      bioControl,
      passControl,
      newpassControl,
      confirmpassControl,
      youtubecontroller,
      instacontroller,
      tiktokcontroller,
      facebookcontroller;

  var email = '';
  var name = '';
  var uname = '';
  var prevuname = '';
  var prevemail = '';
  var birthday = '';
  var bio = '';
  var link = '';
  var pass = '';
  var isLoading = false.obs;
  var edited = "";
  // ignore: prefer_typing_uninitialized_variables
  var hobbies;
  // ignore: prefer_typing_uninitialized_variables
  var hobItem;
  // ignore: prefer_typing_uninitialized_variables
  var image;
  var gender;
  // ignore: non_constant_identifier_names
  var followers_count;
  // ignore: non_constant_identifier_names
  var following_count;
  // ignore: non_constant_identifier_names
  var posts_count;
  late String uid = "";

  var unamechecker, messages, errorMessages, emailchecker;
  late String unames = '', emailsInfo = '';
  List<Hobbies> hobbyitems = [];
  List<String> hobbiesSplit = [];
  List<String> tobeSent = [];

  // ignore: prefer_typing_uninitialized_variables
  var suggested;
  var suggestObjs = <User>[].obs;
  var links;
  @override
  void onInit() {
    nameControl = TextEditingController();
    birthdayControl = TextEditingController();
    unameControl = TextEditingController();
    bioControl = TextEditingController();
    passControl = TextEditingController();
    newpassControl = TextEditingController();
    confirmpassControl = TextEditingController();
    youtubecontroller = TextEditingController();
    instacontroller = TextEditingController();
    tiktokcontroller = TextEditingController();
    facebookcontroller = TextEditingController();
    super.onInit();
  }

  void fetchProfile(var id) async {
    try {
      uid = id.toString();

      suggested = await RemoteServices.fetchProfile(id);
      if (suggested.id != null) {
        nameControl.text = suggested.name;
        birthdayControl.text = suggested.date_of_birth;
        unameControl.text = suggested.userName;
        bioControl.text = suggested.bio;
        prevuname = suggested.userName;
        prevemail = suggested.email;
        gender = suggested.gender;
        followers_count = suggested.followers_count;
        following_count = suggested.following_count;
        posts_count = suggested.posts_count;

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

  void fetchlinks(var id) async {
    links = await RemoteServices.fetchProfilelink(id);

    if (links != null) {
      youtubecontroller.text = links.youtube_link;
      facebookcontroller.text = links.fb_link;
      instacontroller.text = links.instagram_link;
      tiktokcontroller.text = links.tiktok_link;
    }
  }

  void changepass(var id) async {
    try {
      final isValid = changePass.currentState!.validate();

      if (isValid == true) {
        isLoading(true);
        changePass.currentState!.save();
        await updatePass(id);
      }
    } finally {
      // TODO
    }
  }

  Future<void> updatePass(id) async {
    openAndCloseLoadingDialog();

    var data = {
      "old_password": passControl.text,
      "password": newpassControl.text,
      "password_confirmation": confirmpassControl.text,
    };

    edited = await RemoteServices.updatepass(data, id);

    if (edited == "200") {
      closeDialog(true, '');
      isLoading(false);
    } else {
      errorMessages = edited;
      closeDialog(false, errorMessages);
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
        "name": nameControl.text,
        "website": "https://www.qstar.com",
        "bio": bioControl.text,
        "phone_number": 0945525252,
        "gender": "male",
        "country_code": "+251",
        "date_of_birth": birthdayControl.text,
        "current_location": "Addis Ababa",
        "account_type": "personal",
        "fb_link": facebookcontroller.text,
        "instagram_link": instacontroller.text,
        "tiktok_link": tiktokcontroller.text,
        "youtube_link": youtubecontroller.text,
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
        "name": nameControl.text,
        "website": "https://www.qstar.com",
        "bio": bioControl.text,
        "phone_number": 0945525252,
        "gender": "male",
        "country_code": "+251",
        "date_of_birth": birthdayControl.text,
        "current_location": "Addis Ababa",
        "account_type": "personal",
        "fb_link": facebookcontroller.text,
        "instagram_link": instacontroller.text,
        "tiktok_link": tiktokcontroller.text,
        "youtube_link": youtubecontroller.text,
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
    await Future.delayed(const Duration(seconds: 1));
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

  String? validateUsername(String value) {
    if (value.isEmpty) {
      return "please Provide a Userame";
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
