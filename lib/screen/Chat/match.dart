import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qstar/controllers/feedcontroller.dart';
import 'package:qstar/screen/feed/model/user.dart';
import 'package:qstar/constant.dart';

class Match extends StatefulWidget {
  const Match({Key? key}) : super(key: key);
  @override
  _FollowersState createState() => _FollowersState();
}

FeedController feedController = Get.find();

class _FollowersState extends State<Match> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        child: Expanded(
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
            ),
            child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
                child: Column(
                  children: [
                    Obx(() => Row(
                        children: feedController.perfectMatches
                            .map((e) => FollowedList(e))
                            .toList()
                            .cast<Widget>())),
                  ],
                )),
          ),
        ),
        onRefresh: () async {});
  }
}

class FollowedList extends StatelessWidget {
  final User user;

  // ignore: use_key_in_widget_constructors
  const FollowedList(this.user);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 5.0, bottom: 5.0, right: 20.0),
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20.0),
          bottomRight: Radius.circular(20.0),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Stack(children: [
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
                          "https://qstar.mindethiopia.com/api/getProfilePicture/${user.id}"))),
            ),
            Positioned(
                bottom: 10,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 2,
                          color: Theme.of(context).scaffoldBackgroundColor),
                      boxShadow: [
                        BoxShadow(
                            spreadRadius: 2,
                            blurRadius: 10,
                            color: Colors.black.withOpacity(0.1),
                            offset: const Offset(0, 10))
                      ],
                      shape: BoxShape.circle,
                      color: Colors.white),
                  child: const Icon(
                    Icons.circle,
                    color: Colors.green,
                    size: 10,
                  ),
                )),
          ]),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                user.name,
                style: const TextStyle(
                  color: mPrimaryColor,
                  fontSize: 17.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                "10 min",
                style: TextStyle(
                  color: Colors.grey.withOpacity(0.5),
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 5.0),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.45,
                child: const Text(
                  "hey there",
                  // ignore: prefer_const_constructors
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          Column(
            children: <Widget>[
              Container(
                width: 20.0,
                height: 20.0,
                decoration: const BoxDecoration(
                    color: mPrimaryColor, shape: BoxShape.circle),
                alignment: Alignment.center,
                child: const Text(
                  '3',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 5.0),
              Text(
                "10 min",
                style: TextStyle(
                  color: Colors.grey.withOpacity(0.5),
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
