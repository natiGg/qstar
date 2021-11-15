import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:qstar/controllers/editprofilecontroller.dart';
import 'package:qstar/screen/profile/widgets/bottomsheet/app_context.dart';
import 'package:qstar/constant.dart';
import 'package:qstar/screen/profile/widgets/profile_tab_bar.dart';
import 'package:qstar/screen/profile/widgets/profile_widgets.dart';
import 'package:qstar/screen/profile/widgets/bottomsheet/bottom_sheet_action.dart';
import 'package:qstar/widget/utils.dart';
import 'package:qstar/screen/profile/followers.dart';
import 'package:qstar/screen/profile/following.dart';
import 'package:qstar/screen/profile/editprofile.dart';

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

final EditprofileController editprofileController =
    Get.put(EditprofileController());

class _ProfileScreenState extends State<ProfileScreen> {
  late VoidCallback _onShowMenu;
  @override
  void initState() {
    _fetchUser();
    super.initState();
    _onShowMenu = () {
      context.showBottomSheet([
        BottomSheetAction(iconData: Icons.settings, title: 'Setting', id: 0),
        BottomSheetAction(iconData: Icons.archive, title: 'Archive', id: 1),
        BottomSheetAction(
            iconData: Icons.password, title: 'Change Password', id: 2),
        BottomSheetAction(iconData: Icons.logout, title: 'Logout', id: 7),
      ]);
    };
  }

  @override
  void deactivate() {
    EasyLoading.dismiss();
    super.deactivate();
  }

  void _fetchUser() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('user');
    print("okke");
    print(token);
    if (token != null) {
      print(token.toString());
      var body = json.decode(token);
      print(body["id"]);
      editprofileController.fetchProfile(body["id"]);
    }
  }

  int _pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    var _screen = MediaQuery.of(context).size;
    var _primaryColorDark = Theme.of(context).primaryColorDark;
    return editprofileController.obx(
        (edit) => Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                leadingWidth: 100,
                backgroundColor: Colors.white,
                leading: Container(
                  padding: const EdgeInsets.only(left: 20, top: 15),
                  width: 100,
                  child: Text(
                    editprofileController.suggested.name,
                    style: const TextStyle(
                      color: mPrimaryColor,
                      fontSize: 23,
                      fontFamily: 'font1',
                    ),
                  ),
                ),
                actions: [
                  IconButton(
                      onPressed: () {
                        _onShowMenu();
                      },
                      icon: const Icon(Icons.menu),
                      color: mPrimaryColor)
                ],
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: const Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            profileStats(
                                screen: _screen,
                                color: mPrimaryColor,
                                context: context),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          PageRouteBuilder(
                                            pageBuilder: (context, animation1,
                                                    animation2) =>
                                                EditProfilePage(),
                                            transitionDuration: Duration.zero,
                                          ),
                                        );
                                      },
                                      child: editProfile(
                                        primaryColorDark: _primaryColorDark,
                                        primaryColor: mPrimaryColor,
                                      ),
                                    ),
                                  ),
                                ),
                                SocialMedia()
                              ],
                            ),
                          ],
                        )),
                    const SizedBox(
                      height: 15,
                    ),
                    Divider(
                      height: 2,
                      color: Colors.grey[500],
                    ),
                    ProfileTabBar(
                      height: 46,
                      color: Colors.grey[500],
                      onTap: (value) {
                        setState(() {
                          _pageIndex = value;
                        });
                      },
                    ),
                    StaggeredGridView.countBuilder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      crossAxisCount: _pageIndex != 1 ? 3 : 2,
                      itemCount: Utils.listOfImageUrl.length,
                      itemBuilder: (contex, index) {
                        return Container(
                          padding: _pageIndex == 1
                              ? const EdgeInsets.all(5)
                              : const EdgeInsets.all(0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ClipRRect(
                            borderRadius: _pageIndex == 1
                                ? BorderRadius.circular(15)
                                : BorderRadius.circular(0),
                            child: Image(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  Utils.listOfImageUrl.elementAt(index)),
                            ),
                          ),
                        );
                      },
                      staggeredTileBuilder: (index) => StaggeredTile.count(
                          _pageIndex != 1 ? 1 : 1, _pageIndex != 1 ? 1 : 1.5),
                      crossAxisSpacing: 2,
                      mainAxisSpacing: 2,
                    ),
                  ],
                ),
              ),
            ),
        onLoading: Center(
          child: loadData(),
        ),
        onEmpty: Text("Can't fetch data"),
        onError: (error) => Center(child: Text(error.toString())));
  }

  Widget profileStats(
      {required Size screen,
      required Color color,
      required BuildContext context}) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 40),
      child: Column(
        children: <Widget>[
          SizedBox(
            width: 100,
            child: Align(
              alignment: Alignment.centerLeft,
              child: profileAvatar(
                height: 100,
                width: 100,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: RatingBarIndicator(
              rating: 2.75,
              itemBuilder: (context, index) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              itemCount: 5,
              itemSize: 20.0,
              direction: Axis.horizontal,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.all(2.0),
              child: Text(
                editprofileController.suggested.userName,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
            ),
          ),
          bio(primaryColor: mPrimaryColor),
          const SizedBox(
            height: 15,
          ),
          SizedBox(
            width: screen.width - 100 - 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                statsBox(count: '57', title: 'Posts'),
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation1, animation2) =>
                              const Followers(),
                          transitionDuration: Duration.zero,
                        ),
                      );
                    },
                    child: statsBox(count: '185', title: 'Followers')),
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation1, animation2) =>
                              const Followed(),
                          transitionDuration: Duration.zero,
                        ),
                      );
                    },
                    child: statsBox(count: '241', title: 'Following')),
              ],
            ),
          ),
        ],
      ),
    );
  }

  loadData() {
    // Here you can write your code for open new view
    EasyLoading.show();
    Future.delayed(const Duration(milliseconds: 500), () {
// Here you can write your code

      EasyLoading.dismiss();
    });
  }
}
