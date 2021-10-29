import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qstar/screen/Chat/home_screen.dart';

import 'package:qstar/constant.dart';
import 'package:qstar/screen/qvideo/bottomsheet_report/app_context.dart';
import 'package:qstar/screen/qvideo/bottomsheet_report/bottom_sheet_action.dart';
import 'widgets/profile_tab_bar.dart';
import 'widgets/profile_widgets.dart';

import 'package:qstar/screen/qvideo/qvideo.dart';
import 'package:qstar/widget/utils.dart';

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class UserProfile extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<UserProfile> {
  VoidCallback? _onShowMenu;

  @override
  void initState() {
    super.initState();

    _onShowMenu = () {
      context.showBottomSheet([
        BottomSheetAction(iconData: Icons.share, title: 'Report', id: 0),
      ]);
    };
  }

  int _pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    var _screen = MediaQuery.of(context).size;
    var _primaryColor = Colors.transparent;
    var _primaryColorDark = Theme.of(context).primaryColorDark;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: mPrimaryColor,
            onPressed: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) =>
                      Qvideoscreen(),
                  transitionDuration: Duration.zero,
                ),
              );
            }),
        // ignore: prefer_const_constructors
        title: Text(
          "Profile",
          style: const TextStyle(
            color: mPrimaryColor,
            fontSize: 27,
            fontFamily: 'font1',
          ),
        ),
        elevation: 5,
        actions: [
          IconButton(
              onPressed: () {
                _onShowMenu!();
              },
              icon: Icon(Icons.more_vert),
              color: mPrimaryColor),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    profileStats(
                        screen: _screen,
                        color: mPrimaryColor,
                        context: context),
                    SizedBox(
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
                              onTap: () {},
                              child: follow(
                                primaryColorDark: _primaryColorDark,
                                primaryColor: mPrimaryColor,
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation1, animation2) =>
                                        HomeScreen(),
                                transitionDuration: Duration.zero,
                              ),
                            );
                          },
                          child: message(
                            primaryColorDark: _primaryColorDark,
                            primaryColor: mPrimaryColor,
                          ),
                        ),
                        SocialMedia(),
                      ],
                    ),
                  ],
                )),
            SizedBox(
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
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              crossAxisCount: _pageIndex != 1 ? 3 : 2,
              itemCount: Utils.listOfImageUrl.length,
              itemBuilder: (contex, index) {
                return Align(
                  child: Container(
                    padding:
                        _pageIndex == 1 ? EdgeInsets.all(5) : EdgeInsets.all(0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ClipRRect(
                      borderRadius: _pageIndex == 1
                          ? BorderRadius.circular(15)
                          : BorderRadius.circular(0),
                      child: Image(
                        fit: BoxFit.cover,
                        image:
                            NetworkImage(Utils.listOfImageUrl.elementAt(index)),
                      ),
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
    );
  }

  Widget follow(
      {@required Color? primaryColor, required Color primaryColorDark}) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(left: 5, right: 5),
      child: Container(
        height: 30,
        width: 70,
        margin: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: mPrimaryColor,
        ),
        child: Center(
            child: Text(
          'Folllow',
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.white, fontSize: 12),
        )),
      ),
    );
  }

  Widget message(
      {@required Color? primaryColor, required Color primaryColorDark}) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(left: 5, right: 5),
      child: Container(
        height: 30,
        width: 70,
        margin: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: mPrimaryColor,
        ),
        child: Center(
            child: Text(
          'Message',
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.white, fontSize: 12),
        )),
      ),
    );
  }
}
