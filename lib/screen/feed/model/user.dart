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

  User(
      {required this.id,
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
      required this.followed});

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
        followed: false.obs);
  }
}

class Post {
  int userid;
  int id;
  String title;
  Post({required this.userid, required this.id, required this.title});
}
