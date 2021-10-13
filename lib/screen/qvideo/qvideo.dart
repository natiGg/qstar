import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:qstar/constant.dart';
import 'package:video_player/video_player.dart';
import 'dart:math' as math;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
      appBar: AppBar(
        leadingWidth: 100,
        backgroundColor: Colors.white,
        leading: Container(
          padding: EdgeInsets.only(left: 20, top: 15),
          width: 100,
          child: Text(
            "video",
            style: TextStyle(
              color: mPrimaryColor,
              fontSize: 27,
              fontFamily: 'font1',
            ),
          ),
        ),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.camera_alt),
            iconSize: 30.0,
            color: mPrimaryColor,
            onPressed: () {},
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
                      height: 80,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Padding(
                              padding: EdgeInsets.only(left: 10, top: 0),
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
                          Container(
                            padding: EdgeInsets.only(
                              left: 10,
                            ),
                            child: Row(
                              children: <Widget>[
                                CircleAvatar(
                                  radius: 12,
                                  backgroundImage:
                                      AssetImage('assets/images/profile2.jpg'),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text('username',
                                    style: TextStyle(color: Colors.white)),
                                SizedBox(
                                  width: 5,
                                ),
                                TextButton.icon(
                                  icon: Icon(
                                    Icons.add,
                                    color: mPrimaryColor,
                                  ),
                                  label: Text('Follow',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 10)),
                                  onPressed: () {},
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(bottom: 10, right: 10),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        width: 70,
                        height: 400,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(top: 53),
                              width: 40,
                              height: 50,
                              child: Stack(
                                children: <Widget>[],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(bottom: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Transform(
                                      alignment: Alignment.center,
                                      transform: Matrix4.rotationY(math.pi),
                                      child: Icon(Icons.more_horiz,
                                          size: 20, color: Colors.white)),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
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
                            Container(
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
                            Container(
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
                            Container(
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
