import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';

import "package:qstar/constant.dart";
import 'package:qstar/controllers/editprofilecontroller.dart';
import 'package:qstar/controllers/followcontroller.dart';
import 'package:qstar/controllers/postcontroller.dart';
import 'package:qstar/remote_services/service.dart';
import "package:qstar/screen/Chat/message_model.dart";
import 'package:qstar/screen/feed/model/user.dart';
import 'package:qstar/screen/profile/following.dart';
import "package:qstar/screen/profile/widgets/profile_widgets.dart";

class Followers extends StatefulWidget {
  // ignore: constant_identifier_names
  final int? id;

  const Followers({required this.id});

  @override
  _FollowersState createState() => _FollowersState();
}

Followcontroller followcontroller = Get.find();

//EditprofileController editprofileController = Get.find();

class _FollowersState extends State<Followers> {
  void initState() {
    Future.delayed(Duration.zero, () async {
      followcontroller.fetchfollowers(widget.id);
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
            "Followres",
            style: TextStyle(
              color: mPrimaryColor,
              fontSize: 27,
              fontFamily: 'font1',
            ),
          ),
        ),
        body: followcontroller.followers_list.isNotEmpty
            ? ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return FollowedList(
                      user: followcontroller.followers_list[index]);
                },
                itemCount: followcontroller.followers_list.length,
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
                Following(),
              ],
            ),
          ),
          onTap: () {},
        ));
  }
}
