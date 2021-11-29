import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:qstar/remote_services/service.dart';
import 'package:qstar/screen/register/model/hobbies.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class HobbiesController extends GetxController with StateMixin {
  // ignore: prefer_typing_uninitialized_variables
  var hobbies;
  List<MultiSelectItem<Hobbies>> hobItem = [];
  // ignore: prefer_typing_uninitialized_variables
  var items;
  var isLoading = true.obs;
  late List<Hobbies> hobbyitems;

  @override
  void onInit() {
    // TODO: implement onInit
    fetchHobbies();
    super.onInit();
  }

  void fetchHobbies() async {
    try {
      hobbies = await RemoteServices.fetchHobbies();
      if (hobbies != null) {
        hobbyitems = hobbies;
        if (hobbyitems != null) {
          hobItem = hobbyitems
              .map((hobbies) => MultiSelectItem<Hobbies>(hobbies, hobbies.name))
              .toList();
        }

        isLoading(false);

        change(hobbies, status: RxStatus.success());
      } else {
        change(null, status: RxStatus.empty());
      }
    } on Exception {
      change(null, status: RxStatus.error("Something went wrong"));
    }
  }
}
