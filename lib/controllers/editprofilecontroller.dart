import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:qstar/screen/feed/model/user.dart';
import 'package:qstar/remote_services/service.dart';
import 'package:qstar/screen/profile/editprofile.dart';
import 'package:qstar/screen/profile/profile.dart';
import 'package:qstar/screen/register/model/hobbies.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class EditprofileController extends GetxController with StateMixin {
  // ignore: non_constant_identifier_names
  final GlobalKey<FormState> EditProf = GlobalKey<FormState>();
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
  var hobbies;
  var hobItem;
  var image;
  late String uid = "";
  var unamechecker, messages,emailchecker;
  late String unames='',emailsInfo='';
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
    emailControl = TextEditingController();
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
      suggested = await RemoteServices.fetchProfile(id);

      if (suggested.id != null) {
        emailControl.text = suggested.email;
        nameControl.text = suggested.name;
        birthdayControl.text = suggested.date_of_birth;
        unameControl.text = suggested.userName;
        bioControl.text = suggested.bio;
        prevuname = suggested.userName;
        prevemail=suggested.email;
        print("just gotttt here");
        print(suggested.hobbies);
        hobbiesSplit = suggested.hobbies.toString().split(",");
        print(hobbiesSplit);

        for (int i = 0; i < hobbiesSplit.length; i++) {
          Hobbies hobbies = Hobbies(id: i, name: hobbiesSplit[i].toString());
          hobbyitems.add(hobbies);
        }
        print(hobbyitems);

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
        print(prevuname);
        print(unameControl.text);
        if (prevuname != unameControl.text && prevemail!=emailControl.text) {
          unamechecker = await RemoteServices.checkUname(unameControl.text);
          emailchecker = await RemoteServices.checkEmail(emailControl.text);
        } else if(prevuname != unameControl.text)
        {
          unamechecker = await RemoteServices.checkUname(unameControl.text);
        }
        else if(prevemail != emailControl.text)
        {
          emailchecker = await RemoteServices.checkEmail(emailControl.text);
        }
        else {
          await updateProf(id);
        }
        if (unamechecker[0] == "200") {
          // if uname avaialble update profile data
          await updateProf(id);
        } else {
          print("herere");
          unameControl.clear();
          unames = unamechecker[2];
          print(unames.toString());
        }
        if (emailchecker[0] == "200") {
          // if uname avaialble update profile data
          await updateProf(id);
        } else {
          print("herere");
          emailControl.clear();
          emailsInfo = emailchecker[1];
          print(emailsInfo.toString());
        }
      }
    } finally {
      // TODO
    }
  }

  Future<void> updateProf(id) async {
    var uploaded = await RemoteServices.uploadImage(image, id.toString());
    var data = {
      "name": name,
      "website": "https://www.qstar.com",
      "bio": bio,
      "email": email,
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
    if (edited.length! > 0) {
      fetchProfile(id);
      isLoading(false);
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

  String? validateunName(String value) {
    if (value.isEmpty) {
      messages = 'please Provide a uname';
      return messages;
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
