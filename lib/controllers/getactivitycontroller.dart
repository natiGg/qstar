import 'package:get/get.dart';
import 'package:qstar/remote_services/service.dart';
import 'package:qstar/screen/feed/model/user.dart';

class GetActivtiycontroller extends GetxController {
  var list = <GetActivity>[].obs;
  var isfetched = false.obs;
  var sent = false.obs;

  void fetchActivity(var id) async {
    list.value = await RemoteServices.getActivity(id);
    if (list.isNotEmpty) {
      isfetched(true);
    }
  }
}
