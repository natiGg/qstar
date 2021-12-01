import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qstar/controllers/editprofilecontroller.dart';
import 'package:qstar/controllers/perfectmatchcontroller.dart';
import 'package:qstar/screen/main/main_screen.dart';
import 'package:qstar/screen/profile/PerfectMatch/data/img.dart';
import 'package:qstar/screen/profile/PerfectMatch/data/my_strings.dart';
import 'package:qstar/screen/profile/PerfectMatch/editpersonalinfoform.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constant.dart';
import '../profile.dart';

class ProfileImageAppbarRoute extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const ProfileImageAppbarRoute();

  @override
  ProfileImageAppbarRouteState createState() => ProfileImageAppbarRouteState();
}

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class ProfileImageAppbarRouteState extends State<ProfileImageAppbarRoute> {
  final PerfectMatchController perfectMatchController =
      Get.put(PerfectMatchController());
  final EditprofileController editprofileController = Get.find();

  @override
  void initState() {
    _fetchUser();
    super.initState();
  }

  void _fetchUser() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('user');

    if (token != null) {
      var body = json.decode(token);
      perfectMatchController.fetchPf();
    }
  }

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
      color: Colors.white,
    );
    return Scaffold(
      key: _scaffoldKey,
      body: Obx(() => perfectMatchController.isFetched.value
          ? NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
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
                      background: Image.network(
                          "https://qstar.mindethiopia.com/api/getProfilePicture/${editprofileController.uid}",
                          fit: BoxFit.cover),
                    ),
                    leading: IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: mPrimaryColor,
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/home');
                      },
                    ),
                    actions: <Widget>[
                      IconButton(
                        icon: const Icon(Icons.edit),
                        color: mPrimaryColor,
                        onPressed: () {
                          Widget optionOne = SimpleDialogOption(
                            child:
                                const Text('Edit  Match Preferences Profile'),
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
                                duration: const Duration(seconds: 1),
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
                              const Divider(),
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Icon(Icons.person,
                              size: 25, color: mPrimaryColor),
                          Container(width: 15),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(height: 2),
                                const Text(
                                  "General Informaion ",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                                Container(height: 5),
                                Row(children: [
                                  const Text(
                                    "Full Name :",
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Container(width: 5),
                                  Text(perfectMatchController.fetched.full_name,
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.normal))
                                ]),
                                Container(height: 4),
                                Row(children: [
                                  const Text(
                                    "Gender :",
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Container(width: 5),
                                  Text(editprofileController.gender,
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.normal))
                                ]),
                                Container(height: 4),
                                Row(children: [
                                  const Text(
                                    "Country :",
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Container(width: 5),
                                  Text(perfectMatchController.fetched.country,
                                      style: const TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.normal))
                                ]),
                                Container(height: 4),
                                Row(children: [
                                  const Text(
                                    "City :",
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Container(width: 5),
                                  Text(perfectMatchController.fetched.city,
                                      style: const TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.normal))
                                ]),
                                Container(height: 4),
                                Row(children: [
                                  const Text(
                                    "Phone Number :",
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Container(width: 5),
                                  Text(
                                      perfectMatchController
                                          .fetched.phone_number,
                                      style: const TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.normal))
                                ])
                              ],
                            ),
                          )
                        ],
                      ),
                      Container(height: 15),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Icon(Icons.person,
                              size: 25, color: mPrimaryColor),
                          Container(width: 15),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(height: 2),
                                const Text(
                                  "Personal Informaion",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                                Container(height: 5),
                                Row(children: [
                                  const Text(
                                    "Religion :",
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Container(width: 5),
                                  Text(perfectMatchController.fetched.religion,
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.normal))
                                ]),
                                Container(height: 4),
                                Row(children: [
                                  const Text(
                                    "Height :",
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Container(width: 5),
                                  Text(perfectMatchController.fetched.height,
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.normal))
                                ]),
                              ],
                            ),
                          )
                        ],
                      ),
                      Container(height: 15),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Icon(Icons.person,
                              size: 25, color: mPrimaryColor),
                          Container(width: 15),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(height: 2),
                                const Text(
                                  "Background Informaion",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                                Container(height: 5),
                                Row(children: [
                                  const Text(
                                    "Education :",
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Container(width: 5),
                                  Text(perfectMatchController.fetched.education,
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.normal))
                                ]),
                                Container(height: 4),
                                Row(children: [
                                  const Text(
                                    "Emapoyment :",
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Container(width: 5),
                                  Text(
                                      perfectMatchController.fetched.employment,
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.normal))
                                ]),
                                Container(height: 4),
                                Row(children: [
                                  const Text(
                                    "Ocuppation :",
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Container(width: 5),
                                  Text(
                                      perfectMatchController.fetched.occupation,
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.normal))
                                ]),
                              ],
                            ),
                          )
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Icon(Icons.person,
                              size: 25, color: mPrimaryColor),
                          Container(width: 15),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(height: 2),
                                const Text(
                                  "Match Preference",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                                Container(height: 5),
                                Row(children: [
                                  const Text(
                                    "Location Preference:",
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Container(width: 5),
                                  Text(
                                      perfectMatchController.fetched.pflocation,
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.normal))
                                ]),
                                Container(height: 4),
                                Row(children: [
                                  const Text(
                                    "Gender Preference :",
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Container(width: 5),
                                  Text(perfectMatchController.fetched.pfgender,
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.normal))
                                ]),
                                Container(height: 4),
                                Row(children: [
                                  const Text(
                                    "Age Preference :",
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Container(width: 5),
                                  Text(
                                      perfectMatchController.fetched.age_min +
                                          " to " +
                                          perfectMatchController
                                              .fetched.age_max,
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.normal))
                                ]),
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
                            Navigator.pushNamed(context, '/home');
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
            )
          : Container()),
    );
  }

  _ondelay() {
    Future.delayed(const Duration(seconds: 1), () {
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
