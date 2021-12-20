import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:qstar/controllers/editprofilecontroller.dart';
import 'package:qstar/remote_services/service.dart';
import 'package:qstar/screen/Chat/nearby.dart';
import 'package:qstar/screen/Chat/online.dart';
import 'package:qstar/screen/Chat/match.dart';
import 'package:qstar/screen/search/search.dart';
import 'category_selector.dart';
import 'friends_chat.dart';
import 'package:qstar/constant.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  TabController? tabController;
  int currentTabIndex = 0;
  final TextEditingController _searchQueryController = TextEditingController();
  bool _isSearching = false;
  String searchQuery = "Search query";

  void onTabChange() {
    setState(() {
      currentTabIndex = tabController!.index;
      // print(currentTabIndex);
    });
  }

  @override
  void initState() {
    tabController = TabController(length: 4, vsync: this);

    tabController?.addListener(() {
      onTabChange();
    });
    super.initState();
  }

  @override
  void dispose() {
    tabController?.addListener(() {
      onTabChange();
    });

    tabController?.dispose();

    super.dispose();
  }

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    //items.add((items.length+1).toString());
    //if(mounted)
    // setState(() {

    // });
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    Future<bool> _onBackPressed() async {
      // This dialog will exit your app on saying yes
      Navigator.of(context).pop(true);
      return Future.value(false);
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: mPrimaryColor,
            onPressed: () {
              Navigator.of(context).pop(true);
            }),
        title: const Text(
          "Chat",
          style: TextStyle(
            color: mPrimaryColor,
            fontSize: 27,
            fontFamily: 'font1',
          ),
        ),
        actions: _buildActions(),
      ),
      body: SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,

        //cheak pull_to_refresh
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: WillPopScope(
          onWillPop: _onBackPressed,
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 5,
              ),
              Container(
                margin: const EdgeInsets.only(top: 1),
                padding:
                    const EdgeInsets.symmetric(vertical: 4, horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.black38.withAlpha(10),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
              ),
              CategorySelector(tabController: tabController!),
              const SizedBox(
                height: 5,
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0),
                    ),
                  ),
                  child: TabBarView(
                    controller: tabController,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      const FriendsChat(),
                      const Online(),
                      const Nearby(),
                      const Match(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Navigator.push(
          //   context,
          //   PageRouteBuilder(
          //     pageBuilder: (context, animation1, animation2) => Qvideoscreen(),
          //     transitionDuration: Duration.zero,
          //   ),
          // );
        },
        label: const Text('Friends'),
        icon: const Icon(FontAwesome.user),
        backgroundColor: mPrimaryColor,
      ),
    );
  }

  List<Widget> _buildActions() {
    return <Widget>[
      IconButton(
        icon: const Icon(Icons.search),
        color: mPrimaryColor,
        onPressed: () {
          // ignore: unnecessary_null_comparison
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation1, animation2) => Search(),
              transitionDuration: Duration.zero,
            ),
          );
        },
      ),
    ];
  }
}
