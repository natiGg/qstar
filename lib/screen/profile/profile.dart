import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qstar/screen/profile/widgets/bottomsheet/app_context.dart';
import 'package:qstar/constant.dart';
import 'package:qstar/screen/profile/widgets/profile_tab_bar.dart';
import 'package:qstar/screen/profile/widgets/profile_widgets.dart';
import 'package:qstar/screen/profile/widgets/bottomsheet/bottom_sheet_action.dart';
import 'package:qstar/widget/utils.dart';

import 'package:qstar/screen/profile/widgets/insta_app_bar.dart';
import 'package:qstar/screen/profile/editprofile.dart';

import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';


class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late VoidCallback _onShowMenu;
  @override
  void initState() {
    super.initState();
    _onShowMenu = () {
      context.showBottomSheet([
        BottomSheetAction(iconData: Icons.settings, title: 'Setting', id: 0),
        BottomSheetAction(iconData: Icons.archive, title: 'Archive', id: 1),
        BottomSheetAction(
            iconData: Icons.mobile_friendly_sharp,
            title: 'Close friends',
            id: 2),
        BottomSheetAction(
            iconData: Icons.history, title: 'Your activity', id: 3),
        BottomSheetAction(iconData: Icons.scanner, title: 'QR Code', id: 4),
        BottomSheetAction(
            iconData: Icons.bookmark_border, title: 'Saved', id: 5),
        BottomSheetAction(
            iconData: Icons.group_add, title: 'Discover People', id: 6),
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
      appBar: AppBar(
        leadingWidth: 100,
        backgroundColor: Colors.white,
        leading: Container(
          padding: EdgeInsets.only(left: 20, top: 15),
          width: 100,
          child: Text(
            "User Name",
            style: TextStyle(
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
              icon: Icon(Icons.menu),
              color: mPrimaryColor)
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
        bottomRight: Radius.circular(10)
    ),
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
                profileStats(screen: _screen, color: mPrimaryColor), SizedBox(height: 15,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: (){
                            Navigator.pushReplacement(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder:
                                            (context, animation1, animation2) =>
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
           SizedBox(height: 15,),
            Preferences(primaryColor: _primaryColor),
            
            storyHighlight(primaryColor: mPrimaryColor),
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
                return Container(
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
}
