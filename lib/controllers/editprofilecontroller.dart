import 'package:get/state_manager.dart';
import 'package:qstar/screen/feed/model/user.dart';
import 'package:qstar/remote_services/service.dart';

class EditprofileController extends GetxController with StateMixin{
  RxBool isLoading = true.obs;
  RxBool btnLoading = false.obs;
  
  var uid = 0.obs;
var suggested;
  var suggestObjs =<User>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    print("controller initialized");
    super.onInit();
  }

  void fetchProfile(var id) async {
     

        try {
          suggested = await RemoteServices.fetchProfile(id);
               
          if (suggested.id != null) {
               isLoading(false);
               change(suggested,status:RxStatus.success());
          
          }
          else {
            change(null,status: RxStatus.empty());
          }
        } on Exception catch (e) {
       change(null,status: RxStatus.error("Something went wrong"));
        }
        
     
       
  }

  void editProf() async {
    try {
      btnLoading(true);

      var uFollowed = await RemoteServices.follow(uid.value.toString());
      if (uFollowed) {
        print(uid.toString());
        final int index = suggestObjs.value
            .indexWhere((element) => element.id.toInt() == uid.toInt());
        print(index);
        print(suggestObjs.value[index].followed);
        suggestObjs.value[index].followed.value = true;
        print("user clicked followed");
      }
    } 
    finally {
      // TODO
      btnLoading(false);
    }
  }
  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
