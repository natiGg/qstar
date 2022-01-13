// ignore_for_file: deprecated_member_use, duplicate_ignore, non_constant_identifier_names, sized_box_for_whitespace, avoid_unnecessary_containers, use_key_in_widget_constructors, invalid_use_of_protected_member

import 'dart:convert';
import 'dart:io';

import 'package:camera_camera/camera_camera.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';

import 'package:image_picker/image_picker.dart';

import 'package:need_resume/need_resume.dart';

import 'package:qstar/controllers/feedcontroller.dart';
import 'package:qstar/controllers/perfectmatchcontroller.dart';
import 'package:qstar/controllers/postcontroller.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_icons/flutter_icons.dart';
import 'package:qstar/constant.dart';

import 'package:qstar/screen/feed/model/user.dart';
import 'package:qstar/screen/feed/widgets/post.dart';

import 'package:qstar/screen/post/main.dart';
import 'package:qstar/screen/Chat/home_screen.dart';
import 'package:get/get.dart';
import 'package:qstar/screen/post/preview_screen_gallery.dart';
import 'package:qstar/screen/profile/PerfectMatch/Progress.dart';
import 'package:qstar/screen/profile/PerfectMatch/profile.dart';
import 'package:qstar/screen/profile/profile.dart';
import 'package:qstar/screen/qvideo/videoPreview.dart';

import 'package:video_player/video_player.dart';

import 'package:qstar/screen/feed/bottomsheet/app_context.dart';
import 'package:qstar/screen/feed/bottomsheet/bottom_sheet_action.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:qstar/screen/feed/widgets/refresh.dart';

// ignore: import_of_legacy_library_into_null_safe
// import 'package:rive/rive.dart';

// for refresh
List<Feeling> _feeling = [
  Feeling(feeling: "happy", icon: "assets/images/smiling.png"),
  Feeling(feeling: "loved", icon: "assets/images/loved.png"),
  Feeling(feeling: "wow", icon: "assets/images/wow.png"),
  Feeling(feeling: "sad", icon: "assets/images/sad.png"),
  Feeling(feeling: "cool", icon: "assets/images/cool.png"),
  Feeling(feeling: "Angry", icon: "assets/images/angry.png")
];

// ignore: unused_element
dynamic _pickImageError;

late int ratings = 3;
late double rating_d = 3;

class Item {
  const Item(this.name, this.icon);
  final String name;
  final Icon icon;
}

class Feed extends StatefulWidget {
  const Feed({Key? key}) : super(key: key);

  @override
  State<Feed> createState() => FeedState();
}

class FeedState extends ResumableState<Feed>
    with AutomaticKeepAliveClientMixin {
  TextEditingController nameController = TextEditingController();
  PostController postController = Get.put(PostController());
  FeedController feedController = Get.find();
  PerfectMatchController perfectMatchController =
      Get.put(PerfectMatchController());
  late VoidCallback _onShowMenu;
  bool connection = true;
  bool alreadySaved = false;
  @override
  void initState() {
    _fetchUser();

    super.initState();

    _fetchUser();

    _cheakperfect();
    _onShowMenu = () {
      context.showBottomSheet([
        BottomSheetAction(iconData: Icons.public, title: 'Public', id: 0),
        BottomSheetAction(
            iconData: Icons.supervised_user_circle_outlined,
            title: 'Friends',
            id: 1),
        BottomSheetAction(iconData: Icons.stars, title: 'Stars', id: 2),
      ]);
    };
  }

  void _cheakperfect() async {
    if (await perfectMatchController.checkmp() == false) {
      alreadySaved = true;
    } else {
      alreadySaved = false;
    }
  }

  void _fetchUser() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('user');
    print(token);
    if (token != null) {
      var body = json.decode(token);
      print(body["id"]);

      editprofileController.fetchProfile(body["id"]);
    }
  }

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    setState(() {
      feedController.onRefreshFeed();
    });
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    //items.add((items.length+1).toString());
    //if(mounted)

    //_cheakperfect();

    _refreshController.loadComplete();
  }

  ImagePicker picker = ImagePicker();
  // ignore: unused_field
  File? _cameraVideo;

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
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return editprofileController.obx((edit) => Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          leading: IconButton(
              icon: const Icon(FontAwesome.heartbeat),
              color: mPrimaryColor,
              onPressed: () async {
                if (await perfectMatchController.check() == true) {
                  // perfectMatchController.fetchPf();

                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) =>
                          const ProfileImageAppbarRoute(),
                      transitionDuration: Duration.zero,
                    ),
                  );
                } else {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) =>
                          const MyPages(),
                      transitionDuration: Duration.zero,
                    ),
                  );
                }
              }),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) =>
                          const HomeScreen(),
                      transitionDuration: Duration.zero,
                    ),
                  );

                  // Navigator.push(
                  //   context,
                  //   PageRouteBuilder(
                  //     pageBuilder: (context, animation1, animation2) =>
                  //         HomeScreen(),
                  //     transitionDuration: Duration.zero,
                  //   ),
                  // );
                },
                icon: const Icon(Icons.send_outlined),
                color: mPrimaryColor),
          ],
        ),
        backgroundColor: Colors.white,
        body: SmartRefresher(
            enablePullDown: true,
            enablePullUp: true,
            header: const WaterDropHeader(),
            //cheak pull_to_refresh
            controller: _refreshController,
            onRefresh: _onRefresh,
            onLoading: _onLoading,
            child: Obx(
              () => feedController.feed.isNotEmpty
                  ? SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 15,
                          ),
                          Card(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 0.0, vertical: 0),
                            elevation: 2,
                            shape: null,
                            child: Container(
                              padding: const EdgeInsets.fromLTRB(
                                  12.0, 0.0, 12.0, 0.0),
                              color: Colors.white,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      // ignore: prefer_const_constructors
                                      CircleAvatar(
                                          backgroundImage: NetworkImage(
                                              "https://qstar.mindethiopia.com/api/getProfilePicture/${editprofileController.uid}")),
                                      const SizedBox(width: 8.0),

                                      Expanded(
                                        // ignore: duplicate_ignore, duplicate_ignore
                                        child: Container(
                                          height: 40,
                                          width: 300,
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              border: Border.all(
                                                  color: Colors.grey
                                                      .withOpacity(0.9))),
                                          // ignore: deprecated_member_use
                                          child: FlatButton(
                                            onPressed: () {
                                              postModal(context);
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    'Share us your thought',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.grey
                                                          .withOpacity(0.9),
                                                    ),
                                                  )),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Divider(height: 5.0, thickness: 0.5),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    height: 40.0,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        FlatButton.icon(
                                          onPressed: () async {
                                            // This funcion will helps you to pick a Video File from Camera

                                            // ignore: deprecated_member_use
                                            PickedFile? pickedFile =
                                                await picker.getVideo(
                                                    source: ImageSource.camera);

                                            _cameraVideo =
                                                File(pickedFile!.path);

                                            // Navigator.push(
                                            //   context,
                                            //   MaterialPageRoute(
                                            //     builder: (context) =>
                                            //         PreviewImageScreengallery(imagePath: pickedFile.path),
                                            //   ),
                                            // );
                                          },
                                          icon: const Icon(
                                            Icons.videocam,
                                            color: Colors.red,
                                          ),
                                          label: const Text('Live'),
                                        ),
                                        const VerticalDivider(width: 8.0),
                                        FlatButton.icon(
                                          onPressed: () {
                                            //  _fetchSuggested();
                                            Navigator.push(
                                              context,
                                              PageRouteBuilder(
                                                pageBuilder: (context,
                                                        animation1,
                                                        animation2) =>
                                                    const PostPage(),
                                                transitionDuration:
                                                    Duration.zero,
                                              ),
                                            );
                                          },
                                          icon: const Icon(
                                            Icons.photo_library,
                                            color: Colors.green,
                                          ),
                                          label: const Text(' Post'),
                                        ),
                                        FlatButton.icon(
                                          onPressed: () {
                                            showModalBottomSheet(
                                                context: context,
                                                builder: (BuildContext bc) {
                                                  return SafeArea(
                                                    child: Container(
                                                      child: Wrap(
                                                        children: <Widget>[
                                                          ListTile(
                                                              leading:
                                                                  const Icon(
                                                                Icons
                                                                    .photo_library,
                                                                color:
                                                                    mPrimaryColor,
                                                              ),
                                                              title: const Text(
                                                                  'Video Library'),
                                                              onTap: () {
                                                                _pickVideo();
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              }),
                                                          ListTile(
                                                            leading: const Icon(
                                                              Icons
                                                                  .videocam_sharp,
                                                              color:
                                                                  mPrimaryColor,
                                                            ),
                                                            title: const Text(
                                                                'Video Camera'),
                                                            onTap: () {
                                                              _pickVideoFromCamera();
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                });
                                          },
                                          icon: const Icon(
                                            Icons.video_collection_sharp,
                                            color: Colors.blue,
                                          ),
                                          label: const Text(' Video'),
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
                          alreadySaved ? perfectmach() : Container(),
                          const Divider(
                            thickness: 1.0,
                          ),
                          ...feedController.feed.map((item) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 18.0),
                              child: WPost(
                                post: item,
                              ),
                            );
                          }).toList(),
                          Container(
                            child: const Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "Suggested Friends",
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: mPrimaryColor,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 250,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                Column(
                                  children: const [
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: SizedBox(height: 5),
                                    ),
                                    // Padding(
                                    //   padding: const EdgeInsets.all(8.0),
                                    //   child: Row(
                                    //       children:
                                    //           _users.map((e) => UserAvatar(e)).toList()),
                                    // )
                                  ],
                                ),
                              ],
                            ),
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
                    ),
            ))));
  }

  void postModal(context) {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
        backgroundColor: Colors.white,
        context: context,
        isScrollControlled: true,
        builder: (context) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Obx(() => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CircleAvatar(
                              backgroundImage: NetworkImage(
                                  "https://qstar.mindethiopia.com/api/getProfilePicture/${editprofileController.uid}")),
                          const SizedBox(width: 8.0),
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: Container(
                              height: 25,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  border: Border.all(
                                      color: Colors.grey.withOpacity(0.9))),
                              child: FlatButton(
                                onPressed: () {
                                  _onShowMenu();
                                },
                                child: Row(
                                  // Replace with a Row for horizontal icon + text
                                  children: <Widget>[
                                    Icon(
                                      postController.post_type.value
                                                  .toString() ==
                                              "public"
                                          ? Icons.public
                                          : postController.post_type.value
                                                      .toString() ==
                                                  "friends"
                                              ? Icons
                                                  .supervised_user_circle_outlined
                                              : Icons.star,
                                      color: mPrimaryColor,
                                      size: 20,
                                    ),
                                    Text(postController.post_type.value
                                        .toString())
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.only(
                              left: 40,
                            ),
                            child: Expanded(
                              child: Container(
                                height: 40,
                                width:
                                    // ignore: unrelated_type_equality_checks
                                    postController.isPosted == false ? 64 : 90,
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                    color: mPrimaryColor,
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(color: mPrimaryColor)),
                                child: FlatButton(
                                  onPressed: () {
                                    postController.createPost();
                                  },
                                  // ignore: unrelated_type_equality_checks
                                  child: postController.isPosting == false
                                      ? Center(
                                          // ignore: unrelated_type_equality_checks
                                          child: postController.isPosted ==
                                                  false
                                              ? const Text(
                                                  'Post',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                  ),
                                                )
                                              : const Text(
                                                  'Posted',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                  ),
                                                ))
                                      : const SizedBox(
                                          height: 20,
                                          width: 20,
                                          child: Center(
                                            child: CircularProgressIndicator(
                                                // ignore: unrelated_type_equality_checks
                                                color: Colors.white),
                                          ),
                                        ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 18.0,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom),
                        child: Container(
                          height: 420,
                          child: Form(
                            key: postController.CaptionForm,
                            child: Column(
                              children: [
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: TextFormField(
                                            minLines: 1,
                                            maxLines:
                                                5, // allow user to enter 5 line in textfield
                                            keyboardType: TextInputType
                                                .multiline, // user keyboard will have a button to move cursor to next line

                                            controller: postController
                                                .captionController,

                                            decoration:
                                                const InputDecoration.collapsed(
                                                    hintText:
                                                        'What\'s on your mind?',
                                                    hintStyle: TextStyle(
                                                      fontSize: 15,
                                                    )),

                                            validator: (value) {
                                              return postController
                                                  .validateCaption(value!);
                                            },
                                          ),
                                        ),
                                        Obx(() => postController
                                                .taggedName.isNotEmpty
                                            ? Container(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Row(
                                                      children: List.generate(
                                                          postController
                                                              .taggedName
                                                              .length, (index) {
                                                    return Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          postController
                                                              .removedTagged(
                                                                  index);
                                                        },
                                                        child: Text(
                                                          postController
                                                              .taggedName[index]
                                                              .toString(),
                                                          style: const TextStyle(
                                                              color:
                                                                  mPrimaryColor,
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                    );
                                                  })),
                                                ),
                                              )
                                            : Container()),
                                        const SizedBox(
                                          height: 40,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Obx(() => postController.imagesList.isNotEmpty
                                    ? Expanded(
                                        child: Container(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 10, left: 12.0, right: 12.0),
                                          child: GridView.count(
                                            crossAxisCount: 3,
                                            childAspectRatio: 1,
                                            children: List.generate(
                                                postController.imagesList
                                                    .length, (index) {
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 4.0),
                                                child: Stack(
                                                  children: <Widget>[
                                                    ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          postController.index
                                                              .value = index;
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          PreviewImageScreengallery(
                                                                            imagePath:
                                                                                postController.imagesList[index].path,
                                                                            isfrompost:
                                                                                false,
                                                                          )));
                                                        },
                                                        child: Image.file(
                                                          File(postController
                                                              .imagesList[index]
                                                              .path),
                                                          fit: BoxFit.cover,
                                                          height: 100,
                                                          width: 400,
                                                        ),
                                                      ),
                                                    ),
                                                    Positioned(
                                                      right: 5,
                                                      top: 5,
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                            color: mPrimaryColor
                                                                .withOpacity(
                                                                    0.5),
                                                            shape: BoxShape
                                                                .circle),
                                                        child: InkWell(
                                                          child: Icon(
                                                            FontAwesome.remove,
                                                            size: 15,
                                                            color: Colors.white
                                                                .withOpacity(
                                                                    0.8),
                                                          ),
                                                          onTap: () {
                                                            postController
                                                                .removeItem(
                                                                    index);
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            }),
                                          ),
                                        ),
                                      ))
                                    : postController.videosList.isNotEmpty
                                        ? Expanded(
                                            child: Container(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10,
                                                  left: 12.0,
                                                  right: 12.0),
                                              child: GridView.count(
                                                crossAxisCount: 3,
                                                childAspectRatio: 2,
                                                children: List.generate(
                                                    postController.videosList
                                                        .length, (index) {
                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 4.0),
                                                    child: Stack(
                                                      children: <Widget>[
                                                        ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          child:
                                                              GestureDetector(
                                                            onTap: () {
                                                              postController
                                                                      .index
                                                                      .value =
                                                                  index;
                                                              // Navigator.push(
                                                              //     context,
                                                              //     MaterialPageRoute(
                                                              //         builder:
                                                              //             (context) =>
                                                              //                 PreviewImageScreengallery(
                                                              //                   imagePath: postController
                                                              //                       .videosList[index]
                                                              //                       .path,
                                                              //                   isfrompost:
                                                              //                       false,
                                                              //                 )));
                                                            },
                                                            child: AspectRatio(
                                                                aspectRatio: 1,
                                                                child: VideoPlayer(
                                                                    postController
                                                                        .controller)),
                                                          ),
                                                        ),
                                                        Center(
                                                          child: Container(
                                                            decoration: BoxDecoration(
                                                                color: mPrimaryColor
                                                                    .withOpacity(
                                                                        0.5),
                                                                shape: BoxShape
                                                                    .circle),
                                                            child: InkWell(
                                                              child: Icon(
                                                                postController
                                                                        .isPlaying
                                                                        .value
                                                                    ? Icons
                                                                        .pause
                                                                    : Icons
                                                                        .play_arrow,
                                                              ),
                                                              onTap: () {
                                                                postController
                                                                    .onPlay();
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                        Positioned(
                                                          right: 5,
                                                          top: 5,
                                                          child: Container(
                                                            decoration: BoxDecoration(
                                                                color: mPrimaryColor
                                                                    .withOpacity(
                                                                        0.5),
                                                                shape: BoxShape
                                                                    .circle),
                                                            child: InkWell(
                                                              child: Icon(
                                                                FontAwesome
                                                                    .remove,
                                                                size: 15,
                                                                color: Colors
                                                                    .white
                                                                    .withOpacity(
                                                                        0.8),
                                                              ),
                                                              onTap: () {
                                                                postController
                                                                    .removeItem(
                                                                        index);
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                }),
                                              ),
                                            ),
                                          ))
                                        : Container()),
                                Obx(() => postController.at_loca.value != ""
                                    ? GestureDetector(
                                        onTap: () {
                                          postController.at_loca.value = "";
                                        },
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Container(
                                            child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  children: [
                                                    const Icon(
                                                        Icons.location_pin),
                                                    Text(
                                                        postController
                                                            .at_loca.value,
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 12))
                                                  ],
                                                )),
                                          ),
                                        ),
                                      )
                                    : Container()),
                                const Divider(
                                  thickness: 1,
                                ),
                                SizedBox(
                                  height: 200,
                                  child: ListView(
                                    scrollDirection: Axis.vertical,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          FlatButton.icon(
                                            onPressed: () {
                                              _showVideoPicker(context);
                                            },
                                            icon: const Icon(
                                              FontAwesome.video_camera,
                                              color: Colors.red,
                                            ),
                                            label: const Text('Add your Video'),
                                          ),
                                          FlatButton.icon(
                                            // ignore: avoid_print
                                            onPressed: () {
                                              _showPicker(context);
                                            },
                                            icon: const Icon(
                                              FontAwesome.photo,
                                              color: Colors.green,
                                            ),
                                            label: const Text('Add Photo'),
                                          ),
                                          FlatButton.icon(
                                            // ignore: avoid_print
                                            onPressed: () {
                                              _showPeople(context);
                                            },
                                            icon: const Icon(
                                              FontAwesome.user,
                                              color: mPrimaryColor,
                                            ),
                                            label: const Text('Add People'),
                                          ),
                                          FlatButton.icon(
                                            // ignore: avoid_print
                                            onPressed: () {
                                              _showFeeling(context);
                                            },
                                            icon: const Icon(
                                              FontAwesome.smile_o,
                                              color: Colors.amber,
                                            ),
                                            label:
                                                const Text('Feeling Activity'),
                                          ),
                                          FlatButton.icon(
                                            // ignore: avoid_print
                                            onPressed: () {
                                              _showLocation(context);
                                            },
                                            icon: const Icon(
                                              FontAwesome.location_arrow,
                                              color: Colors.green,
                                            ),
                                            label: const Text('Add  Location'),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
            ));
  }

  void _showVideoPicker(context) async {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: Wrap(
                children: <Widget>[
                  ListTile(
                      leading: const Icon(
                        Icons.photo_library,
                        color: mPrimaryColor,
                      ),
                      title: const Text('Video Library'),
                      onTap: () {
                        postController.selectVideos();
                        Navigator.of(context).pop();
                      }),
                  ListTile(
                    leading: const Icon(
                      Icons.videocam_sharp,
                      color: mPrimaryColor,
                    ),
                    title: const Text('Video Camera'),
                    onTap: () {
                      postController.selectVideosFromCam();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  void _showPeople(context) {
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
        builder: (BuildContext bc) {
          return Container(
            height: 350,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: ListTile(
                      leading: const Icon(Icons.search),
                      title: TextField(
                        controller: postController.searchController,
                        decoration: const InputDecoration(
                            hintText: 'Search', border: InputBorder.none),
                        onChanged: postController.onSearchTextChanged,
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.cancel),
                        onPressed: () {
                          postController.searchController.clear();
                          postController.onSearchTextChanged('');
                        },
                      ),
                    ),
                  ),
                ),
                Obx(() => Expanded(
                      // ignore: invalid_use_of_protected_member
                      child: postController.searched.value.isNotEmpty ||
                              postController.searchController.text.isNotEmpty
                          ? ListView.builder(
                              reverse: false,
                              // ignore: invalid_use_of_protected_member
                              itemCount: postController.searched.value.length,
                              padding: const EdgeInsets.all(8),
                              itemBuilder: (BuildContext context, int index) {
                                return SafeArea(
                                    child: Container(
                                        child: Wrap(children: <Widget>[
                                  ListTile(
                                    leading: CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          "https://qstar.mindethiopia.com/api/getProfilePicture/${postController.searched[index].id.toString()}"),
                                    ),
                                    title: Text(postController
                                        .searched[index].name
                                        .toString()),
                                    onTap: () {
                                      postController.tapSelection(index);
                                      Navigator.of(context).pop(true);
                                    },
                                  ),
                                ])));
                              })
                          : ListView.builder(
                              reverse: false,
                              itemCount: postController.suggestions.length,
                              padding: const EdgeInsets.all(8),
                              itemBuilder: (BuildContext context, int index) {
                                return SafeArea(
                                    child: Container(
                                        child: Wrap(children: <Widget>[
                                  ListTile(
                                    leading: CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          "https://qstar.mindethiopia.com/api/getProfilePicture/${postController.suggestions[index].id.toString()}"),
                                    ),
                                    title: Text(postController
                                        .suggestions[index].name
                                        .toString()),
                                    onTap: () {
                                      postController.tapSelection(index);
                                      Navigator.of(context).pop(true);
                                    },
                                  ),
                                ])));
                              }),
                    )),
              ],
            ),
          );
        });
  }

  void _showLocation(context) {
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
        builder: (BuildContext bc) {
          return Container(
            height: 350,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: ListTile(
                      leading: const Icon(Icons.search),
                      title: TextField(
                        controller: postController.locationController,
                        decoration: const InputDecoration(
                            hintText: 'Search Location',
                            border: InputBorder.none),
                        onChanged: postController.onLocationTextChanged,
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.cancel),
                        onPressed: () {
                          postController.locationController.clear();
                          postController.onLocationTextChanged('');
                        },
                      ),
                    ),
                  ),
                ),
                Obx(() => Expanded(
                      child: postController.searchedLoc.value.isNotEmpty ||
                              postController.locationController.text.isNotEmpty
                          ? ListView.builder(
                              reverse: false,
                              itemCount:
                                  // ignore: invalid_use_of_protected_member
                                  postController.searchedLoc.value.length,
                              padding: const EdgeInsets.all(8),
                              itemBuilder: (BuildContext context, int index) {
                                return SafeArea(
                                    child: Container(
                                        child: Wrap(children: <Widget>[
                                  ListTile(
                                    leading: const Icon(Icons.location_pin),
                                    title: Text(postController
                                        .searchedLoc[index].location
                                        .toString()),
                                    onTap: () {
                                      postController
                                          .tapsearcLocselection(index);
                                      Navigator.of(context).pop(true);
                                    },
                                  ),
                                ])));
                              })
                          : ListView.builder(
                              reverse: false,
                              itemCount: postController.location.length,
                              padding: const EdgeInsets.all(8),
                              itemBuilder: (BuildContext context, int index) {
                                return SafeArea(
                                    child: Container(
                                        child: Wrap(children: <Widget>[
                                  ListTile(
                                    leading: const Icon(Icons.location_pin),
                                    title: Text(postController
                                        .location[index].location
                                        .toString()),
                                    onTap: () {
                                      postController.tapLocselection(index);
                                      Navigator.of(context).pop(true);
                                    },
                                  ),
                                ])));
                              }),
                    )),
              ],
            ),
          );
        });
  }

  void _showFeeling(context) {
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
        builder: (BuildContext bc) {
          return Expanded(
            child: Container(
              height: 150,
              padding: const EdgeInsets.all(12.0),
              child: GridView.count(
                crossAxisCount: 3,
                childAspectRatio: 2,
                children: List.generate(_feeling.length, (index) {
                  return SafeArea(
                      child: Container(
                          child: Wrap(children: <Widget>[
                    ListTile(
                      leading: CircleAvatar(
                        radius: 15,
                        backgroundImage: AssetImage(_feeling[index].icon),
                      ),
                      title: Text(
                        _feeling[index].feeling.toString(),
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      onTap: () {
                        if (_feeling[index].feeling.toString() == "happy") {
                          postController.captionController.text =
                              postController.captionController.text +
                                  " " +
                                  editprofileController.suggested.name +
                                  " is Feeling " +
                                  _feeling[index].feeling.toString() +
                                  " 😁";
                        }
                        if (_feeling[index].feeling.toString() == "loved") {
                          postController.captionController.text =
                              postController.captionController.text +
                                  " " +
                                  editprofileController.suggested.name +
                                  " is Feeling " +
                                  _feeling[index].feeling.toString() +
                                  " 🥰";
                        }
                        if (_feeling[index].feeling.toString() == "wow") {
                          postController.captionController.text =
                              postController.captionController.text +
                                  " " +
                                  editprofileController.suggested.name +
                                  " is Feeling " +
                                  _feeling[index].feeling.toString() +
                                  " 😲";
                        }
                        if (_feeling[index].feeling.toString() == "sad") {
                          postController.captionController.text =
                              postController.captionController.text +
                                  " " +
                                  editprofileController.suggested.name +
                                  " is Feeling " +
                                  _feeling[index].feeling.toString() +
                                  "  😥";
                        }
                        if (_feeling[index].feeling.toString() == "cool") {
                          postController.captionController.text =
                              postController.captionController.text +
                                  " " +
                                  editprofileController.suggested.name +
                                  " is Feeling " +
                                  _feeling[index].feeling.toString() +
                                  " 😎";
                        }
                        if (_feeling[index].feeling.toString() == "Angry") {
                          postController.captionController.text =
                              postController.captionController.text +
                                  " " +
                                  editprofileController.suggested.name +
                                  " is Feeling " +
                                  _feeling[index].feeling.toString() +
                                  " 😡";
                        }
                        Navigator.of(context).pop(true);
                      },
                    ),
                  ])));
                }),
              ),
            ),
          );
        });
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: Wrap(
                children: <Widget>[
                  ListTile(
                      leading: const Icon(
                        Icons.photo_library,
                        color: mPrimaryColor,
                      ),
                      title: const Text('Photo Library'),
                      onTap: () {
                        postController.selectImages();
                        Navigator.of(context).pop();
                      }),
                  ListTile(
                    leading: const Icon(
                      Icons.photo_camera,
                      color: mPrimaryColor,
                    ),
                    title: const Text('Camera'),
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => CameraCamera(
                                    onFile: (file) {
                                      postController.isCam.value = true;
                                      Navigator.of(context).pop();
                                      _onCapturePressed(file);
                                    },
                                  )));
                      // _imgFromCamera();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  void _onCapturePressed(File file) {
    String path;
    path = file.path;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PreviewImageScreengallery(
          imagePath: path,
          isfrompost: false,
        ),
      ),
    );
  }

  perfectmach() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 25.0),
              child: Text(
                'Your Perfect match',
                style: TextStyle(
                    color: mPrimaryColor,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              width: 150,
            ),
            Obx(() => GestureDetector(
                onTap: () {
                  feedController.refreshMatches();
                },
                child: Expanded(
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: feedController.isRefreshing.value
                            ? Refresh()
                            : const Icon(
                                FontAwesome.refresh,
                                color: mPrimaryColor,
                              ))))),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(25),
          child: Container(
            height: 200,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Obx(() => Row(
                    children: feedController.perfectMatches
                        .map((e) => UserStories(e))
                        .toList()
                        .cast<Widget>())),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class UserStories extends StatefulWidget {
  final User user;

  const UserStories(this.user);

  @override
  State<UserStories> createState() => _UserStoriesState();
}

class _UserStoriesState extends State<UserStories> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: Container(
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                  image: NetworkImage(
                      'https://qstar.mindethiopia.com/api/getProfilePicture/${widget.user.id}'),
                  fit: BoxFit.cover),
            ),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient:
                      LinearGradient(begin: Alignment.bottomRight, colors: [
                    Colors.black.withOpacity(.9),
                    Colors.black.withOpacity(.1),
                  ])),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: 110,
                    height: 150,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 1.0, left: 9),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(children: <Widget>[
                          const Icon(
                            Icons.location_on,
                            size: 10,
                            color: Colors.white,
                          ),
                          const SizedBox(
                            width: 1,
                          ),
                          Text(
                            widget.user.current_location,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                            ),
                          ),
                        ]),
                        Row(children: <Widget>[
                          const Icon(
                            Icons.manage_accounts_sharp,
                            size: 9,
                            color: Colors.white,
                          ),
                          const SizedBox(
                            width: 1,
                          ),
                          Text(
                            widget.user.name,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                        ]),
                        Row(children: const <Widget>[]),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
