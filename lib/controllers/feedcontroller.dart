import 'package:get/get.dart';
import 'package:get/state_manager.dart';

import 'package:qstar/remote_services/service.dart';

import 'package:qstar/screen/feed/model/feed.dart';
import 'package:qstar/screen/feed/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class FeedController extends GetxController with StateMixin {
  var perfectMatches = <User>[].obs;
  var refreshedMatches = <User>[].obs;
  var isRefreshing = false.obs;
  var feed = <Feeds>[].obs;
  // ignore: prefer_typing_uninitialized_variables
  var uid;

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
    feed.value = await RemoteServices.fetchFeed();
    // ignore: invalid_use_of_protected_member
    for (var feeds in feed.value) {}
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
