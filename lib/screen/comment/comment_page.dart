// ignore_for_file: constant_identifier_names, prefer_const_constructors_in_immutables

import 'package:qstar/constant.dart';
import 'package:flutter/material.dart';

import 'comment_widget.dart';
import 'package:qstar/screen/feed/feed.dart';

// ignore: use_key_in_widget_constructors
class CommentPage extends StatefulWidget {
  static const ROUTE_NAME = 'CommentPage';

  CommentPage({Key? key}) : super(key: key);

  @override
  _CommentPageState createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  @override
  Widget build(BuildContext context) {
    // ignore: unnecessary_new
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const UsersFeed()));
        return true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              color: mPrimaryColor,
              onPressed: () {
                Navigator.of(context).pop(true);
              }),
          title: const Text(
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
          children: const <Widget>[
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
              padding: const EdgeInsets.only(left: 16, right: 8),
              child: Row(
                children: [
                  // ignore: prefer_const_constructors
                  CircleAvatar(
                    backgroundImage: const AssetImage('assets/images/1.jpg'),
                    radius: 18,
                  ),
                  // ignore: prefer_const_constructors
                  Expanded(
                    // ignore: prefer_const_constructors
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16, right: 8),
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
