// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names

import 'package:get/get.dart';
import 'package:qstar/controllers/feedcontroller.dart';
import 'package:qstar/remote_services/service.dart';

import 'package:qstar/screen/feed/model/user.dart';

class Followcontroller extends GetxController {
  var isLoading = true.obs;
  RxBool btnLoading = false.obs;
  RxBool following = false.obs;
  RxBool isChecked = false.obs;
  RxBool isFetching = false.obs;
  late User profile;
  var following_list = <User>[].obs;
  var unFollowed, uFollowed;
  FeedController feedController = Get.find();

    void fetchUProfile(var id) async {
    try {
      isFetching(true);
      profile= await RemoteServices.fetchProfile(id);
      isFetching(false);
    } finally {}
  }

  void fetchFollowing(var id) async {
    try {
      isFetching(true);
      following_list.value = await RemoteServices.fetchallFollowing(id);
      isFetching(false);
    } finally {}
  }

  void check(var check_id, var u_id) async {
    try {
      uFollowed =
          await RemoteServices.checkFollowers(check_id, u_id.toString());
      following.value = uFollowed;
      isChecked(true);
    } finally {}
  }

  void follow(var id) async {
    try {
      btnLoading(true);
      uFollowed = await RemoteServices.follow(id);
      following.value = uFollowed;
    } finally {
      btnLoading(false);
    }
  }

  void unfollow(var id) async {
    try {
      btnLoading(true);

      unFollowed = await RemoteServices.unfollow(id);

      following.value = !unFollowed;
      fetchFollowing(feedController.uid);
      btnLoading(false);
    } finally {}
  }
}
