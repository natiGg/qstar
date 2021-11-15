// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:qstar/network_utils/api.dart';
import 'package:qstar/screen/feed/model/user.dart';
import 'dart:convert';

class RemoteServices {
  static var res, body;

  static Future<List<User>> fetchSuggested() async {
    res = await Network().getData("friendSuggestion");
    var body = json.decode(res.body);
    if (res.statusCode == 200) {
      return body["data"].map((e) => User.fromJson(e)).toList().cast<User>();
      // return User.fromJson(jsonDecode(body["data"]));
    } else {
      throw Exception('Failed to load Users');
    }
  }
   static Future<List<User>> fetchHobbies() async {
    res = await Network().getData("friendSuggestion");
    var body = json.decode(res.body);
    if (res.statusCode == 200) {
      return body["data"].map((e) => User.fromJson(e)).toList().cast<User>();
      // return User.fromJson(jsonDecode(body["data"]));
    } else {
      throw Exception('Failed to load Users');
    }
  }

  static Future<bool> follow(String id) async {
    var data = {'following_id': id};
    res = await Network().getpassedData(data, "following");
    body = json.decode(res.body);
    if (res.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to Follow User');
    }
  }

  static Future<bool> unfollow(String id) async {
    var data = {'following_id': id};
    res = await Network().getpassedData(data, "delete");
    body = json.decode(res.body);
    if (res.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to unFollow User');
    }
  }

  static Future<User> fetchProfile(var id) async {
    res = await Network().getData("profile/${id.toString()}");

    var body = json.decode(res.body);
    if (res.statusCode == 200) { 
   
      return User.fromJson(body["data"]);
    } else {
         print(res.headers.toString());
      throw Exception('Failed to load User' + res.statusCode.toString());
    }
  }

  static Future<String> editprofile(var data,var id) async {
    res = await Network().getpassedData(data, "profile/${id}");
    body = json.decode(res.body);
    if (res.statusCode == 200) {
      print(body);
      return body.toString();
    } else {
      print(body.toString());
      throw Exception('Failed to edit profile');
    }
  }
}
