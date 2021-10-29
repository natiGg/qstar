import 'dart:io';
import 'package:qstar/constant.dart';
import 'package:flutter/material.dart';
import 'auth_bloc.dart';

import 'dart:developer' as developer;
import 'package:flutter_svg/svg.dart';
import 'comment_widget.dart';
import 'package:qstar/screen/feed/feed.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
      onWillPop: () async {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => UsersFeed()));
        return true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              color: mPrimaryColor,
              onPressed: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) =>
                        UsersFeed(),
                    transitionDuration: Duration.zero,
                  ),
                );
              }),
          title: Text(
            "Comments",
            style: TextStyle(
              color: mPrimaryColor,
              fontSize: 27,
              fontFamily: 'font1',
            ),
          ),
          elevation: 0.0,
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
                            hintText: 'Comment here', border: InputBorder.none),
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

  // Future<bool> _willPopCallback() async {

  //   Navigator.of(context)
  //       .push(MaterialPageRoute(builder: (context) => const UsersFeed()));
  //   return true; //
  // }
  // _moveToScreen2(BuildContext context) =>
  //     Navigator.pushNamed(context, "screen2");
}
