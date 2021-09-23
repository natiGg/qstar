import 'package:flutter/material.dart';
import 'package:qstar/screen/feed/feed.dart';
import 'package:qstar/screen/main/widget/custom_animated_bottom_bar.dart';
import 'package:qstar/screen/profile/profile.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:qstar/screen/qvideo/qvideo.dart';
import 'package:qstar/screen/search/search.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 2;

  final _inactiveColor = Colors.grey;
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: getBody(), bottomNavigationBar: _buildBottomBar());
  }

  Widget _buildBottomBar() {
    return CustomAnimatedBottomBar(
      containerHeight: 70,
      backgroundColor: Colors.white,
      selectedIndex: _currentIndex,
      showElevation: true,
      itemCornerRadius: 24,
      curve: Curves.easeIn,
      onItemSelected: (index) => setState(() => _currentIndex = index),
      items: <BottomNavyBarItem>[
        BottomNavyBarItem(
          icon: Icon(Icons.home),
          title: Text('Home'),
          activeColor: Colors.purpleAccent,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: Icon(Icons.search),
          title: Text('Search'),
          activeColor: Colors.purpleAccent,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon:ImageIcon(
            AssetImage("assets/images/q.png"),
          ),
          title: Text(''),
          activeColor: Colors.purpleAccent,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
        
        BottomNavyBarItem(
          icon: Icon(Icons.notifications),
          title: Text(
            'Activity ',
          ),
          activeColor: Colors.purpleAccent,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: Icon(Icons.person),
          title: Text('Profile'),
          activeColor: Colors.purpleAccent,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget getBody() {
    List<Widget> pages = [
      UsersFeed(),
      //  ProfilePage(),
      Search(),
      Qvideo(),
      Container(
        alignment: Alignment.center,
        child: Text(
          "Messages",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),

      ProfileScreen(),
    ];
    return IndexedStack(
      index: _currentIndex,
      children: pages,
    );
  }
}
