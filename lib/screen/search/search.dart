// ignore_for_file: import_of_legacy_library_into_null_safe, unnecessary_null_comparison, camel_case_types, must_be_immutable, must_call_super, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:qstar/constant.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:qstar/controllers/editprofilecontroller.dart';
import 'package:qstar/remote_services/service.dart';
import 'package:qstar/screen/feed/model/user.dart';

import 'package:qstar/screen/profile/userprofiledetail.dart';
import 'package:qstar/screen/search/hashtagdetail.dart';
import 'package:qstar/screen/search/placesdetail.dart';

class Search extends StatelessWidget {
  const Search({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  static const historyLength = 5;

  final List<String> _searchHistory = [
    'user1',
    'user2',
    'user3',
    'user4',
  ];

  late List<String> filteredSearchHistory;

  String selectedTerm = "Search";

  List<String> filterSearchTerms({
    required String filter,
  }) {
    if (filter != null && filter.isNotEmpty) {
      return _searchHistory.reversed
          .where((term) => term.startsWith(filter))
          .toList();
    } else {
      return _searchHistory.reversed.toList();
    }
  }

  void addSearchTerm(String term) {
    if (_searchHistory.contains(term)) {
      putSearchTermFirst(term);
      return;
    }

    _searchHistory.add(term);
    if (_searchHistory.length > historyLength) {
      _searchHistory.removeRange(0, _searchHistory.length - historyLength);
    }

    filteredSearchHistory = filterSearchTerms(filter: "");
  }

  void deleteSearchTerm(String term) {
    _searchHistory.removeWhere((t) => t == term);
    filteredSearchHistory = filterSearchTerms(filter: "");
  }

  void putSearchTermFirst(String term) {
    deleteSearchTerm(term);
    addSearchTerm(term);
  }

  late FloatingSearchBarController controller;

  @override
  void initState() {
    super.initState();
    controller = FloatingSearchBarController();
    filteredSearchHistory = filterSearchTerms(filter: "");
  }

  @override
  void dispose() {
    controller.dispose();
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
    await Future.delayed(const Duration(milliseconds: 1000));

    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: true,

      //cheak pull_to_refresh
      controller: _refreshController,
      onRefresh: _onRefresh,
      onLoading: _onLoading,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: DefaultTabController(
          length: 3,
          child: Scaffold(
              resizeToAvoidBottomInset: false,
              body: NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    const SliverAppBar(
                      centerTitle: true,
                      backgroundColor: Colors.white,
                      title: TabBar(
                        labelColor: mPrimaryColor,
                        unselectedLabelColor: mPrimaryColor,
                        indicatorWeight: 2.0,
                        indicatorColor: mPrimaryColor,
                        isScrollable: true,
                        tabs: [
                          Tab(
                            child: Text(
                              "Users",
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 26,
                                fontFamily: 'font1',
                              ),
                            ),
                          ),
                          Tab(
                            child: Text(
                              "Hashtag",
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 26,
                                fontFamily: 'font1',
                              ),
                            ),
                          ),
                          Tab(
                            child: Text(
                              "Places",
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 26,
                                fontFamily: 'font1',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ];
                },
                body: TabBarView(
                  children: <Widget>[
                    // Users
                    FloatingSearchBar(
                      controller: controller,
                      iconColor: mPrimaryColor,
                      body: FloatingSearchBarScrollNotifier(
                        child: UserSearchResultsListView(
                          searchTerm: selectedTerm,
                          key: null,
                        ),
                      ),
                      transition: CircularFloatingSearchBarTransition(),
                      physics: const BouncingScrollPhysics(),
                      title: Text(
                        selectedTerm,
                        style: const TextStyle(
                            fontFamily: "font1",
                            color: mPrimaryColor,
                            fontSize: 25),
                      ),
                      hint: 'Search Users...',
                      actions: [
                        FloatingSearchBarAction.searchToClear(),
                      ],
                      onQueryChanged: (query) {
                        setState(() {
                          filteredSearchHistory =
                              filterSearchTerms(filter: query);
                        });
                      },
                      onSubmitted: (query) {
                        setState(() {
                          addSearchTerm(query);
                          selectedTerm = query;
                        });
                        controller.close();
                      },
                      builder: (context, transition) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Material(
                            color: Colors.white,
                            elevation: 4,
                            child: Builder(
                              builder: (context) {
                                if (filteredSearchHistory.isEmpty &&
                                    controller.query.isEmpty) {
                                  return Container(
                                    height: 56,
                                    width: double.infinity,
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Start searching',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style:
                                          Theme.of(context).textTheme.caption,
                                    ),
                                  );
                                } else if (filteredSearchHistory.isEmpty) {
                                  return ListTile(
                                    title: Text(controller.query),
                                    leading: const Icon(Icons.search),
                                    onTap: () {
                                      setState(() {
                                        addSearchTerm(controller.query);
                                        selectedTerm = controller.query;
                                      });
                                      controller.close();
                                    },
                                  );
                                } else {
                                  return Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: filteredSearchHistory
                                        .map(
                                          (term) => ListTile(
                                            title: Text(
                                              term,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            leading: const Icon(Icons.history),
                                            trailing: IconButton(
                                              icon: const Icon(Icons.clear),
                                              onPressed: () {
                                                setState(() {
                                                  deleteSearchTerm(term);
                                                });
                                              },
                                            ),
                                            onTap: () {
                                              setState(() {
                                                putSearchTermFirst(term);
                                                selectedTerm = term;
                                              });
                                              controller.close();
                                            },
                                          ),
                                        )
                                        .toList(),
                                  );
                                }
                              },
                            ),
                          ),
                        );
                      },
                    ),

                    // Hastags

                    FloatingSearchBar(
                      controller: controller,
                      iconColor: mPrimaryColor,
                      body: FloatingSearchBarScrollNotifier(
                        child: HastagSearchResultsListView(
                          searchTerm: selectedTerm,
                          key: null,
                        ),
                      ),
                      transition: CircularFloatingSearchBarTransition(),
                      physics: const BouncingScrollPhysics(),
                      title: Text(
                        selectedTerm,
                        style: const TextStyle(
                            fontFamily: "font1",
                            color: mPrimaryColor,
                            fontSize: 25),
                      ),
                      hint: 'Search Hastags...',
                      actions: [
                        FloatingSearchBarAction.searchToClear(),
                      ],
                      onQueryChanged: (query) {
                        setState(() {
                          filteredSearchHistory =
                              filterSearchTerms(filter: query);
                        });
                      },
                      onSubmitted: (query) {
                        setState(() {
                          addSearchTerm(query);
                          selectedTerm = query;
                        });
                        controller.close();
                      },
                      builder: (context, transition) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Material(
                            color: Colors.white,
                            elevation: 4,
                            child: Builder(
                              builder: (context) {
                                if (filteredSearchHistory.isEmpty &&
                                    controller.query.isEmpty) {
                                  return Container(
                                    height: 56,
                                    width: double.infinity,
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Start searching',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style:
                                          Theme.of(context).textTheme.caption,
                                    ),
                                  );
                                } else if (filteredSearchHistory.isEmpty) {
                                  return ListTile(
                                    title: Text(controller.query),
                                    leading: const Icon(Icons.search),
                                    onTap: () {
                                      setState(() {
                                        addSearchTerm(controller.query);
                                        selectedTerm = controller.query;
                                      });
                                      controller.close();
                                    },
                                  );
                                } else {
                                  return Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: filteredSearchHistory
                                        .map(
                                          (term) => ListTile(
                                            title: Text(
                                              term,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            leading: const Icon(Icons.history),
                                            trailing: IconButton(
                                              icon: const Icon(Icons.clear),
                                              onPressed: () {
                                                setState(() {
                                                  deleteSearchTerm(term);
                                                });
                                              },
                                            ),
                                            onTap: () {
                                              setState(() {
                                                putSearchTermFirst(term);
                                                selectedTerm = term;
                                              });
                                              controller.close();
                                            },
                                          ),
                                        )
                                        .toList(),
                                  );
                                }
                              },
                            ),
                          ),
                        );
                      },
                    ),
                    //places
                    FloatingSearchBar(
                      controller: controller,
                      iconColor: mPrimaryColor,
                      body: FloatingSearchBarScrollNotifier(
                        child: placesSearchResultsListView(
                          searchTerm: selectedTerm,
                          key: null,
                        ),
                      ),
                      transition: CircularFloatingSearchBarTransition(),
                      physics: const BouncingScrollPhysics(),
                      title: Text(
                        selectedTerm,
                        style: const TextStyle(
                            fontFamily: "font1",
                            color: mPrimaryColor,
                            fontSize: 25),
                      ),
                      hint: 'Search places...',
                      actions: [
                        FloatingSearchBarAction.searchToClear(),
                      ],
                      onQueryChanged: (query) {
                        setState(() {
                          filteredSearchHistory =
                              filterSearchTerms(filter: query);
                        });
                      },
                      onSubmitted: (query) {
                        setState(() {
                          addSearchTerm(query);
                          selectedTerm = query;
                        });
                        controller.close();
                      },
                      builder: (context, transition) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Material(
                            color: Colors.white,
                            elevation: 4,
                            child: Builder(
                              builder: (context) {
                                if (filteredSearchHistory.isEmpty &&
                                    controller.query.isEmpty) {
                                  return Container(
                                    height: 56,
                                    width: double.infinity,
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Start searching',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style:
                                          Theme.of(context).textTheme.caption,
                                    ),
                                  );
                                } else if (filteredSearchHistory.isEmpty) {
                                  return ListTile(
                                    title: Text(controller.query),
                                    leading: const Icon(Icons.search),
                                    onTap: () {
                                      setState(() {
                                        addSearchTerm(controller.query);
                                        selectedTerm = controller.query;
                                      });
                                      controller.close();
                                    },
                                  );
                                } else {
                                  return Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: filteredSearchHistory
                                        .map(
                                          (term) => ListTile(
                                            title: Text(
                                              term,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            leading: const Icon(Icons.history),
                                            trailing: IconButton(
                                              icon: const Icon(Icons.clear),
                                              onPressed: () {
                                                setState(() {
                                                  deleteSearchTerm(term);
                                                });
                                              },
                                            ),
                                            onTap: () {
                                              setState(() {
                                                putSearchTermFirst(term);
                                                selectedTerm = term;
                                              });
                                              controller.close();
                                            },
                                          ),
                                        )
                                        .toList(),
                                  );
                                }
                              },
                            ),
                          ),
                        );
                      },
                    ),

                    //video
                  ],
                ),
              )),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

// ignore: must_be_immutable
class UserSearchResultsListView extends StatelessWidget {
  final String searchTerm;
  EditprofileController editprofileController = Get.find();
  UserSearchResultsListView({
    Key? key,
    required this.searchTerm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (searchTerm == null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(
              Icons.search,
              size: 64,
            ),
          ],
        ),
      );
    }

    final fsb = FloatingSearchBar.of(context);

    return SizedBox(
      height: 200.0,
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.only(top: fsb.height + fsb.margins.vertical),
        children: List.generate(
            1,
            (index) => ListTile(
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Row(
                      children: [
                        searchTerm == "Search Accounts"
                            ? const Icon(
                                Icons.search_sharp,
                                size: 0,
                              )
                            : const Icon(
                                Icons.search_sharp,
                                size: 0,
                              ),
                        FutureBuilder(
                            future: RemoteServices.fetachsearch(searchTerm),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (snapshot.hasError) {
                                return Center(
                                  child: Text(snapshot.error.toString()),
                                );
                              }
                              if (snapshot.hasData) {
                                return Expanded(
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    physics: const BouncingScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return SearchList(
                                          user: snapshot.data[index]);
                                    },
                                    itemCount: snapshot.data.length,
                                  ),
                                );
                              } else {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            }),
                      ],
                    ),
                  ),
                )),
      ),
    );
  }
}

class HastagSearchResultsListView extends StatelessWidget {
  final String searchTerm;
  EditprofileController editprofileController = Get.find();
  HastagSearchResultsListView({
    Key? key,
    required this.searchTerm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (searchTerm == null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(
              Icons.search,
              size: 64,
            ),
          ],
        ),
      );
    }

    final fsb = FloatingSearchBar.of(context);

    return SizedBox(
      height: 200.0,
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.only(top: fsb.height + fsb.margins.vertical),
        children: List.generate(
            1,
            (index) => ListTile(
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Row(
                      children: [
                        searchTerm == "Search Tags"
                            ? const Icon(
                                Icons.search_sharp,
                                size: 0,
                              )
                            : const Icon(
                                Icons.search_sharp,
                                size: 0,
                              ),
                        FutureBuilder(
                            future: RemoteServices.fetachsearchtag(searchTerm),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (snapshot.hasError) {
                                return Center(
                                  child: Text(snapshot.error.toString()),
                                );
                              }
                              if (snapshot.hasData) {
                                return Expanded(
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    physics: const BouncingScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return SearchListtag(
                                          tag: snapshot.data[index]);
                                    },
                                    itemCount: snapshot.data.length,
                                  ),
                                );
                              } else {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            }),
                      ],
                    ),
                  ),
                )),
      ),
    );
  }
}

class placesSearchResultsListView extends StatelessWidget {
  final String searchTerm;
  EditprofileController editprofileController = Get.find();
  placesSearchResultsListView({
    Key? key,
    required this.searchTerm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (searchTerm == null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(
              Icons.search,
              size: 64,
            ),
          ],
        ),
      );
    }

    final fsb = FloatingSearchBar.of(context);

    return SizedBox(
      height: 200.0,
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.only(top: fsb.height + fsb.margins.vertical),
        children: List.generate(
            1,
            (index) => ListTile(
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Row(
                      children: [
                        searchTerm == "Search Places"
                            ? const Icon(
                                Icons.search_sharp,
                                size: 0,
                              )
                            : const Icon(
                                Icons.search_sharp,
                                size: 0,
                              ),
                        FutureBuilder(
                            future:
                                RemoteServices.fetachsearchplace(searchTerm),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (snapshot.hasError) {
                                return Center(
                                  child: Text(snapshot.error.toString()),
                                );
                              }
                              if (snapshot.hasData) {
                                return Expanded(
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    physics: const BouncingScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return SearchListplace(
                                          place: snapshot.data[index]);
                                    },
                                    itemCount: snapshot.data.length,
                                  ),
                                );
                              } else {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            }),
                      ],
                    ),
                  ),
                )),
      ),
    );
  }
}

class SearchList extends StatelessWidget {
  final User? user;
  const SearchList({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Theme.of(context).cardColor,
        child: InkWell(
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) =>
                      UserProfileDetail(
                    user: user,
                    fromFeed: false,
                  ),
                  transitionDuration: Duration.zero,
                ),
              );
            },
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
                ],
              ),
            ),
          ),
          onTap: () {},
        ));
  }
}

class SearchListtag extends StatelessWidget {
  final Tag? tag;
  const SearchListtag({Key? key, required this.tag}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Theme.of(context).cardColor,
        child: InkWell(
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) =>
                      Hashtagdetail(
                    tag: tag,
                  ),
                  transitionDuration: Duration.zero,
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 16),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 40,
                    height: 40,
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
                        image: const DecorationImage(
                          fit: BoxFit.contain,
                          image: AssetImage('assets/images/hash.png'),
                        )),
                  ),
                  Expanded(
                      child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: RichText(
                              text: TextSpan(children: [
                            TextSpan(
                                text: tag!.hashtag,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1
                                    ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16)),
                          ])))),
                ],
              ),
            ),
          ),
          onTap: () {},
        ));
  }
}

class SearchListplace extends StatelessWidget {
  final Place? place;
  const SearchListplace({Key? key, required this.place}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Theme.of(context).cardColor,
        child: InkWell(
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) =>
                      PlaceDetail(place: place),
                  transitionDuration: Duration.zero,
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 16),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 40,
                    height: 40,
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
                        image: const DecorationImage(
                          fit: BoxFit.contain,
                          image: AssetImage('assets/images/loc.png'),
                        )),
                  ),
                  Expanded(
                      child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: RichText(
                              text: TextSpan(children: [
                            TextSpan(
                                text: place!.location,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1
                                    ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16)),
                          ])))),
                ],
              ),
            ),
          ),
          onTap: () {},
        ));
  }
}
