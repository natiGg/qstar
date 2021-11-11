import 'package:flutter/material.dart';
import 'package:qstar/screen/feed/feed.dart';
import 'package:qstar/screen/main/main_screen.dart';
import 'package:qstar/screen/profile/PerfectMatch/data/img.dart';
import 'package:qstar/screen/profile/PerfectMatch/data/my_strings.dart';
import 'package:qstar/screen/profile/PerfectMatch/editpersonalinfoform.dart';

import '../../../constant.dart';

class ProfileImageAppbarRoute extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const ProfileImageAppbarRoute();

  @override
  ProfileImageAppbarRouteState createState() => ProfileImageAppbarRouteState();
}

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class ProfileImageAppbarRouteState extends State<ProfileImageAppbarRoute> {
  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
      color: Colors.white,
    );
    return Scaffold(
      key: _scaffoldKey,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              backgroundColor: Colors.white,
              title: const Text(
                "Profile",
                style: TextStyle(
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
                icon: const Icon(
                  Icons.arrow_back,
                  color: mPrimaryColor,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              actions: <Widget>[
                IconButton(
                  icon: const Icon(Icons.edit),
                  color: mPrimaryColor,
                  onPressed: () {
                    Widget optionOne = SimpleDialogOption(
                      child: const Text('Edit  Match Preferences Profile'),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditPersonalInfo()),
                        );
                      },
                    );
                    Widget optionTwo = SimpleDialogOption(
                      child: const Text('Turn Off Match Preferences'),
                      onPressed: () {
                        _scaffoldKey.currentState!
                            // ignore: deprecated_member_use
                            .showSnackBar(SnackBar(
                          duration: const Duration(seconds: 4),
                          content: Row(
                            children: const <Widget>[
                              CircularProgressIndicator(),
                              Text("    Turning Off...")
                            ],
                          ),
                        ));
                        _ondelay();
                      },
                    );
                    SimpleDialog dialog = SimpleDialog(
                      title: const Text('Setting'),
                      children: <Widget>[
                        optionOne,
                        Divider(),
                        optionTwo,
                      ],
                    );
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return dialog;
                      },
                    );
                  },
                ),
              ],
            ),
          ];
        },
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(height: 15),
                Row(
                  children: <Widget>[
                    Container(width: 40),
                    const Text(
                      "Full name",
                    ),
                  ],
                ),
                Container(height: 15),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Icon(Icons.person, size: 25, color: mPrimaryColor),
                    Container(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(height: 2),
                          const Text(
                            "General Informaion ",
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                          Container(height: 5),
                          const Text(
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
                    const Icon(Icons.person, size: 25, color: mPrimaryColor),
                    Container(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(height: 2),
                          const Text(
                            "Personal Informaion",
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                          Container(height: 5),
                          const Text(
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
                    const Icon(Icons.person, size: 25, color: mPrimaryColor),
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
                          const Text(
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
                  // ignore: deprecated_member_use
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
                      child: const Text(
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

  _ondelay() {
    Future.delayed(const Duration(seconds: 3), () {
      // Navigator.popUntil(context, (route) {
      //   return count++ == 2;
      // });

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const MyHomePage(),
        ),
      );
    });
  }
}
