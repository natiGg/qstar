import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import "package:qstar/constant.dart";
import 'package:qstar/controllers/followcontroller.dart';
import 'package:qstar/remote_services/service.dart';
import "package:qstar/screen/Chat/message_model.dart";
import "package:qstar/screen/profile/widgets/profile_widgets.dart";
import 'package:qstar/screen/feed/model/user.dart';

class Followed extends StatefulWidget {
  final int? id;

  Followed({required this.id});
  @override
  _FollowedState createState() => _FollowedState();
}

Followcontroller followcontroller = Get.find();

class _FollowedState extends State<Followed> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      followcontroller.fetchFollowing(widget.id);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              color: mPrimaryColor,
              onPressed: () {
                Navigator.of(context).pop(true);
              }),
          title: const Text(
            "Following",
            style: TextStyle(
              color: mPrimaryColor,
              fontSize: 27,
              fontFamily: 'font1',
            ),
          ),
        ),
        body: followcontroller.following_list.isNotEmpty
            ? ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return FollowedList(
                      user: followcontroller.following_list[index]);
                },
                itemCount: followcontroller.following_list.length,
              )
            : followcontroller.isFetching.value
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                          child: Column(children: [
                        Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1,
                                  color: Theme.of(context)
                                      .scaffoldBackgroundColor),
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
                                      "https://cdn-icons-png.flaticon.com/512/983/983937.png"))),
                        ),
                        RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              text: "No Followed Users",
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16)),
                        ]))
                      ])),
                    ],
                  )));
  }
}

class FollowedList extends StatelessWidget {
  final User? user;
  const FollowedList({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Followcontroller followcontroller = Get.find();

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
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              "https://qstar.mindethiopia.com/api/getProfilePicture/${user!.id}"))),
                ),
                Expanded(
                    child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              text: user!.name,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16)),
                        ])))),
                GestureDetector(
                    onTap: () {
                      Get.defaultDialog(
                          title: "",
                          middleText: "Hello world!",
                          backgroundColor: Colors.white,
                          titleStyle: TextStyle(color: mPrimaryColor),
                          middleTextStyle: TextStyle(color: Colors.white),
                          content: Column(
                            children: [
                              Container(
                                width: 70,
                                height: 70,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 4,
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor),
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
                                            "https://qstar.mindethiopia.com/api/getProfilePicture/${user!.id}"))),
                              ),
                              Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: RichText(
                                      text: TextSpan(children: [
                                    TextSpan(
                                        text: user!.name,
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1
                                            ?.copyWith(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16)),
                                  ])))
                            ],
                          ),
                          actions: [
                            GestureDetector(
                              onTap: () {
                                followcontroller.unfollow(user!.id.toString());
                                Navigator.of(context).pop(true);
                              },
                              child: Container(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: Container(
                                  height: 30,
                                  width: 200,
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  decoration: BoxDecoration(
                                      color: mPrimaryColor,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color: mPrimaryColor)),
                                  child: !followcontroller.btnLoading.value
                                      ? Center(
                                          child: const Text(
                                          'unfollow',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ))
                                      : const Center(
                                          child: SizedBox(
                                            height: 12,
                                            width: 12,
                                            child: Center(
                                              child: CircularProgressIndicator(
                                                // ignore: unrelated_type_equality_checks
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                ),
                              ),
                            ),
                          ]);
                    },
                    child: Unfollow()),
              ],
            ),
          ),
          onTap: () {},
        ));
  }
}
