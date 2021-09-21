import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:qstar/screen/profile/widgets/profile_tab_bar.dart';
import 'package:qstar/screen/profile/widgets/profile_widgets.dart';
import 'package:qstar/widget/utils.dart';

import 'package:flutter/material.dart';
import 'package:qstar/widget/utils.dart';

import 'package:qstar/screen/profile/widgets/profile_tab_bar.dart';
import 'package:qstar/screen/profile/widgets/insta_app_bar.dart';
import 'package:qstar/screen/profile/widgets/profile_widgets.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    var _screen = MediaQuery.of(context).size;
    var _primaryColor = Colors.transparent;
    var _primaryColorDark = Theme.of(context).primaryColorDark;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            profileStats(screen: _screen, color: _primaryColor),
            bio(primaryColor: _primaryColor),
            editProfile(
              primaryColorDark: _primaryColorDark,
              primaryColor: _primaryColor,
            ),
            storyHighlight(primaryColor: _primaryColor),
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
