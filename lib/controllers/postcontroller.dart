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
  late TextEditingController locationController;
  var caption;
  // ignore: non_constant_identifier_names
  var post_type = 'public'.obs;
  var at_loca = "".obs;
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
  var suggestions, location;
  var isCam = false.obs;
  var searched = <User>[].obs;
  var searchedLoc = <Location>[].obs;

  var isSelected = false.obs;
  var selectedUsers = [].obs;
  var imagefile = <File>[].obs;
  var tagged = [].obs;
  var taggedName = [].obs;

  var hashTags = [""].obs;
  late VideoPlayerController controller;
  var isPlaying = false.obs;
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
    fetchallLocation();
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
      },
      onMatch: (List<String> matches) {
        // Do something with matches.
        hashtags.value = matches;
        print(hashtags);
      },
      deleteOnBack: true,
    );
    locationController = TextEditingController();
    fetchall();
    // TODO: implement onInit
    super.onInit();
  }

  void onSearchTextChanged(String text) async {
    print(text);
    print(tagged.join(","));

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

  void onLocationTextChanged(String text) async {
    searchedLoc.clear();
    if (text.isEmpty) {
      return;
    }
    location.forEach((loc) {
      if (loc.location.toLowerCase().contains(text)) {
        searchedLoc.add(loc);
      }
    });
  }

  void tapSelection(var index) {
    print("objectf");
    if (taggedName.contains("@" + suggestions[index].userName)) {
      print("already added");
    } else {
      taggedName.add("@" + suggestions[index].userName);
      tagged.add(suggestions[index].id.toString());
      print(suggestions[index].id.toString());
    }
  }

  void removedTagged(var index) {
    taggedName.removeAt(index);
    tagged.removeAt(index);
  }

  void tapLocselection(var index) {
    print("objectf");
    at_loca.value = location[index].location;
  }

  void onPlay() async {
    if (controller.value.isPlaying) {
      isPlaying(false);
      controller.pause();
    } else {
      // If the video is paused, play it.
      isPlaying(true);
      controller.play();
    }
  }

  void fetchall() async {
    print(id.toString() + "fdfdf");
    suggestions = await RemoteServices.fetchallFollower(id.toString());
  }

  void fetchallLocation() async {
    print(id.toString() + "fdfdf");
    location = await RemoteServices.fetchallPlaces();
  }

  void changePostype(var type) async {
    post_type.value = type;
  }

  void removeItem(var index) async {
    if (imagesList.isNotEmpty) {
      imagesList.removeAt(index);
      imagefile.removeAt(index);
    } else if (videosList.isNotEmpty) {
      videosList.removeAt(index);
      controller.dispose();
    }
  }

  void removeEdited(var index) async {
    imagefile.removeAt(index);
  }

  void createPost() async {
    try {
      for (var tags in hashtags) {
        if (tags.contains("#")) {
          hashTags.add(tags);
        }
      }
      print(hashTags.join(""));
      print(tagged.join(","));
      var isValid = CaptionForm.currentState!.validate();
      print(at_loca.value.toString());
      if (isValid) {
        var data = {
          "location": at_loca.value.toString(),
          "caption": captionController.text,
          "post_type": post_type,
          "tags": tagged.join(",")
        };
        isPosting(true);
        if (imagesList.isNotEmpty) {
          posted = await RemoteServices.createPost(imagesList, data);
        } else if (videosList.isNotEmpty) {
          posted = await RemoteServices.createPost(videosList, data);
        }
        print(posted);
        if (posted.toString() == "200") {
          isPosting(false);
          isPosted(true);
          imagesList.clear();
          videosList.clear();
          hashTags.clear();
          taggedName.clear();
          tagged.clear();
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
