// ignore_for_file: deprecated_member_use, duplicate_ignore, non_constant_identifier_names, sized_box_for_whitespace, avoid_unnecessary_containers, use_key_in_widget_constructors

import 'dart:async';
import 'dart:convert';
import 'package:qstar/screen/api/network_utils/api.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_icons/flutter_icons.dart';

import 'package:qstar/constant.dart';

import 'package:qstar/screen/feed/model/user.dart';
import 'package:qstar/screen/feed/widgets/info_widget.dart';

import 'package:qstar/screen/post/main.dart';
import 'package:qstar/screen/Chat/home_screen.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:qstar/screen/comment/comment_page.dart';

import 'package:qstar/screen/profile/PerfectMatch/Progress.dart';
import 'package:qstar/screen/qvideo/userprofile.dart';
import 'package:qstar/screen/search/search.dart';
// import 'package:rive/rive.dart';

List<User> _users = [
  User(id: 1, userName: "gelila", storyImage: "", userImage: "",name:"",website:"",bio:"",email:"",country_code:"",

  phone_number:"" , gender:"", enable_suggestion:"", status:"",

  date_of_birth:"", current_location:"",account_type:"",online_status:"",
  joined_date:"",hobbies:"",total_followers:""
),
  User(id: 2, userName: "natig", storyImage: "", userImage: "",name:"",website:"",bio:"",email:"",country_code:"",

  phone_number:"" , gender:"", enable_suggestion:"", status:"",

  date_of_birth:"", current_location:"",account_type:"",online_status:"",
  joined_date:"",hobbies:"",total_followers:""),
  User(id: 3, userName: "bini", storyImage: "", userImage: "",name:"",website:"",bio:"",email:"",country_code:"",

  phone_number:"" , gender:"", enable_suggestion:"", status:"",

  date_of_birth:"", current_location:"",account_type:"",online_status:"",
  joined_date:"",hobbies:"",total_followers:""),
  User(id: 4, userName: "yosi", storyImage: "", userImage: "",name:"",website:"",bio:"",email:"",country_code:"",

  phone_number:"" , gender:"", enable_suggestion:"", status:"",

  date_of_birth:"", current_location:"",account_type:"",online_status:"",
  joined_date:"",hobbies:"",total_followers:""),
  User(id: 5, userName: "abrsh", storyImage: "", userImage: "",name:"",website:"",bio:"",email:"",country_code:"",

  phone_number:"" , gender:"", enable_suggestion:"", status:"",

  date_of_birth:"", current_location:"",account_type:"",online_status:"",
  joined_date:"",hobbies:"",total_followers:""),
  User(id: 1, userName: "gelila", storyImage: "", userImage: "",name:"",website:"",bio:"",email:"",country_code:"",

  phone_number:"" , gender:"", enable_suggestion:"", status:"",

  date_of_birth:"", current_location:"",account_type:"",online_status:"",
  joined_date:"",hobbies:"",total_followers:""),
  User(id: 2, userName: "natig", storyImage: "", userImage: "",name:"",website:"",bio:"",email:"",country_code:"",

  phone_number:"" , gender:"", enable_suggestion:"", status:"",

  date_of_birth:"", current_location:"",account_type:"",online_status:"",
  joined_date:"",hobbies:"",total_followers:""),
  User(id: 3, userName: "bini", storyImage: "", userImage: "",name:"",website:"",bio:"",email:"",country_code:"",

  phone_number:"" , gender:"", enable_suggestion:"", status:"",

  date_of_birth:"", current_location:"",account_type:"",online_status:"",
  joined_date:"",hobbies:"",total_followers:""),
  User(id: 4, userName: "yosi", storyImage: "", userImage: "",name:"",website:"",bio:"",email:"",country_code:"",

  phone_number:"" , gender:"", enable_suggestion:"", status:"",

  date_of_birth:"", current_location:"",account_type:"",online_status:"",
  joined_date:"",hobbies:"",total_followers:""),
  User(id: 5, userName: "abrsh", storyImage: "", userImage: "",name:"",website:"",bio:"",email:"",country_code:"",

  phone_number:"" , gender:"", enable_suggestion:"", status:"",

  date_of_birth:"", current_location:"",account_type:"",online_status:"",
  joined_date:"",hobbies:"",total_followers:""),
  User(id: 5, userName: "abrsh", storyImage: "", userImage: "",name:"",website:"",bio:"",email:"",country_code:"",

  phone_number:"" , gender:"", enable_suggestion:"", status:"",

  date_of_birth:"", current_location:"",account_type:"",online_status:"",
  joined_date:"",hobbies:"",total_followers:"")
];

List<Post> _posts = [
  Post(userid: 1, id: 1, title: 'mike check'),
  Post(userid: 2, id: 2, title: 'mike check'),
  Post(userid: 3, id: 3, title: 'mike check'),
  Post(userid: 4, id: 4, title: 'mike check'),
  Post(userid: 5, id: 5, title: 'mike check'),
];

List _usersd = [
  const Item(
      'Public',
      Icon(
        Icons.public,
        color: mPrimaryColor,
      )),
  const Item(
      'Friends',
      Icon(
        Icons.supervised_user_circle_sharp,
        color: mPrimaryColor,
      )),
  const Item(
      'Starts',
      Icon(
        Icons.star,
        color: mPrimaryColor,
      )),
];
List<bool> _isFF = [true, false, false, true, false];
late int ratings = 3;
late double rating_d = 3;

void main() {
  runApp(const UsersFeed());
}

class UsersFeed extends StatefulWidget {
  const UsersFeed({Key? key}) : super(key: key);

  @override
  State<UsersFeed> createState() => _UsersFeedState();
}

class _UsersFeedState extends State<UsersFeed> {
  @override
  late BuildContext context;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: RefreshIndicator(
        child: const Feed(),
        onRefresh: onPullRefresh,
      ),
    );
  }

  Future<void> onPullRefresh() async {
    //People item = Dummy.getPeopleData()[0];
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      //   adapter.addItem(item);
    });
  }
}

class Item {
  const Item(this.name, this.icon);
  final String name;
  final Icon icon;
}

class Feed extends StatefulWidget {
  const Feed({Key? key}) : super(key: key);

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  TextEditingController nameController = TextEditingController();

  List users = [
    const Item(
        'Android',
        Icon(
          Icons.android,
          color: Color(0xFF167F67),
        )),
    const Item(
        'Flutter',
        Icon(
          Icons.flag,
          color: Color(0xFF167F67),
        )),
    const Item(
        'ReactNative',
        Icon(
          Icons.format_indent_decrease,
          color: Color(0xFF167F67),
        )),
    const Item(
        'iOS',
        Icon(
          Icons.mobile_screen_share,
          color: Color(0xFF167F67),
        )),
  ];
  @override
  void initState() {
    // TODO: implement initState
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
            icon: const Icon(FontAwesome.heartbeat),
            color: mPrimaryColor,
            onPressed: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) => MyPages(),
                  transitionDuration: Duration.zero,
                ),
              );
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            // Padding(
            //   padding: EdgeInsets.all(20),
            //   child: Container(
            //     height: 110,
            //     child: ListView(
            //       scrollDirection: Axis.horizontal,
            //       children: [
            //         SizedBox(height: 5),
            //         Row(children: _users.map((e) => UserStories(e)).toList())
            //       ],
            //     ),
            //   ),
            // ),

            Card(
              margin: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 8),
              elevation: 2,
              shape: null,
              child: Container(
                padding: const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 0.0),
                color: Colors.white,
                child: Column(
                  children: [
                    Row(
                      children: [
                        // ignore: prefer_const_constructors
                        CircleAvatar(
                            backgroundImage:
                                const AssetImage('assets/images/profile1.jpg')),
                        const SizedBox(width: 8.0),

                        Expanded(
                          // ignore: duplicate_ignore, duplicate_ignore
                          child: Container(
                            height: 40,
                            width: 300,
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(
                                    color: Colors.grey.withOpacity(0.9))),
                            // ignore: deprecated_member_use
                            child: FlatButton(
                              onPressed: () {
                                _postModal(context);
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Share us your thought',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey.withOpacity(0.9),
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
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          FlatButton.icon(
                            onPressed: () {
                              //    _postModal(context);
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
                              _fetchSuggested();
                              // Navigator.push(
                              //   context,
                              //   PageRouteBuilder(
                              //     pageBuilder:
                              //         (context, animation1, animation2) =>
                              //             const PostPage(),
                              //     transitionDuration: Duration.zero,
                              //   ),
                              // );
                            },
                            icon: const Icon(
                              Icons.photo_library,
                              color: Colors.green,
                            ),
                            label: const Text(' Post'),
                          ),
                          FlatButton.icon(
                            onPressed: () {
                              //  _postModal(context);
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
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 25.0),
                  child: Text(
                    'Perfect match for you',
                    style: TextStyle(
                        color: mPrimaryColor,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  width: 150,
                ),
                const Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      FontAwesome.refresh,
                      color: mPrimaryColor,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(25),
              child: Container(
                height: 200,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Row(children: _users.map((e) => UserStories(e)).toList()),
                  ],
                ),
              ),
            ),

            const Divider(
              thickness: 1.0,
            ),
            ..._posts.map((item) {
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
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: SizedBox(height: 5),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                            children:
                                _users.map((e) => UserAvatar(e)).toList()),
                      )
                    ],
                  ),
                ],
              ),
            ),
            ..._posts.map((item) {
              return Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: WPost(
                  post: item,
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
    
  }
    void _fetchSuggested() async {
         SharedPreferences localStorage = await SharedPreferences.getInstance();
             localStorage.remove('token');
              Navigator.of(context).pop(true);

    //       print("waoaoaoossa");
    // var res = await Network().getData("friendSuggestion");
    // var body = json.decode(res.body);
    // print("waoaoaooa");
    // print(body.toString());
    // print(res.statusCode);

  }

  void _postModal(context) {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
        backgroundColor: Colors.white,
        context: context,
        isScrollControlled: true,
        builder: (context) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    children: [
                      const CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/images/profile1.jpg')),
                      const SizedBox(width: 8.0),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                child: const Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(2.0),
                                    child: Text(
                                      "@Betty",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      children: [
                                        DropdownButton(
                                          items: _usersd
                                              .map(
                                                (user) => DropdownMenuItem(
                                                  value: user,
                                                  child: Row(
                                                    children: [
                                                      user.icon,
                                                      const SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(
                                                        user.name,
                                                        style: const TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 12),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                              .toList(),
                                          onChanged: (value) {
                                            setState(() {
                                              value;
                                            });
                                          },
                                          hint: Container(
                                            child: const Text("public"),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                padding: const EdgeInsets.only(
                                  left: 20,
                                ),
                                child: Expanded(
                                  child: Container(
                                    height: 40,
                                    width: 64,
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    decoration: BoxDecoration(
                                        color: mPrimaryColor,
                                        borderRadius: BorderRadius.circular(5),
                                        border:
                                            Border.all(color: mPrimaryColor)),
                                    child: FlatButton(
                                      onPressed: () {},
                                      child: const Center(
                                          child: Text(
                                        'Post',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      )),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: Container(
                      height: 300,
                      child: Column(
                        children: [
                          const Expanded(
                            child: TextField(
                              decoration: InputDecoration.collapsed(
                                hintText: 'What\'s on your mind?',
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 200,
                            child: ListView(
                              scrollDirection: Axis.vertical,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    FlatButton.icon(
                                      onPressed: () {},
                                      icon: const Icon(
                                        FontAwesome.video_camera,
                                        color: Colors.red,
                                      ),
                                      label: const Text('Add your Video'),
                                    ),
                                    FlatButton.icon(
                                      // ignore: avoid_print
                                      onPressed: () => print('Photo'),
                                      icon: const Icon(
                                        FontAwesome.photo,
                                        color: Colors.green,
                                      ),
                                      label: const Text(' Add Photo'),
                                    ),
                                    FlatButton.icon(
                                      // ignore: avoid_print
                                      onPressed: () => print('Room'),
                                      icon: const Icon(
                                        FontAwesome.user,
                                        color: mPrimaryColor,
                                      ),
                                      label: const Text('Add People'),
                                    ),
                                    FlatButton.icon(
                                      // ignore: avoid_print
                                      onPressed: () => print('Room'),
                                      icon: const Icon(
                                        FontAwesome.smile_o,
                                        color: Colors.amber,
                                      ),
                                      label: const Text('Feeling Activity'),
                                    ),
                                    FlatButton.icon(
                                      // ignore: avoid_print
                                      onPressed: () => print('Room'),
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
                ],
              ),
            ));
  }
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
                  image: AssetImage('assets/images/post${widget.user.id}.jpg'),
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
                        Row(children: const <Widget>[
                          Icon(
                            Icons.location_on,
                            size: 10,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 1,
                          ),
                          Text(
                            'Addis Ababa',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                            ),
                          ),
                        ]),
                        Row(children: const <Widget>[
                          Icon(
                            Icons.manage_accounts_sharp,
                            size: 9,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 1,
                          ),
                          Text(
                            'betty',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Icon(
                            Icons.calendar_today,
                            size: 9,
                            color: Colors.white,
                          ),
                          Text(
                            ' 20',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                            ),
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

class UserAvater2 extends StatefulWidget {
  final User user;
  const UserAvater2(this.user);

  @override
  State<UserAvater2> createState() => _UserAvatarState2();
}

class _UserAvatarState2 extends State<UserAvater2> {
  bool isFollowed = false;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
          children: List.generate(1, (index) {
        return Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                            colors: [mPrimaryColor, mPrimaryColor],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter)),
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Container(
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 2),
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: AssetImage(
                                    'assets/images/profile${widget.user.id}.jpg'),
                                fit: BoxFit.cover),
                          )),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Center(
                  child: Text(
                widget.user.userName,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: mPrimaryColor),
              )),
            ],
          ),
        );
      }))
    ]);
  }
}

class UserAvatar extends StatefulWidget {
  final User user;
  const UserAvatar(this.user);

  @override
  State<UserAvatar> createState() => _UserAvatarState();
}

class _UserAvatarState extends State<UserAvatar> {
  bool isFollowed = false;

  @override
  Widget build(BuildContext context) {
    // return Container(
    //   margin: EdgeInsets.all(6),
    //   child:Column(
    //     children: [
    //       CircleAvatar(
    //         radius: 37,
    //         backgroundColor: Colors.red.shade200,
    //         child: CircleAvatar(
    //           radius: 36,
    //           backgroundColor:Colors.white,
    //           child: CircleAvatar(
    //             radius:32,
    //             backgroundImage: AssetImage('assets/images/profile${this.user.id}.jpg')),
    //         ),
    //       ),
    //       SizedBox(height:3),
    //       Text('${this.user.userName}',style: TextStyle(color: Colors.white))
    //     ],
    //   ) ,
    // );
    return Column(children: [
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Card(
          elevation: 2,
          child: Row(
              children: List.generate(1, (index) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        width: 68,
                        height: 68,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                                colors: [mPrimaryColor, mPrimaryColor],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter)),
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.white, width: 2),
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/profile${widget.user.id}.jpg'),
                                    fit: BoxFit.cover),
                              )),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isFollowed = !isFollowed;
                          });
                        },
                        child: followButton(isFollowed),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Center(
                      child: Text(
                    widget.user.userName,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: mPrimaryColor),
                  )),
                  RatingBarIndicator(
                    rating: rating_d,
                    // ignore: prefer_const_constructors
                    itemBuilder: (context, index) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    itemCount: ratings,
                    itemSize: 20.0,
                    direction: Axis.horizontal,
                  ),
                  Container(
                    color: Colors.white,
                    height: 60,
                    width: 80,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const <Widget>[
                        Text(
                          "12k",
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "followers",
                          style: TextStyle(fontSize: 12, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          })),
        ),
      )
    ]);
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
}

class WPost extends StatefulWidget {
  final Post post;

  const WPost({required this.post});

  @override
  State<WPost> createState() => _WPostState();
}

class _WPostState extends State<WPost> {
  bool isActive = false;
  bool isdisActive = false;
  bool isFollowed = false;
  final FlareControls flareControls = FlareControls();

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
                                  backgroundImage: AssetImage(
                                      'assets/images/profile${widget.post.userid}.jpg')),
                            ),
                          ),
                        ),
                      ),
                    ),
                    _isFF[(widget.post.userid) - 1]
                        ? Container(
                            margin: const EdgeInsets.only(
                                left: 20, top: 55, right: 20),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  isFollowed = !isFollowed;
                                });
                              },
                              child: followButton(isFollowed),
                            ),
                          )
                        : const SizedBox(
                            width: 0,
                          ),
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
                                        Navigator.pop(context);
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
                          '${_users.where((element) => element.id == widget.post.userid).first.userName}     129K',
                          style: const TextStyle(color: Colors.black)),
                      const SizedBox(
                        height: 5,
                      ),
                      RatingBarIndicator(
                        rating: rating_d,
                        itemBuilder: (context, index) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        itemCount: ratings,
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
                      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, ",
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
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image:
                          AssetImage("assets/images/post${widget.post.id}.jpg"),
                      fit: BoxFit.cover),
                ),
                height: 500,
              ),
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
                    child: activeLikeButton(isActive)),
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
                    child: activedisLikeButton(isdisActive)),
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation1, animation2) =>
                              CommentPage(),
                          transitionDuration: Duration.zero,
                        ),
                      );
                    },
                    child: Comment()),
                Share(),
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
          const Padding(
            padding: EdgeInsets.all(2.0),
            child: InfoWidget(),
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
