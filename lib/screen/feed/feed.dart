import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:qstar/constant.dart';

import 'package:qstar/screen/feed/model/user.dart';
import 'package:qstar/screen/feed/widgets/info_widget.dart';
import 'package:qstar/screen/videocall/videocall.dart';
import 'package:qstar/screen/post/main.dart';
import 'package:qstar/screen/Chat/home_screen.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:qstar/screen/comment/comment_page.dart';

import 'package:qstar/screen/feed/bottomsheet/bottom_sheet_action.dart';

import 'package:qstar/screen/feed/bottomsheet/app_context.dart';
// import 'package:rive/rive.dart';

List<User> _users = [
  User(id: 1, userName: "gelila", storyImage: "", userImage: ""),
  User(id: 2, userName: "natig", storyImage: "", userImage: ""),
  User(id: 3, userName: "bini", storyImage: "", userImage: ""),
  User(id: 4, userName: "yosi", storyImage: "", userImage: ""),
  User(id: 5, userName: "abrsh", storyImage: "", userImage: ""),
];

List<Post> _posts = [
  Post(userid: 1, id: 1, title: 'mike check'),
  Post(userid: 2, id: 2, title: 'mike check'),
  Post(userid: 3, id: 3, title: 'mike check'),
  Post(userid: 4, id: 4, title: 'mike check'),
  Post(userid: 5, id: 5, title: 'mike check'),
];

void main() {
  runApp(const UsersFeed());
}

class UsersFeed extends StatefulWidget {
  const UsersFeed({Key? key}) : super(key: key);

  @override
  State<UsersFeed> createState() => _UsersFeedState();
}

late VoidCallback _onShowMenu;

class _UsersFeedState extends State<UsersFeed> {
  @override
  void initState() {
    super.initState();

    _onShowMenu = () {
      context.showBottomSheet([
        BottomSheetAction(iconData: Icons.share, title: 'Share TO', id: 0),
        BottomSheetAction(
            iconData: Icons.account_circle_outlined, title: 'User 1', id: 1),
        BottomSheetAction(
            iconData: Icons.account_circle_outlined, title: 'User 2', id: 2),
        BottomSheetAction(
            iconData: Icons.account_circle_outlined, title: 'User 3', id: 3),
      ]);
    };
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Feed',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: mBackgroundColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Feed(),
    );
  }
}

class Feed extends StatefulWidget {
  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
            icon: Icon(Icons.video_call),
            color: mPrimaryColor,
            onPressed: () {
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) =>
                      GroupCallScreen(),
                  transitionDuration: Duration.zero,
                ),
              );
            }),
        title: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            color: mPrimaryColor,
            onPressed: () {
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) => MyApp(),
                  transitionDuration: Duration.zero,
                ),
              );
            },
          ),
        ]),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) =>
                        HomeScreen(),
                    transitionDuration: Duration.zero,
                  ),
                );
              },
              icon: Icon(Icons.send_outlined),
              color: mPrimaryColor),
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Padding(
            //   padding: EdgeInsets.all(20),
            //   child: Container(
            //     height: 110,
            //     child: ListView(
            //       scrollDirection: Axis.horizontal,
            //       children: [
            //         SizedBox(height: 5),
            //         Row(children: _users.map((e) => UserStories(e)).toList())
            //       ],
            //     ),
            //   ),
            // ),
         
            Card(
              margin: EdgeInsets.symmetric(horizontal: 0.0),
              elevation: 0.0,
              shape: null,
              child: Container(
                padding: const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 0.0),
                color: Colors.white,
                child: Column(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/images/profile1.jpg')),
                        const SizedBox(width: 8.0),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration.collapsed(
                              hintText: 'What\'s on your mind?',
                            ),
                          ),
                        )
                      ],
                    ),
                    const Divider(height: 10.0, thickness: 0.5),
                    Container(
                      height: 40.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          FlatButton.icon(
                            onPressed: () => print('Live'),
                            icon: const Icon(
                              Icons.videocam,
                              color: Colors.red,
                            ),
                            label: Text('Live'),
                          ),
                          const VerticalDivider(width: 8.0),
                          FlatButton.icon(
                            onPressed: () => print('Photo'),
                            icon: const Icon(
                              Icons.photo_library,
                              color: Colors.green,
                            ),
                            label: Text('Photo'),
                          ),
                          const VerticalDivider(width: 8.0),
                          FlatButton.icon(
                            onPressed: () => print('Room'),
                            icon: const Icon(
                              Icons.video_call,
                              color: Colors.purpleAccent,
                            ),
                            label: Text('Room'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            ..._posts.map((item) {
              return Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: WPost(
                  post: item,
                ),
              );
            }).toList(),
               Container(
                 child: Padding(
                   padding: const EdgeInsets.all(10.0),
                   child: Align(
                     alignment: Alignment.topLeft,
                     child: Text(
                                    "Suggested Friends",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: mPrimaryColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                   ),
                 ),
               ),  
            Container(
              height: 250,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                    Column(
                      children: [
                     
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(height: 5),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(children: _users.map((e) => UserAvatar(e)).toList()),
                          )
                      ],
                    ),
                
                ],
              ),
            ),
              ..._posts.map((item) {
              return Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: WPost(
                  post: item,
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}

class UserStories extends StatefulWidget {
  final User user;

  UserStories(this.user);

  @override
  State<UserStories> createState() => _UserStoriesState();
}

class _UserStoriesState extends State<UserStories> {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.6 / 2,
      child: Container(
        margin: EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(
              image: AssetImage('assets/images/post${this.widget.user.id}.jpg'),
              fit: BoxFit.cover),
        ),
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: LinearGradient(begin: Alignment.bottomRight, colors: [
                Colors.black.withOpacity(.9),
                Colors.black.withOpacity(.1),
              ])),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                    image: DecorationImage(
                        image: AssetImage(
                            'assets/images/profile${this.widget.user.id}.jpg'),
                        fit: BoxFit.cover)),
              ),
              Text(
                '${this.widget.user.userName}',
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class UserAvatar extends StatelessWidget {
  final User user;
  UserAvatar(this.user);

  @override
  Widget build(BuildContext context) {
    // return Container(
    //   margin: EdgeInsets.all(6),
    //   child:Column(
    //     children: [
    //       CircleAvatar(
    //         radius: 37,
    //         backgroundColor: Colors.red.shade200,
    //         child: CircleAvatar(
    //           radius: 36,
    //           backgroundColor:Colors.white,
    //           child: CircleAvatar(
    //             radius:32,
    //             backgroundImage: AssetImage('assets/images/profile${this.user.id}.jpg')),
    //         ),
    //       ),
    //       SizedBox(height:3),
    //       Text('${this.user.userName}',style: TextStyle(color: Colors.white))
    //     ],
    //   ) ,
    // );
    return Column(children: [
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Card(
          elevation: 2,
          child: Row(
              children: List.generate(1, (index) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Stack(
                    children:[ Container(
                      width: 68,
                      height: 68,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                              colors: [Color(0xFF9B2282), Color(0xFFEEA863)],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter)),
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white, width: 2),
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/profile${this.user.id}.jpg'),
                                  fit: BoxFit.cover),
                            )),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 50),
                                                        decoration: BoxDecoration(
                                                          shape: BoxShape.circle,
                                                          border: Border.all(
                                                              color: mPrimaryColor, width: 1),
                                                        ),
                                                        child: CircleAvatar(
                                                          radius: 9,
                                                          backgroundColor:
                                                              Colors.white,
                                                          child: Center(
                                                              child: Icon(Icons.add,
                                                                  size: 16,
                                                                  color: mPrimaryColor)),
                                                        ),
                                                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Center(
                      child: Text(
                    '${this.user.userName}',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: mPrimaryColor),
                  )),
                  RatingBarIndicator(
                    rating: 2.75,
                    itemBuilder: (context, index) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    itemCount: 5,
                    itemSize: 20.0,
                    direction: Axis.horizontal,
                  ),
                  Container(
                    color: Colors.white,
                    height: 60,
                    width: 80,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "12k",
                          style: TextStyle(
                              fontSize: 18,
                              color: mPrimaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "followers",
                          style: const TextStyle(
                              fontSize: 14, color: mPrimaryColor),
                        ),
                      ],
                    ),
                  ),
                  
                ],
              ),
            );
          })),
        ),
      )
    ]);
  }
}

class WPost extends StatefulWidget {
  final Post post;

  WPost({required this.post});

  @override
  State<WPost> createState() => _WPostState();
}

class _WPostState extends State<WPost> {
  bool isActive = false;
  bool isdisActive = false;

  final FlareControls flareControls = FlareControls();

  /// Is the animation currently playing?
  bool _isPlaying = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              Padding(
                padding: EdgeInsets.only(left: 45),
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: mPrimaryColor, width: 2),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: CircleAvatar(
                          radius: 30,
                          backgroundImage: AssetImage(
                              'assets/images/profile${this.widget.post.userid}.jpg')),
                    ),
                  ),
                ),
              ),
              Spacer(),
              IconButton(
                onPressed: () {
                  showDialog(
                    useRootNavigator: false,
                    context: context,
                    builder: (context) {
                      return Dialog(
                        child: ListView(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            shrinkWrap: true,
                            children: [
                              'Report...',
                              'Turn on Post notification',
                              'Copy Link',
                              'Share to...',
                              'Mute'
                            ]
                                .map((e) => InkWell(
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 12, horizontal: 16),
                                        child: Text(e),
                                      ),
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                    ))
                                .toList()),
                      );
                    },
                  );
                },
                icon: Icon(Icons.more_vert),
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text(
                          '${_users.where((element) => element.id == this.widget.post.userid).first.userName}',
                          style: TextStyle(color: Colors.black)),
                      RatingBarIndicator(
                        rating: 2.75,
                        itemBuilder: (context, index) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        itemCount: 5,
                        itemSize: 20.0,
                        direction: Axis.horizontal,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                child: Center(
                  child: Text(
                    "To create bordered text, a Paint with Paint.style set to PaintingStyle.",
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.6),
                      decorationStyle: TextDecorationStyle.wavy,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
          Stack(children: <Widget>[
            SizedBox(
              height: 5,
            ),
            GestureDetector(
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
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                          "assets/images/post${this.widget.post.id}.jpg"),
                      fit: BoxFit.cover),
                ),
                height: 500,
              ),
            ),
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
          ]),
          Container(
            padding: EdgeInsets.all(5.0),
            child: Row(
              children: [
                GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isdisActive && !isActive) {
                          isActive = !isActive;
                          isdisActive = !isdisActive;
                        } else if (!isdisActive && isActive) {
                          isActive = !isActive;
                        } else if (!isdisActive && !isActive) {
                          isActive = !isActive;
                        }
                      });
                    },
                    child: activeLikeButton(isActive)),
                GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isActive && !isdisActive) {
                          isActive = !isActive;
                          isdisActive = !isdisActive;
                        } else if (isdisActive && !isActive) {
                          isdisActive = !isdisActive;
                        } else if (!isdisActive && !isActive) {
                          isdisActive = !isdisActive;
                        }
                      });
                    },
                    child: activedisLikeButton(isdisActive)),
                GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation1, animation2) =>
                              CommentPage(),
                          transitionDuration: Duration.zero,
                        ),
                      );
                    },
                    child: Comment()),
                Share(),
                Spacer(),
                Spacer(),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.bookmark_border,
                      color: mPrimaryColor,
                    )),
                SizedBox(
                  width: 5,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: InfoWidget(),
          )
        ],
      ),
    );
  }

  Widget activeLikeButton(isActive) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              isActive ? Icons.thumb_up : Icons.thumb_up_alt_outlined,
              color: isActive ? mPrimaryColor : Colors.grey,
              size: 25,
            )
          ],
        ),
      ),
    );
  }

  Widget activedisLikeButton(isActive) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              isActive ? Icons.thumb_down : Icons.thumb_down_outlined,
              color: isActive ? mPrimaryColor : Colors.grey,
              size: 25,
            )
          ],
        ),
      ),
    );
  }

  Widget Comment() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.chat, color: Colors.grey, size: 25),
          ],
        ),
      ),
    );
  }

  Widget Share() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.share, color: Colors.grey, size: 25),
              onPressed: () {
                _onShowMenu();
              },
            ),
          ],
        ),
      ),
    );
  }
}
