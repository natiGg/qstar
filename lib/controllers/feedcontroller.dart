import 'package:get/get.dart';
import 'package:get/state_manager.dart';

import 'package:qstar/remote_services/service.dart';

import 'package:qstar/screen/feed/model/user.dart';

class FeedController extends GetxController with StateMixin {
  var perfectMatches = <User>[].obs;
  var refreshedMatches = <User>[].obs;
  var isRefreshing = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit

    super.onInit();

    fetchPerfectMatches();
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
