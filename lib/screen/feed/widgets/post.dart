// ignore_for_file: unused_import, avoid_unnecessary_containers

import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter_share_me/flutter_share_me.dart';
import 'package:camera_camera/camera_camera.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:need_resume/need_resume.dart';
import 'package:qstar/controllers/editprofilecontroller.dart';
import 'package:qstar/controllers/feedcontroller.dart';
import 'package:qstar/controllers/getcommentcontroller.dart';

import 'package:qstar/controllers/perfectmatchcontroller.dart';
import 'package:qstar/controllers/postcontroller.dart';
import 'package:qstar/remote_services/service.dart';
import 'package:qstar/screen/comment/comment_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_icons/flutter_icons.dart';
import 'package:qstar/constant.dart';
import 'package:qstar/screen/feed/Report/report.dart';
import 'package:qstar/screen/feed/model/feed.dart';
import 'package:qstar/screen/feed/model/user.dart';
import 'package:qstar/screen/feed/widgets/info_widget.dart';
import 'package:qstar/screen/feed/widgets/sharetousers.dart';
import 'package:qstar/screen/post/main.dart';
import 'package:qstar/screen/Chat/home_screen.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:get/get.dart';
import 'package:qstar/screen/post/preview_screen_gallery.dart';
import 'package:qstar/screen/profile/PerfectMatch/Progress.dart';
import 'package:qstar/screen/profile/PerfectMatch/profile.dart';
import 'package:qstar/screen/profile/profile.dart';
import 'package:qstar/screen/profile/userprofiledetail.dart';
import 'package:qstar/screen/qvideo/qvideo2.dart';
import 'package:qstar/screen/qvideo/userprofile.dart';
import 'package:qstar/screen/qvideo/videoPreview.dart';
import 'package:qstar/screen/qvideo/videopicker.dart';
import 'package:qstar/screen/register/phonevarification.dart';
import 'package:video_player/video_player.dart';
import 'package:qstar/screen/search/search.dart';
import 'package:qstar/screen/feed/bottomsheet/app_context.dart';
import 'package:qstar/screen/feed/bottomsheet/bottom_sheet_action.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:visibility_detector/visibility_detector.dart';

enum Share {
  facebook,
  twitter,
  whatsapp,
  whatsapp_personal,
  whatsapp_business,
  share_system,
  share_instagram,
  share_telegram
}

int? postid;

class WPost extends StatefulWidget {
  final Feeds post;

  const WPost({required this.post});

  @override
  State<WPost> createState() => _WPostState();
}

late TextEditingController message;

class _WPostState extends State<WPost> {
  bool isFollowed = false;
  final FlareControls flareControls = FlareControls();
  FeedController feedController = Get.find();
  GetCommenteController getCommenteController =
      Get.put(GetCommenteController());

  late VideoPlayerController controller;
  late Future<void> initializeVideoPlayerFuture;
  @override
  void initState() {
    feedController.isActive.value = widget.post.viewer_has_liked;
    if (widget.post.posts.is_image == "0") {
      controller = VideoPlayerController.network(
          "https://qstar.mindethiopia.com/api/getPostPicture/${widget.post.posts.post_id}");
      // Initialize the controller and store the Future for later use.
      initializeVideoPlayerFuture = controller.initialize();
      // Use the controller to loop the video.
      controller.setLooping(true);
    }
    message = TextEditingController();

    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    message.dispose();
    super.dispose();
  }

  void onPlay() async {
    if (controller.value.isPlaying) {
      feedController.isPlaying(false);
      controller.pause();
    } else {
      // If the video is paused, play it.
      feedController.isPlaying(true);
      controller.play();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 45),
                      child: Center(
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: mPrimaryColor, width: 2),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder:
                                        (context, animation1, animation2) {
                                      return UserProfileDetail(
                                          user: widget.post.posts.profile);
                                    },
                                  ),
                                );
                              },
                              child: CircleAvatar(
                                  radius: 30,
                                  backgroundImage: NetworkImage(
                                      'https://qstar.mindethiopia.com/api/getProfilePicture/${widget.post.posts.profile.id}')),
                            ),
                          ),
                        ),
                      ),
                    ),
                    // _isFF[(widget.post.userid) - 1]
                    //     ? Container(
                    //         margin: const EdgeInsets.only(
                    //             left: 20, top: 55, right: 20),
                    //         child: GestureDetector(
                    //           onTap: () {
                    //             setState(() {
                    //               isFollowed = !isFollowed;
                    //             });
                    //           },
                    //           child: followButton(isFollowed),
                    //         ),
                    //       )
                    //     : const SizedBox(
                    //         width: 0,
                    //       ),
                  ]),
                ],
              ),
              const Spacer(),
              IconButton(
                onPressed: () {
                  showDialog(
                    useRootNavigator: false,
                    context: context,
                    builder: (context) {
                      return Dialog(
                        child: ListView(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shrinkWrap: true,
                            children: [
                              'Report...',
                              'Hide',
                              'Block',
                            ]
                                .map((e) => InkWell(
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12, horizontal: 16),
                                        child: Text(e),
                                      ),
                                      onTap: () {
                                        if (e == "Report...") {
                                          Navigator.push(
                                            context,
                                            PageRouteBuilder(
                                              pageBuilder: (context, animation1,
                                                      animation2) =>
                                                  const ReportScreen(),
                                              transitionDuration: Duration.zero,
                                            ),
                                          );
                                        }
                                      },
                                    ))
                                .toList()),
                      );
                    },
                  );
                },
                icon: const Icon(Icons.more_vert),
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
                      const SizedBox(height: 10),
                      Text(
                          '${widget.post.posts.profile.name}   ${widget.post.posts.profile.followers_count}',
                          style: const TextStyle(color: Colors.black)),
                      const SizedBox(
                        height: 5,
                      ),
                      RatingBarIndicator(
                        rating: widget.post.posts.profile.ratting.toDouble(),
                        itemBuilder: (context, index) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        itemCount: widget.post.posts.profile.ratting,
                        itemSize: 20.0,
                        direction: Axis.horizontal,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                child: Center(
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "${widget.post.posts.caption}",
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.6),
                            decorationStyle: TextDecorationStyle.wavy,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      widget.post.posts.post_tags.isNotEmpty
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                  children: List.generate(
                                      widget.post.posts.post_tags.length,
                                      (index) {
                                return Align(
                                  alignment: Alignment.centerLeft,
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(context, PageRouteBuilder(
                                          pageBuilder: (context, animation1,
                                              animation2) {
                                        return UserProfileDetail(
                                            user: widget.post.posts
                                                .post_tags[index].profile);
                                      }));
                                    },
                                    child: Row(
                                      children: [
                                        Text(
                                          widget.post.posts.post_tags[index]
                                                  .profile.name +
                                              "",
                                          style: const TextStyle(
                                              color: mPrimaryColor,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        index !=
                                                widget.post.posts.post_tags
                                                        .length -
                                                    1
                                            ? Text(
                                                ", ",
                                                style: TextStyle(
                                                    color: mPrimaryColor,
                                                    fontSize: 13,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            : Container(),
                                      ],
                                    ),
                                  ),
                                );
                              })),
                            )
                          : Container(),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
          Stack(children: <Widget>[
            const SizedBox(
              height: 5,
            ),
            GestureDetector(
              onDoubleTap: () {
                feedController.LikePost(widget.post.posts.post_id);

                setState(() {
                  if (!feedController.isActive.value) {
                    feedController.isActive.value =
                        !feedController.isActive.value;
                  }
                  // _isPlaying ? null : _controller.isActive = true;
                });
                flareControls.play("like");
              },
              child: widget.post.posts.is_image.toString() == "1"
                  ? Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                                "https://qstar.mindethiopia.com/api/getPostPicture/${widget.post.posts.post_id}"),
                            fit: BoxFit.cover),
                      ),
                      height: 500,
                    )
                  : GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            PageRouteBuilder(
                                pageBuilder: (context, animation1,
                                        animation2) =>
                                    Qvideoscreen2(post: widget.post.posts)));
                      },
                      child: Stack(
                        children: [
                          VisibilityDetector(
                              key: Key("unique key"),
                              onVisibilityChanged: (VisibilityInfo info) {
                                if (info.visibleFraction == 0) {
                                  controller.pause();
                                } else {
                                  controller.play();
                                }
                              },
                              child: AspectRatio(
                                  aspectRatio: controller.value.aspectRatio,
                                  child: VideoPlayer(controller))),
                        ],
                      ),
                    ),
            ),
            widget.post.posts.is_image.toString() == "1"
                ? Container(
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
                  )
                : AspectRatio(
                    aspectRatio: controller.value.aspectRatio,
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
            padding: const EdgeInsets.all(5.0),
            child: Row(
              children: [
                GestureDetector(
                    onTap: () {
                      setState(() {
                        if (!feedController.isActive.value) {
                          feedController.LikePost(widget.post.posts.post_id);
                          feedController.isActive.value =
                              !feedController.isActive.value;
                        } else if (feedController.isActive.value) {
                          feedController.DisLikePost(widget.post.posts.post_id);
                          feedController.isActive.value =
                              !feedController.isActive.value;
                        }
                      });
                    },
                    child: activeLikeButton(feedController.isActive.value)),
                GestureDetector(
                    onTap: () {
                      showSheetcomment(context, widget.post.posts.post_id);
                    },
                    child: Comment()),
                Share(),
                const Spacer(),
                const Spacer(),
                IconButton(
                    onPressed: () {
                      setState(() {
                        if (!feedController.isBookMarked.value) {
                          feedController.isBookMarked.value =
                              !feedController.isBookMarked.value;
                          feedController
                              .postBookMark(widget.post.posts.post_id);
                        } else if (feedController.isBookMarked.value) {
                          feedController.unBookMark(widget.post.posts.post_id);
                          feedController.isBookMarked.value =
                              !feedController.isBookMarked.value;
                        }
                      });
                    },
                    icon: Icon(
                      feedController.isBookMarked.value
                          ? Icons.bookmark
                          : Icons.bookmark_border,
                      color: mPrimaryColor,
                    )),
                const SizedBox(
                  width: 5,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(2.0),
            child: InfoWidget(post: widget.post),
          ),
          const Divider(
            thickness: 1.0,
          ),
        ],
      ),
    );
  }

  Widget activeLikeButton(isActive) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
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

  Widget followButton(isFollowed) {
    return Container(
        margin: const EdgeInsets.only(left: 50),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: mPrimaryColor, width: 1),
        ),
        child: CircleAvatar(
          radius: 9,
          backgroundColor: isFollowed ? mPrimaryColor : Colors.white,
          child: Center(
              child: Icon(isFollowed ? Icons.check : Icons.add,
                  size: 16, color: isFollowed ? Colors.white : mPrimaryColor)),
        ));
  }

  Widget activedisLikeButton(isActive) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
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
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Icon(Icons.chat, color: Colors.grey, size: 25),
          ],
        ),
      ),
    );
  }

  Widget Share() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.share, color: Colors.grey, size: 25),
              onPressed: () {
                showSheet(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void showSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 10,
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      const Spacer(),
                      const Text(
                        "Send to",
                        style: TextStyle(
                          color: mPrimaryColor,
                          fontFamily: "font1",
                          fontSize: 24,
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation1, animation2) =>
                                  const Search(),
                              transitionDuration: Duration.zero,
                            ),
                          );
                        },
                        child: const Icon(
                          Icons.search,
                          color: mPrimaryColor,
                          size: 15,
                        ),
                      ),
                    ])
                  ],
                )),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Expanded(
                    child: Container(
                      height: 150,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          Column(
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ]),
                const Divider(indent: 18, endIndent: 18, color: Colors.grey),
                const Text(
                  "Share to",
                  style: TextStyle(
                    color: mPrimaryColor,
                    fontFamily: "font1",
                    fontSize: 24,
                  ),
                ),
                Container(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: 18,
                        ),
                        Container(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Icon(
                              Icons.copy,
                              color: mPrimaryColor,
                            ),
                            Container(
                              height: 10,
                            ),
                            Text("copy link",
                                style: TextStyle(
                                  color: Colors.grey[400],
                                ))
                          ],
                        )),
                        Container(
                          width: 18,
                        ),
                        Container(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Icon(
                              FontAwesome.whatsapp,
                              color: Colors.green,
                            ),
                            Container(
                              height: 10,
                            ),
                            Text("whatsapp",
                                style: TextStyle(
                                  color: Colors.grey[400],
                                ))
                          ],
                        )),
                        Container(
                          width: 18,
                        ),
                        Container(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Icon(
                              FontAwesome.facebook,
                              color: Colors.blue,
                            ),
                            Container(
                              height: 10,
                            ),
                            Text("More Apps",
                                style: TextStyle(
                                  color: Colors.grey[400],
                                ))
                          ],
                        )),
                        Container(
                          width: 18,
                        ),
                        Container(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Icon(
                              FontAwesome.instagram,
                              color: Colors.redAccent,
                            ),
                            Container(
                              height: 10,
                            ),
                            Text("Instagram",
                                style: TextStyle(
                                  color: Colors.grey[400],
                                ))
                          ],
                        )),
                        Container(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Icon(
                              FontAwesome.telegram,
                              color: Colors.blue,
                            ),
                            Container(
                              height: 10,
                            ),
                            Text("Telegram",
                                style: TextStyle(
                                  color: Colors.grey[400],
                                ))
                          ],
                        )),
                        Container(
                          width: 21,
                        ),
                        Container(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Icon(
                              FontAwesome.twitter,
                              color: Colors.blue,
                            ),
                            Container(
                              height: 10,
                            ),
                            Text("twitter",
                                style: TextStyle(
                                  color: Colors.grey[400],
                                ))
                          ],
                        )),
                        Container(
                          width: 26,
                        ),
                        Container(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Icon(
                              FontAwesome.google_plus,
                              color: Colors.red,
                            ),
                            Container(
                              height: 10,
                            ),
                            Text("google_plus",
                                style: TextStyle(
                                  color: Colors.grey[400],
                                ))
                          ],
                        )),
                        Container(
                          width: 32,
                        ),
                        Container(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Icon(
                              FontAwesome.twitch,
                              color: Colors.redAccent,
                            ),
                            Container(
                              height: 10,
                            ),
                            Text("twitch",
                                style: TextStyle(
                                  color: Colors.grey[400],
                                ))
                          ],
                        )),
                        Container(
                          width: 25,
                        ),
                        Container(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Icon(
                              FontAwesome.youtube,
                              color: Colors.red,
                            ),
                            Container(
                              height: 8,
                            ),
                            Text("youtube",
                                style: TextStyle(
                                  color: Colors.grey[400],
                                ))
                          ],
                        )),
                        Container(
                          width: 18,
                        ),
                        Container(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Icon(
                              FontAwesome.google,
                              color: Colors.redAccent,
                            ),
                            Container(
                              height: 2,
                            ),
                            Text("google",
                                style: TextStyle(
                                  color: Colors.grey[400],
                                ))
                          ],
                        )),
                        Container(
                          width: 26,
                        ),
                        Container(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Icon(
                              Icons.more_horiz_sharp,
                              color: mPrimaryColor,
                            ),
                            Container(
                              height: 6,
                            ),
                            Text("More App",
                                style: TextStyle(
                                  color: Colors.grey[400],
                                ))
                          ],
                        )),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
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
                                    itemCount:
                                        getCommenteController.list.length,
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
}

Future<void> onButtonTap(Share share, id, cap) async {
  String msg = cap;
  String url = 'https://qstar.mindethiopia.com/api/getPostPicture/${id}';

  String? response;
  final FlutterShareMe flutterShareMe = FlutterShareMe();
  switch (share) {
    case Share.facebook:
      response = await flutterShareMe.shareToFacebook(url: url, msg: msg);
      break;
    case Share.twitter:
      response = await flutterShareMe.shareToTwitter(url: url, msg: msg);
      break;
    case Share.whatsapp:
      response = await flutterShareMe.shareToWhatsApp(msg: msg);

      break;
    case Share.whatsapp_business:
      response = await flutterShareMe.shareToWhatsApp(msg: msg);
      break;
    case Share.share_system:
      response = await flutterShareMe.shareToSystem(msg: msg);

      break;
    case Share.whatsapp_personal:
      response = await flutterShareMe.shareWhatsAppPersonalMessage(
          message: msg, phoneNumber: 'phone-number-with-country-code');
      break;
    case Share.share_instagram:
      // response = await flutterShareMe.shareToInstagram(msg: msg);
      break;
    case Share.share_telegram:
      response = await flutterShareMe.shareToTelegram(msg: msg);
      break;
  }
  debugPrint(response);
}

class CommestList extends StatefulWidget {
  final User user;
  final GetComment comment;

  const CommestList({
    Key? key,
    required this.user,
    required this.comment,
  }) : super(key: key);

  @override
  State<CommestList> createState() => _CommestListState();
}

class _CommestListState extends State<CommestList> {
  GetCommenteController getCommenteController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    border: Border.all(
                        width: 4,
                        color: Theme.of(context).scaffoldBackgroundColor),
                    boxShadow: [
                      BoxShadow(
                          spreadRadius: 2,
                          blurRadius: 10,
                          color: Colors.black.withOpacity(0.1),
                          offset: const Offset(0, 10))
                    ],
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            "https://qstar.mindethiopia.com/api/getProfilePicture/${widget.user.id}"))),
              ),
              Expanded(
                  child: Container(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RichText(
                        text: TextSpan(children: [
                          TextSpan(
                              text: widget.user.name,
                              style: Theme.of(context).textTheme.bodyText2),
                          TextSpan(
                              text: " " + widget.comment.comment,
                              style: Theme.of(context).textTheme.bodyText1),
                        ]),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: DefaultTextStyle(
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(
                                    fontSize: 12, fontWeight: FontWeight.w400),
                            child: Row(
                              // ignore: prefer_const_literals_to_create_immutables
                              children: [
                                Text(widget.comment.date),
                                SizedBox(
                                  width: 24,
                                ),
                                Text('3 likes'),
                                SizedBox(
                                  width: 24,
                                ),
                                GestureDetector(
                                    onTap: () {
                                      message.text = widget.user.name;

                                      //  getCommenteController.sendreplay(message.text, post_id);
                                    },
                                    child: Text('Reply'))
                              ],
                            )),
                      )
                    ],
                  ),
                ),
              )),
              GestureDetector(
                onTap: () {
                
                },
                child: likebutonComment(getCommenteController.isActive.value),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget likeComment(isActive) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Icon(
        getCommenteController.isActive.value
            ? FontAwesome.heart
            : FontAwesome.heart_o,
        size: 16,
      ),
    );
  }
    Widget likebutonComment(isActive) {
    return Container(
      padding: EdgeInsets.all(8),
      child: IconButton(
        onPressed: () {
          setState(() {
                    if (!getCommenteController.isActive.value) {
                      getCommenteController.isActive.value =
                          !getCommenteController.isActive.value;
                      getCommenteController.likeComment(widget.comment.id);
                    } else {
                      getCommenteController.isActive.value =
                          !getCommenteController.isActive.value;
                      getCommenteController.dislikeComment(widget.comment.id);
                    }
                  });
        },
        icon:Icon(  getCommenteController.isActive.value
            ? FontAwesome.heart
            : FontAwesome.heart_o,size: 14)
      ,
        
      ),
    );
  }
}
