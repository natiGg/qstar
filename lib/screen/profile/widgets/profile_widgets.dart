import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:qstar/constant.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:qstar/screen/profile/PerfectMatch/personalinfoform.dart';

import 'package:qstar/widget/utils.dart';

Widget profileStats({required Size screen, required Color color}) {
  return Container(
    padding: const EdgeInsets.only(left: 10, right: 10, top: 60),
    child: Column(
      children: <Widget>[
        Container(
          width: 100,
          child: Align(
            alignment: Alignment.centerLeft,
            child: profileAvatar(
              height: 100,
              width: 100,
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: RatingBarIndicator(
            rating: 2.75,
            itemBuilder: (context, index) => Icon(
              Icons.star,
              color: Colors.amber,
            ),
            itemCount: 5,
            itemSize: 20.0,
            direction: Axis.horizontal,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Text(
              "@Betty",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
          ),
        ),
        bio(primaryColor: mPrimaryColor),
        SizedBox(
          height: 15,
        ),
        Container(
          width: screen.width - 100 - 20,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              statsBox(count: '57', title: 'Posts'),
              statsBox(count: '185', title: 'Followers'),
              statsBox(count: '241', title: 'Following'),
            ],
          ),
        ),
      ],
    ),
  );
}

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
            text: TextSpan(
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
Widget Preferences({required Color primaryColor,required BuildContext context}) {
  return Container(
    color: Colors.white,
    padding: const EdgeInsets.only(left: 10, right: 10),
    child: Container(
      height: 30,
      width: 300,
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: mPrimaryColor)),
      child: FlatButton(
        onPressed: () {
           Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) {
                      return PersonalInfo();
                    },
                  ),
                );
        },
        child: Center(
            child: Text(
          'Perfect match preferences',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: mPrimaryColor,
          ),
        )),
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
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: mPrimaryColor,
      ),
      child: Center(
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

Widget storyHighlight({@required primaryColor}) {
  return Container(
    color: Colors.white,
    padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
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

Widget SocialMedia() {
  return Row(
    children: [
      Container(
        width: 40,
        height: 30,
        child: RawMaterialButton(
          onPressed: () {},
          elevation: 2.0,
          fillColor: Colors.white,
          child: Image(
            image: new AssetImage("assets/images/yt.png"),
            width: 20,
            height: 20,
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
      ),
      SizedBox(
        width: 10,
      ),
      Container(
        width: 40,
        height: 30,
        child: RawMaterialButton(
          onPressed: () {},
          elevation: 2.0,
          fillColor: Colors.white,
          child: Image(
            image: new AssetImage("assets/images/fb.png"),
            width: 20,
            height: 20,
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
      ),
      SizedBox(
        width: 10,
      ),
      Container(
        width: 40,
        height: 30,
        child: RawMaterialButton(
          onPressed: () {},
          elevation: 2.0,
          fillColor: Colors.white,
          child: Image(
            image: new AssetImage("assets/images/tiktok.png"),
            width: 20,
            height: 20,
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
      ),
      SizedBox(
        width: 10,
      ),
      Container(
        width: 40,
        height: 30,
        child: RawMaterialButton(
          onPressed: () {},
          elevation: 2.0,
          fillColor: Colors.white,
          child: Image(
            image: new AssetImage("assets/images/inst.png"),
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
          style: TextStyle(
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
              decoration: BoxDecoration(
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
