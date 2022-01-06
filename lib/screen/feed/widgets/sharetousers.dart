// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/painting.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe

import 'package:qstar/constant.dart';
import 'package:qstar/screen/Chat/chat_screen.dart';

import 'package:qstar/screen/feed/model/user.dart';

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
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation1, animation2) =>
                              ChatScreen(
                            user: widget.user,
                            fromsshare: "yes",
                          ),
                          transitionDuration: Duration.zero,
                        ),
                      );
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 4,
                              color: Theme.of(context).scaffoldBackgroundColor),
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 2,
                                blurRadius: 10,
                                color: Colors.black.withOpacity(0.1),
                                offset: const Offset(0, 10))
                          ],
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  "https://qstar.mindethiopia.com/api/getProfilePicture/${widget.user.id}"))),
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
