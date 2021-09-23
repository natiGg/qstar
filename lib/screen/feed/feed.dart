import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qstar/screen/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:qstar/constant.dart';
import 'package:qstar/screen/splash/splash_screen.dart';
import 'package:qstar/screen/feed/model/user.dart';
import 'package:qstar/screen/feed/widgets/info_widget.dart';
import 'package:google_fonts/google_fonts.dart';

List<User> _users = [
  User(id: 1, userName: "gelila",storyImage:"",userImage:""),
  User(id: 2, userName: "natig",storyImage:"",userImage:""),
  User(id: 3, userName: "bini",storyImage:"",userImage:""),
  User(id: 4, userName: "yosi",storyImage:"",userImage:""),
  User(id: 5, userName: "abrsh",storyImage:"",userImage:""),

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

          Padding(
            padding: EdgeInsets.all(20),
            child: Container(
              height:110 ,
              child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                  SizedBox(height: 5),
                  Row(
                    children:_users.map((e) => UserStories(e)).toList()
                  )
                ],),
            ),
          ),
          SizedBox(height: 15,),
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
                 
            fit: BoxFit.cover
          ),
        ),
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(
              begin: Alignment.bottomRight,
              colors: [
                Colors.black.withOpacity(.9),
                Colors.black.withOpacity(.1),
              ]
            )
          ),
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
                    image: AssetImage('assets/images/profile${this.user.id}.jpg'),
                    fit: BoxFit.cover
                  )
                ),
              ),
              Text('${this.user.userName}', style: TextStyle(color: Colors.white),)
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
                width: 24,
              ),
                 Spacer(),
              CircleAvatar(
                  backgroundImage: AssetImage(
                      'assets/images/profile${this.post.userid}.jpg')),
              SizedBox(
                width: 5,
                
              ),
              Text(
                  '${_users.where((element) => element.id == this.post.userid).first.userName}',
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
            height: 500,
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
          ),
          InfoWidget()
        ],
      ),
    );
  }
}
