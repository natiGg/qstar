import 'package:get/get.dart';
import 'package:qstar/remote_services/service.dart';
import 'package:qstar/screen/feed/model/user.dart';

class HashController extends GetxController {
  var list = <hashtagPost>[].obs;
  var isfetched = false.obs;

  void fetch(id) async {
    list.value = await RemoteServices.hashtagdetail(id.toString());
    if (list.isNotEmpty) {
      isfetched(true);
    }
  }
}
