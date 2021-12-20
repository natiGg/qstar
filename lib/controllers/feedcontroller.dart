import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:qstar/constant.dart';

import 'package:qstar/remote_services/service.dart';

import 'package:flutter/material.dart';
import 'package:qstar/screen/feed/model/feed.dart';
import 'package:qstar/screen/feed/model/user.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:rich_text_controller/rich_text_controller.dart';

class FeedController extends GetxController with StateMixin {
  var perfectMatches = <User>[].obs;
  var refreshedMatches = <User>[].obs;
  var isRefreshing = false.obs;
  var feed=<Feeds>[].obs;
    var uid;


  @override
  void onInit() async {
    // TODO: implement onInit
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('user');

    if (token != null) {
      var body = json.decode(token);

      uid = body['id'];
      print(uid);
    }
    super.onInit();
    fetchFeed();
    fetchPerfectMatches();
  }

  void fetchFeed() async{
    feed.value=await RemoteServices.fetchFeed();
    for (var feeds in feed.value){
      print(feeds.posts.post_id);
    }
  }
  void fetchPerfectMatches() async {
    try {
      perfectMatches.value = await RemoteServices.fetchPerfectMatch();
      print(perfectMatches);
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
      print("i am refreshing");
      isRefreshing(true);
      refreshedMatches.value = await RemoteServices.refreshMatch();
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
