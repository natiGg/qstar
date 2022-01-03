import 'package:get/get.dart';
import 'package:qstar/controllers/feedcontroller.dart';
import 'package:qstar/remote_services/service.dart';
import 'package:qstar/screen/feed/model/user.dart';

class GetCommenteController extends GetxController {
  var list = <GetComment>[].obs;
  var isfetched = false.obs;
  var sent = false.obs;
  var isActive=false.obs;
  var isLiked=false.obs;
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
  void likeComment(comment_id) async {
    try{
        isLiked.value=await RemoteServices.likeCommentPost(comment_id);
    }
    on Exception {
      throw Exception("can't like comment");
    }
  }
    void dislikeComment(comment_id) async {
    try{
        isLiked.value=!await RemoteServices.dislikeCommentPost(comment_id);
    }
    on Exception {
      throw Exception("can't like comment");
    }
  }
}
