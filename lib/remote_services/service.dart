// ignore_for_file: prefer_typing_uninitialized_variables, unnecessary_brace_in_string_interps, duplicate_ignore

import 'package:qstar/network_utils/api.dart';
import 'package:qstar/screen/feed/model/feed.dart';
import 'package:qstar/screen/feed/model/user.dart';
import 'dart:convert';
import 'package:qstar/screen/register/model/hobbies.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:async/async.dart';

class RemoteServices {
  static var res, body;
  static List<String> sent = [];

  static Future<List<Feeds>> fetchFeed() async {
    res = await Network().getData("feedUpdate");
    var body = json.decode(res.body);
    if (res.statusCode == 200) {
      return body["feed"].map((e) => Feeds.fromJson(e)).toList().cast<Feeds>();
    } else {
      throw Exception('Failed to load Feed');
    }
  }

  static Future<List<Feeds>> refreshFeed() async {
    res = await Network().getData("oldFeedUpdate");
    var body = json.decode(res.body);
    if (res.statusCode == 200) {
      return body["feed"].map((e) => Feeds.fromJson(e)).toList().cast<Feeds>();
    } else {
      throw Exception('Failed to load Feed');
    }
  }

  static Future<bool> likePost(var id) async {
    var data = {'post_id': id};
    res = await Network().getpassedData(data, "postlike");
    var body = json.decode(res.body);

    if (res.statusCode == 200) {
      print(body);
      return true;
    } else {
      throw Exception('Failed to like');
    }
  }

  static Future<bool> dislikePost(var id) async {
    res = await Network().getdeleteData("postlike/${id}");

    if (res.statusCode == 200) {
      print("disliked");
      return true;
    } else {
      throw Exception('Failed to like');
    }
  }

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

  static Future<bool> checkFollowers(var checkId, var id) async {
    res = await Network().getData("friendship/${id}/following");
    var body = json.decode(res.body);
    if (res.statusCode == 200) {
      var check = body["data"]
          .map((e) => User.fromJson(e))
          .where((user) {
            final uid = user.id.toString();

            return uid == checkId.toString();
          })
          .toList()
          .cast<User>();
      if (check.toList().isNotEmpty) {
        return true;
      } else {
        return false;
      }
      // return User.fromJson(jsonDecode(body["data"]));
    } else {
      if (body['data'] == null) {
        return false;
      } else {
        throw Exception('Failed to load Users');
      }
    }
  }

  static Future<List<User>> fetchallFollowing(var id) async {
    res = await Network().getData("friendship/${id}/following");
    var body = json.decode(res.body);

    if (res.statusCode == 200) {
      return body["data"].map((e) => User.fromJson(e)).toList().cast<User>();
      // return User.fromJson(jsonDecode(body["data"]));
    } else {
      throw Exception('Failed to load Users');
    }
  }

  static Future<List<User>> fetchallFollower(var id) async {
    res = await Network().getData("friendship/${id}/followers");
    var body = json.decode(res.body);
    if (res.statusCode == 200) {
      return body["data"].map((e) => User.fromJson(e)).toList().cast<User>();
      // return User.fromJson(jsonDecode(body["data"]));
    } else {
      throw Exception('Failed to load Users');
    }
  }

  static Future<List<Locations>> fetchallPlaces() async {
    res = await Network().getData("placeSearch");
    var body = json.decode(res.body);

    if (res.statusCode == 200) {
      return body["data"]
          .map((e) => Locations.fromJson(e))
          .toList()
          .cast<Locations>();
      // return User.fromJson(jsonDecode(body["data"]));
    } else {
      throw Exception('Failed to load Users');
    }
  }

  static Future<List<User>> fetachsearch(var uname) async {
    res = await Network().getData("accountSearch?q=${uname}");
    var body = json.decode(res.body);

    if (res.statusCode == 200) {
      return body["data"].map((e) => User.fromJson(e)).toList().cast<User>();

      // return User.fromJson(jsonDecode(body["data"]));
    } else {
      throw Exception('Failed to load Users');
    }
  }

  static Future<List<Tag>> fetachsearchtag(var uname) async {
    res = await Network().getData("tagSearch?q=${uname}");
    var body = json.decode(res.body);
    if (res.statusCode == 200) {
      return body["data"].map((e) => Tag.fromJson(e)).toList().cast<Tag>();

      // return User.fromJson(jsonDecode(body["data"]));
    } else {
      throw Exception('Failed to load Users');
    }
  }

  static Future<List<hashtagPost>> hashtagdetail(var uname) async {
    res = await Network().getData("hashtagSearch?tag=${uname}");
    var body = json.decode(res.body);

    if (res.statusCode == 200) {
      return body["data"]
          .map((e) => hashtagPost.fromJson(e))
          .toList()
          .cast<hashtagPost>();

      // return User.fromJson(jsonDecode(body["data"]));
    } else {
      throw Exception('Failed to load Users');
    }
  }

  static Future<List<Place>> fetachsearchplace(var uname) async {
    res = await Network().getData("placeSearch?q=${uname}");
    var body = json.decode(res.body);
    if (res.statusCode == 200) {
      return body["data"].map((e) => Place.fromJson(e)).toList().cast<Place>();

      // return User.fromJson(jsonDecode(body["data"]));
    } else {
      throw Exception('Failed to load Users');
    }
  }

  static Future<List<videoCategory>> getvideoCategory() async {
    res = await Network().getData("videoCategory");
    var body = json.decode(res.body);

    if (res.statusCode == 200) {
      return body["data"]
          .map((e) => videoCategory.fromJson(e))
          .toList()
          .cast<videoCategory>();

      // return User.fromJson(jsonDecode(body["data"]));
    } else {
      throw Exception('Failed to load Users');
    }
  }

  static Future<List<PlacePost>> placedetail(var uname) async {
    res = await Network().getData("locationPostSearch?location=${uname}");
    var body = json.decode(res.body);

    if (res.statusCode == 200) {
      return body["data"]
          .map((e) => PlacePost.fromJson(e))
          .toList()
          .cast<PlacePost>();

      // return User.fromJson(jsonDecode(body["data"]));
    } else {
      throw Exception('Failed to load Users');
    }
  }

  static Future<List<User>> fetchPerfectMatch() async {
    res = await Network().getData("myPerfectMatch");
    var body = json.decode(res.body);
    if (res.statusCode == 200) {
      return body["data"].map((e) => User.fromJson(e)).toList().cast<User>();
      // return User.fromJson(jsonDecode(body["data"]));
    } else {
      throw Exception('Failed to load Users');
    }
  }

  static Future<List<User>> refreshMatch() async {
    res = await Network().getData("refreshMatch");
    var body = json.decode(res.body);
    if (res.statusCode == 200) {
      return body["data"].map((e) => User.fromJson(e)).toList().cast<User>();
      // return User.fromJson(jsonDecode(body["data"]));
    } else {
      throw Exception('Failed to Load Users');
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
    res = await Network().getdeleteData("following/${id}");
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

  static Future<links> fetchProfilelink(var id) async {
    res = await Network().getData("profile/${id.toString()}/links");

    var body = json.decode(res.body);
    if (res.statusCode == 200) {
      return links.fromJson(body);
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

  static Future<String> updatepass(var data, var id) async {
    // ignore: unnecessary_brace_in_string_interps
    res = await Network().getpassedData(data, "changePassword/${id}");
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

    if (res.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> machpf() async {
    // ignore: unnecessary_brace_in_string_interps
    res = await Network().getData("myPerfectMatch");
    var body = json.decode(res.body);

    if (body["data"].isEmpty) {
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
    print(data);
    // create multipart request
    res = await Network().postFile("post", image, data);
    print(res.statusCode.toString());
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

  static Future<String> editPassword(var data) async {
    List<String> errors = [];
    // create multipart request
    res = await Network().getpassedData(data, "changePassword");

    body = json.decode(res.body);

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

  static Future<bool> sendmessage(
      var content, var messageType, var receivingProfileId) async {
    var data = {
      'content': content,
      'message_type': messageType,
      'receiving_profile_id': receivingProfileId,
    };
    res = await Network().getpassedData(data, "message");
    body = json.decode(res.body);
    // ignore: avoid_print

    if (res.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to send  Mesaage');
    }
  }

  static Future<List<Getmessage>> getmessage(var id) async {
    res = await Network().getData("message/${id}/conversation");
    var body = json.decode(res.body);

    if (res.statusCode == 200) {
      return body["data"]
          .map((e) => Getmessage.fromJson(e))
          .toList()
          .cast<Getmessage>();
      // return User.fromJson(jsonDecode(body["data"]));
    } else {
      throw Exception('Failed to Load Users');
    }
  }

  static Future<List<RecentChat>> recentchat() async {
    res = await Network().getData("recentConversation");
    var body = json.decode(res.body);

    print(body);
    if (res.statusCode == 200) {
      return body["data"]
          .map((e) => RecentChat.fromJson(e))
          .toList()
          .cast<RecentChat>();
      // return User.fromJson(jsonDecode(body["data"]));
    } else {
      throw Exception('Failed to load Users');
    }
  }

  static Future<List<GetComment>> getcomment(var id) async {
    res = await Network().getData("post/${id}/coments");
    var body = json.decode(res.body);

    print(body);
    if (res.statusCode == 200) {
      return body["data"]
          .map((e) => GetComment.fromJson(e))
          .toList()
          .cast<GetComment>();
      // return User.fromJson(jsonDecode(body["data"]));
    } else {
      throw Exception('Failed to load Users');
    }
  }

  static Future<bool> sendcomment(var comment, var post_id) async {
    var data = {
      'comment': comment,
      'post_id': post_id,
    };
    res = await Network().getpassedData(data, "postcomment");
    body = json.decode(res.body);
    // ignore: avoid_print

    if (res.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to send  Mesaage');
    }
  }
}
