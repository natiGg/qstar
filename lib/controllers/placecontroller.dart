import 'package:get/get.dart';
import 'package:qstar/remote_services/service.dart';
import 'package:qstar/screen/feed/model/user.dart';

class Placecontroller extends GetxController {
  var list = <PlacePost>[].obs;
  var isfetched = false.obs;

  void fetch(id) async {
    list.value = await RemoteServices.placedetail(id);
    if (list.isNotEmpty) {
      isfetched(true);
    }
  }
}
