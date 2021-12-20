import 'package:get/state_manager.dart';
import 'package:qstar/screen/feed/model/user.dart';
import 'package:qstar/remote_services/service.dart';

class SuggestedUserController extends GetxController {
  var isLoading = true.obs;
  RxBool btnLoading = false.obs;
  var uid = 0.obs;

  var suggestObjs = <User>[].obs;

  @override
  void onInit() {
    fetchSuggeted();
    super.onInit();
  }

  updateId(var id) {
    uid(id);
  }

  void fetchSuggeted() async {
    try {
      isLoading(true);
      var suggested = await RemoteServices.fetchSuggested();
      // ignore: prefer_is_empty
      if (suggested.length >= 1) {
        suggestObjs.value = suggested;
      }
    } finally {
      isLoading(false);
    }
  }

  void follow() async {
    try {
      btnLoading(true);

      var uFollowed = await RemoteServices.follow(uid.value.toString());
      if (uFollowed) {
        // ignore: invalid_use_of_protected_member
        final int index = suggestObjs.value
            .indexWhere((element) => element.id.toInt() == uid.toInt());

        // ignore: invalid_use_of_protected_member
        suggestObjs.value[index].followed.value = true;
      }
    } finally {
      btnLoading(false);
    }
  }

  void unfollow() async {
    try {
      btnLoading(true);

      var unFollowed = await RemoteServices.unfollow(uid.value.toString());
      if (unFollowed) {
        // ignore: invalid_use_of_protected_member
        final int index = suggestObjs.value
            .indexWhere((element) => element.id.toInt() == uid.toInt());

        // ignore: invalid_use_of_protected_member
        suggestObjs.value[index].followed.value = false;
      }
    } finally {
      btnLoading(false);
    }
  }
}
