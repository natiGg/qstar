import 'dart:convert';

class User {
  int id;
  String userName;
  String storyImage;
  String userImage;
  String name;
  String website;
  String bio;
  String email;
  String country_code;
  String phone_number;
  String gender;
  String enable_suggestion;
  String status;
  String date_of_birth;
  String current_location;
  String account_type;
  String online_status;
  String joined_date;
  String hobbies;
  String total_followers;

  User(
      {required this.id,
      required this.userName,
      required this.storyImage,
      required this.userImage,
      required this.name,
      required this.website,
      required this.bio,
      required this.email,
      required this.country_code,
      required this.phone_number,
      required this.gender,
      required this.enable_suggestion,
      required this.status,
      required this.date_of_birth,
      required this.current_location,
      required this.account_type,
      required this.online_status,
      required this.joined_date,
      required this.hobbies,
      required this.total_followers});

  factory User.fromJson(Map<String, dynamic> json) {
    print("olla");
    print(json);

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
        total_followers: json['total_followers'].toString());
  }
}

class Post {
  int userid;
  int id;
  String title;
  Post({required this.userid, required this.id, required this.title});
}
