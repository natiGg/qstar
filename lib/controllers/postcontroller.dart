import 'dart:convert';
import 'dart:isolate';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:qstar/constant.dart';
import 'package:qstar/screen/feed/model/user.dart';
import 'package:qstar/remote_services/service.dart';
import 'package:qstar/screen/profile/editprofile.dart';
import 'package:qstar/screen/profile/profile.dart';
import 'package:qstar/screen/register/model/hobbies.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:flutter/material.dart';

class PostController extends GetxController {
  final GlobalKey<FormState> CaptionForm = GlobalKey<FormState>();
  late TextEditingController captionController;
  var caption;
  var post_type = 'public'.obs;
    var image;
    var posted;


  @override
  void onInit() {
    // TODO: implement onInit
    captionController = TextEditingController();
    super.onInit();
  }

  void changePostype(var type) async {
    post_type.value = type;
  }

  void createPost() async{
    try{
      var isValid = CaptionForm.currentState!.validate();
      if(isValid){
        var data = {
      "location": "Addis Ababa",
      "caption": captionController.text,
      "post_type": post_type,
      "comment_disabled": 1,
      "hashtags": "#music",
      "post_attachment":image ,
    };
      posted=await RemoteServices.createPost(data);

      }
      else {

      }
    }
    finally{

    }
  }

  String? validateCaption(String value) {
    if (value.isEmpty) {
      return "Provide a post caption";
    }
    return null;
  }

}
