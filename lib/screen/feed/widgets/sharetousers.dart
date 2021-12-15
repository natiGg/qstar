import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:camera_camera/camera_camera.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:image_picker/image_picker.dart';
import 'package:need_resume/need_resume.dart';
import 'package:qstar/controllers/editprofilecontroller.dart';
import 'package:qstar/controllers/feedcontroller.dart';
import 'package:qstar/controllers/perfectmatchcontroller.dart';
import 'package:qstar/controllers/postcontroller.dart';
import 'package:qstar/remote_services/service.dart';
import 'package:qstar/screen/comment/comment_widget.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_icons/flutter_icons.dart';

import 'package:qstar/constant.dart';
import 'package:qstar/screen/feed/model/feed.dart';

import 'package:qstar/screen/feed/model/user.dart';

import 'package:qstar/screen/feed/widgets/info_widget.dart';

import 'package:qstar/screen/post/main.dart';
import 'package:qstar/screen/Chat/home_screen.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:get/get.dart';
import 'package:qstar/screen/post/preview_screen_gallery.dart';

import 'package:qstar/screen/profile/PerfectMatch/Progress.dart';
import 'package:qstar/screen/profile/PerfectMatch/profile.dart';
import 'package:qstar/screen/profile/profile.dart';
import 'package:qstar/screen/qvideo/userprofile.dart';
import 'package:qstar/screen/qvideo/videoPreview.dart';
import 'package:qstar/screen/qvideo/videopicker.dart';
import 'package:qstar/screen/register/phonevarification.dart';
import 'package:video_player/video_player.dart';
import 'package:qstar/screen/search/search.dart';
import 'package:qstar/screen/feed/bottomsheet/app_context.dart';
import 'package:qstar/screen/feed/bottomsheet/bottom_sheet_action.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';




class UserAvater2 extends StatefulWidget {
  final User user;
  const UserAvater2(this.user);

  @override
  State<UserAvater2> createState() => _UserAvatarState2();
}

class _UserAvatarState2 extends State<UserAvater2> {
  bool isFollowed = false;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
          children: List.generate(1, (index) {
        return Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                            colors: [mPrimaryColor, mPrimaryColor],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter)),
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Container(
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 2),
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: AssetImage(
                                    'assets/images/profile${widget.user.id}.jpg'),
                                fit: BoxFit.cover),
                          )),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Center(
                  child: Text(
                widget.user.userName,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: mPrimaryColor),
              )),
            ],
          ),
        );
      }))
    ]);
  }
}