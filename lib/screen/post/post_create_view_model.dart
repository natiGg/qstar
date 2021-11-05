// ignore_for_file: constant_identifier_names

import 'package:flutter/foundation.dart';

class PostCreateViewModel extends ChangeNotifier {
  // ignore: constant_identifier_names
  static const TAG = 'PostCreateViewModel';

  List<String> locationSuggest = ['Addis Ababa', 'Adama', 'New York', 'Adama'];

  String? currentLocation;

  bool isShareFacebook = false;

  bool isShareTwitter = false;

  bool isShareTumblr = false;

  void setCurrentLocation(String? location) {
    currentLocation = location;
    notifyListeners();
  }

  void enableSocialShare(SocialShare type, bool value) {
    switch (type) {
      case SocialShare.FACEBOOK:
        isShareFacebook = value;
        break;
      case SocialShare.TWITTER:
        isShareTwitter = value;
        break;
      case SocialShare.TUMBLR:
        isShareTumblr = value;
        break;
    }
    notifyListeners();
  }
}

enum SocialShare { FACEBOOK, TWITTER, TUMBLR }
