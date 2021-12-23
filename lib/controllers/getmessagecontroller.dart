import 'package:get/get.dart';
import 'package:qstar/controllers/feedcontroller.dart';
import 'package:qstar/remote_services/service.dart';
import 'package:qstar/screen/feed/model/user.dart';

class GetMessageController extends GetxController {
  var list = <Getmessage>[].obs;
  var isfetched = false.obs;
  var sent = false.obs;
  FeedController feedController = Get.find();

  void fetchmessage(id) async {
    list.value = await RemoteServices.getmessage(id.toString());
    if (list.isNotEmpty) {
      isfetched(true);
    }
  }

  void sendMessage(message, messagetype, id) async {
    try {
      sent.value = await RemoteServices.sendmessage(message, messagetype, id);
      if (sent.isTrue) {
        fetchmessage(id);
      }
    } on Exception {
      throw Exception('Failed to send  Mesaage');
    }
  }
}
