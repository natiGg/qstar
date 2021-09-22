import 'package:flutter/material.dart';
import 'package:qstar/screen/feed/feed.dart';
import 'package:qstar/screen/main/widget/custom_animated_bottom_bar.dart';
import 'package:qstar/screen/profile/profile.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:qstar/screen/qvideo/qvideo.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  final _inactiveColor = Colors.grey;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
              appBar:AppBar(
                
                
        backgroundColor: Colors.white,
        centerTitle: true,
        leading:IconButton(icon: Icon(Icons.video_call),color: Colors.black,onPressed: (){}),
        title: Row(
           mainAxisSize: MainAxisSize.min,
           children: <Widget>[
                IconButton(
                  
                  icon: Icon(Icons.add),
                  color: Colors.black,
                  onPressed: null,
                ),
           ]
        ),
        
        actions: [
          IconButton(onPressed:(){}, icon: Icon(Icons.send_outlined),color: Colors.black)
          
        ],
      ),
        body: getBody(),
        bottomNavigationBar: _buildBottomBar());
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
          icon: Icon(Icons.video_collection),
          title: Text('Video'),
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

      Container(
        alignment: Alignment.center,
        child: Text(
          "Messages",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      Qvideo(),
      Container(
        alignment: Alignment.center,
        child: Text(
          "Settings",
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
