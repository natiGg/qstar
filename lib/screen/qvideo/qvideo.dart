// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:qstar/constant.dart';
import 'package:qstar/screen/qvideo/bottomsheet_report/app_context.dart';
import 'package:qstar/screen/qvideo/bottomsheet_report/bottom_sheet_action.dart';
import 'package:qstar/screen/qvideo/category.dart';

import 'package:qstar/screen/qvideo/comment/comment_page.dart';
import 'package:qstar/screen/qvideo/useraudio.dart';
import 'package:qstar/screen/qvideo/userprofile.dart';
import 'package:video_player/video_player.dart';
import 'dart:math' as math;
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controls.dart';

import 'package:qstar/screen/qvideo/Video_Picker.dart';

class Qvideoscreen extends StatefulWidget {
  @override
  _QvideoState2 createState() => _QvideoState2();
}

class _QvideoState2 extends State<Qvideoscreen>
    with SingleTickerProviderStateMixin {
  bool abo = false;
  bool foryou = true;
  bool play = true;
  bool isActive = false;
  bool isdisActive = false;
  final FlareControls flareControls = FlareControls();
  late VideoPlayerController _controller;
  late AnimationController animationController;
  PageController pageController =
      PageController(initialPage: 0, viewportFraction: 0.8);
  PageController foryouController = PageController();
  late VoidCallback _onShowMenu;
  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 5));
    animationController.repeat();
    _controller = VideoPlayerController.asset('assets/vod.mp4')
      ..initialize().then((value) {
        _controller.play();
        _controller.setLooping(true);
        setState(() {});
      });

    _onShowMenu = () {
      context.showBottomSheet([
        BottomSheetAction(iconData: Icons.report, title: 'Report', id: 0),
        BottomSheetAction(iconData: Icons.remove, title: 'Block', id: 1),
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

    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: mPrimaryColor),
            onPressed: () {
              int count = 0;
              Navigator.popUntil(context, (route) {
                return count++ == 1;
              });
            }),
        title: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            iconSize: 30.0,
            color: mPrimaryColor,
            onPressed: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) =>
                      VideoRecorderExample(),
                  transitionDuration: Duration.zero,
                ),
              );
            },
          ),
        ]),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.videocam),
            iconSize: 30.0,
            color: mPrimaryColor,
            onPressed: () {},
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          homescreen(),
          SizedBox(
            height: 500,
            child: Center(
              child: SizedBox(
                width: 80,
                height: 80,
                child: FlareActor(
                  'assets/images/instagram_like.flr',
                  controller: flareControls,
                  animation: 'idle',
                ),
              ),
            ),
          ),
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
          return GestureDetector(
            onDoubleTap: () {
              setState(() {
                if (isdisActive && !isActive) {
                  isdisActive = !isdisActive;
                  isActive = !isActive;
                } else if (!isActive) {
                  isActive = !isActive;
                }

                // _isPlaying ? null : _controller.isActive = true;
              });
              flareControls.play("like");
            },
            child: Container(
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
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: VideoPlayer(_controller),
                      )),
                  Padding(
                    padding: EdgeInsets.only(bottom: 0, top: 100),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: SizedBox(
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
                                          Navigator.push(
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
                                                  size: 11,
                                                  color: Colors.white),
                                            )),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
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
                                    TextSpan(children: const <TextSpan>[
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
                        child: SizedBox(
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
                                  children: const <Widget>[],
                                ),
                              ),

                              GestureDetector(
                                onTap: () {
                                  _onShowMenu();
                                },
                                child: Container(
                                  padding: EdgeInsets.only(bottom: 5),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Transform(
                                        alignment: Alignment.center,
                                        transform: Matrix4.rotationY(math.pi),
                                        // ignore: prefer_const_constructors
                                        child: Icon(
                                          Icons.arrow_back_outlined,
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

                              Container(
                                padding: const EdgeInsets.only(bottom: 30),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          if (isdisActive && !isActive) {
                                            isActive = !isActive;
                                            isdisActive = !isdisActive;
                                          } else if (!isdisActive && isActive) {
                                            isActive = !isActive;
                                          } else if (!isdisActive &&
                                              !isActive) {
                                            isActive = !isActive;
                                          }
                                        });
                                      },
                                      child: Icon(Icons.thumb_up,
                                          size: 20,
                                          color: isActive
                                              ? mPrimaryColor
                                              : Colors.white),
                                    ),
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
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          if (isActive && !isdisActive) {
                                            isActive = !isActive;
                                            isdisActive = !isdisActive;
                                          } else if (isdisActive && !isActive) {
                                            isdisActive = !isdisActive;
                                          } else if (!isdisActive &&
                                              !isActive) {
                                            isdisActive = !isdisActive;
                                          }
                                        });
                                      },
                                      child: Icon(Icons.thumb_down,
                                          size: 20,
                                          color: isdisActive
                                              ? mPrimaryColor
                                              : Colors.white),
                                    ),
                                    Text('Dislike',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 10))
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Transform(
                                          alignment: Alignment.center,
                                          transform: Matrix4.rotationY(math.pi),
                                          child: Icon(Icons.sms,
                                              size: 20, color: Colors.white)),
                                      Text('2051',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 10))
                                    ],
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  showSheet(context);
                                },
                                child: Container(
                                  padding: EdgeInsets.only(bottom: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Transform(
                                          alignment: Alignment.center,
                                          transform: Matrix4.rotationY(math.pi),
                                          child: Icon(Icons.reply,
                                              size: 20, color: Colors.white)),
                                      Text('Share',
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 10))
                                    ],
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
                                        backgroundImage: AssetImage(
                                            'assets/images/music.jpg'),
                                      ),
                                    ),
                                    builder: (context, _widget) {
                                      return Transform.rotate(
                                          angle:
                                              animationController.value * 6.3,
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
            ),
          );
        });
  }

  void showSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            height: 780,
            color: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 0, horizontal: 5),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 5,
                    ),
                    Text(
                      "Send to",
                      style: TextStyle(
                        color: mPrimaryColor,
                        fontFamily: "font1",
                        fontSize: 24,
                      ),
                    )
                  ],
                )),
                Container(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.account_box,
                          color: mPrimaryColor,
                        ),
                        Container(
                          height: 5,
                        ),
                        Text("user1",
                            style: TextStyle(
                              color: Colors.grey[400],
                            ))
                      ],
                    )),
                    Container(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.account_box,
                          color: mPrimaryColor,
                        ),
                        Container(
                          height: 10,
                        ),
                        Text("user2",
                            style: TextStyle(
                              color: Colors.grey[400],
                            ))
                      ],
                    )),
                    Container(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.account_box,
                          color: mPrimaryColor,
                        ),
                        Container(
                          height: 10,
                        ),
                        Text("user3",
                            style: TextStyle(
                              color: Colors.grey[400],
                            ))
                      ],
                    )),
                    Container(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.search,
                          color: mPrimaryColor,
                        ),
                        Container(
                          height: 10,
                        ),
                        Text("Search",
                            style: TextStyle(
                              color: Colors.grey[400],
                            ))
                      ],
                    )),
                  ],
                ),
                Container(
                  height: 10,
                ),
                Row(
//                mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: 18,
                    ),
                  ],
                ),
                Container(
                  height: 10,
                ),
                Divider(indent: 18, endIndent: 18, color: Colors.grey),
                Text(
                  "Share to",
                  style: TextStyle(
                    color: mPrimaryColor,
                    fontFamily: "font1",
                    fontSize: 24,
                  ),
                ),
                Container(
                  height: 5,
                ),
                Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: 18,
                    ),
                    Container(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.copy,
                          color: mPrimaryColor,
                        ),
                        Container(
                          height: 10,
                        ),
                        Text("copy link",
                            style: TextStyle(
                              color: Colors.grey[400],
                            ))
                      ],
                    )),
                    Container(
                      width: 18,
                    ),
                    Container(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          FontAwesome.whatsapp,
                          color: Colors.green,
                        ),
                        Container(
                          height: 10,
                        ),
                        Text("whatsapp",
                            style: TextStyle(
                              color: Colors.grey[400],
                            ))
                      ],
                    )),
                    Container(
                      width: 18,
                    ),
                    Container(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          FontAwesome.facebook,
                          color: Colors.blue,
                        ),
                        Container(
                          height: 5,
                        ),
                        Text("More Apps",
                            style: TextStyle(
                              color: Colors.grey[400],
                            ))
                      ],
                    )),
                    Container(
                      width: 18,
                    ),
                    Container(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          FontAwesome.instagram,
                          color: Colors.redAccent,
                        ),
                        Container(
                          height: 5,
                        ),
                        Text("Instagram",
                            style: TextStyle(
                              color: Colors.grey[400],
                            ))
                      ],
                    )),
                  ],
                ),
                Container(
                  height: 10,
                ),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: 18,
                    ),
                    Container(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          FontAwesome.telegram,
                          color: Colors.blue,
                        ),
                        Container(
                          height: 10,
                        ),
                        Text("Telegram",
                            style: TextStyle(
                              color: Colors.grey[400],
                            ))
                      ],
                    )),
                    Container(
                      width: 21,
                    ),
                    Container(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          FontAwesome.twitter,
                          color: Colors.blue,
                        ),
                        Container(
                          height: 5,
                        ),
                        Text("twitter",
                            style: TextStyle(
                              color: Colors.grey[400],
                            ))
                      ],
                    )),
                    Container(
                      width: 26,
                    ),
                    Container(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          FontAwesome.google_plus,
                          color: Colors.red,
                        ),
                        Container(
                          height: 5,
                        ),
                        Text("google_plus",
                            style: TextStyle(
                              color: Colors.grey[400],
                            ))
                      ],
                    )),
                    Container(
                      width: 32,
                    ),
                    Container(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          FontAwesome.twitch,
                          color: Colors.redAccent,
                        ),
                        Container(
                          height: 5,
                        ),
                        Text("twitch",
                            style: TextStyle(
                              color: Colors.grey[400],
                            ))
                      ],
                    )),
                  ],
                ),
                Container(
                  height: 5,
                ),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: 25,
                    ),
                    Container(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          FontAwesome.youtube,
                          color: Colors.red,
                        ),
                        Container(
                          height: 8,
                        ),
                        Text("youtube",
                            style: TextStyle(
                              color: Colors.grey[400],
                            ))
                      ],
                    )),
                    Container(
                      width: 18,
                    ),
                    Container(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          FontAwesome.google,
                          color: Colors.redAccent,
                        ),
                        Container(
                          height: 2,
                        ),
                        Text("google",
                            style: TextStyle(
                              color: Colors.grey[400],
                            ))
                      ],
                    )),
                    Container(
                      width: 26,
                    ),
                    Container(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.more_horiz_sharp,
                          color: mPrimaryColor,
                        ),
                        Container(
                          height: 2,
                        ),
                        Text("More App",
                            style: TextStyle(
                              color: Colors.grey[400],
                            ))
                      ],
                    )),
                  ],
                ),
              ],
            ),
          );
        });
  }
}
