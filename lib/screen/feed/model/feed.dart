// ignore_for_file: non_constant_identifier_names

import 'package:qstar/screen/feed/model/user.dart';

class Feeds {
  int id;
  Posts posts;
  Dimensions dimension;
  String display_url;
  bool is_video;
  String tracking_token;
  bool comments_disabled;
  String location;
  bool viewer_has_liked;
  bool viewer_has_saved;
  bool viewer_in_photo_of_you;
  bool viewer_can_reshare;

  Feeds(
      {required this.id,
      required this.posts,
      required this.dimension,
      required this.display_url,
      required this.is_video,
      required this.tracking_token,
      required this.comments_disabled,
      required this.location,
      required this.viewer_has_liked,
      required this.viewer_has_saved,
      required this.viewer_in_photo_of_you,
      required this.viewer_can_reshare});

  factory Feeds.fromJson(Map<String, dynamic> json) {
    return Feeds(
        id: json["id"],
        posts: Posts.fromJson(json["post"]),
        dimension: Dimensions.fromJson(json["dimensions"]),
        display_url: json["display_url"],
        is_video: json["is_video"],
        tracking_token: json["tracking_token"],
        comments_disabled: json["comments_disabled"],
        location: json["location"],
        viewer_has_liked: json["viewer_has_liked"],
        viewer_has_saved: json["viewer_has_saved"],
        viewer_in_photo_of_you: json["viewer_in_photo_of_you"],
        viewer_can_reshare: json["viewer_can_reshare"]);
  }
}



class Dimensions {
  int width;
  int height;
  Dimensions({required this.width, required this.height});
  factory Dimensions.fromJson(Map<String, dynamic> json) {
    return Dimensions(
        height: json["height"] as int, width: json["width"] as int);
  }
}

class Posts {
  int post_id;
  String date;
  String caption;
  String file_url;
  List<String> post_files;
  LikePreview like_preview;
  CommentPreview comment_preview;
  List<Tags> post_tags;
  User profile;
  String is_image;
  Posts(
      {required this.post_id,
      required this.date,
      required this.caption,
      required this.file_url,
      required this.post_files,
      required this.like_preview,
      required this.comment_preview,
      required this.post_tags,
      required this.profile,
      required this.is_image
      });
  factory Posts.fromJson(Map<String, dynamic> json) {
    return Posts(
        post_id: json["post_id"] as int,
        date: json["date"].toString(),
        caption: json["caption"].toString(),
        file_url: json["file_url"].toString(),
        post_files: json["post_files"].cast<String>(),
        like_preview: LikePreview.fromJson(json["like_preview"]),
        comment_preview: CommentPreview.fromJson(json["comment_preview"]),
        post_tags: (json["post_tags"] as List)
            .map((tags) => Tags.fromJson(tags))
            .toList(),
        profile: User.fromJson(json["profile"]),
        is_image: json["is_image"].toString());
  }
}

class LikePreview {
  int count;
  List<String> previews;
  LikePreview({required this.count, required this.previews});
  factory LikePreview.fromJson(Map<String, dynamic> json) {
    return LikePreview(
        count: json["count"], previews: json["previews"].cast<String>());
  }
}

class CommentPreview {
  int count;
  List<String> previews;
  CommentPreview({required this.count, required this.previews});
  factory CommentPreview.fromJson(Map<String, dynamic> json) {
    return CommentPreview(
        count: json["count"], previews: json["previews"].cast<String>());
  }
}

class Tags {
  int id;
  User profile;

  Tags({
    required this.id,
    required this.profile
  });

  factory Tags.fromJson(Map<String,dynamic> json){
    print(json["profile"]);
    return Tags(
      id: json['id'], 
      profile: User.fromJson(json["profile"][0]));
  }
}