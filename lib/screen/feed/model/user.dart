import 'package:get/get.dart';

class User {
  int id;
  String userName;
  String storyImage;
  String userImage;
  String name;
  String website;
  String bio;
  String email;
  // ignore: non_constant_identifier_names
  String country_code;
  // ignore: non_constant_identifier_names
  String phone_number;
  String gender;
  // ignore: non_constant_identifier_names
  String enable_suggestion;
  String status;
  // ignore: non_constant_identifier_names
  String date_of_birth;
  // ignore: non_constant_identifier_names
  String current_location;
  // ignore: non_constant_identifier_names
  String account_type;
  // ignore: non_constant_identifier_names
  String online_status;
  // ignore: non_constant_identifier_names
  String joined_date;
  String hobbies;

  // ignore: non_constant_identifier_names
  String total_followers;
  RxBool followed;

  String posts_count;
  String followers_count;
  String following_count;

  User({
    required this.id,
    required this.userName,
    required this.storyImage,
    required this.userImage,
    required this.name,
    required this.website,
    required this.bio,
    required this.email,
    // ignore: non_constant_identifier_names
    required this.country_code,
    // ignore: non_constant_identifier_names
    required this.phone_number,
    required this.gender,
    // ignore: non_constant_identifier_names
    required this.enable_suggestion,
    required this.status,
    // ignore: non_constant_identifier_names
    required this.date_of_birth,
    // ignore: non_constant_identifier_names
    required this.current_location,
    // ignore: non_constant_identifier_names
    required this.account_type,
    // ignore: non_constant_identifier_names
    required this.online_status,
    // ignore: non_constant_identifier_names
    required this.joined_date,
    required this.hobbies,
    // ignore: non_constant_identifier_names
    required this.total_followers,
    required this.followed,
    required this.posts_count,
    required this.followers_count,
    required this.following_count,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'] as int,
        userName: json['username'].toString(),
        storyImage: json['profile_pic_url'].toString(),
        userImage: json['profile_pic_url'].toString(),
        name: json['name'].toString(),
        website: json['website'].toString(),
        bio: json['bio'].toString(),
        email: json['email'].toString(),
        country_code: json['country_code'].toString(),
        phone_number: json['phone_number'].toString(),
        gender: json['gender'].toString(),
        enable_suggestion: json['enable_suggestion'].toString(),
        status: json['status'].toString(),
        date_of_birth: json['date_of_birth'].toString(),
        current_location: json['current_location'].toString(),
        account_type: json['account_type'].toString(),
        online_status: json['online_status'].toString(),
        joined_date: json['joined_date'].toString(),
        hobbies: json['hobbies'].toString(),
        total_followers: json['total_followers'].toString(),
        posts_count: json['posts_count'].toString(),
        followers_count: json['followers_count'].toString(),
        following_count: json['following_count'].toString(),
        followed: false.obs);
  }
}

class links {
  String fb_link;
  String instagram_link;
  String tiktok_link;
  String youtube_link;

  links({
    required this.fb_link,
    required this.instagram_link,
    required this.tiktok_link,
    required this.youtube_link,
  });

  factory links.fromJson(dynamic json) {
    return links(
      fb_link: json['fb_link'],
      instagram_link: json['instagram_link'],
      tiktok_link: json['tiktok_link'],
      youtube_link: json['youtube_link'],
    );
  }
}

class Feeling {
  String feeling;
  String icon;
  Feeling({required this.feeling, required this.icon});
}

class Userpf {
  int id;
  String full_name;
  String location;
  String country;
  String city;
  String phone_number;
  String height;
  String language;
  // ignore: non_constant_identifier_names
  String education;
  // ignore: non_constant_identifier_names
  String employment;
  String occupation;

  String age_min;
  String age_max;

  String pfgender;
  String religion;
  String min_height;
  String max_height;
  String pflanguage;
  String pfemployment;
  String pflocation;
  // ignore: non_constant_identifier_names

  Userpf({
    required this.id,
    required this.full_name,
    required this.location,
    required this.country,
    required this.city,
    required this.phone_number,
    required this.height,
    required this.language,
    // ignore: non_constant_identifier_names
    required this.education,
    // ignore: non_constant_identifier_names
    required this.employment,
    required this.occupation,
    required this.age_min,
    required this.age_max,
    required this.pfgender,
    required this.religion,
    required this.min_height,
    required this.max_height,
    required this.pflanguage,
    required this.pfemployment,
    required this.pflocation,

    // ignore: non_constant_identifier_names
  });

  factory Userpf.fromJson(Map<String, dynamic> json) {
    var pref = json["matchPreference"] as Map;

    return Userpf(
        id: pref["id"] as int,
        full_name: json['full_name'].toString(),
        location: json['location'].toString(),
        country: json['country'].toString(),
        city: json['city'].toString(),
        phone_number: json['phone_number'].toString(),
        height: json['height'].toString(),
        language: json['language'].toString(),
        education: json['education'].toString(),
        employment: json['employment'].toString(),
        occupation: json['occupation'].toString(),
        age_min: pref["age_min"].toString(),
        age_max: pref["age_max"].toString(),
        pfgender: pref["gender"].toString(),
        religion: json["religion"].toString(),
        min_height: pref["min_height"].toString(),
        max_height: pref["max_height"].toString(),
        pflanguage: pref["pflanguage"].toString(),
        pfemployment: pref["employment"].toString(),
        pflocation: pref["location"].toString());
  }
}

class Post {
  int userid;
  int id;
  String title;
  Post({required this.userid, required this.id, required this.title});
}

class Tag {
  // ignore: non_constant_identifier_names
  String number_of_posts;
  String hashtag;

  Tag({
    required this.number_of_posts,
    required this.hashtag,
  });

  factory Tag.fromJson(dynamic json) {
    return Tag(
      number_of_posts: json['number_of_posts'],
      hashtag: json['hashtag'],
    );
  }
}

class hashtagPost {
  int post_id;
  String fileurl;

  hashtagPost({
    required this.post_id,
    required this.fileurl,
  });

  factory hashtagPost.fromJson(Map<String, dynamic> json) {
    return hashtagPost(post_id: json["post_id"], fileurl: json["fileurl"]);
  }
}

class Place {
  // ignore: non_constant_identifier_names
  String number_of_posts;
  String location;

  Place({
    required this.number_of_posts,
    required this.location,
  });

  factory Place.fromJson(dynamic json) {
    return Place(
      number_of_posts: json['number_of_posts'],
      location: json['location'],
    );
  }
}

class PlacePost {
  int post_id;

  PlacePost({
    required this.post_id,
  });

  factory PlacePost.fromJson(Map<String, dynamic> json) {
    return PlacePost(post_id: json["post_id"]);
  }
}

class Location {
  String posts_num;
  String location;
  Location({required this.posts_num, required this.location});
  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
        posts_num: json["number_of_posts"], location: json["location"]);
  }
}

class videoCategory {
  int id;
  String title;
  String remark;

  videoCategory({
    required this.id,
    required this.title,
    required this.remark,
  });

  factory videoCategory.fromJson(Map<String, dynamic> json) {
    return videoCategory(
        id: json["id"], title: json["title"], remark: json["remark"]);
  }
}
