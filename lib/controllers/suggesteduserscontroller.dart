import 'package:get/state_manager.dart';
import 'package:qstar/screen/feed/model/user.dart';
import 'package:qstar/remote_services/service.dart';

class SuggestedUserController extends GetxController {
  var isLoading = true.obs;
  RxBool btnLoading = false.obs;
  var uid=0.obs;
  

  var suggestObjs = <User>[].obs;


  @override
  void onInit() {
    // TODO: implement onInit
    print("controller initialized");
    fetchSuggeted();
    super.onInit();
  }
  updateId(var id)
  {
    uid(id);
  }
  void fetchSuggeted() async {

    try { 
      isLoading(true);
      var suggested = await RemoteServices.fetchSuggested();
      if(suggested.length >= 1)
      {
        suggestObjs.value = suggested;
      }
    } finally {
      // TODO 
      isLoading(false);
    }
  
  }
   void follow() async {

    try { 
      btnLoading(true);

      var uFollowed = await RemoteServices.follow(uid.value.toString());
      if(uFollowed)
      {
        print(uid.toString());
        final int index = suggestObjs.value.indexWhere((element) => element.id.toInt() == uid.toInt());
        print(index); 
        print(suggestObjs.value[index].followed);
        suggestObjs.value[index].followed.value= true;
        print("user clicked followed");
      }
    } finally {
      // TODO 
       btnLoading(false);
    }
  
  }
     void unfollow() async {

    try { 
      btnLoading(true);

      var unFollowed = await RemoteServices.follow(uid.value.toString());
      if(unFollowed)
      {
        print(uid.toString());
        final int index = suggestObjs.value.indexWhere((element) => element.id.toInt() == uid.toInt());
        print(index); 
        print(suggestObjs.value[index].followed);
        suggestObjs.value[index].followed.value= false;
        print("user clicked unfollowed");
      }
    } finally {
      // TODO 
       btnLoading(false);
    }
  
  }



}