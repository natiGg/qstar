import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import "package:qstar/constant.dart";
import 'package:qstar/remote_services/service.dart';
import "package:qstar/screen/Chat/message_model.dart";
import "package:qstar/screen/profile/widgets/profile_widgets.dart";
import 'package:qstar/screen/feed/model/user.dart';

class Followed extends StatefulWidget {
  // ignore: constant_identifier_names
  static const ROUTE_NAME = 'Followed';

  const Followed({Key? key}) : super(key: key);
  @override
  _FollowedState createState() => _FollowedState();
}

class _FollowedState extends State<Followed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: mPrimaryColor,
            onPressed: () {
              Navigator.of(context).pop(true);
            }),
        title: const Text(
          "Following",
          style: TextStyle(
            color: mPrimaryColor,
            fontSize: 27,
            fontFamily: 'font1',
          ),
        ),
      ),
      body: RefreshIndicator(
          child: FutureBuilder(
              future:
                  RemoteServices.fetchallFollowing(editprofileController.uid),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                }
                if (snapshot.hasData) {
                  return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return FollowedList(user: snapshot.data[index]);
                    },
                    itemCount: snapshot.data.length,
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
          onRefresh: () async {}),
    );
  }
}

class FollowedList extends StatelessWidget {
  final User? user;
  const FollowedList({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Theme.of(context).cardColor,
        child: InkWell(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 16),
            child: Row(
              children: <Widget>[
                Container(
                  width: 70,
                  height: 70,
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
                              "https://qstar.mindethiopia.com/api/getProfilePicture/${user!.id}"))),
                ),
                Expanded(
                    child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              text: user!.name,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16)),
                        ])))),
                Unfollow(),
              ],
            ),
          ),
          onTap: () {},
        ));
  }
}
