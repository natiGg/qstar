import 'package:flutter/material.dart';

import 'dart:developer' as developer;

import 'activity_item_widget.dart';

class ActivityPage extends StatefulWidget {
  static const ROUTE_NAME = 'ActivityPage';
  @override
  _ActivityPageState createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  static const TAG = 'ActivityPage';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 100,
        backgroundColor: Colors.white,
        leading: Container(
          padding: EdgeInsets.only(left: 20, top: 15),
          width: 100,
          child: Text(
            "Activity",
            style: TextStyle(
                color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: RefreshIndicator(
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) => ActivityItemWidget(),
            itemCount: 20,
          ),
          onRefresh: () async {}),
    );
  }
}
