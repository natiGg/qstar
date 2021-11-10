import 'package:qstar/network_utils/api.dart';
import 'package:qstar/screen/feed/model/user.dart';
import 'dart:convert';

class RemoteServices {
  static var res, body;

  static Future<List<User>> fetchSuggested() async {
    print("about to fetch suggested");
    res = await Network().getData("friendSuggestion");
    var body = json.decode(res.body);
    if (res.statusCode == 200) {
      print(body["data"].toString());
      return body["data"].map((e) => User.fromJson(e)).toList().cast<User>();
      // return User.fromJson(jsonDecode(body["data"]));
    } else {
      throw Exception('Failed to load Users');
    }
  }

  static Future<bool> follow(String id) async {
    print("about to follow");
    var data = {'following_id': id};
    res = await Network().getpassedData(data, "following");
    body = json.decode(res.body);
    if (res.statusCode == 200) {
      print('user successfully followed');
      return true;
    } else {
      throw Exception('Failed to Follow User');
    }
  }

  static Future<bool> unfollow(String id) async {
    print("about to unfollow");
    var data = {'following_id': id};
    res = await Network().getpassedData(data, "delete");
    body = json.decode(res.body);
    if (res.statusCode == 200) {
      print('user successfully unfollowed');
      return true;
    } else {
      throw Exception('Failed to unFollow User');
    }
  }

  static Future<User> fetchProfile(var id) async {
    print("about to fetch suggested" + id.toString());
    res = await Network().getData("profile/${id.toString()}");
    print(json.decode(res.body).toString());
    var body = json.decode(res.body);
    if (res.statusCode == 200) {
      print(json.decode(res.body.toString()).toString());
      return User.fromJson(jsonDecode(body["data"].toString()));
    } else {
      throw Exception('Failed to load User' + res.statusCode.toString());
    }
  }

  static Future<List> editprofile(var data) async {
    print("about to unfollow");
    res = await Network().getpassedData(data, "delete");
    body = json.decode(res.body);
    if (res.statusCode == 200) {
      print('user successfully unfollowed');
      return body;
    } else {
      throw Exception('Failed to unFollow User');
    }
  }
}
