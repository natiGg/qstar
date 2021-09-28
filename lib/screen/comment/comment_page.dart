import 'dart:io';

import 'package:flutter/material.dart';
import 'auth_bloc.dart';

import 'dart:developer' as developer;

import 'comment_widget.dart';
import 'package:qstar/screen/feed/feed.dart';

class CommentPage extends StatefulWidget {
  static const ROUTE_NAME = 'CommentPage';

  @override
  _CommentPageState createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  static const TAG = 'CommentPage';
  @override
  Widget build(BuildContext context) {
    // ignore: unnecessary_new
    return WillPopScope(
      onWillPop: () => _moveToScreen2(
        context,
      ),
      child: new Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          leadingWidth: 100,
          backgroundColor: Colors.white,
          leading: Container(
            padding: const EdgeInsets.only(left: 20, top: 15),
            width: 100,
            // ignore: prefer_const_constructors
            child: Text(
              "Comments",
              // ignore: prefer_const_constructors
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        body: Column(
          children: <Widget>[
            CommentWidget(),
            CommentWidget(),
            CommentWidget(),
            CommentWidget(),
            CommentWidget(),
            CommentWidget(),
          ],
        ),
        bottomNavigationBar: Material(
          type: MaterialType.canvas,
          child: SafeArea(
            child: Container(
              height: kToolbarHeight,
              margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              padding: EdgeInsets.only(left: 16, right: 8),
              child: Row(
                children: [
                  // ignore: prefer_const_constructors
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/images/1.jpg'),
                    radius: 18,
                  ),
                  // ignore: prefer_const_constructors
                  Expanded(
                    // ignore: prefer_const_constructors
                    child: Padding(
                      padding: EdgeInsets.only(left: 16, right: 8),
                      // ignore: prefer_const_constructors
                      child: TextField(
                        // ignore: prefer_const_constructors
                        decoration: InputDecoration(
                            hintText: 'Comment a', border: InputBorder.none),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 8),
                      child: Text(
                        'Post',
                        style: Theme.of(context)
                            .primaryTextTheme
                            .bodyText2
                            ?.copyWith(color: Colors.blue),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _moveToScreen2(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => UsersFeed()));
  }
}
