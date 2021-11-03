import 'package:flutter/material.dart';
import 'package:qstar/screen/feed/feed.dart';
import 'package:qstar/screen/profile/PerfectMatch/data/img.dart';
import 'package:qstar/screen/profile/PerfectMatch/data/my_colors.dart';
import 'package:qstar/screen/profile/PerfectMatch/data/my_strings.dart';

import '../../../constant.dart';

class ProfileImageAppbarRoute extends StatefulWidget {
  ProfileImageAppbarRoute();

  @override
  ProfileImageAppbarRouteState createState() =>
      new ProfileImageAppbarRouteState();
}

class ProfileImageAppbarRouteState extends State<ProfileImageAppbarRoute> {
  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
      color: Colors.white,
    );
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              backgroundColor: Colors.white,
              title: Text(
                "Profile",
                style: const TextStyle(
                  color: mPrimaryColor,
                  fontSize: 27,
                  fontFamily: 'font1',
                ),
              ),
              expandedHeight: 260,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                background: Image.asset(Img.get('photo_female_8.jpg'),
                    fit: BoxFit.cover),
              ),
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: mPrimaryColor,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.edit),
                  color: mPrimaryColor,
                  onPressed: () {},
                ),
              ],
            ),
          ];
        },
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(height: 15),
                Row(
                  children: <Widget>[
                    Container(width: 40),
                    Text(
                      "Full name",
                    ),
                  ],
                ),
                Container(height: 15),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Icon(Icons.person, size: 25, color: mPrimaryColor),
                    Container(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(height: 2),
                          Text(
                            "General Informaion ",
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                          Container(height: 5),
                          Text(
                            MyStrings.lorem_ipsum,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Container(height: 15),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Icon(Icons.person, size: 25, color: mPrimaryColor),
                    Container(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(height: 2),
                          Text(
                            "Personal Informaion",
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                          Container(height: 5),
                          Text(
                            "Swimming, playing tennis, cooking are my favorite hobbie",
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Container(height: 15),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Icon(Icons.person, size: 25, color: mPrimaryColor),
                    Container(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(height: 2),
                          const Text(
                            "Background Informaion",
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                          Container(height: 5),
                          Text(
                            "Swimming, playing tennis, cooking are my favorite hobbie",
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Container(height: 20),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(36),
                    ),
                    color: mPrimaryColor,
                    onPressed: () {
                      int count = 0;
                      Navigator.popUntil(context, (route) {
                        return count++ == 3;
                      });
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      alignment: Alignment.center,
                      child: Text(
                        'Get Started',
                        style: textStyle,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
