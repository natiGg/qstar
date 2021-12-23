// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/painting.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe

import 'package:qstar/constant.dart';

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
