import 'dart:convert';
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
import 'dart:io';

import 'package:rich_text_controller/rich_text_controller.dart';


class PostController extends GetxController {
  final GlobalKey<FormState> CaptionForm = GlobalKey<FormState>();
  late RichTextController  captionController;
  var caption;
  var post_type = 'public'.obs;
    var image;
    var posted;
    var imageAdded=false.obs;
    var imagesList = <File>[].obs;
    var isPosting=false.obs;
    var isPosted=false.obs;
    var hasHash=false.obs;
    var hashtags;
  @override
  void onInit() {
     captionController = RichTextController(
      patternMatchMap: {
        RegExp(r"\B#[a-zA-Z0-9]+\b"): TextStyle(color: mPrimaryColor, fontSize: 18,
                                            fontWeight: FontWeight.bold),
      },
      onMatch: (List<String> matches) {
        // Do something with matches.
        hashtags=matches;
      },
      deleteOnBack: true,
    );
    // TODO: implement onInit
    super.onInit();
   
    
  }

  void changePostype(var type) async {
    post_type.value = type;
  }
  void removeItem(var index) async{
      imagesList.removeAt(index);
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
      "hashtags": "#hashtags",
    };
      isPosting(true);
      posted=await RemoteServices.createPost(imagesList,data);
      print(posted);
      if(posted.toString()=="200"){
        isPosting(false);
        isPosted(true);
        imagesList.clear();
        captionController.clear();
        post_type.value="public";
      }
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
