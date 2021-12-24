// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names

import 'package:get/get.dart';
import 'package:get/state_manager.dart';

import 'package:qstar/remote_services/service.dart';

import 'package:qstar/screen/feed/model/feed.dart';
import 'package:qstar/screen/feed/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:video_player/video_player.dart';


class FeedController extends GetxController with StateMixin {
  var perfectMatches = <User>[].obs;
  var refreshedMatches = <User>[].obs;
  var isRefreshing = false.obs;
  var feed = <Feeds>[].obs;
  var liked = false.obs;
  var isActive = false.obs;
  var isdisActive = false.obs;
<<<<<<< HEAD
  var uid;
=======
    var uid;
      var isPlaying = false.obs;



>>>>>>> b6a9b74c6b0d54d75d4cee304680edebd845d29a

  @override
  void onInit() async {
    // TODO: implement onInit
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('user');

    if (token != null) {
      var body = json.decode(token);

      uid = body['id'];
    }
    super.onInit();
    fetchFeed();
    fetchPerfectMatches();
  }

  void fetchFeed() async {
    try {
      feed.value = await RemoteServices.fetchFeed();

      if (feed.isEmpty) {
        onRefreshFeed();
      }
    } on Exception {
      change(null, status: RxStatus.error("Something went wrong"));
    }
  }

  void onRefreshFeed() async {
    try {
      feed.value = await RemoteServices.fetchFeed();
      if (feed.isEmpty) {
        feed.value = await RemoteServices.refreshFeed();
      }
    } on Exception {
      change(null, status: RxStatus.error("Something went wrong"));
    }
  }
<<<<<<< HEAD

  void LikePost(var postId) async {
    try {
      liked.value = await RemoteServices.likePost(postId);
    } on Exception {
=======
  void LikePost(var post_id) async {
    try{
      print("inside like");
      liked.value=await RemoteServices.likePost(post_id);
      print("about to like"+liked.value.toString());
   
    }
     on Exception {
>>>>>>> b6a9b74c6b0d54d75d4cee304680edebd845d29a
      change(null, status: RxStatus.error("Can't like post"));
    }
  }
<<<<<<< HEAD

  void DisLikePost(var postId) async {
    try {
      liked.value = await RemoteServices.likePost(postId);
    } on Exception {
      change(null, status: RxStatus.error("Can't like post"));
=======
 void DisLikePost(var post_id) async {
    try{
      print("dislike");
      liked.value=await RemoteServices.likePost(post_id);
      print("about to dislike"+liked.value.toString());
    }
     on Exception {
      change(null, status: RxStatus.error("Can't dislike post"));

>>>>>>> b6a9b74c6b0d54d75d4cee304680edebd845d29a
    }
  }

  void fetchPerfectMatches() async {
    try {
      perfectMatches.value = await RemoteServices.fetchPerfectMatch();

      if (perfectMatches.isNotEmpty) {
        change(perfectMatches, status: RxStatus.success());
      } else {
        change(null, status: RxStatus.empty());
      }
    } on Exception {
      change(null, status: RxStatus.error("Something went wrong"));
    }
  }

  void refreshMatches() async {
    try {
      isRefreshing(true);
      refreshedMatches.value = await RemoteServices.refreshMatch();
      // ignore: invalid_use_of_protected_member
      perfectMatches.value = refreshedMatches.value;
      if (perfectMatches.isNotEmpty) {
        isRefreshing(false);
        change(perfectMatches, status: RxStatus.success());
      } else {
        change(null, status: RxStatus.empty());
      }
    } on Exception {
      change(null, status: RxStatus.error("Something went wrong"));
    }
  } 
  

}

 