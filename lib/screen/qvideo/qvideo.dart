import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
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
            "Q video",
            style: TextStyle(
                color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          homescreen(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextButton(
                  onPressed: () {
                    setState(() {
                      abo = true;
                      foryou = false;
                    });
                  },
                  child: Text('Following',
                      style: abo
                          ? const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18)
                          : TextStyle(color: Colors.white, fontSize: 16))),
              const Text('|',
                  style: TextStyle(color: Colors.white, fontSize: 5)),
              TextButton(
                  onPressed: () {
                    setState(() {
                      abo = false;
                      foryou = true;
                    });
                  },
                  child: Text('For You',
                      style: foryou
                          ? TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18)
                          : TextStyle(color: Colors.white, fontSize: 16))),
            ],
          )
        ],
      ),
    );
  }

  homescreen() {
    if (foryou) {
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
            return Stack(
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
                      margin: const EdgeInsets.only(top: 0.0),
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
                      height: 100,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Padding(
                            padding: EdgeInsets.only(left: 10, bottom: 5),
                            child: Text(
                              '@spook_clothing',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          const Padding(
                              padding: EdgeInsets.only(left: 10, bottom: 5),
                              child: Text.rich(
                                TextSpan(children: <TextSpan>[
                                  TextSpan(text: 'Eiffel Tower'),
                                  TextSpan(
                                      text: '#foot\n',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  TextSpan(
                                      text: 'Voir la traduction',
                                      style: TextStyle(fontSize: 12))
                                ]),
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14),
                              )),
                          Container(
                            padding: EdgeInsets.only(left: 10),
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.music_note,
                                    size: 16, color: Colors.white),
                                Text('R10 - Oboy',
                                    style: TextStyle(color: Colors.white))
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(bottom: 65, right: 10),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        width: 70,
                        height: 400,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(bottom: 23),
                              width: 40,
                              height: 50,
                              child: Stack(
                                children: <Widget>[
                                  CircleAvatar(
                                    radius: 20,
                                    backgroundColor: Colors.white,
                                    child: CircleAvatar(
                                      radius: 19,
                                      backgroundColor: Colors.black,
                                      backgroundImage:
                                          AssetImage('assets/spook.png'),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: CircleAvatar(
                                      radius: 10,
                                      backgroundColor:
                                          Color(0xfd2c58).withOpacity(1),
                                      child: Center(
                                          child: Icon(Icons.add,
                                              size: 15, color: Colors.white)),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(bottom: 25),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Icon(Icons.favorite,
                                      size: 35, color: Colors.white),
                                  Text('427.9K',
                                      style: TextStyle(color: Colors.white))
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
                                      child: Icon(Icons.sms,
                                          size: 35, color: Colors.white)),
                                  Text('2051',
                                      style: TextStyle(color: Colors.white))
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(bottom: 50),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Transform(
                                      alignment: Alignment.center,
                                      transform: Matrix4.rotationY(math.pi),
                                      child: Icon(Icons.reply,
                                          size: 35, color: Colors.white)),
                                  Text('Share',
                                      style:
                                          const TextStyle(color: Colors.white))
                                ],
                              ),
                            ),
                            AnimatedBuilder(
                              animation: animationController,
                              child: CircleAvatar(
                                radius: 22,
                                backgroundColor: Color(0x222222).withOpacity(1),
                                child: CircleAvatar(
                                  radius: 12,
                                  backgroundImage:
                                      AssetImage('assets/oboy.jpg'),
                                ),
                              ),
                              builder: (context, _widget) {
                                return Transform.rotate(
                                    angle: animationController.value * 6.3,
                                    child: _widget);
                              },
                            )
                          ],
                        ),
                      ),
                    ))
              ],
            );
          });
    } else {
      _controller.play();
      return Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.black,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                      padding: EdgeInsets.only(bottom: 14),
                      child: Text(
                        'Créateurs tendances',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: Column(
                      children: <Widget>[
                        Center(
                          child: Text(
                              'Abonne-toi à un compte pour découvrir ses',
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.8))),
                        ),
                        Center(
                          child: Text('dernières vidéos ici.',
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.8))),
                        )
                      ],
                    ),
                  )
                ],
              ),
              Container(
                height: 372,
                margin: EdgeInsets.only(top: 25),
                child: PageView.builder(
                    dragStartBehavior: DragStartBehavior.down,
                    controller: pageController,
                    itemCount: 5,
                    itemBuilder: (context, position) {
                      return videoSlider(position);
                    }),
              )
            ],
          ));
    }
  }

  videoSlider(int index) {
    return AnimatedBuilder(
      animation: pageController,
      builder: (context, widget) {
        double value = 1;
        if (pageController.position.haveDimensions) {
          value = (pageController.page! - index);
          value = (1 - (value.abs() * 0.3)).clamp(0.0, 1.0);
        }
        return Center(
          child: SizedBox(
            height: Curves.easeInOut.transform(value) * 372,
            width: Curves.easeInOut.transform(value) * 300,
            child: widget,
          ),
        );
      },
      child: Stack(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            child: VideoPlayer(_controller),
          ),
          Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.all(5),
                child: Icon(
                  Icons.close,
                  size: 15,
                  color: Colors.white,
                ),
              )),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.only(bottom: 15),
              height: 370 / 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(bottom: 15),
                      child: CircleAvatar(
                        backgroundColor: Colors.black,
                        backgroundImage: const AssetImage('assets/spook.png'),
                        radius: 30,
                      )),
                  Padding(
                      padding: EdgeInsets.only(bottom: 6),
                      child:
                          Text('Spook', style: TextStyle(color: Colors.white))),
                  Text('@spook_clothing',
                      style: TextStyle(color: Colors.white.withOpacity(0.5))),
                  Container(
                      height: 50,
                      margin: EdgeInsets.only(left: 50, right: 50, top: 12),
                      decoration: BoxDecoration(
                        color: Color(0xfe2b54).withOpacity(1),
                        borderRadius:
                            BorderRadius.all(const Radius.circular(5)),
                      ),
                      child: Center(
                        child: const Text(
                          'Abonnement',
                          style: TextStyle(color: Colors.white),
                        ),
                      ))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  buttonplus() {
    return Container(
      width: 46,
      height: 30,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.transparent),
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              width: 28,
              height: 30,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  color: Color(0x2dd3e7).withOpacity(1)),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              width: 28,
              height: 30,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: const Color(0x00ed316a).withOpacity(1)),
            ),
          ),
          Center(
            child: Container(
              width: 28,
              height: 30,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(const Radius.circular(10)),
                  color: Colors.white),
              child: Center(child: Icon(Icons.add, color: Colors.black)),
            ),
          )
        ],
      ),
    );
  }
}
