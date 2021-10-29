import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:qstar/screen/Chat/nearby.dart';
import 'package:qstar/screen/Chat/online.dart';
import 'package:qstar/screen/Chat/match.dart';
import 'category_selector.dart';
import 'favorite_contacts.dart';
import 'package:qstar/screen/feed/feed.dart';
import 'recent_chats.dart';
import 'package:qstar/constant.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  TabController? tabController;
  int currentTabIndex = 0;
  TextEditingController _searchQueryController = TextEditingController();
  bool _isSearching = false;
  String searchQuery = "Search query";

  void onTabChange() {
    setState(() {
      currentTabIndex = tabController!.index;
      print(currentTabIndex);
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
        leading: _isSearching
            ? IconButton(
                icon: Icon(Icons.arrow_back),
                color: mPrimaryColor,
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) =>
                          UsersFeed(),
                      transitionDuration: Duration.zero,
                    ),
                  );
                })
            : Container(),
        title: _isSearching ? _buildSearchField() : _buildTitle(context),
        actions: _buildActions(),
      ),
      body: WillPopScope(
        onWillPop: _onBackPressed,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 5,
            ),
            Container(
              margin: EdgeInsets.only(top: 1),
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.black38.withAlpha(10),
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Search ",
                        hintStyle: TextStyle(
                          color: Colors.black.withAlpha(120),
                        ),
                        border: InputBorder.none,
                      ),
                      onChanged: (String keyword) {},
                    ),
                  ),
                  Icon(
                    Icons.search,
                    color: Colors.black.withAlpha(120),
                  )
                ],
              ),
            ),
            CategorySelector(tabController: tabController!),
            SizedBox(
              height: 5,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                ),
                child: TabBarView(
                  controller: tabController,
                  children: [
                    RecentChats(),
                    Online(),
                    Nearby(),
                    Match(),
                  ],
                ),
              ),
            ),
          ],
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

  Widget _buildSearchField() {
    return TextField(
      controller: _searchQueryController,
      autofocus: true,
      decoration: InputDecoration(
        hintText: "Search Data...",
        border: InputBorder.none,
        hintStyle: TextStyle(color: mPrimaryColor),
      ),
      style: TextStyle(color: Colors.black, fontSize: 16.0),
      onChanged: (query) => updateSearchQuery(query),
    );
  }

  List<Widget> _buildActions() {
    if (_isSearching) {
      return <Widget>[
        IconButton(
          icon: const Icon(Icons.clear),
          color: mPrimaryColor,
          onPressed: () {
            if (_searchQueryController == null ||
                _searchQueryController.text.isEmpty) {
              Navigator.pop(context);
              return;
            }
            _clearSearchQuery();
          },
        ),
      ];
    }

    return <Widget>[
      Padding(
        padding: const EdgeInsets.only(right: 255.0, top: 20),
        child: Text(
          "Chat",
          style: TextStyle(
            color: mPrimaryColor,
            fontSize: 27,
            fontFamily: 'font1',
          ),
        ),
      ),
      IconButton(
        icon: const Icon(Icons.search),
        onPressed: _startSearch,
        color: mPrimaryColor,
      ),
    ];
  }

  void _startSearch() {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));

    setState(() {
      _isSearching = true;
    });
  }

  void updateSearchQuery(String newQuery) {
    setState(() {
      searchQuery = newQuery;
    });
  }

  void _stopSearching() {
    _clearSearchQuery();

    setState(() {
      _isSearching = false;
    });
  }

  void _clearSearchQuery() {
    setState(() {
      _searchQueryController.clear();
      updateSearchQuery("");
    });
  }

  _buildTitle(BuildContext context) {}
}
