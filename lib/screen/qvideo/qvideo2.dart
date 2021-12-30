// ignore_for_file: import_of_legacy_library_into_null_safe, must_call_super

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qstar/constant.dart';
import 'package:qstar/screen/feed/model/feed.dart';

import 'package:qstar/screen/qvideo/bottomsheet_report/app_context.dart';
import 'package:qstar/screen/qvideo/bottomsheet_report/bottom_sheet_action.dart';
import 'package:qstar/screen/feed/widgets/sharetousers.dart';

import 'package:qstar/screen/qvideo/comment/comment_widget.dart';
import 'package:qstar/screen/qvideo/live.dart';
import 'package:qstar/screen/qvideo/useraudio.dart';
import 'package:qstar/screen/qvideo/userprofile.dart';
import 'package:qstar/screen/qvideo/videoPreview.dart';
import 'package:qstar/screen/search/search.dart';
import 'package:video_player/video_player.dart';
import 'dart:math' as math;
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:get/get.dart';

import 'package:qstar/screen/feed/model/user.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

List<User> _users = [
  User(
      id: 1,
      userName: "gelila",
      storyImage: "",
      userImage: "",
      name: "",
      website: "",
      bio: "",
      email: "",
      country_code: "",
      phone_number: "",
      gender: "",
      enable_suggestion: "",
      status: "",
      date_of_birth: "",
      current_location: "",
      account_type: "",
      online_status: "",
      joined_date: "",
      hobbies: "",
      total_followers: "",
      followed: false.obs,
      ratting: 3,
      followers_count: "",
      following_count: "",
      posts_count: ""),
  User(
      id: 2,
      userName: "natig",
      storyImage: "",
      userImage: "",
      name: "",
      website: "",
      bio: "",
      email: "",
      country_code: "",
      phone_number: "",
      gender: "",
      enable_suggestion: "",
      status: "",
      date_of_birth: "",
      current_location: "",
      account_type: "",
      online_status: "",
      joined_date: "",
      hobbies: "",
      total_followers: "",
      followed: false.obs,
      ratting: 3,
      followers_count: "",
      following_count: "",
      posts_count: ""),
  User(
      id: 3,
      userName: "bini",
      storyImage: "",
      userImage: "",
      name: "",
      website: "",
      bio: "",
      email: "",
      country_code: "",
      phone_number: "",
      gender: "",
      enable_suggestion: "",
      status: "",
      date_of_birth: "",
      current_location: "",
      account_type: "",
      online_status: "",
      joined_date: "",
      hobbies: "",
      total_followers: "",
      followed: false.obs,
      ratting: 3,
      followers_count: "",
      following_count: "",
      posts_count: ""),
  User(
      id: 4,
      userName: "yosi",
      storyImage: "",
      userImage: "",
      name: "",
      website: "",
      bio: "",
      email: "",
      country_code: "",
      phone_number: "",
      gender: "",
      enable_suggestion: "",
      status: "",
      date_of_birth: "",
      current_location: "",
      account_type: "",
      online_status: "",
      joined_date: "",
      hobbies: "",
      total_followers: "",
      followed: false.obs,
      ratting: 3,
      followers_count: "",
      following_count: "",
      posts_count: ""),
  User(
      id: 5,
      userName: "abrsh",
      storyImage: "",
      userImage: "",
      name: "",
      website: "",
      bio: "",
      email: "",
      country_code: "",
      phone_number: "",
      gender: "",
      enable_suggestion: "",
      status: "",
      date_of_birth: "",
      current_location: "",
      account_type: "",
      online_status: "",
      joined_date: "",
      hobbies: "",
      total_followers: "",
      followed: false.obs,
      ratting: 3,
      followers_count: "",
      following_count: "",
      posts_count: ""),
  User(
      id: 1,
      userName: "gelila",
      storyImage: "",
      userImage: "",
      name: "",
      website: "",
      bio: "",
      email: "",
      country_code: "",
      phone_number: "",
      gender: "",
      enable_suggestion: "",
      status: "",
      date_of_birth: "",
      current_location: "",
      account_type: "",
      online_status: "",
      joined_date: "",
      hobbies: "",
      total_followers: "",
      followed: false.obs,
      ratting: 3,
      followers_count: "",
      following_count: "",
      posts_count: ""),
  User(
      id: 2,
      userName: "natig",
      storyImage: "",
      userImage: "",
      name: "",
      website: "",
      bio: "",
      email: "",
      country_code: "",
      phone_number: "",
      gender: "",
      enable_suggestion: "",
      status: "",
      date_of_birth: "",
      current_location: "",
      account_type: "",
      online_status: "",
      joined_date: "",
      hobbies: "",
      total_followers: "",
      followed: false.obs,
      ratting: 3,
      followers_count: "",
      following_count: "",
      posts_count: ""),
  User(
      id: 3,
      userName: "bini",
      storyImage: "",
      userImage: "",
      name: "",
      website: "",
      bio: "",
      email: "",
      country_code: "",
      phone_number: "",
      gender: "",
      enable_suggestion: "",
      status: "",
      date_of_birth: "",
      current_location: "",
      account_type: "",
      online_status: "",
      joined_date: "",
      hobbies: "",
      total_followers: "",
      followed: false.obs,
      ratting: 3,
      followers_count: "",
      following_count: "",
      posts_count: ""),
  User(
      id: 4,
      userName: "yosi",
      storyImage: "",
      userImage: "",
      name: "",
      website: "",
      bio: "",
      email: "",
      country_code: "",
      phone_number: "",
      gender: "",
      enable_suggestion: "",
      status: "",
      date_of_birth: "",
      current_location: "",
      account_type: "",
      online_status: "",
      joined_date: "",
      hobbies: "",
      total_followers: "",
      followed: false.obs,
      ratting: 3,
      followers_count: "",
      following_count: "",
      posts_count: ""),
  User(
      id: 5,
      userName: "abrsh",
      storyImage: "",
      userImage: "",
      name: "",
      website: "",
      bio: "",
      email: "",
      country_code: "",
      phone_number: "",
      gender: "",
      enable_suggestion: "",
      status: "",
      date_of_birth: "",
      current_location: "",
      account_type: "",
      online_status: "",
      joined_date: "",
      hobbies: "",
      total_followers: "",
      followed: false.obs,
      ratting: 3,
      followers_count: "",
      following_count: "",
      posts_count: ""),
];

class Qvideoscreen2 extends StatefulWidget {
  Posts?post;
   Qvideoscreen2({Key? key,required this.post}) : super(key: key);

  @override
  _QvideoState2 createState() => _QvideoState2();
}

class _QvideoState2 extends State<Qvideoscreen2>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  ImagePicker picker = ImagePicker();
  // ignore: unused_field
  File? _cameraVideo;
  bool abo = false;
  bool foryou = true;
  bool play = true;
  bool isActive = false;
  bool isdisActive = false;
  final FlareControls flareControls = FlareControls();
  late VideoPlayerController _controller;
  late AnimationController animationController;
  PageController pageController =
      PageController(initialPage: 0, viewportFraction: 0.8);
  PageController foryouController = PageController();
  late VoidCallback _onShowMenu;
  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    animationController.repeat();
    _controller = VideoPlayerController.network("https://qstar.mindethiopia.com/api/getPostPicture/${widget.post!.post_id}")
      ..initialize().then((value) {
        _controller.play();
        _controller.setLooping(true);
        setState(() {});
      });

    _onShowMenu = () {
      context.showBottomSheet([
        BottomSheetAction(iconData: Icons.download, title: 'Save Video', id: 2),
        BottomSheetAction(iconData: Icons.report, title: 'Report', id: 0),
        BottomSheetAction(iconData: Icons.block, title: 'Block', id: 1),
      ]);
    };
  }

  _pickVideoFromCamera() async {
    // ignore: deprecated_member_use
    PickedFile? pickedFile = await picker.getVideo(source: ImageSource.camera);

    _cameraVideo = File(pickedFile!.path);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VideoPreview(imagePath: pickedFile.path),
      ),
    );
  }

  _pickVideo() async {
    ImagePicker picker = ImagePicker();
    // ignore: deprecated_member_use
    PickedFile? pickedFile = await picker.getVideo(source: ImageSource.gallery);

    // _video = File(pickedFile!.path);
    await _playVideo(pickedFile!.path);
  }

  _playVideo(file) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VideoPreview(imagePath: file),
      ),
    );
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    _controller.dispose();
    _controller.pause();

    animationController.dispose();
    super.dispose();
  }

  final RefreshController _refreshControllers =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshControllers.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    //items.add((items.length+1).toString());
    //if(mounted)
    // setState(() {

    // });
    _refreshControllers.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: true,
      header: const WaterDropHeader(),
      //cheak pull_to_refresh
      controller: _refreshControllers,
      onRefresh: _onRefresh,
      onLoading: _onLoading,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        // appBar: AppBar(
        //   backgroundColor: Colors.white,
        //   centerTitle: true,
        //   leading: IconButton(
        //       icon: const Icon(Icons.arrow_back, color: mPrimaryColor),
        //       onPressed: () {
        //         _controller.dispose();
        //         _controller.pause();

        //         Navigator.pushNamed(context, "/home");
        //       }),
        //   title: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
        //     IconButton(
        //       icon: const Icon(Icons.add),
        //       iconSize: 30.0,
        //       color: mPrimaryColor,
        //       onPressed: () {
        //         _controller.pause();

        //         showModalBottomSheet(
        //             context: context,
        //             builder: (BuildContext bc) {
        //               return SafeArea(
        //                 child: Wrap(
        //                   children: <Widget>[
        //                     ListTile(
        //                         leading: const Icon(
        //                           Icons.photo_library,
        //                           color: mPrimaryColor,
        //                         ),
        //                         title: const Text('Video Library'),
        //                         onTap: () {
        //                           _pickVideo();
        //                           Navigator.of(context).pop();
        //                         }),
        //                     ListTile(
        //                       leading: const Icon(
        //                         Icons.videocam_sharp,
        //                         color: mPrimaryColor,
        //                       ),
        //                       title: const Text('Video Camera'),
        //                       onTap: () {
        //                         _pickVideoFromCamera();
        //                         Navigator.of(context).pop();
        //                       },
        //                     ),
        //                   ],
        //                 ),
        //               );
        //             });
        //       },
        //     ),
        //   ]),
        //   actions: <Widget>[
        //     IconButton(
        //       icon: const Icon(Icons.videocam),
        //       iconSize: 30.0,
        //       color: Colors.red,
        //       onPressed: () async {
        //         _controller.pause();
        //         _controller.dispose();

        //         Navigator.push(
        //           context,
        //           PageRouteBuilder(
        //             pageBuilder: (context, animation1, animation2) =>
        //                 const Live(),
        //             transitionDuration: Duration.zero,
        //           ),
        //         );
        //       },
        //     ),
        //   ],
        // ),
        body: Stack(
          children: <Widget>[
            homescreen(),
            SizedBox(
              height: height,
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
          ],
        ),
      ),
    );
  }

  homescreen() {
    return PageView.builder(
        controller: foryouController,
        onPageChanged: (index) {
          setState(() {
            _controller.seekTo(Duration.zero);
            _controller.play();
          });
        },
        scrollDirection: Axis.vertical,
        itemCount: 5,
        itemBuilder: (context, index) {
          return GestureDetector(
            onDoubleTap: () {
              setState(() {
                if (isdisActive && !isActive) {
                  isdisActive = !isdisActive;
                  isActive = !isActive;
                } else if (!isActive) {
                  isActive = !isActive;
                }

                // _isPlaying ? null : _controller.isActive = true;
              });
              flareControls.play("like");
            },
            child: Stack(
              children: <Widget>[
                TextButton(
                    onPressed: () {
                      setState(() {
                        if (play) {
                          _controller.pause();
                          play = !play;
                        } else {
                          _controller.play();
                          play = !play;
                        }
                      });
                    },
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: VideoPlayer(_controller),
                    )),
                Padding(
                  padding: const EdgeInsets.only(bottom: 0, top: 100),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width - 100,
                      height: 90,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Text.rich(
                                TextSpan(children: <TextSpan>[
                                  TextSpan(text: 'football love'),
                                  TextSpan(
                                      text: '#foot\n',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ]),
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14),
                              )),
                          Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(left: 13),
                                width: 62,
                                height: 42,
                                child: Stack(
                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: () {
                                        _controller.dispose();
                                        _controller.pause();

                                        Navigator.push(
                                          context,
                                          PageRouteBuilder(
                                            pageBuilder: (context, animation1,
                                                    animation2) =>
                                                const UserProfile(),
                                            transitionDuration: Duration.zero,
                                          ),
                                        );
                                      },
                                      child: const CircleAvatar(
                                        radius: 20,
                                        backgroundColor: Colors.white,
                                        child: CircleAvatar(
                                          radius: 19,
                                          backgroundColor: Colors.black,
                                          backgroundImage:
                                              AssetImage('assets/spook.png'),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              color: Colors.white, width: 1),
                                        ),
                                        child: CircleAvatar(
                                          radius: 7,
                                          backgroundColor:
                                              mPrimaryColor.withOpacity(1),
                                          child: Center(
                                              child: GestureDetector(
                                            onTap: () {},
                                            child: const Icon(Icons.add,
                                                size: 11, color: Colors.white),
                                          )),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  _controller.dispose();
                                  _controller.pause();

                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder:
                                          (context, animation1, animation2) =>
                                              const UserProfile(),
                                      transitionDuration: Duration.zero,
                                    ),
                                  );
                                },
                                child: const Text.rich(
                                  TextSpan(children: <TextSpan>[
                                    TextSpan(text: 'UserName'),
                                  ]),
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 100,
                  ),
                  child: Container(
                    padding: const EdgeInsets.only(top: 20),
                    height: 48,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: IconButton(
                                icon: const Icon(Icons.arrow_back,
                                    color: mPrimaryColor),
                                onPressed: () {
                                  _controller.dispose();
                                  _controller.pause();

                                  Navigator.pushNamed(context, "/home");
                                }),
                          ),
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.center,
                            child: IconButton(
                              icon: const Icon(Icons.add),
                              iconSize: 30.0,
                              color: mPrimaryColor,
                              onPressed: () {
                                _controller.pause();

                                showModalBottomSheet(
                                    context: context,
                                    builder: (BuildContext bc) {
                                      return SafeArea(
                                        child: Wrap(
                                          children: <Widget>[
                                            ListTile(
                                                leading: const Icon(
                                                  Icons.photo_library,
                                                  color: mPrimaryColor,
                                                ),
                                                title:
                                                    const Text('Video Library'),
                                                onTap: () {
                                                  _pickVideo();
                                                  Navigator.of(context).pop();
                                                }),
                                            ListTile(
                                              leading: const Icon(
                                                Icons.videocam_sharp,
                                                color: mPrimaryColor,
                                              ),
                                              title: const Text('Video Camera'),
                                              onTap: () {
                                                _pickVideoFromCamera();
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        ),
                                      );
                                    });
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: IconButton(
                              icon: const Icon(Icons.videocam),
                              iconSize: 30.0,
                              color: Colors.red,
                              onPressed: () async {
                                _controller.pause();

                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder:
                                        (context, animation1, animation2) =>
                                            const Live(),
                                    transitionDuration: Duration.zero,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(bottom: 25, right: 10),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: SizedBox(
                        width: 70,
                        height: 450,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.only(top: 50),
                              width: 40,
                              height: 25,
                              child: Stack(
                                children: const <Widget>[],
                              ),
                            ),

                            GestureDetector(
                              onTap: () {
                                _onShowMenu();
                              },
                              child: Container(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Transform(
                                      alignment: Alignment.center,
                                      transform: Matrix4.rotationY(math.pi),
                                      // ignore: prefer_const_constructors
                                      child: Icon(
                                        Icons.more_horiz,
                                        size: 25,
                                        color: Colors.white,
                                      ),
                                    ),
                                    // ignore: prefer_const_constructors
                                    SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // ignore: unnecessary_new
                            new GestureDetector(
                              onTap: () {
                                _controller.dispose();
                                _controller.pause();

                                Navigator.pushReplacement(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder:
                                        (context, animation1, animation2) =>
                                            const UserProfile(),
                                    transitionDuration: Duration.zero,
                                  ),
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Transform(
                                      alignment: Alignment.center,
                                      transform: Matrix4.rotationY(math.pi),
                                      // ignore: prefer_const_constructors
                                      child: Icon(
                                        Icons.arrow_back_outlined,
                                        size: 25,
                                        color: Colors.white,
                                      ),
                                    ),
                                    // ignore: prefer_const_constructors
                                    SizedBox(
                                      height: 15,
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            Container(
                              padding: const EdgeInsets.only(bottom: 30),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        if (isdisActive && !isActive) {
                                          isActive = !isActive;
                                          isdisActive = !isdisActive;
                                        } else if (!isdisActive && isActive) {
                                          isActive = !isActive;
                                        } else if (!isdisActive && !isActive) {
                                          isActive = !isActive;
                                        }
                                      });
                                    },
                                    child: Icon(Icons.thumb_up,
                                        size: 25,
                                        color: isActive
                                            ? mPrimaryColor
                                            : Colors.white),
                                  ),
                                  const Text('427.9K',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 10))
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(bottom: 30),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        if (isActive && !isdisActive) {
                                          isActive = !isActive;
                                          isdisActive = !isdisActive;
                                        } else if (isdisActive && !isActive) {
                                          isdisActive = !isdisActive;
                                        } else if (!isdisActive && !isActive) {
                                          isdisActive = !isdisActive;
                                        }
                                      });
                                    },
                                    child: Icon(Icons.thumb_down,
                                        size: 25,
                                        color: isdisActive
                                            ? mPrimaryColor
                                            : Colors.white),
                                  ),
                                  const Text('Dislike',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 10))
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                // _controller.pause();
                                showSheetcomment(context);
                              },
                              child: Container(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Transform(
                                        alignment: Alignment.center,
                                        transform: Matrix4.rotationY(math.pi),
                                        child: const Icon(Icons.sms,
                                            size: 25, color: Colors.white)),
                                    const Text('2051',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 10))
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                showSheet(context);
                              },
                              child: Container(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Transform(
                                        alignment: Alignment.center,
                                        transform: Matrix4.rotationY(math.pi),
                                        child: const Icon(Icons.reply,
                                            size: 25, color: Colors.white)),
                                    const Text('Share',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 10))
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                _controller.dispose();
                                _controller.pause();

                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder:
                                        (context, animation1, animation2) =>
                                            const Useraudeio(),
                                    transitionDuration: Duration.zero,
                                  ),
                                );
                              },
                              child: AnimatedBuilder(
                                animation: animationController,
                                child: CircleAvatar(
                                  radius: 15,
                                  backgroundColor:
                                      const Color(0x00222222).withOpacity(1),
                                  child: const CircleAvatar(
                                    radius: 12,
                                    backgroundImage:
                                        AssetImage('assets/images/music.jpg'),
                                  ),
                                ),
                                builder: (context, _widget) {
                                  return Transform.rotate(
                                      angle: animationController.value * 6.3,
                                      child: _widget);
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ))
              ],
            ),
          );
        });
  }

  @override
  bool get wantKeepAlive => true;
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
              Column(
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
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Expanded(
                  child: SizedBox(
                    height: 150,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                  children: _users
                                      .map((e) => UserAvater2(e))
                                      .toList()),
                            )
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
                      Column(
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
                      ),
                      Container(
                        width: 18,
                      ),
                      Column(
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
                      ),
                      Container(
                        width: 18,
                      ),
                      Column(
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
                      ),
                      Container(
                        width: 18,
                      ),
                      Column(
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
                      ),
                      Column(
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
                      ),
                      Container(
                        width: 21,
                      ),
                      Column(
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
                      ),
                      Container(
                        width: 26,
                      ),
                      Column(
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
                      ),
                      Container(
                        width: 32,
                      ),
                      Column(
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
                      ),
                      Container(
                        width: 25,
                      ),
                      Column(
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
                      ),
                      Container(
                        width: 18,
                      ),
                      Column(
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
                      ),
                      Container(
                        width: 26,
                      ),
                      Column(
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
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      });
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
