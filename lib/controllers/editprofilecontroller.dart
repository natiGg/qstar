import 'package:get/state_manager.dart';
import 'package:qstar/screen/feed/model/user.dart';
import 'package:qstar/remote_services/service.dart';

class EditprofileController extends GetxController {
  RxBool isLoading = true.obs;
  RxBool btnLoading = false.obs;
  var uid = 0.obs;
  var suggested;
  var suggestObjs = <User>[].obs;

  @override
  void onInit() {
    // ignore: todo
    // TODO: implement onInit
    // ignore: avoid_print
    print("controller initialized");
    super.onInit();
  }

  void fetchProfile(var id) async {
    try {
      suggested = await RemoteServices.fetchProfile(id);

      if (suggested.id != null) {
        isLoading(false);
      }
    } finally {
      // TODO
      isLoading(false);
    }
  }

  void editProf() async {
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
      // TODO
      btnLoading(false);
    }
  }
}
