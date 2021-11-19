import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:qstar/controllers/editprofilecontroller.dart';
import 'package:qstar/screen/feed/model/user.dart';
import 'package:qstar/remote_services/service.dart';
import 'package:qstar/screen/profile/editprofile.dart';
import 'package:qstar/screen/profile/profile.dart';
import 'package:qstar/screen/register/model/hobbies.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class UnameController extends GetxController  {
    var isLoading=false.obs;
    late TextEditingController unameControl;
    var unamechecker,prevuname,messages,uname;
    EditprofileController editprofileController = Get.find();
    var unames=''.obs;
    var saved =false.obs;
  
    

  // ignore: non_constant_identifier_names
  final GlobalKey<FormState> EditUname = GlobalKey<FormState>();

  @override
  void onInit() {
    unameControl = TextEditingController();
    prevuname = editprofileController.prevuname;
    unameControl.text=prevuname;
    super.onInit();
  }
  void editUname() async {
    final isValid = EditUname.currentState!.validate();
    if (isValid) {
      print(prevuname);
      print(unameControl.text);
      if (prevuname != unameControl.text) {
        isLoading(true);
        unamechecker = await RemoteServices.checkUname(unameControl.text);
        print(unamechecker);   
        
        if (unamechecker[0] == "200") {
        // if uname avaialble update profile data
        await updateUname(unameControl.text);
      } else {
        print("herere");
        unameControl.clear();
        unames.value = unamechecker[2].toString();
        saved(false);
        isLoading(false);
      }
      }
      else if (prevuname == unameControl.text){
        
        
        isLoading(true);
        await updateUname(unameControl.text);
      }
   
    }
  }
  Future<void> updateUname(id) async {
    var uploaded = await RemoteServices.changeUname(unameControl.text);
    if (uploaded.length! > 0) {
      unames.value = '';
      isLoading(false);
      saved(true);
      print("uname changed");
    }
  }
    String? validateunName(String value) {
    if (value.isEmpty) {
      messages = 'please Provide a uname';
      return messages;
    }
    return null;
  }
}