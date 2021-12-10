import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:get/get.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:qstar/constant.dart';
import 'package:qstar/remote_services/service.dart';
import 'package:qstar/screen/feed/model/user.dart';

class Hashtagdetail extends StatefulWidget {
  final Tag? tag;

  const Hashtagdetail({Key? key, required this.tag}) : super(key: key);

  @override
  _Hashtagdetail createState() => _Hashtagdetail();
}

class _Hashtagdetail extends State<Hashtagdetail> {
  late List<hashtagPost> list = [];
  int ind = 0;
  @override
  void initState() {
    super.initState();

    ind = int.parse(widget.tag!.number_of_posts);
    fetch();
  }

  void fetch() async {
    list = await RemoteServices.hashtagdetail(widget.tag!.hashtag);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.white,
            toolbarHeight: 80,
            leading: Container(
              padding: const EdgeInsets.only(top: 5, left: 10),
              child: Align(
                alignment: Alignment.topLeft,
                child: Container(
                  color: Colors.white,
                  height: 70, //155,
                  width: 70, //155,
                  child: Stack(
                    children: [
                      Container(
                        height: 140 - 10, //140,
                        width: 140 - 10, //140,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const CircleAvatar(
                          backgroundColor: Colors.transparent,
                          backgroundImage: AssetImage('assets/images/hash.png'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            title: Expanded(
                child: Center(
              child: Column(children: [
                Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text: "# ${widget.tag!.hashtag} ",
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1
                              ?.copyWith(
                                  fontWeight: FontWeight.bold, fontSize: 16)),
                    ]))),
                const SizedBox(
                  height: 10,
                ),
                Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text: "${widget.tag!.number_of_posts} posts",
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1
                              ?.copyWith(
                                  fontWeight: FontWeight.bold, fontSize: 16)),
                    ]))),
              ]),
            )),
          ),

          // add package sliver_staggered_grid
          SliverStaggeredGrid.count(
            crossAxisCount: 3,
            mainAxisSpacing: 1,
            crossAxisSpacing: 1,
            children: List.generate(
              ind,
              (index) => _gridItems(index, list),
            ),
            staggeredTiles: List.generate(ind, (index) {
              int value = index % ind + 1;
              if (value == 2) {
                // Reels
                return StaggeredTile.count(1, 2);
              } else if (value == 8) {
                // IG TV
                return StaggeredTile.count(2, 2);
              }
              // Anything
              return StaggeredTile.count(1, 1);
            }),
          ),
        ],
      ),
    );
  }
}

Widget _gridItems(int index, List<hashtagPost> list) {
  return Stack(
    fit: StackFit.expand,
    children: [
      Image.network(
        "https://qstar.mindethiopia.com/api/getPostPicture/${list[index].post_id}",
        fit: BoxFit.cover,
      ),
      if (index % 3 == 0)
        Padding(
          padding: EdgeInsets.all(5),
          child: Align(
            alignment: Alignment.topRight,
            child: Icon(
              Icons.play_arrow,
              color: Colors.white,
              size: 28,
            ),
          ),
        )
      else if (index == 2)
        Padding(
          padding: EdgeInsets.all(8),
          child: Image.asset(
            'assets/icons/reels_outline.png',
            alignment: Alignment.bottomLeft,
            scale: 1.8,
            color: Colors.white,
          ),
        )
      else
        Padding(
          padding: EdgeInsets.all(8),
          child: Align(
            alignment: Alignment.topRight,
            child: Icon(
              Icons.photo_library,
              color: Colors.white,
              size: 22,
            ),
          ),
        ),
    ],
  );
}
