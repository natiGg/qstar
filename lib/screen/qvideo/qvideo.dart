import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:qstar/constant.dart';

import 'package:qstar/screen/qvideo/bottomsheet/app_context.dart';
import 'package:qstar/screen/qvideo/category.dart';
import 'package:qstar/screen/qvideo/comment/comment_page.dart';
import 'package:qstar/screen/qvideo/useraudio.dart';
import 'package:qstar/screen/qvideo/userprofile.dart';
import 'package:video_player/video_player.dart';
import 'dart:math' as math;

import 'package:qstar/screen/qvideo/bottomsheet/bottom_sheet_action.dart';
import 'package:qstar/screen/qvideo/Video_Picker.dart';

class Qvideoscreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Qvideo(),
    );
  }
}

class Qvideo extends StatefulWidget {
  @override
  _QvideoState2 createState() => _QvideoState2();
}

class _QvideoState2 extends State<Qvideo> with SingleTickerProviderStateMixin {
  bool abo = false;
  bool foryou = true;
  bool play = true;

  late VideoPlayerController _controller;
  late AnimationController animationController;
  PageController pageController =
      PageController(initialPage: 0, viewportFraction: 0.8);
  ScrollController _scrollController = ScrollController(initialScrollOffset: 0);
  PageController foryouController = new PageController();
  late VoidCallback _onShowMenu;
  late VoidCallback _onShowshare;
  @override
  void initState() {
    super.initState();
    animationController = new AnimationController(
        vsync: this, duration: new Duration(seconds: 5));
    animationController.repeat();
    _controller = VideoPlayerController.asset('assets/vod.mp4')
      ..initialize().then((value) {
        _controller.play();
        _controller.setLooping(true);
        setState(() {});
      });

    _onShowMenu = () {
      context.showBottomSheet([
        BottomSheetAction(
            iconData: Icons.description, title: 'Description', id: 0),
        BottomSheetAction(iconData: Icons.flag, title: 'Report', id: 1),
      ]);
    };
    _onShowshare = () {
      context.showBottomSheet([
        BottomSheetAction(iconData: Icons.share, title: 'Share to', id: 2),
        BottomSheetAction(iconData: Icons.account_box, title: 'User 1', id: 3),
        BottomSheetAction(iconData: Icons.account_box, title: 'User 2', id: 4),
      ]);
    };
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    _controller.dispose();
    _controller.pause();
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: new IconButton(
            icon: new Icon(Icons.arrow_back, color: mPrimaryColor),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) =>
                      CategoryVid(),
                  transitionDuration: Duration.zero,
                ),
              );
            }),
        title: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
          Text(
            "video",
            style: TextStyle(
              color: mPrimaryColor,
              fontSize: 27,
              fontFamily: 'font1',
            ),
          ),
        ]),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.switch_video_outlined),
            iconSize: 30.0,
            color: mPrimaryColor,
            onPressed: () {
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) =>
                      VideoRecorderExample(),
                  transitionDuration: Duration.zero,
                ),
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          homescreen(),
        ],
      ),
    );
  }

  homescreen() {
    return PageView.builder(
        controller: foryouController,
        onPageChanged: (index) {
          setState(() {
            _controller.seekTo(Duration.zero);
            _controller.play();
          });
        },
        scrollDirection: Axis.vertical,
        itemCount: 5,
        itemBuilder: (context, index) {
          return Container(
            child: Stack(
              children: <Widget>[
                TextButton(
                    onPressed: () {
                      setState(() {
                        if (play) {
                          _controller.pause();
                          play = !play;
                        } else {
                          _controller.play();
                          play = !play;
                        }
                      });
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: VideoPlayer(_controller),
                    )),
                Padding(
                  padding: EdgeInsets.only(bottom: 0, top: 100),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      width: MediaQuery.of(context).size.width - 100,
                      height: 90,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Text.rich(
                                TextSpan(children: <TextSpan>[
                                  TextSpan(text: 'football love'),
                                  TextSpan(
                                      text: '#foot\n',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ]),
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14),
                              )),
                          Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 13),
                                width: 62,
                                height: 42,
                                child: Stack(
                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pushReplacement(
                                          context,
                                          PageRouteBuilder(
                                            pageBuilder: (context, animation1,
                                                    animation2) =>
                                                UserProfile(),
                                            transitionDuration: Duration.zero,
                                          ),
                                        );
                                      },
                                      child: CircleAvatar(
                                        radius: 20,
                                        backgroundColor: Colors.white,
                                        child: CircleAvatar(
                                          radius: 19,
                                          backgroundColor: Colors.black,
                                          backgroundImage:
                                              AssetImage('assets/spook.png'),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              color: Colors.white, width: 1),
                                        ),
                                        child: CircleAvatar(
                                          radius: 7,
                                          backgroundColor:
                                              mPrimaryColor.withOpacity(1),
                                          child: Center(
                                              child: GestureDetector(
                                            onTap: () {},
                                            child: Icon(Icons.add,
                                                size: 11, color: Colors.white),
                                          )),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushReplacement(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder:
                                          (context, animation1, animation2) =>
                                              UserProfile(),
                                      transitionDuration: Duration.zero,
                                    ),
                                  );
                                },
                                child: Text.rich(
                                  TextSpan(children: <TextSpan>[
                                    TextSpan(text: 'UserName'),
                                  ]),
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(bottom: 25, right: 10),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        width: 70,
                        height: 450,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(top: 50),
                              width: 40,
                              height: 25,
                              child: Stack(
                                children: <Widget>[],
                              ),
                            ),
                            // ignore: unnecessary_new
                            new GestureDetector(
                              onTap: () {
                                Navigator.pushReplacement(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder:
                                        (context, animation1, animation2) =>
                                            UserProfile(),
                                    transitionDuration: Duration.zero,
                                  ),
                                );
                              },
                              child: Container(
                                padding: EdgeInsets.only(bottom: 5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Transform(
                                      alignment: Alignment.center,
                                      transform: Matrix4.rotationY(math.pi),
                                      // ignore: prefer_const_constructors
                                      child: Icon(
                                        Icons.arrow_circle_up_outlined,
                                        size: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                    // ignore: prefer_const_constructors
                                    SizedBox(
                                      height: 15,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            new GestureDetector(
                              onTap: () {
                                _onShowMenu();
                              },
                              child: Container(
                                padding: EdgeInsets.only(bottom: 5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Transform(
                                      alignment: Alignment.center,
                                      transform: Matrix4.rotationY(math.pi),
                                      // ignore: prefer_const_constructors
                                      child: Icon(
                                        Icons.more_horiz,
                                        size: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                    // ignore: prefer_const_constructors
                                    SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(bottom: 30),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Icon(Icons.thumb_up,
                                      size: 20, color: Colors.white),
                                  Text('427.9K',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 10))
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(bottom: 30),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Icon(Icons.thumb_down,
                                      size: 20, color: Colors.white),
                                  Text('Dislike',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 10))
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushReplacement(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder:
                                        (context, animation1, animation2) =>
                                            CommentPage(),
                                    transitionDuration: Duration.zero,
                                  ),
                                );
                              },
                              child: Container(
                                padding: EdgeInsets.only(bottom: 5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Transform(
                                        alignment: Alignment.center,
                                        transform: Matrix4.rotationY(math.pi),
                                        child: Icon(Icons.sms,
                                            size: 20, color: Colors.white)),
                                    Text('2051',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 10))
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                _onShowshare();
                              },
                              child: Container(
                                padding: EdgeInsets.only(bottom: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Transform(
                                        alignment: Alignment.center,
                                        transform: Matrix4.rotationY(math.pi),
                                        child: Icon(Icons.reply,
                                            size: 20, color: Colors.white)),
                                    Text('Share',
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 10))
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushReplacement(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder:
                                        (context, animation1, animation2) =>
                                            Useraudeio(),
                                    transitionDuration: Duration.zero,
                                  ),
                                );
                              },
                              child: Container(
                                child: AnimatedBuilder(
                                  animation: animationController,
                                  child: CircleAvatar(
                                    radius: 15,
                                    backgroundColor:
                                        Color(0x222222).withOpacity(1),
                                    child: CircleAvatar(
                                      radius: 12,
                                      backgroundImage:
                                          AssetImage('assets/images/music.jpg'),
                                    ),
                                  ),
                                  builder: (context, _widget) {
                                    return Transform.rotate(
                                        angle: animationController.value * 6.3,
                                        child: _widget);
                                  },
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ))
              ],
            ),
          );
        });
  }
}
