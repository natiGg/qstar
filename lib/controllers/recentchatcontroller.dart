import 'package:get/get.dart';
import 'package:qstar/remote_services/service.dart';
import 'package:qstar/screen/feed/model/user.dart';

class RecenetChatController extends GetxController {
  var list = <RecentChat>[].obs;
  var isfetched = false.obs;

  void fetch() async {
    list.value = await RemoteServices.recentchat();
    print(list.length);
    if (list.isNotEmpty) {
      isfetched(true);
    }
  }
}
