import 'package:flutter/material.dart';

import 'package:qstar/constant.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:qstar/screen/profile/followers.dart';
import 'package:qstar/screen/profile/following.dart';

import 'package:qstar/widget/utils.dart';

Widget bio({required Color primaryColor}) {
  return Container(
    color: Colors.white,
    height: 40,
    width: 200,
    padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
    child: Card(
      elevation: 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          RichText(
            text: const TextSpan(
              children: [
                TextSpan(
                  text: 'It is what it is...',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget editProfile(
    {@required Color? primaryColor, required Color primaryColorDark}) {
  return Container(
    color: Colors.white,
    padding: const EdgeInsets.only(left: 10, right: 10),
    child: Container(
      height: 30,
      width: 100,
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: mPrimaryColor,
      ),
      child: const Center(
          child: Text(
        'Edit Profile',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      )),
    ),
  );
}

// ignore: non_constant_identifier_names
Widget Following() {
  return Container(
    color: Colors.transparent,
    padding: const EdgeInsets.only(left: 10, right: 10),
    child: Container(
      height: 30,
      width: 100,
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: mPrimaryColor)),
      child: const Center(
          child: Text(
        'remove',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: mPrimaryColor,
        ),
      )),
    ),
  );
}

// ignore: non_constant_identifier_names
Widget Unfollow() {
  return Container(
    color: Colors.transparent,
    padding: const EdgeInsets.only(left: 10, right: 10),
    child: Container(
      height: 30,
      width: 100,
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: mPrimaryColor)),
      child: const Center(
          child: Text(
        'Following',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: mPrimaryColor,
        ),
      )),
    ),
  );
}

Widget storyHighlight({@required primaryColor}) {
  return Container(
    color: Colors.white,
    padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const <Widget>[
        Text(
          'Story Highligts',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        Icon(
          Icons.keyboard_arrow_down,
          color: Colors.black,
        ),
      ],
    ),
  );
}

// ignore: non_constant_identifier_names
Widget SocialMedia() {
  return Row(
    children: [
      SizedBox(
        width: 40,
        height: 30,
        child: RawMaterialButton(
          onPressed: () {},
          elevation: 2.0,
          fillColor: Colors.white,
          child: const Image(
            image: AssetImage("assets/images/yt.png"),
            width: 20,
            height: 20,
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
      ),
      const SizedBox(
        width: 10,
      ),
      SizedBox(
        width: 40,
        height: 30,
        child: RawMaterialButton(
          onPressed: () {},
          elevation: 2.0,
          fillColor: Colors.white,
          child: const Image(
            image: AssetImage("assets/images/fb.png"),
            width: 20,
            height: 20,
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
      ),
      const SizedBox(
        width: 10,
      ),
      SizedBox(
        width: 40,
        height: 30,
        child: RawMaterialButton(
          onPressed: () {},
          elevation: 2.0,
          fillColor: Colors.white,
          child: const Image(
            image: AssetImage("assets/images/tiktok.png"),
            width: 20,
            height: 20,
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
      ),
      const SizedBox(
        width: 10,
      ),
      SizedBox(
        width: 40,
        height: 30,
        child: RawMaterialButton(
          onPressed: () {},
          elevation: 2.0,
          fillColor: Colors.white,
          child: const Image(
            image: AssetImage("assets/images/inst.png"),
            width: 20,
            height: 20,
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
      ),
    ],
  );
}

Widget statsBox({
  required String count,
  required String title,
}) {
  return Container(
    color: Colors.white,
    height: 60,
    width: 80,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          count,
          style: const TextStyle(
              fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        Text(
          title,
          style: const TextStyle(fontSize: 14, color: Colors.black),
        ),
      ],
    ),
  );
}

Widget profileAvatar({
  required double height,
  required double width,
  bool isStorySeen = false,
}) {
  return Container(
    color: Colors.transparent,
    height: height, //155,
    width: width, //155,
    child: Center(
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              height: height, // 150,
              width: width, //150,

              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(width: 3, color: mPrimaryColor)),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              height: height - 10, //140,
              width: width - 10, //140,
              decoration: const BoxDecoration(
                color: Colors.black,
                shape: BoxShape.circle,
              ),
              child: CircleAvatar(
                backgroundImage: NetworkImage(Utils.getRandomImageUrl()),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
