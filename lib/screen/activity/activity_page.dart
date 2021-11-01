// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:qstar/constant.dart';

import 'activity_item_widget.dart';

class ActivityPage extends StatefulWidget {
  static const ROUTE_NAME = 'ActivityPage';

  const ActivityPage({Key? key}) : super(key: key);
  @override
  _ActivityPageState createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leadingWidth: 100,
        backgroundColor: Colors.white,
        leading: Container(
          padding: const EdgeInsets.only(left: 20, top: 15),
          width: 100,
          child: const Text(
            "Activity",
            style: TextStyle(
              color: mPrimaryColor,
              fontSize: 27,
              fontFamily: 'font1',
            ),
          ),
        ),
      ),
      body: RefreshIndicator(
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) => const ActivityItemWidget(),
            itemCount: 20,
          ),
          onRefresh: () async {}),
    );
  }
}
