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
  var feed=<Feeds>[].obs;
  var liked=false.obs;
  var isActive = false.obs;
  var isdisActive = false.obs;
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

  void fetchFeed() async{
    try{
          feed.value=await RemoteServices.fetchFeed();

          if(feed.isEmpty){
            onRefreshFeed();
          }
    }
    on Exception {
      change(null, status: RxStatus.error("Something went wrong"));
    }
  }
  void onRefreshFeed() async{
      try{

          feed.value=await RemoteServices.fetchFeed();
          if(feed.isEmpty){
            feed.value=await RemoteServices.refreshFeed();
          }
      }
       on Exception {
      change(null, status: RxStatus.error("Something went wrong"));
    }

  }
  void LikePost(var post_id) async {
    try{
      print("inside like");
      liked.value=await RemoteServices.likePost(post_id);
      print("about to like"+liked.value.toString());
    }
     on Exception {
      change(null, status: RxStatus.error("Can't like post"));
    }

  }
    void DisLikePost(var post_id) async {
    try{
      print("inside like");
      liked.value=await RemoteServices.likePost(post_id);
      print("about to like"+liked.value.toString());
    }
     on Exception {
      change(null, status: RxStatus.error("Can't like post"));
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
