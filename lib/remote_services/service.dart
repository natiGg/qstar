// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:qstar/network_utils/api.dart';
import 'package:qstar/screen/feed/model/user.dart';
import 'dart:convert';
import 'package:qstar/screen/register/model/hobbies.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:async/async.dart';

class RemoteServices {
  static var res, body;
  static List<String> sent = [];

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

  static Future<List<String>> checkUname(String uname) async {
    var data = {'username': uname};
    res = await Network().authData(data, "validateUsername");
    body = json.decode(res.body);

    if (res.statusCode == 200) {
      sent = [
        res.statusCode.toString(),
        body["data"].toString(),
        body["message"].toString()
      ];
      return sent;
    } else if (res.statusCode == 422) {
      Map<String, dynamic> map = body["errors"];
      List<dynamic> data = map["username"];
      sent = [
        res.statusCode.toString(),
        data[0]["message"].toString(),
        data[0]["suggestion"].toString()
      ];
      return sent;
    } else {
      throw Exception('Failed to check username');
    }
  }

  static Future<List<String>> checkEmail(String uname) async {
    var data = {'username': uname};
    res = await Network().authData(data, "validateEmail");
    body = json.decode(res.body);

    if (res.statusCode == 200) {
      sent = [
        res.statusCode.toString(),
        body["success"].toString(),
        body["message"].toString()
      ];
      return sent;
    } else if (res.statusCode == 422) {
      Map<String, dynamic> map = body["errors"];
      List<dynamic> data = map["email"];
      sent = [res.statusCode.toString(), data[0].toString()];
      return sent;
    } else {
      throw Exception('Failed to check email');
    }
  }

  static Future<List<String>> changeUname(String uname) async {
    var data = {'username': uname};
    res = await Network().authData(data, "validateEmail");
    body = json.decode(res.body);

    if (res.statusCode == 200) {
      sent = [
        res.statusCode.toString(),
        body["success"].toString(),
        body["message"].toString()
      ];
      return sent;
    } else if (res.statusCode == 422) {
      Map<String, dynamic> map = body["errors"];
      List<dynamic> data = map["email"];
      sent = [res.statusCode.toString(), data[0].toString()];
      return sent;
    } else {
      throw Exception('Failed to check email');
    }
  }

  static Future<List<Hobbies>> fetchHobbies() async {
    res = await Network().getData("lookup?type=hobbies");
    var body = json.decode(res.body);
    var lookups;
    if (res.statusCode == 200) {
      lookups = body["lookups"];
      print(lookups["data"]);
      return lookups["data"]
          .map((e) => Hobbies.fromJson(e))
          .toList()
          .cast<Hobbies>();
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

  static Future<bool> uploadImage(File image, String id) async {
    var data = {'following_id': id};
    var stream = new http.ByteStream(DelegatingStream.typed(image.openRead()));
    var length = await image.length();
    // create multipart request
    res = await Network()
        .uploadFile("updateProfilePicture/${id}", image, stream, length);

    if (res.statusCode == 200) {
      res.stream.transform(utf8.decoder).listen((value) {
        print(value);
      });
      return true;
    } else {
      print(res.statusCode);

      throw Exception('Failed to Upload file');
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

  static Future<String> editprofile(var data, var id) async {
    res = await Network().getpassedData(data, "profile/${id}");
    body = json.decode(res.body);
    if (res.statusCode == 200) {
      print(body);
      return res.statusCode.toString();
    } else {
      Map<String, dynamic> map = body["errors"];
      return map.toString();
    }
  }
    static Future<String> createPost(File image,var data) async {
      var stream = new http.ByteStream(DelegatingStream.typed(image.openRead()));
    var length = await image.length();
    // create multipart request
    res = await Network().postFile("post",image,stream,length,data);
    body = json.decode(res.body);
    if (res.statusCode == 200) 
    {
      print(body);
      return res.statusCode.toString();
    } else {
      Map<String, dynamic> map = body["errors"];
      return map.toString();
    }
  }
}
