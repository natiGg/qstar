// ignore_for_file: unused_import, avoid_unnecessary_containers

import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter_share_me/flutter_share_me.dart';
import 'package:camera_camera/camera_camera.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:image_picker/image_picker.dart';
import 'package:need_resume/need_resume.dart';
import 'package:qstar/controllers/editprofilecontroller.dart';
import 'package:qstar/controllers/feedcontroller.dart';
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

class WPost extends StatefulWidget {
  final Feeds post;

  const WPost({required this.post});

  @override
  State<WPost> createState() => _WPostState();
}

class _WPostState extends State<WPost> {
  bool isFollowed = false;
  final FlareControls flareControls = FlareControls();
  FeedController feedController = Get.find();
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
    // TODO: implement initState
    super.initState();
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
                                      return const UserProfile();
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
                              'unfollow',
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
                  child: Padding(
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
                  : Stack(children: <Widget>[
                      Container(
                        child: VideoPlayer(controller),
                        height: 500,
                      ),
                      Center(
                        child: Container(
                          decoration: BoxDecoration(
                              color: mPrimaryColor.withOpacity(0.5),
                              shape: BoxShape.circle),
                          child: InkWell(
                            child: Icon(
                              feedController.isPlaying.value
                                  ? Icons.pause
                                  : Icons.play_arrow,
                            ),
                            onTap: () {
                              onPlay();
                            },
                          ),
                        ),
                      ),
                    ]),
            ),
            Container(
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
                      showSheetcomment(context);
                    },
                    child: Comment()),
                Share(widget.post.posts.post_id, widget.post.posts.caption),
                const Spacer(),
                const Spacer(),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.bookmark_border,
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

  Widget Share(int id, String cap) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.share, color: Colors.grey, size: 25),
              onPressed: () {
                showSheet(context, id, cap);
              },
            ),
          ],
        ),
      ),
    );
  }
}

void showSheet(context, id, cap) {
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
                          GestureDetector(
                            onTap: () {
                              print("object");
                              // FlutterShareMe().shareToFacebook(
                              //     url:
                              //         "https://qstar.mindethiopia.com/api/getPostPicture/${id}",
                              //     msg: "Babilok");

                              onButtonTap(Share.twitter, id, cap);
                            },
                            child: const Icon(
                              FontAwesome.facebook,
                              color: Colors.blue,
                            ),
                          ),
                          Container(
                            height: 10,
                          ),
                          Text("Facebook",
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
