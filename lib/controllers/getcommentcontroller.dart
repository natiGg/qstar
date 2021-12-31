import 'package:get/get.dart';
import 'package:qstar/controllers/feedcontroller.dart';
import 'package:qstar/remote_services/service.dart';
import 'package:qstar/screen/feed/model/user.dart';

class GetCommenteController extends GetxController {
  var list = <GetComment>[].obs;

  var isfetched = false.obs;
  var sent = false.obs;

  void fetchComment(id) async {
    list.value = await RemoteServices.getcomment(id.toString());
    print(list.length.toString());
    if (list.isNotEmpty) {
      isfetched(true);
    }
  }

  void sendcomment(comment, postId) async {
    try {
      sent.value = await RemoteServices.sendcomment(comment, postId);
      if (sent.isTrue) {
        fetchComment(postId);
      }
    } on Exception {
      throw Exception('Failed to send  Mesaage');
    }
  }

  void sendReplay(comment, commentid) async {
    try {
      sent.value = await RemoteServices.sendcomment(comment, commentid);
      if (sent.isTrue) {
        fetchComment(commentid);
      }
    } on Exception {
      throw Exception('Failed to send  Mesaage');
    }
  }
}
