// ignore_for_file: deprecated_member_use, duplicate_ignore, non_constant_identifier_names, sized_box_for_whitespace, avoid_unnecessary_containers, use_key_in_widget_constructors

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




class Refresh extends StatefulWidget {
  @override
  State<Refresh> createState() => RefreshState();
}

class RefreshState extends State<Refresh> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2))
          ..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, child) {
        return Transform.rotate(
          angle: _controller.value * 5 * pi,
          child: child,
        );
      },
      child: Icon(
        FontAwesome.refresh,
        color: mPrimaryColor,
      ),
    );
  }
}

// TypeAheadFormField<User?>(
//   hideOnEmpty: true,
//   textFieldConfiguration:
//       TextFieldConfiguration(
//     controller:
//         postController.captionController,
//     decoration:
//         const InputDecoration.collapsed(
//             hintText:
//                 'What\'s on your mind?',
//             hintStyle: TextStyle(
//               fontSize: 15,
//             )),
//   ),
//   suggestionsCallback:
//       RemoteServices.fetchFollowers,
//   itemBuilder:
//       (context, User? suggestion) {
//     final user = suggestion!;
//     return ListTile(
//       leading: CircleAvatar(
//         backgroundImage: NetworkImage(
//             "https://qstar.mindethiopia.com/api/getProfilePicture/${user.id}"),
//       ),
//       title: Text(user.name),
//     );
//   },
//   onSuggestionSelected:
//       (User? suggestion) {
//     final user = suggestion;
//     ScaffoldMessenger.of(context)
//       ..removeCurrentSnackBar()
//       ..showSnackBar(SnackBar(
//         content: Text(
//             'Selected user: ${user!.name}'),
//       ));
//   },
//   validator: (value) {
//     return postController
//         .validateCaption(value!);
//   },
// )