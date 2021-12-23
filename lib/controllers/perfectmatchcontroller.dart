import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';

import 'package:flutter/material.dart';
import 'package:qstar/remote_services/service.dart';
import 'package:qstar/constant.dart';
import 'package:qstar/screen/profile/PerfectMatch/profile.dart';

import 'package:rich_text_controller/rich_text_controller.dart';

class PerfectMatchController extends GetxController with StateMixin {
  // ignore: non_constant_identifier_names
  GlobalKey<FormState> Form = GlobalKey<FormState>();
  // ignore: non_constant_identifier_names
  GlobalKey<FormState> Form2 = GlobalKey<FormState>();
  // ignore: non_constant_identifier_names
  GlobalKey<FormState> Form3 = GlobalKey<FormState>();
  // ignore: non_constant_identifier_names
  GlobalKey<FormState> Form4 = GlobalKey<FormState>();
  late RichTextController captionController;

  late TextEditingController fullname;
  // ignore: prefer_typing_uninitialized_variables
  var gender;
  var currentStep = 0.obs;
  var country = "Counrty".obs;
  var matchcountry = "Counrty".obs;
  late TextEditingController city;
  late TextEditingController phone;
  late TextEditingController religion;
  late TextEditingController height;

  late TextEditingController lancon;
  var isFetched = false.obs;
  var lan = "Language".obs;
  // ignore: prefer_typing_uninitialized_variables
  var hob;
  // ignore: prefer_typing_uninitialized_variables
  var edu;
  // ignore: prefer_typing_uninitialized_variables
  var emp;
  late TextEditingController occ;
  late TextEditingController location;
  // ignore: prefer_typing_uninitialized_variables
  var macthgender;
  // ignore: prefer_typing_uninitialized_variables
  var inforesponse;
  var checkpf, fetched;
  RangeValues currentRangeValues = const RangeValues(18, 65);
  // ignore: prefer_typing_uninitialized_variables
  var agestart;
  // ignore: prefer_typing_uninitialized_variables
  var ageend;

  @override
  void onInit() {
    fullname = TextEditingController();
    city = TextEditingController();
    phone = TextEditingController();
    religion = TextEditingController();
    height = TextEditingController();
    occ = TextEditingController();
    location = TextEditingController();

    lancon = TextEditingController();

    super.onInit();
  }

  Future<void> fetchPf() async {
    try {
      openAndCloseLoadingDialog();
      fetched = await RemoteServices.fetchpf();
      //   print(fetched);
      if (fetched != "") {
        isFetched.value = true;
        fullname.text = fetched.full_name;

        country.value = fetched.country;
        matchcountry.value = fetched.pflocation;
        city.text = fetched.city;
        phone.text = fetched.phone_number;
        religion.text = fetched.religion;
        height.text = fetched.height;
        lancon.text = fetched.language;
        edu = fetched.education;
        emp = fetched.employment;
        occ.text = fetched.occupation;
        agestart = fetched.age_min;
        ageend = fetched.age_max;

        macthgender = fetched.pfgender;

        await Future.delayed(const Duration(seconds: 1));
        // Dismiss CircularProgressIndicator
        Navigator.of(Get.context!).pop();
      }
      change(fetched, status: RxStatus.success());
    } on Exception catch (e) {
      change(null, status: RxStatus.error("Something went wrong"));

      // TODO
    }
  }

  Future<bool> check() async {
    checkpf = await RemoteServices.cheakpf();
    return checkpf;
  }

  Future<bool> checkmp() async {
    checkpf = await RemoteServices.machpf();
    return checkpf;
  }

  void create() async {
    try {
      var isValid = Form.currentState!.validate();

      if (isValid) {
        currentStep.value += 1;
      }
    } finally {}
  }

  void create2() async {
    try {
      var isValid2 = Form2.currentState!.validate();
      if (isValid2) {
        currentStep.value += 1;
      }
    } finally {}
  }

  void create3() async {
    try {
      var isValid3 = Form3.currentState!.validate();
      if (isValid3) {
        currentStep.value += 1;
      }
    } finally {}
  }

  void create4() async {
    try {
      var isValid4 = Form4.currentState!.validate();
      if (isValid4) {
        currentStep.value += 1;
      }
    } finally {}
  }

  Future<void> setInfo() async {
    openAndCloseLoadingDialog();

    var data = {
      "full_name": fullname.text,
      "location": country.value,
      "country": country.value,
      "city": city.text,
      "phone_number": phone.text,
      "religion": religion.text,
      "height": height.text,
      "language": lan.value,
      "education": edu,
      "employment": emp,
      "occupation": occ.text,
      "preference_location": location.text,
      "age_max": currentRangeValues.end.toInt(),
      "age_min": currentRangeValues.start.toInt(),
      "gender": macthgender,
    };
    inforesponse = await RemoteServices.updatePersonalInfo(data);
    if (inforesponse == "200") {
      print(inforesponse.toString());
      closeDialog(true, '');
    } else {
      closeDialog(false, inforesponse);
    }
  }

  Future<void> seteditInfo() async {
    openAndCloseLoadingDialog();

    var data = {
      "full_name": fullname.text,
      "location": country.value,
      "country": country.value,
      "city": city.text,
      "phone_number": phone.text,
      "religion": religion.text,
      "height": height.text,
      "language": lan.value,
      "education": edu,
      "employment": emp,
      "occupation": occ.text,
      "preference_location": matchcountry.value,
      "age_max": currentRangeValues.end.toInt(),
      "age_min": currentRangeValues.start.toInt(),
      "gender": macthgender,
      "_method": "put",
    };
    inforesponse = await RemoteServices.editPersonalInfo(data);
    if (inforesponse.toString() == "200") {
      closeDialog(true, '');
    } else {
      closeDialog(false, inforesponse);
    }
  }

  Future<void> openSnackBar() async {
    Get.snackbar("info", "profile Added",
        icon: Icon(Icons.person, color: mPrimaryColor.withOpacity(0.05)),
        snackPosition: SnackPosition.TOP);
    Navigator.push(
      Get.context!,
      MaterialPageRoute(builder: (context) => const ProfileImageAppbarRoute()),
    );
  }

  Future<void> openSnackBaredit() async {
    Get.snackbar("", "profile Edited",
        icon: Icon(Icons.person, color: mPrimaryColor.withOpacity(0.05)),
        snackPosition: SnackPosition.TOP);
    await Future.delayed(const Duration(seconds: 1));
    Navigator.pushNamed(Get.context!, '/home');
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
    // Navigator.of(Get.context!).pop();
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
      openSnackBaredit();
    }
  }

  String? validateName(String value) {
    if (value.isEmpty) {
      return "please Provide a name";
    }
    return null;
  }

  String? validatecity(String value) {
    if (value.isEmpty) {
      return "please Provide  city";
    }
    return null;
  }

  String? validatephone(String value) {
    if (value.isEmpty) {
      return "please Provide phone number";
    }
    return null;
  }

  String? validatereligion(String value) {
    if (value.isEmpty) {
      return "please Provide your Religion ";
    }
    return null;
  }

  String? validateheight(String value) {
    if (value.isEmpty) {
      return "please Provide your height ";
    }
    return null;
  }

  String? validateOccupation(String value) {
    if (value.isEmpty) {
      return "please Provide your Occupation ";
    }
    return null;
  }

  String? validatelocation(String value) {
    if (value.isEmpty) {
      return "please Provide your location ";
    }
    return null;
  }

  void openpage() {}
}
