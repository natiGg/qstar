// ignore_for_file: deprecated_member_use

import 'dart:core';

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:qstar/constant.dart';

import 'package:qstar/screen/main/main_screen.dart';

import 'package:qstar/screen/register/verification.dart';
import 'package:qstar/screen/feed/model/user.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

List<User> _users = [
  User(id: 1, userName: "gelila", storyImage: "", userImage: ""),
  User(id: 2, userName: "natig", storyImage: "", userImage: ""),
  User(id: 3, userName: "bini", storyImage: "", userImage: ""),
  User(id: 4, userName: "yosi", storyImage: "", userImage: ""),
  User(id: 5, userName: "abrsh", storyImage: "", userImage: ""),
];
late int ratings = 3;
// ignore: non_constant_identifier_names
late double rating_d = 3;

class Suggested extends StatelessWidget {
  const Suggested({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
      color: Colors.white,
    );
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        mainAxisAlignment:
            MainAxisAlignment.center, //Center Column contents vertically,
        children: <Widget>[
          Column(
            children: [
              const Text(
                "Quick follow",
                style: TextStyle(
                  // we use the [TextStyle] widget to customize text
                  color: mPrimaryColor, // set the color
                  fontSize: 25.0,
                  fontFamily: 'font1', // and the font size
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Connect with your best friend on Qstar",
                style: TextStyle(
                    // we use the [TextStyle] widget to customize text
                    color: Colors.black, // set the color
                    fontSize: 15.0,
                    fontWeight: FontWeight.normal,
                    fontStyle: FontStyle.italic
                    // and the font size
                    ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 5, left: 30.0, right: 30),
                child: Text(
                  "Reward your 1st star to your profile by following suggested friends on Qstar.",
                  style: TextStyle(
                    color: mPrimaryColor,
                    decorationStyle: TextDecorationStyle.wavy,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: SizedBox(
                  height: 300,
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    children: [
                      const SizedBox(height: 4),
                      Column(
                          children:
                              _users.map((e) => SuggestedUsers(e)).toList())
                    ],
                  ),
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(36),
              ),
              color: mPrimaryColor,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MyHomePage(),
                  ),
                );
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16),
                alignment: Alignment.center,
                child: const Text(
                  'Get Started ',
                  style: textStyle,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SuggestedUsers extends StatelessWidget {
  final User user;

  // ignore: use_key_in_widget_constructors
  const SuggestedUsers(this.user);

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
      color: Colors.white,
    );
    return Column(children: <Widget>[
      Container(
        padding: const EdgeInsets.only(top: 10),
        child: Row(
          children: <Widget>[
            Container(
              height: 110,
              width: 110,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    'assets/images/profile${user.id}.jpg',
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 10, left: 20),
              height: 160,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.only(top: 10, left: 20),
                    child: Text(
                      "@Egele",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: mPrimaryColor),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 8, left: 26),
                    child: Text(
                      "Full name",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: mPrimaryColor),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 20),
                    child: RatingBarIndicator(
                      rating: rating_d,
                      itemBuilder: (context, index) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      itemCount: ratings,
                      itemSize: 20.0,
                      direction: Axis.horizontal,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 10, left: 20),
                    child: Text(
                      "127K",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: mPrimaryColor),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 20),
                    child: SizedBox(
                      width: 100,
                      height: 30,
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(36),
                        ),
                        color: mPrimaryColor,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const Verification();
                              },
                            ),
                          );
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          alignment: Alignment.center,
                          child: const Text(
                            'Follow',
                            style: textStyle,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ]);
  }
}
