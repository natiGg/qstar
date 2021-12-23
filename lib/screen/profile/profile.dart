// ignore_for_file: import_of_legacy_library_into_null_safe, unused_import

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:qstar/controllers/editprofilecontroller.dart';
import 'package:qstar/screen/profile/widgets/bottomsheet/app_context.dart';
import 'package:qstar/constant.dart';
import 'package:qstar/screen/profile/widgets/profile_tab_bar.dart';
import 'package:qstar/screen/profile/widgets/profile_widgets.dart';
import 'package:qstar/screen/profile/widgets/bottomsheet/bottom_sheet_action.dart';
import 'package:qstar/widget/utils.dart';
import 'package:qstar/screen/profile/following.dart';
import 'package:qstar/screen/profile/followres.dart';
import 'package:qstar/screen/profile/editprofile.dart';

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:url_launcher/url_launcher.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

final EditprofileController editprofileController =
    Get.put(EditprofileController());

class _ProfileScreenState extends State<ProfileScreen>
    with AutomaticKeepAliveClientMixin {
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

    // ignore: avoid_print

    if (token != null) {
      var body = json.decode(token);
      // ignore: avoid_print
      print(body["id"]);
      editprofileController.fetchProfile(body["id"]);
      editprofileController.fetchlinks(body["id"]);
    }
  }

  int _pageIndex = 0;
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    setState(() {});
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    //items.add((items.length+1).toString());
    //if(mounted)
    // setState(() {

    // });
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    var _screen = MediaQuery.of(context).size;
    var _primaryColorDark = Theme.of(context).primaryColorDark;
    return editprofileController.obx(
        (edit) => Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                leadingWidth: 200,
                backgroundColor: Colors.white,
                leading: Container(
                  padding: const EdgeInsets.only(left: 20, top: 15),
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
                        // ignore: avoid_print
                        print(editprofileController.suggested.storyImage);
                        _onShowMenu();
                      },
                      icon: const Icon(Icons.menu),
                      color: mPrimaryColor)
                ],
              ),
              body: SmartRefresher(
                enablePullDown: true,
                enablePullUp: true,

                //cheak pull_to_refresh
                controller: _refreshController,
                onRefresh: _onRefresh,
                onLoading: _onLoading,
                child: SingleChildScrollView(
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
                                                  const EditProfilePage(),
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
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 40,
                                            height: 30,
                                            child: RawMaterialButton(
                                              onPressed: () {
                                                if (editprofileController
                                                        .links.youtube_link
                                                        .toString() !=
                                                    "null") {
                                                  _launchURL();
                                                } else {
                                                  openSnackBar();
                                                }
                                              },
                                              elevation: 2.0,
                                              fillColor: Colors.white,
                                              child: const Image(
                                                image: AssetImage(
                                                    "assets/images/yt.png"),
                                                width: 20,
                                                height: 20,
                                              ),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0)),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          SizedBox(
                                            width: 40,
                                            height: 30,
                                            child: RawMaterialButton(
                                              onPressed: () {
                                                if (editprofileController
                                                        .links.fb_link
                                                        .toString() !=
                                                    "null") {
                                                  _launchURLfb();
                                                } else {
                                                  openSnackBar();
                                                }
                                              },
                                              elevation: 2.0,
                                              fillColor: Colors.white,
                                              child: const Image(
                                                image: AssetImage(
                                                    "assets/images/fb.png"),
                                                width: 20,
                                                height: 20,
                                              ),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0)),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          SizedBox(
                                            width: 40,
                                            height: 30,
                                            child: RawMaterialButton(
                                              onPressed: () {
                                                if (editprofileController
                                                        .links.tiktok_link
                                                        .toString() !=
                                                    "null") {
                                                  _launchURLtik();
                                                } else {
                                                  openSnackBar();
                                                }
                                              },
                                              elevation: 2.0,
                                              fillColor: Colors.white,
                                              child: const Image(
                                                image: AssetImage(
                                                    "assets/images/tiktok.png"),
                                                width: 20,
                                                height: 20,
                                              ),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0)),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          SizedBox(
                                            width: 40,
                                            height: 30,
                                            child: RawMaterialButton(
                                              onPressed: () {
                                                if (editprofileController
                                                        .links.instagram_link
                                                        .toString() !=
                                                    "null") {
                                                  _launchURLinsta();
                                                } else {
                                                  openSnackBar();
                                                }
                                              },
                                              elevation: 2.0,
                                              fillColor: Colors.white,
                                              child: const Image(
                                                image: AssetImage(
                                                    "assets/images/inst.png"),
                                                width: 20,
                                                height: 20,
                                              ),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0)),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
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
            ),
        onLoading: Center(
          child: loadData(),
        ),
        onEmpty: const Text("Can't fetch data"),
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
              padding: const EdgeInsets.all(2.0),
              child: Text(
                editprofileController.suggested.userName,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
            ),
          ),
          Container(
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
                          text: editprofileController.suggested.bio,
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          SizedBox(
            width: screen.width - 100 - 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                statsBox(
                    count: editprofileController.suggested.posts_count,
                    title: 'Posts'),
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
                    child: statsBox(
                        count: editprofileController.suggested.followers_count,
                        title: 'Followers')),
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
                    child: statsBox(
                        count: editprofileController.suggested.following_count,
                        title: 'Following')),
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

  @override
  bool get wantKeepAlive => true;

  _launchURL() async {
    var url =
        "https://www.youtube.com/channel/${editprofileController.links.youtube_link}";
    if (!await launch(
      url,
      forceSafariVC: false,
      forceWebView: false,
      headers: <String, String>{'my_header_key': 'my_header_value'},
    )) {
      openSnackBar();
    }
  }
}

_launchURLfb() async {
  var url = "https://www.facebook.com/${editprofileController.links.fb_link}";
  if (!await launch(
    url,
    forceSafariVC: false,
    forceWebView: false,
    headers: <String, String>{'my_header_key': 'my_header_value'},
  )) {
    openSnackBar();
  }
}

_launchURLtik() async {
  var url = "https://www.tiktok.com/${editprofileController.links.tiktok_link}";
  if (!await launch(
    url,
    forceSafariVC: false,
    forceWebView: false,
    headers: <String, String>{'my_header_key': 'my_header_value'},
  )) {
    openSnackBar();
  }
}

_launchURLinsta() async {
  var url =
      "https://www.instagram.com/${editprofileController.links.instagram_link}";
  if (!await launch(
    url,
    forceSafariVC: false,
    forceWebView: false,
    headers: <String, String>{'my_header_key': 'my_header_value'},
  )) {
    openSnackBar();
  }
}

Future<void> openSnackBar() async {
  Get.snackbar("info", "No Link avalable please edit profile to add link",
      icon: Icon(Icons.person, color: mPrimaryColor.withOpacity(0.05)),
      snackPosition: SnackPosition.TOP);
}
