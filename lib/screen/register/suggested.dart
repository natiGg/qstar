// ignore_for_file: deprecated_member_use, prefer_typing_uninitialized_variables

import 'dart:core';

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:qstar/constant.dart';

import 'package:qstar/screen/main/main_screen.dart';

import 'package:qstar/screen/register/verification.dart';
import 'package:qstar/screen/feed/model/user.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'dart:convert';
import 'package:qstar/screen/api/network_utils/api.dart';

late int ratings = 3;
// ignore: non_constant_identifier_names
late double rating_d = 3;

class Suggested extends StatefulWidget {
  const Suggested({Key? key}) : super(key: key);

  @override
  State<Suggested> createState() => _SuggestedState();
}

class _SuggestedState extends State<Suggested> {
  late List<User> suggestObjs = [];
  var body, res;

  @override
  void initState() {
    // TODO: implement initState
    _fetchSuggested();
  }

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
                          children: suggestObjs
                              .map((e) => SuggestedUsers(e))
                              .toList())
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

  _fetchSuggested() async {
    print("about to fetch suggested");
    res = await Network().getData("friendSuggestion");
    body = json.decode(res.body);
    print("received response");
    print(body["data"].toString());

    suggestObjs =
        body["data"].map((e) => User.fromJson(e)).toList().cast<User>();
    // ignore: avoid_print
    print(suggestObjs.toString());
    return suggestObjs;
  }
}

class SuggestedUsers extends StatefulWidget {
  final User user;

  // ignore: use_key_in_widget_constructors
  const SuggestedUsers(this.user);

  @override
  State<SuggestedUsers> createState() => _SuggestedUsersState();
}

class _SuggestedUsersState extends State<SuggestedUsers> {
  var body, res;
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
                    'assets/images/profile${widget.user.status}.jpg',
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
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 20),
                    child: Text(
                      widget.user.userName,
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: mPrimaryColor),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, left: 26),
                    child: Text(
                      widget.user.name,
                      style: const TextStyle(
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
