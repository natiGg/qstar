// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/painting.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe

import 'package:qstar/constant.dart';

import 'package:qstar/screen/feed/model/user.dart';

import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class UserAvatar extends StatefulWidget {
  final User user;
  const UserAvatar(this.user);

  @override
  State<UserAvatar> createState() => _UserAvatarState();
}

class _UserAvatarState extends State<UserAvatar> {
  bool isFollowed = false;

  @override
  Widget build(BuildContext context) {
    // return Container(
    //   margin: EdgeInsets.all(6),
    //   child:Column(
    //     children: [
    //       CircleAvatar(
    //         radius: 37,
    //         backgroundColor: Colors.red.shade200,
    //         child: CircleAvatar(
    //           radius: 36,
    //           backgroundColor:Colors.white,
    //           child: CircleAvatar(
    //             radius:32,
    //             backgroundImage: AssetImage('assets/images/profile${this.user.id}.jpg')),
    //         ),
    //       ),
    //       SizedBox(height:3),
    //       Text('${this.user.userName}',style: TextStyle(color: Colors.white))
    //     ],
    //   ) ,
    // );
    return Column(children: [
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Card(
          elevation: 2,
          child: Row(
              children: List.generate(1, (index) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        width: 68,
                        height: 68,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                                colors: [mPrimaryColor, mPrimaryColor],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter)),
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.white, width: 2),
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/profile${widget.user.id}.jpg'),
                                    fit: BoxFit.cover),
                              )),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isFollowed = !isFollowed;
                          });
                        },
                        child: followButton(isFollowed),
                      )
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
                  RatingBarIndicator(
                    rating: 3,
                    // ignore: prefer_const_constructors
                    itemBuilder: (context, index) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    itemCount: 3,
                    itemSize: 20.0,
                    direction: Axis.horizontal,
                  ),
                  Container(
                    color: Colors.white,
                    height: 60,
                    width: 80,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const <Widget>[
                        Text(
                          "12k",
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "followers",
                          style: TextStyle(fontSize: 12, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          })),
        ),
      )
    ]);
  }

  Widget followButton(isFollowed) {
    return Container(
        margin: const EdgeInsets.only(left: 50),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: mPrimaryColor, width: 1),
        ),
        child: CircleAvatar(
          radius: 9,
          backgroundColor: isFollowed ? mPrimaryColor : Colors.white,
          child: Center(
              child: Icon(isFollowed ? Icons.check : Icons.add,
                  size: 16, color: isFollowed ? Colors.white : mPrimaryColor)),
        ));
  }
}
