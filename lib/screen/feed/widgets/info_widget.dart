import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qstar/screen/comment/comment_page.dart';
import 'dart:developer' as developer;

class InfoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          DefaultTextStyle(
              style: Theme.of(context)
                  .textTheme
                  .subtitle2!
                  .copyWith(fontWeight: FontWeight.w800),
              child: Text(
                '1,102 likes',
                style: Theme.of(context).textTheme.bodyText2,
              )),
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(
              top: 0,
            ),
          ),
          InkWell(
            child: Container(
              child: Text(
                'View all 4 comment',
                style: Theme.of(context).textTheme.bodyText2,
              ),
              padding: EdgeInsets.symmetric(vertical: 5),
            ),
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
          )
        ],
      ),
    );
  }
}
