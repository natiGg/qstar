import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qstar/screen/feed/feed.dart';

import 'package:qstar/screen/profile/profile.dart';

import 'package:qstar/screen/main/widget/icons_app.dart';
import 'package:qstar/screen/qvideo/category.dart';
import 'package:tuple/tuple.dart';
import 'package:qstar/screen/qvideo/qvideo.dart';
import 'package:qstar/screen/search/search.dart';
import 'package:qstar/screen/activity/activity_page.dart';
import 'package:qstar/screen/main/widget/bottom_navigation_item.dart';

class MyHomePage extends StatefulWidget {
  // ignore: constant_identifier_names
  static const ROUTE_NAME = 'BottomNavPage';

  const MyHomePage({Key? key}) : super(key: key);

  @override
  _BottomNavPageState createState() => _BottomNavPageState();
}

class _BottomNavPageState extends State<MyHomePage> {
  int _currentTabIndex = 0;
  final PageController _pageController = PageController(initialPage: 0);

  List<Tuple2<String, String>> tabsIcons = [
    const Tuple2(IconsApp.icHome, IconsApp.icHomeSelected),
    const Tuple2(IconsApp.icSearch, IconsApp.icSearchSelected),
    const Tuple2(IconsApp.icq, IconsApp.icqslected),
    const Tuple2(IconsApp.icFavorite, IconsApp.icFavoriteSelected),
    const Tuple2(IconsApp.icAccount, IconsApp.icAccountSelected),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          if (index <= 0) {
            setState(() {
              _currentTabIndex = index;
            });
          } else {
            setState(() {
              _currentTabIndex = index + 0;
            });
          }
        },
        children: <Widget>[
          UsersFeed(),
          Search(),
          CategoryVid(),
          ActivityPage(),
          ProfileScreen(),
        ],
      ),
      bottomNavigationBar: Material(
        elevation: 4,
        color: Theme.of(context).bottomAppBarColor,
        child: SafeArea(
          child: Container(
            decoration: BoxDecoration(
                border: Border(top: Divider.createBorderSide(context))),
            height: 56,
            child: Row(
              children: <Widget>[
                Expanded(
                    child: BottomNavigationItem(
                        tabsIcons[0], 0 == _currentTabIndex, onPress: () {
                  setState(() {
                    _currentTabIndex = 0;
                    _pageController.jumpToPage(0);
                  });
                })),
                Expanded(
                  child: BottomNavigationItem(
                      tabsIcons[1], 1 == _currentTabIndex, onPress: () {
                    setState(() {
                      _currentTabIndex = 1;
                      _pageController.jumpToPage(1);
                    });
                  }),
                ),
                Expanded(
                    child: BottomNavigationItem(
                        tabsIcons[2], 2 == _currentTabIndex, onPress: () {
                  setState(() {
                    _currentTabIndex = 2;
                    _pageController.jumpToPage(2);
                  });
                })),
                Expanded(
                    child: BottomNavigationItem(
                        tabsIcons[3], 3 == _currentTabIndex, onPress: () {
                  setState(() {
                    _currentTabIndex = 3;
                    _pageController.jumpToPage(3);
                  });
                })),
                Expanded(
                    child: BottomNavigationItem(
                        tabsIcons[4], 4 == _currentTabIndex, onPress: () {
                  setState(() {
                    _currentTabIndex = 4;
                    _pageController.jumpToPage(4);
                  });
                })),
              ],
            ),
          ),
          bottom: true,
        ),
      ),
    );
  }
}
