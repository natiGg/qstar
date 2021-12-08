import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:qstar/constant.dart';
import 'package:qstar/controllers/editprofilecontroller.dart';

import 'package:qstar/remote_services/service.dart';
import 'package:flutter/material.dart';
import 'package:qstar/screen/feed/model/user.dart';
import 'dart:io';
import 'package:qstar/screen/qvideo/videopicker.dart';
import 'package:rich_text_controller/rich_text_controller.dart';
import 'package:video_player/video_player.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostController extends GetxController {
  // ignore: non_constant_identifier_names

  final GlobalKey<FormState> CaptionForm = GlobalKey<FormState>();
  late RichTextController captionController, searchController;
  var caption;
  // ignore: non_constant_identifier_names
  var post_type = 'public'.obs;
  var image;
  var posted;
  var imageAdded = false.obs;
  var imagesList = <File>[].obs;
  var videosList = <File>[].obs;
  var isPosting = false.obs;
  var isPosted = false.obs;
  var hasHash = false.obs;
  var unames = [""].obs;
  var hashtags = [""].obs;
  var index = 0.obs;
  var suggestions;
  var isCam = false.obs;
  var searched = <User>[].obs;
  var isSelected = false.obs;
  var selectedUsers = [].obs;
  var imagefile = <File>[].obs;
    late VideoPlayerController controller;
  late Future<void> initializeVideoPlayerFuture;
  var id;
  @override
  void onInit() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('user');

    if (token != null) {
      var body = json.decode(token);

      id = body['id'];
    }
    fetchall();
    searchController = RichTextController(
      patternMatchMap: {
        RegExp(r"\B@[a-zA-Z0-9]+\b"): TextStyle(
            color: mPrimaryColor, fontSize: 18, fontWeight: FontWeight.bold),
      },
      onMatch: (List<String> matches) {
        // Do something with matches.
        unames.value = matches;
      },
      deleteOnBack: true,
    );
    captionController = RichTextController(
      patternMatchMap: {
        RegExp(r"\B#[a-zA-Z0-9]+\b"): TextStyle(
            color: mPrimaryColor, fontSize: 18, fontWeight: FontWeight.bold),
        RegExp(r"\B@[a-zA-Z0-9]+\b"): TextStyle(
            color: mPrimaryColor, fontSize: 18, fontWeight: FontWeight.bold),
      },
      onMatch: (List<String> matches) {
        // Do something with matches.
        hashtags.value = matches;
        print(hashtags);
      },
      deleteOnBack: true,
    );
    fetchall();
    // TODO: implement onInit
    super.onInit();
  }

  void onSearchTextChanged(String text) async {
    print(videosList.length);
    searched.clear();
    if (text.isEmpty) {
      return;
    }
    suggestions.forEach((userDetail) {
      if (userDetail.name.toLowerCase().contains(text) ||
          userDetail.userName.toLowerCase().contains(text)) {
        searched.add(userDetail);
      }
    });
  }

  void tapSelection(var index) {
    print("objectf");
    if (hashtags.contains("@" + suggestions[index].userName) == true) {
      print("already added");
    } else {
      print(hashtags);
      hashtags.add(suggestions[index].userName);
      captionController.text =
          captionController.text + "@" + suggestions[index].userName + " ";
    }
  }

  void fetchall() async {
    print(id.toString() + "fdfdf");
    suggestions = await RemoteServices.fetchallFollower(id.toString());
  }

  void changePostype(var type) async {
    post_type.value = type;
  }

  void removeItem(var index) async {
    imagesList.removeAt(index);
    imagefile.removeAt(index);
  }

  void removeEdited(var index) async {
    imagefile.removeAt(index);
  }

  void createPost() async {
    try {
      var isValid = CaptionForm.currentState!.validate();
      if (isValid) {
        var data = {
          "location": "Addis Ababa",
          "caption": captionController.text,
          "post_type": post_type,
          "comment_disabled": 1,
          "hashtags": "#hashtags",
        };
        isPosting(true);
        posted = await RemoteServices.createPost(imagesList, data);
        print(posted);
        if (posted.toString() == "200") {
          isPosting(false);
          isPosted(true);
          imagesList.clear();
          captionController.clear();
          post_type.value = "public";
        }
      }
    } finally {}
  }

  String? validateCaption(String value) {
    if (value.isEmpty) {
      return "Provide a post caption";
    }
    return null;
  }
}
