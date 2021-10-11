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

class UsersFeed extends StatelessWidget {
  const UsersFeed({Key? key}) : super(key: key);
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

class Feed extends StatelessWidget {
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
            Padding(
              padding: EdgeInsets.all(20),
              child: Container(
                height: 110,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    SizedBox(height: 5),
                    Row(children: _users.map((e) => UserStories(e)).toList())
                  ],
                ),
              ),
            ),
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
          ],
        ),
      ),
    );
  }
}

class UserStories extends StatelessWidget {
  final User user;

  UserStories(this.user);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.6 / 2,
      child: Container(
        margin: EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(
              image: AssetImage('assets/images/post${this.user.id}.jpg'),
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
                            'assets/images/profile${this.user.id}.jpg'),
                        fit: BoxFit.cover)),
              ),
              Text(
                '${this.user.userName}',
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class WPost extends StatelessWidget {
  final Post post;

  WPost({required this.post});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: 130,
              ),
              Expanded(
                child: CircleAvatar(
                    backgroundImage: AssetImage(
                        'assets/images/profile${this.post.userid}.jpg')),
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
          Text(
              '${_users.where((element) => element.id == this.post.userid).first.userName}',
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
          Container(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: RichText(
                text: TextSpan(children: [
                  TextSpan(
                    text:
                        'This is gonna be the best day of my life....my la lalala lalllaaaaalaaa aaaa',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        ?.copyWith(fontWeight: FontWeight.w400),
                  ),
                ]),
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/post${this.post.id}.jpg"),
                  fit: BoxFit.cover),
            ),
            height: 500,
          ),
          Container(
            padding: EdgeInsets.all(12.0),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.thumb_up,
                          color: mPrimaryColor,
                          size: 25,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.chat, color: mPrimaryColor, size: 25),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.share, color: mPrimaryColor, size: 25),
                      ],
                    ),
                  ),
                ),
                Spacer(),
                // Container(
                //   decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(15), color: Colors.red),
                //   height: 7,
                //   width: 10,
                // ),
                // // CircleAvatar(
                // //   radius: 3,
                // //   backgroundColor: Colors.grey,
                // // ),
                // // CircleAvatar(
                // //   radius: 3,
                // //   backgroundColor: Colors.grey,
                // // ),
                // // CircleAvatar(
                // //   radius: 3,
                // //   backgroundColor: Colors.grey,
                // // ),
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
            padding: const EdgeInsets.all(8.0),
            child: InfoWidget(),
          )
        ],
      ),
    );
  }
}
