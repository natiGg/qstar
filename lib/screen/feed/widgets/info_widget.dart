import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qstar/controllers/getcommentcontroller.dart';
import 'package:qstar/screen/comment/comment_widget.dart';
import 'package:qstar/screen/feed/model/feed.dart';
import 'package:qstar/screen/feed/widgets/post.dart';

import '../../../constant.dart';

GetCommenteController getCommenteController = Get.put(GetCommenteController());

class InfoWidget extends StatelessWidget {
  final Feeds post;
  const InfoWidget({Key? key, required this.post}) : super(key: key);

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
                'View all ${getCommenteController.list.length} comment',
                style: Theme.of(context).textTheme.bodyText2,
              ),
              padding: const EdgeInsets.symmetric(vertical: 5),
            ),
            onTap: () {
              showSheetcomment(context, post.posts.post_id);
            },
          )
        ],
      ),
    );
  }
}

void showSheetcomment(context, int post_id) {
  getCommenteController.fetchComment(post_id);

  showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
      backgroundColor: Colors.white,
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: SizedBox(
              height: 400,
              child: Obx(() => Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      getCommenteController.list.value.isNotEmpty
                          ? Expanded(
                              child: ListView.builder(
                                  itemCount: getCommenteController.list.length,
                                  reverse: false,
                                  itemBuilder: (context, int index) {
                                    return GestureDetector(
                                      onTap: () {},
                                      child: CommestList(
                                        user: getCommenteController
                                            .list[index].profile,
                                        comment:
                                            getCommenteController.list[index],
                                      ),
                                    );
                                  }),
                            )
                          : Container(
                              child: Center(
                                  child: const CircularProgressIndicator()),
                            ),
                      _buildMessageComposer(post_id)
                    ],
                  )),
            ),
          ));
}

_buildMessageComposer(int post_id) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    height: 60,
    // ignore: prefer_const_constructors
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(30.0)),
    ),
    child: Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            height: 40,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.emoji_emotions_outlined,
                  color: Colors.grey[500],
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: TextField(
                    controller: message,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Type your Comment ...',
                      hintStyle: TextStyle(color: Colors.grey[500]),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          width: 16,
        ),
        GestureDetector(
          onTap: () {
            getCommenteController.sendcomment(message.text, post_id);
            message.clear();
          },
          child: const CircleAvatar(
            backgroundColor: mPrimaryColor,
            child: Icon(
              Icons.send,
              color: Colors.white,
            ),
          ),
        )
      ],
    ),
  );
}
