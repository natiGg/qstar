import 'package:flutter/material.dart';
import 'package:qstar/screen/comment/comment_widget.dart';
import 'package:qstar/screen/feed/model/feed.dart';

class InfoWidget extends StatelessWidget {
 final Feeds post;
  const InfoWidget({Key? key,required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
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
                '${post.posts.like_preview.count} likes',
                style: Theme.of(context).textTheme.bodyText2,
              )),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(
              top: 0,
            ),
          ),
          InkWell(
            child: Container(
              child: Text(
                'View all 4 comment',
                style: Theme.of(context).textTheme.bodyText2,
              ),
              padding: const EdgeInsets.symmetric(vertical: 5),
            ),
            onTap: () {
              showSheetcomment(context);
            },
          )
        ],
      ),
    );
  }
}

void showSheetcomment(context) {
  showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
      backgroundColor: Colors.white,
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    CommentWidget(),
                    CommentWidget(),
                    CommentWidget(),
                    CommentWidget(),
                  ],
                ),
                Material(
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
                            backgroundImage:
                                const AssetImage('assets/images/1.jpg'),
                            radius: 18,
                          ),
                          // ignore: prefer_const_constructors
                          Expanded(
                            // ignore: prefer_const_constructors
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 16, right: 8),
                              // ignore: prefer_const_constructors
                              child: TextField(
                                // ignore: prefer_const_constructors
                                decoration: InputDecoration(
                                    hintText: 'Comment here',
                                    border: InputBorder.none),
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
              ],
            ),
          ));
}
