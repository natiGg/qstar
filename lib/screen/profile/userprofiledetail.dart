import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qstar/controllers/feedcontroller.dart';
import 'package:qstar/controllers/followcontroller.dart';
import 'package:qstar/screen/Chat/chat_screen.dart';
import 'package:qstar/screen/Chat/home_screen.dart';

import 'package:qstar/constant.dart';
import 'package:qstar/screen/profile/following.dart';
import 'package:qstar/screen/profile/widgets/bottomsheet/app_context.dart';

import 'package:qstar/screen/profile/widgets/bottomsheet/bottom_sheet_action.dart';
import 'package:qstar/screen/qvideo/qvideo2.dart';
import 'package:qstar/screen/register/phonevarification.dart';
import 'package:video_player/video_player.dart';
import 'widgets/profile_tab_bar.dart';

import 'package:qstar/widget/utils.dart';
import 'package:qstar/screen/feed/model/user.dart';

import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:get/get.dart';

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class UserProfileDetail extends StatefulWidget {
  final User? user;
  const UserProfileDetail({Key? key, required this.user}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

late Followcontroller followcontroller = Get.find();
late FeedController feedController = Get.find();
late VoidCallback? _onShowMenu;
VideoPlayerController? controller;
late Future<void>? initializeVideoPlayerFuture;

class _ProfileScreenState extends State<UserProfileDetail> {
  @override
  void initState() {
    // followcontroller.following_list.value = [];

    Future.delayed(Duration.zero, () async {
      followcontroller.check(widget.user!.id, feedController.uid);
      followcontroller.fetchUProfile(widget.user!.id);
      followcontroller.fetchFlgPost(widget.user!.id);
      controller = VideoPlayerController.network(
          "https://qstar.mindethiopia.com/api/getPostPicture/${followcontroller.flgPosts[0].post_id}");

      initializeVideoPlayerFuture = controller!.initialize();
      // Use the controller to loop the video.
      controller!.setLooping(true);
    });

    super.initState();
    _onShowMenu = () {
      context.showBottomSheet2([
        BottomSheetAction2(
            iconData: Icons.share, title: 'Report', id: 0, unFlwid: ""),
        followcontroller.following.value
            ? BottomSheetAction2(
                iconData: Icons.share,
                title: 'unfollow',
                id: 1,
                unFlwid: followcontroller.profile.id.toString())
            : BottomSheetAction2(
                iconData: Icons.delete, title: '', id: 1, unFlwid: ""),
      ]);
    };
  }

  int _pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    var _screen = MediaQuery.of(context).size;
    var _primaryColorDark = Theme.of(context).primaryColorDark;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: mPrimaryColor,
            onPressed: () {
              Navigator.pop(context);
            }),
        // ignore: prefer_const_constructors
        title: Text(
          "Profile",
          style: const TextStyle(
            color: mPrimaryColor,
            fontSize: 27,
            fontFamily: 'font1',
          ),
        ),
        elevation: 5,
        actions: [
          IconButton(
              onPressed: () {
                _onShowMenu!();
              },
              icon: const Icon(Icons.more_vert),
              color: mPrimaryColor),
        ],
      ),
      body: Obx(() => followcontroller.isChecked.value &&
              !followcontroller.isFetching.value
          ? SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          profileStats(
                              screen: _screen,
                              color: mPrimaryColor,
                              context: context),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              followcontroller.following.value == false
                                  ? Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: GestureDetector(
                                          onTap: () {
                                            followcontroller.follow(
                                                followcontroller.profile.id
                                                    .toString());
                                          },
                                          child: follow(
                                            primaryColorDark: _primaryColorDark,
                                            primaryColor: mPrimaryColor,
                                          ),
                                        ),
                                      ),
                                    )
                                  : Container(),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder:
                                          (context, animation1, animation2) =>
                                              const HomeScreen(),
                                      transitionDuration: Duration.zero,
                                    ),
                                  );

                                  Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder:
                                            (context, animation1, animation2) =>
                                                ChatScreen(
                                          user: widget.user,
                                          fromsshare: "no",
                                        ),
                                        transitionDuration: Duration.zero,
                                      ));
                                },
                                child: message(
                                  primaryColorDark: _primaryColorDark,
                                  primaryColor: mPrimaryColor,
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SocialMedia(),
                              ],
                            ),
                          )
                        ],
                      )),
                  const SizedBox(
                    height: 15,
                  ),
                  Divider(
                    height: 2,
                    color: Colors.grey[500],
                  ),
                  ProfileTabBar(
                    height: 46,
                    color: Colors.grey[500],
                    onTap: (value) {
                      setState(() {
                        _pageIndex = value;
                      });
                    },
                  ),
                  StaggeredGridView.countBuilder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    crossAxisCount: _pageIndex != 1 ? 3 : 2,
                    itemCount: followcontroller.flgPosts.length,
                    itemBuilder: (contex, index) {
                      return Align(
                        child: Container(
                          padding: _pageIndex == 1
                              ? const EdgeInsets.all(5)
                              : const EdgeInsets.all(0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ClipRRect(
                            borderRadius: _pageIndex == 1
                                ? BorderRadius.circular(15)
                                : BorderRadius.circular(0),
                            child: followcontroller.flgPosts[index].is_image ==
                                    "1"
                                ? Image(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                        "https://qstar.mindethiopia.com/api/getPostPicture/${followcontroller.flgPosts[index].post_id}"),
                                  )
                                : GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          PageRouteBuilder(
                                              pageBuilder: (context, animation1,
                                                      animation2) =>
                                                  Qvideoscreen2(
                                                      post: followcontroller
                                                          .flgPosts[index])));
                                    },
                                    child: Stack(children: [
                                      VideoPlayer(controller!),
                                      Align(
                                          alignment: Alignment.center,
                                          child: IconButton(
                                            icon: const Icon(
                                              Icons.play_arrow_rounded,
                                              color: Colors.white,
                                              size: 40.0,
                                            ),
                                            onPressed: () {},
                                          )),
                                    ])),
                          ),
                        ),
                      );
                    },
                    staggeredTileBuilder: (index) => StaggeredTile.count(
                        _pageIndex != 1 ? 1 : 1, _pageIndex != 1 ? 1 : 1.5),
                    crossAxisSpacing: 2,
                    mainAxisSpacing: 2,
                  ),
                ],
              ),
            )
          : const Center(
              child: SizedBox(
                width: 30,
                height: 30,
                child: CircularProgressIndicator(
                  color: mPrimaryColor,
                  strokeWidth: 8,
                ),
              ),
            )),
    );
  }

  void onPlay() async {
    if (controller!.value.isPlaying) {
      controller!.pause();
    } else {
      // If the video is paused, play it.
      controller!.play();
    }
  }

  Widget follow(
      {@required Color? primaryColor, required Color primaryColorDark}) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(left: 5, right: 5),
      child: Container(
        height: 30,
        width: 70,
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: mPrimaryColor,
        ),
        child: !followcontroller.btnLoading.value
            ? const Center(
                child: Text(
                'Folllow',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 12),
              ))
            : const Center(
                child: SizedBox(
                  height: 12,
                  width: 12,
                  child: Center(
                    child: CircularProgressIndicator(
                      // ignore: unrelated_type_equality_checks
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  Widget message(
      {@required Color? primaryColor, required Color primaryColorDark}) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(left: 5, right: 5),
      child: Container(
        height: 30,
        width: 70,
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: mPrimaryColor,
        ),
        child: const Center(
            child: Text(
          'Message',
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.white, fontSize: 12),
        )),
      ),
    );
  }

  Widget profileStats(
      {required Size screen,
      required Color color,
      required BuildContext context}) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 30),
      child: Column(
        children: <Widget>[
          SizedBox(
            width: 100,
            child: Align(
              alignment: Alignment.centerLeft,
              child: profileAvatar(
                height: 100,
                width: 100,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: RatingBarIndicator(
              rating: 2.75,
              itemBuilder: (context, index) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              itemCount: 5,
              itemSize: 20.0,
              direction: Axis.horizontal,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Text(
                followcontroller.profile.name,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
            ),
          ),
          Container(
            color: Colors.white,
            height: 40,
            width: 200,
            padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
            child: Card(
              elevation: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: followcontroller.profile.bio,
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          SizedBox(
            width: screen.width - 100 - 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                statsBox(
                    count: followcontroller.profile.posts_count,
                    title: 'Posts'),
                GestureDetector(
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   PageRouteBuilder(
                      //     pageBuilder: (context, animation1, animation2) =>
                      //         const Followers(),
                      //     transitionDuration: Duration.zero,
                      //   ),
                      // );
                    },
                    child: statsBox(
                        count:
                            followcontroller.profile.followers_count.toString(),
                        title: 'Followers')),
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation1, animation2) =>
                              Followed(id: widget.user!.id),
                          transitionDuration: Duration.zero,
                        ),
                      );
                    },
                    child: statsBox(
                        count:
                            followcontroller.profile.following_count.toString(),
                        title: 'Following')),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget editProfile(
      {@required Color? primaryColor, required Color primaryColorDark}) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Container(
        height: 30,
        width: 100,
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: mPrimaryColor,
        ),
        child: const Center(
            child: Text(
          'Edit Profile',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        )),
      ),
    );
  }

// ignore: non_constant_identifier_names
  Widget Following() {
    return Container(
      color: Colors.transparent,
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Container(
        height: 30,
        width: 100,
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: mPrimaryColor)),
        child: const Center(
            child: Text(
          'remove',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: mPrimaryColor,
          ),
        )),
      ),
    );
  }

// ignore: non_constant_identifier_names
  Widget Unfollow() {
    return Container(
      color: Colors.transparent,
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Container(
        height: 30,
        width: 100,
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: mPrimaryColor)),
        child: const Center(
            child: Text(
          'Following',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: mPrimaryColor,
          ),
        )),
      ),
    );
  }

  Widget storyHighlight({@required primaryColor}) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const <Widget>[
          Text(
            'Story Highligts',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          Icon(
            Icons.keyboard_arrow_down,
            color: Colors.black,
          ),
        ],
      ),
    );
  }

// ignore: non_constant_identifier_names
  Widget SocialMedia() {
    return Row(
      children: [
        SizedBox(
          width: 40,
          height: 30,
          child: RawMaterialButton(
            onPressed: () {},
            elevation: 2.0,
            fillColor: Colors.white,
            child: const Image(
              image: AssetImage("assets/images/yt.png"),
              width: 20,
              height: 20,
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        SizedBox(
          width: 40,
          height: 30,
          child: RawMaterialButton(
            onPressed: () {},
            elevation: 2.0,
            fillColor: Colors.white,
            child: const Image(
              image: AssetImage("assets/images/fb.png"),
              width: 20,
              height: 20,
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        SizedBox(
          width: 40,
          height: 30,
          child: RawMaterialButton(
            onPressed: () {},
            elevation: 2.0,
            fillColor: Colors.white,
            child: const Image(
              image: AssetImage("assets/images/tiktok.png"),
              width: 20,
              height: 20,
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        SizedBox(
          width: 40,
          height: 30,
          child: RawMaterialButton(
            onPressed: () {},
            elevation: 2.0,
            fillColor: Colors.white,
            child: const Image(
              image: AssetImage("assets/images/inst.png"),
              width: 20,
              height: 20,
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
          ),
        ),
      ],
    );
  }

  Widget statsBox({
    required String count,
    required String title,
  }) {
    return Container(
      color: Colors.white,
      height: 60,
      width: 80,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            count,
            style: const TextStyle(
                fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          Text(
            title,
            style: const TextStyle(fontSize: 14, color: Colors.black),
          ),
        ],
      ),
    );
  }

  Widget profileAvatar({
    required double height,
    required double width,
    bool isStorySeen = false,
  }) {
    return Container(
      color: Colors.transparent,
      height: height, //155,
      width: width, //155,
      child: Center(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                height: height, // 150,
                width: width, //150,

                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(width: 3, color: mPrimaryColor)),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                height: height - 10, //140,
                width: width - 10, //140,
                decoration: const BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.circle,
                ),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://qstar.mindethiopia.com/api/getProfilePicture/${followcontroller.profile.id}"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
