// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qstar/constant.dart';
import 'package:qstar/screen/feed/feed.dart';
import 'package:qstar/screen/feed/widgets/sharetousers.dart';
import 'package:qstar/screen/qvideo/comment/comment_widget.dart';

import 'package:qstar/screen/search/search.dart';
import 'package:video_player/video_player.dart';

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

class Live extends StatefulWidget {
  const Live({Key? key}) : super(key: key);

  @override
  _QvideoState2 createState() => _QvideoState2();
}

class _QvideoState2 extends State<Live> with SingleTickerProviderStateMixin {
  ImagePicker picker = ImagePicker();
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
  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    animationController.repeat();
    _controller = VideoPlayerController.asset('assets/vod.mp4')
      ..initialize().then((value) {
        _controller.play();
        _controller.setLooping(true);
        setState(() {});
      });
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
    await Future.delayed(const Duration(milliseconds: 1000));

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
        //   leading: IconButton(
        //       icon: const Icon(Icons.arrow_back),
        //       color: mPrimaryColor,
        //       onPressed: () {
        //         _controller.pause();
        //         _controller.dispose();
        //         Navigator.pushNamed(context, '/video');
        //       }),
        //   title: const Text(
        //     "Live Video",
        //     style: TextStyle(
        //       color: mPrimaryColor,
        //       fontSize: 27,
        //       fontFamily: 'font1',
        //     ),
        //   ),
        //   actions: <Widget>[
        //     IconButton(
        //       icon: const Icon(Icons.add),
        //       iconSize: 30.0,
        //       color: mPrimaryColor,
        //       onPressed: () async {
        //         _controller.pause();
        //         _controller.dispose();
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
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: VideoPlayer(_controller),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 60),
                  child: Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        height: kToolbarHeight,
                        // child: Column(
                        //   mainAxisSize: MainAxisSize.min,
                        //   children: <Widget>[
                        //     Column(
                        //       mainAxisAlignment: MainAxisAlignment.center,
                        //       children: const <Widget>[
                        //         CommentWidget(),
                        //         // CommentWidget(),
                        //         // CommentWidget(),
                        //         // CommentWidget(),
                        //       ],
                        //     ),
                        //   ],
                        // ),
                        child: SingleChildScrollView(
                          child: Column(
                            children: const <Widget>[
                              CommentWidget(),
                              CommentWidget(),
                              CommentWidget(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      height: kToolbarHeight,
                      child: Material(
                        borderRadius: BorderRadius.circular(9),
                        type: MaterialType.transparency,
                        child: SafeArea(
                          child: Container(
                            height: kToolbarHeight,
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
                                    padding: const EdgeInsets.only(
                                        left: 3, right: 8),
                                    // ignore: prefer_const_constructors
                                    child: TextField(
                                      style:
                                          const TextStyle(color: Colors.white),
                                      // ignore: prefer_const_constructors
                                      decoration: InputDecoration(
                                          hintText: 'Comment here',
                                          hintStyle: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 12),
                                          border: InputBorder.none),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {},
                                  child: Text(
                                    'Post',
                                    style: Theme.of(context)
                                        .primaryTextTheme
                                        .bodyText2
                                        ?.copyWith(color: Colors.white),
                                  ),
                                ),

                                InkWell(
                                  onTap: () {},
                                  child: IconButton(
                                      icon: const Icon(Icons.share),
                                      color: Colors.white,
                                      onPressed: () {}),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 110,
                  ),
                  child: Container(
                    padding: const EdgeInsets.only(top: 20),
                    height: 78,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: SizedBox(
                              height: kToolbarHeight,
                              child: Material(
                                borderRadius: BorderRadius.circular(9),
                                type: MaterialType.transparency,
                                child: SafeArea(
                                  child: Container(
                                    height: kToolbarHeight,
                                    margin: EdgeInsets.only(
                                        bottom: MediaQuery.of(context)
                                            .viewInsets
                                            .top),
                                    padding: const EdgeInsets.only(
                                        left: 16, right: 8),
                                    child: Row(
                                      children: const [
                                        CircleAvatar(
                                          backgroundImage:
                                              AssetImage('assets/images/1.jpg'),
                                          radius: 18,
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                left: 3, right: 8),
                                            child: TextField(
                                              style: TextStyle(
                                                  color: Colors.white),
                                              decoration: InputDecoration(
                                                  hintText: 'username',
                                                  hintStyle: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14),
                                                  border: InputBorder.none),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 18.0),
                              child: IconButton(
                                icon: const Icon(Icons.add),
                                iconSize: 30.0,
                                color: mPrimaryColor,
                                onPressed: () async {
                                  // _controller.pause();
                                  // _controller.dispose();

                                  // Navigator.push(
                                  //   context,
                                  //   PageRouteBuilder(
                                  //     pageBuilder:
                                  //         (context, animation1, animation2) =>
                                  //             const Live(),
                                  //     transitionDuration: Duration.zero,
                                  //   ),
                                  // );
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.only(bottom: 100, top: 0),
                //   child: Align(
                //     alignment: Alignment.topCenter,
                //     child: SizedBox(
                //       height: kToolbarHeight,
                //       child: Column(
                //           crossAxisAlignment: CrossAxisAlignment.center,
                //           children: <Widget>[
                //             Material(
                //               borderRadius: BorderRadius.circular(9),
                //               type: MaterialType.transparency,
                //               child: SafeArea(
                //                 child: Container(
                //                   height: kToolbarHeight,
                //                   margin: EdgeInsets.only(
                //                       bottom: MediaQuery.of(context)
                //                           .viewInsets
                //                           .top),
                //                   padding:
                //                       const EdgeInsets.only(left: 16, right: 8),
                //                   child: Row(
                //                     children: [
                //                       // ignore: prefer_const_constructors
                //                       CircleAvatar(
                //                         backgroundImage: const AssetImage(
                //                             'assets/images/1.jpg'),
                //                         radius: 18,
                //                       ),
                //                       // ignore: prefer_const_constructors
                //                       Expanded(
                //                         // ignore: prefer_const_constructors
                //                         child: Padding(
                //                           padding: const EdgeInsets.only(
                //                               left: 3, right: 8),
                //                           // ignore: prefer_const_constructors
                //                           child: TextField(
                //                             style:
                //                                 TextStyle(color: Colors.white),
                //                             // ignore: prefer_const_constructors
                //                             decoration: InputDecoration(
                //                                 hintText: 'username',
                //                                 hintStyle: TextStyle(
                //                                     color: Colors.white,
                //                                     fontSize: 13),
                //                                 border: InputBorder.none),
                //                           ),
                //                         ),
                //                       ),
                //                     ],
                //                   ),
                //                 ),
                //               ),
                //             ),
                //           ]),
                //     ),
                //   ),
                // ),
              ],
            ),
          );
        });
  }
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
              ],
            ),
          ));
}
