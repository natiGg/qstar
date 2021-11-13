import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:qstar/screen/feed/model/user.dart';
import 'package:qstar/remote_services/service.dart';
import 'package:qstar/screen/profile/editprofile.dart';

class EditprofileController extends GetxController with StateMixin {
 
  final GlobalKey<FormState> EditProf = GlobalKey<FormState>();
  late TextEditingController nameControl,unameControl,birthdayControl,emailControl,bioControl,passControl;
  var email='';
  var name = '';
  var uname = '';
  var birthday = '';
  var bio = '';
  var pass = '';
  var isLoading=false.obs;
  var edited="";
   List<String> hobbiesSplit=[];
     var hobbiesSplit2=<Map>[].cast<Animal>();

  
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
      suggested = await RemoteServices.fetchProfile(id);

      if (suggested.id != null) {
        emailControl.text=suggested.email;
        nameControl.text= suggested.name;
        birthdayControl.text = suggested.date_of_birth;
        unameControl.text = suggested.userName;
        bioControl.text = suggested.bio;
        print("just gotttt here");
        print(suggested.hobbies);
        hobbiesSplit=suggested.hobbies.toString().split(",");
       
        
        change(suggested, status: RxStatus.success());
      } else {
        change(null, status: RxStatus.empty());
      }
    } on Exception catch (e) {
      change(null, status: RxStatus.error("Something went wrong"));
    }
  }

  void editProf(var id) async {
    try {
      final isValid = EditProf.currentState!.validate();

      if(isValid == true)
      {
        isLoading(true);
        EditProf.currentState!.save();
        var data={
          "name":name,
          "website":"https://www.qstar.com",
          "bio":bio,
          "email":email,
          "phone_number":0945525252,
          "gender":"male",
          "country_code":"+251",
          "date_of_birth":birthdayControl.text,
          "current_location":"Addis Ababa",
          "account_type":"personal",
          "_method":"put"
        };
         edited = await RemoteServices.editprofile(data,id);
          if(edited.length! > 0){

            print(edited.length);
            isLoading(false);
            print(isLoading);

          }
       
      }
    
    } finally {
      // TODO
    }
  }

  @override
  void onClose() {
    // TODO: implement onClose
    
    super.onClose();
  }
  String?validateEmail (String value)
  {
    if (!GetUtils.isEmail(value))
    {
      return "Provide a valid Email";
    }
    return null;
  }
  String?validateName (String value)
  {
    if (value.isEmpty)
    {
      return "please Provide a name";
    }
    return null;
  }
   String?validateunName (String value)
  {
    if (value.isEmpty)
    {
      return "please Provide a uname";
    }
    return null;
  }
    String?validateBio (String value)
  {
    if (value.isEmpty)
    {
      return "please Provide a bio";
    }
    return null;
  }
    String?validateBd (String value)
  {
    if (value.isEmpty)
    {
      return "please Provide a birthday";
    }
    return null;
  }


    String?validatePass (String value)
  {
    if (!validateStructure(value))
    {
      return "please Provide a valid password";
    }
    return null;
  }
  bool validateStructure(String value) 
  {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(value);
  }

}
