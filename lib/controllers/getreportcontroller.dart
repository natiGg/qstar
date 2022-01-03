import 'package:get/get.dart';

import 'package:qstar/remote_services/service.dart';
import 'package:qstar/screen/feed/model/user.dart';

class GeteportCategoryController extends GetxController {
  var list = <GetReportCategory>[].obs;
  var isfetched = false.obs;
  var sent = false.obs;

  void fetchReplay() async {
    list.value = await RemoteServices.getReportCategory();
    if (list.isNotEmpty) {
      isfetched(true);
    }
  }

  void sendReport(report_category_id, post_id) async {
    try {
      sent.value = await RemoteServices.sendReport(
        report_category_id,
        post_id,
      );
      if (sent.isTrue) {
        // fetchReplay(id);
      }
    } on Exception {
      throw Exception('Failed to send  Mesaage');
    }
  }
}
