// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:qstar/constant.dart';

import 'activity_item_widget.dart';

class ActivityPage extends StatefulWidget {
  static const ROUTE_NAME = 'ActivityPage';

  const ActivityPage({Key? key}) : super(key: key);
  @override
  _ActivityPageState createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    //items.add((items.length+1).toString());
    //if(mounted)
    // setState(() {

    // });
    _refreshController.loadComplete();
  }

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
      body: SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,

        //cheak pull_to_refresh
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) => const ActivityItemWidget(),
          itemCount: 20,
        ),
      ),
    );
  }
}
