import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:qstar/remote_services/service.dart';
import 'package:qstar/screen/register/model/hobbies.dart';


class HobbiesController extends GetxController with StateMixin {
  var hobbies;
  
void fetchHobbies() async
{

hobbies=await RemoteServices.fetchHobbies();

}


}



