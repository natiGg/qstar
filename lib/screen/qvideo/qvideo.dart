// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:qstar/constant.dart';

import 'package:qstar/screen/qvideo/bottomsheet/app_context.dart';

import 'package:qstar/screen/qvideo/comment/comment_page.dart';
import 'package:qstar/screen/qvideo/useraudio.dart';
import 'package:qstar/screen/qvideo/userprofile.dart';
import 'package:video_player/video_player.dart';
import 'dart:math' as math;
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:qstar/screen/qvideo/bottomsheet/bottom_sheet_action.dart';
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
  PageController foryouController = new PageController();
  late VoidCallback _onShowMenu;
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
        leading: new IconButton(
            icon: new Icon(Icons.arrow_back, color: mPrimaryColor),
            onPressed: () {
              Navigator.of(context).pop(true);
            }),
        title: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
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
            icon: Icon(Icons.switch_video_outlined),
            iconSize: 30.0,
            color: mPrimaryColor,
            onPressed: () {},
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          homescreen(),
          Container(
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

                              new GestureDetector(
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
                                          Icons.arrow_forward_outlined,
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
            child: new Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Container(
                      height: 5,
                    ),
                    new Text(
                      "Send to",
                      style: TextStyle(
                        color: mPrimaryColor,
                        fontFamily: "font1",
                        fontSize: 24,
                      ),
                    )
                  ],
                )),
                new Container(
                  height: 10,
                ),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Icon(
                          Icons.account_box,
                          color: mPrimaryColor,
                        ),
                        new Container(
                          height: 5,
                        ),
                        new Text("user1",
                            style: TextStyle(
                              color: Colors.grey[400],
                            ))
                      ],
                    )),
                    Container(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Icon(
                          Icons.account_box,
                          color: mPrimaryColor,
                        ),
                        new Container(
                          height: 10,
                        ),
                        new Text("user2",
                            style: TextStyle(
                              color: Colors.grey[400],
                            ))
                      ],
                    )),
                    Container(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Icon(
                          Icons.account_box,
                          color: mPrimaryColor,
                        ),
                        new Container(
                          height: 10,
                        ),
                        new Text("user3",
                            style: TextStyle(
                              color: Colors.grey[400],
                            ))
                      ],
                    )),
                    Container(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Icon(
                          Icons.search,
                          color: mPrimaryColor,
                        ),
                        new Container(
                          height: 10,
                        ),
                        new Text("Search",
                            style: TextStyle(
                              color: Colors.grey[400],
                            ))
                      ],
                    )),
                  ],
                ),
                new Container(
                  height: 10,
                ),
                new Row(
//                mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: 18,
                    ),
                  ],
                ),
                new Container(
                  height: 10,
                ),
                new Divider(indent: 18, endIndent: 18, color: Colors.grey),
                new Text(
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
                new Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: 18,
                    ),
                    Container(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Icon(
                          Icons.copy,
                          color: mPrimaryColor,
                        ),
                        new Container(
                          height: 10,
                        ),
                        new Text("copy link",
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
                        new Icon(
                          FontAwesome.whatsapp,
                          color: Colors.green,
                        ),
                        new Container(
                          height: 10,
                        ),
                        new Text("whatsapp",
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
                        new Icon(
                          FontAwesome.facebook,
                          color: Colors.blue,
                        ),
                        new Container(
                          height: 5,
                        ),
                        new Text("More Apps",
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
                        new Icon(
                          FontAwesome.instagram,
                          color: Colors.redAccent,
                        ),
                        new Container(
                          height: 5,
                        ),
                        new Text("Instagram",
                            style: TextStyle(
                              color: Colors.grey[400],
                            ))
                      ],
                    )),
                  ],
                ),
                new Container(
                  height: 10,
                ),
                new Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: 18,
                    ),
                    Container(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Icon(
                          FontAwesome.telegram,
                          color: Colors.blue,
                        ),
                        new Container(
                          height: 10,
                        ),
                        new Text("Telegram",
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
                        new Icon(
                          FontAwesome.twitter,
                          color: Colors.blue,
                        ),
                        new Container(
                          height: 5,
                        ),
                        new Text("twitter",
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
                        new Icon(
                          FontAwesome.google_plus,
                          color: Colors.red,
                        ),
                        new Container(
                          height: 5,
                        ),
                        new Text("google_plus",
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
                        new Icon(
                          FontAwesome.twitch,
                          color: Colors.redAccent,
                        ),
                        new Container(
                          height: 5,
                        ),
                        new Text("twitch",
                            style: TextStyle(
                              color: Colors.grey[400],
                            ))
                      ],
                    )),
                  ],
                ),
                new Container(
                  height: 5,
                ),
                new Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: 25,
                    ),
                    Container(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Icon(
                          FontAwesome.youtube,
                          color: Colors.red,
                        ),
                        new Container(
                          height: 8,
                        ),
                        new Text("youtube",
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
                        new Icon(
                          FontAwesome.google,
                          color: Colors.redAccent,
                        ),
                        new Container(
                          height: 2,
                        ),
                        new Text("google",
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
                        new Icon(
                          Icons.more_horiz_sharp,
                          color: mPrimaryColor,
                        ),
                        new Container(
                          height: 2,
                        ),
                        new Text("More App",
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
