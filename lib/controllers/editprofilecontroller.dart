import 'package:get/state_manager.dart';
import 'package:qstar/screen/feed/model/user.dart';
import 'package:qstar/remote_services/service.dart';

class EditprofileController extends GetxController {
  var isLoading = true.obs;
  RxBool btnLoading = false.obs;
  var uid = 0.obs;

  var suggestObjs = <User>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    print("controller initialized");
    super.onInit();
  }

  void fetchProfile(var id) async {
    try {
      isLoading(true);
      var suggested = await RemoteServices.fetchProfile(id);
      print("bryhhh");
      print(suggested.toString());
      if (suggested.id != null) {
        print("user fetched");
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
        print(uid.toString());
        final int index = suggestObjs.value
            .indexWhere((element) => element.id.toInt() == uid.toInt());
        print(index);
        print(suggestObjs.value[index].followed);
        suggestObjs.value[index].followed.value = true;
        print("user clicked followed");
      }
    } finally {
      // TODO
      btnLoading(false);
    }
  }
}
