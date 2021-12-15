import 'package:get/get.dart';
import 'package:qstar/remote_services/service.dart';
import 'package:qstar/screen/feed/model/user.dart';

class VideocatagoryController extends GetxController {
  var list = <videoCategory>[].obs;
  var isfetched = false.obs;

  void fetch() async {
    list.value = await RemoteServices.getvideoCategory();
    if (list.isNotEmpty) {
      isfetched(true);
    }
  }
}
