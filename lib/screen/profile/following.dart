import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import "package:qstar/constant.dart";
import "package:qstar/screen/Chat/message_model.dart";
import "package:qstar/screen/profile/widgets/profile_widgets.dart";

class Followers extends StatefulWidget {
  // ignore: constant_identifier_names
  static const ROUTE_NAME = 'Followers';

  const Followers({Key? key}) : super(key: key);
  @override
  _FollowersState createState() => _FollowersState();
}

class _FollowersState extends State<Followers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leadingWidth: 100,
        backgroundColor: Colors.white,
        leading: Container(
          padding: const EdgeInsets.only(left: 20, top: 15),
          width: 100,
          child: const Text(
            "followers",
            style: TextStyle(
              color: mPrimaryColor,
              fontSize: 27,
              fontFamily: 'font1',
            ),
          ),
        ),
      ),
      body: RefreshIndicator(
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) => const FollowersList(),
            itemCount: chats.length,
          ),
          onRefresh: () async {}),
    );
  }
}

class FollowersList extends StatelessWidget {
  const FollowersList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Theme.of(context).cardColor,
        child: InkWell(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 16),
            child: Row(
              children: <Widget>[
                Container(
                  width: 70,
                  height: 70,
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
                      image: const DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage("assets/images/profile1.jpg"))),
                ),
                Expanded(
                    child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              text: 'Natnaek dangngocduc',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16)),
                          TextSpan(
                              text: ' follows you',
                              style: Theme.of(context).textTheme.subtitle1),
                          const TextSpan(
                              text: '   + follow',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: mPrimaryColor)),
                        ])))),
                Following(),
              ],
            ),
          ),
          onTap: () {},
        ));
  }
}
