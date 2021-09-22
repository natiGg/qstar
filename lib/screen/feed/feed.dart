import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qstar/screen/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:qstar/constant.dart';
import 'package:qstar/screen/splash/splash_screen.dart';
import 'package:qstar/screen/feed/model/user.dart';
import 'package:google_fonts/google_fonts.dart';

List<User> _users = [
  User(id: 1, family: "Hodiseh_moazafari"),
  User(id: 2, family: "ui. street"),
  User(id: 3, family: "Alireza"),
  User(id: 4, family: "Muhammed"),
  User(id: 5, family: "Arian"),
];

List<Post> _posts = [
  Post(userid: 1, id: 1, title: 'mike check'),
  Post(userid: 2, id: 2, title: 'mike check'),
  Post(userid: 3, id: 3, title: 'mike check'),
  Post(userid: 4, id: 4, title: 'mike check'),
];

void main() {
  runApp(const UsersFeed());
}

class UsersFeed extends StatelessWidget {
  const UsersFeed({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coffee',
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
            color: Colors.black,
            onPressed: () {}),
        title: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            color: Colors.black,
            onPressed: null,
          ),
        ]),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(Icons.send_outlined),
              color: Colors.black)
        ],
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // SizedBox(height: 10,),
          // Container(
          //   height:110 ,
          //   child: ListView(
          //       scrollDirection: Axis.horizontal,
          //       children: [
          //       SizedBox(height: 5),
          //       Row(
          //         children:_users.map((e) => UserAvatar(e)).toList()
          //       )
          //     ],),
          // ),
          // SizedBox(height: 15,),
          Expanded(
            child: ListView(
              children: _posts.map((e) => WPost(post: e)).toList(),
            ),
          )
        ],
      ),
    );
  }
}

class UserAvatar extends StatelessWidget {
  final User user;
  UserAvatar(this.user);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(6),
      child: Column(
        children: [
          CircleAvatar(
            radius: 37,
            backgroundColor: Colors.red.shade200,
            child: CircleAvatar(
              radius: 36,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                  radius: 32,
                  backgroundImage:
                      AssetImage('assets/images/profile${this.user.id}.jpg')),
            ),
          ),
          SizedBox(height: 3),
          Text('${this.user.family}', style: TextStyle(color: Colors.black))
        ],
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
                width: 24,
              ),
              CircleAvatar(
                  backgroundImage: AssetImage(
                      'assets/images/profile${this.post.userid}.jpg')),
              SizedBox(
                width: 5,
              ),
              Text(
                  '${_users.where((element) => element.id == this.post.userid).first.family}',
                  style: TextStyle(color: Colors.black)),
              Spacer(),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.more_horiz_rounded,
                    color: Colors.black,
                  ))
            ],
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
            height: 300,
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  CupertinoIcons.heart_fill,
                  color: Colors.red,
                ),
                padding: EdgeInsets.zero,
              ),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    CupertinoIcons.chat_bubble_text,
                    color: Colors.black,
                  )),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.send_outlined,
                    color: Colors.black,
                  )),
              Spacer(),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15), color: Colors.red),
                height: 7,
                width: 10,
              ),
              CircleAvatar(
                radius: 3,
                backgroundColor: Colors.grey,
              ),
              CircleAvatar(
                radius: 3,
                backgroundColor: Colors.grey,
              ),
              CircleAvatar(
                radius: 3,
                backgroundColor: Colors.grey,
              ),
              Spacer(),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.bookmark_border,
                    color: Colors.black,
                  )),
              SizedBox(
                width: 5,
              ),
            ],
          )
        ],
      ),
    );
  }
}
