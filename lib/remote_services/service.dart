// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:qstar/network_utils/api.dart';
import 'package:qstar/screen/feed/model/user.dart';
import 'dart:convert';
import 'package:qstar/screen/register/model/hobbies.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

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

    static Future<List<User>> fetchFollowers(String querys) async {
    res = await Network().getData("friendship/170/followers");
    var body = json.decode(res.body);
    if (res.statusCode == 200) {
      return body["data"].map((e) => User.fromJson(e)).where((user){
        final uname=user.userName.toLowerCase().toString();
        final query=querys.toLowerCase();
        return uname.contains(query);
      }).toList().cast<User>();
      // return User.fromJson(jsonDecode(body["data"]));
    } else {
      throw Exception('Failed to load Users');
    }
  }

  static Future<List<User>> fetchallFollowers() async {
    res = await Network().getData("friendship/170/followers");
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
    // ignore: unnecessary_null_comparison
    if (image != null) {
      var stream =
          // ignore: deprecated_member_use
          http.ByteStream(DelegatingStream.typed(image.openRead()));
      var length = await image.length();
      // create multipart request
      res = await Network()
          .uploadFile("updateProfilePicture/${id}", image, stream, length);

      if (res.statusCode == 200) {
        res.stream.transform(utf8.decoder).listen((value) {});
        return true;
      } else {
        throw Exception('Failed to Upload file');
      }
    } else {
      return false;
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
      throw Exception('Failed to load User' + res.statusCode.toString());
    }
  }

  static Future<String> editprofile(var data, var id) async {
    // ignore: unnecessary_brace_in_string_interps
    res = await Network().getpassedData(data, "profile/${id}");
    body = json.decode(res.body);
    if (res.statusCode == 200) {
      return res.statusCode.toString();
    } else {
      Map<String, dynamic> map = body["errors"];
      return map.toString();
    }
  }

  static Future<bool> cheakpf() async {
    // ignore: unnecessary_brace_in_string_interps
    res = await Network().getData("personalInformation");
    print(res.body.toString());
    if (res.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future<Userpf> fetchpf() async {
    res = await Network().getData("personalInformation");

    var body = json.decode(res.body);
    if (res.statusCode == 200) {
      return Userpf.fromJson(body["data"]);
    } else {
      throw Exception('Failed to load User' + res.statusCode.toString());
    }
  }

  static Future<String> createPost(var image, var data) async {
    // create multipart request
    res = await Network().postFile("post", image, data);

    if (res.statusCode == 200) {
      res.stream.transform(utf8.decoder).listen((value) {});
      return res.statusCode.toString();
    } else {
      throw Exception("can't post");
    }
  }

  static Future<String> updatePersonalInfo(var data) async {
    List<String> errors = [];
    // create multipart request
    res = await Network().getpassedData(data, "personalInformation");

    body = json.decode(res.body);
    print(body.toString());
    if (res.statusCode == 200) {
      return res.statusCode.toString();
    } else {
      if (body["message"] != null) {
        return body["message"].toString();
      } else {
        Map<String, dynamic> map = body["errors"];
        map.forEach((key, value) {
          errors.add(value[0].toString());
        });

        return errors.join("\n").toString();
      }
    }
  }

  static Future<String> editPersonalInfo(var data) async {
    List<String> errors = [];
    // create multipart request
    res = await Network().getpassedData(data, "personalInformation");

    body = json.decode(res.body);
    print(res.statusCode.toString());
    if (res.statusCode == 200) {
      return res.statusCode.toString();
    } else {
      if (body["message"] != null) {
        return body["message"].toString();
      } else {
        Map<String, dynamic> map = body["errors"];
        map.forEach((key, value) {
          errors.add(value[0].toString());
        });

        return errors.join("\n").toString();
      }
    }
  }
}
