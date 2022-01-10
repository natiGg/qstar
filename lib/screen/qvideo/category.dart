import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qstar/constant.dart';
import 'package:qstar/controllers/videocatagorycontroller.dart';
import 'package:qstar/screen/qvideo/qvideo.dart';

class CategoryVid extends StatefulWidget {
  const CategoryVid({Key? key}) : super(key: key);

  @override
  _CategoryVideo2 createState() => _CategoryVideo2();
}

class _CategoryVideo2 extends State<CategoryVid>
    with SingleTickerProviderStateMixin {
  VideocatagoryController videocatagoryController =
      Get.put(VideocatagoryController());
  int ind = 0;
  @override
  void initState() {
    super.initState();

    //  ind = int.parse(widget.tag!.number_of_posts);

    videocatagoryController.fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: mPrimaryColor,
            onPressed: () {
              Navigator.pushNamed(context, '/home');
            }),
        title: const Text(
          "Q video",
          style: TextStyle(
            color: mPrimaryColor,
            fontSize: 27,
            fontFamily: 'font1',
          ),
        ),
        actions: [
          IconButton(
              // ignore: prefer_const_constructors
              icon: Icon(
                Icons.search,
                size: 28,
                color: mPrimaryColor,
              ),
              onPressed: () {}),
        ],
      ),
      body: Obx(
        () => SafeArea(
          child: Container(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: <Widget>[
                Expanded(
                    child: GridView.count(
                  crossAxisCount: 2,
                  children: videocatagoryController.list
                      .map((item) => GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder:
                                      (context, animation1, animation2) =>
                                          const Qvideoscreen(),
                                  transitionDuration: Duration.zero,
                                ),
                              );
                            },
                            child: Card(
                              color: Colors.transparent,
                              elevation: 0,
                              child: Stack(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                            begin: Alignment.bottomRight,
                                            colors: [
                                              Colors.black.withOpacity(.9),
                                              Colors.black.withOpacity(.1),
                                            ]),
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                                "https://qstar.mindethiopia.com/api/videoCategory/${item.id}"))),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Align(
                                              alignment: Alignment.center,
                                              child: IconButton(
                                                icon: const Icon(
                                                  Icons.play_arrow_rounded,
                                                  color: Colors.white,
                                                  size: 40.0,
                                                ),
                                                onPressed: () {
                                                  Navigator.push(
                                                    context,
                                                    PageRouteBuilder(
                                                      pageBuilder: (context,
                                                              animation1,
                                                              animation2) =>
                                                          const Qvideoscreen(),
                                                      transitionDuration:
                                                          Duration.zero,
                                                    ),
                                                  );
                                                },
                                              )),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Text(
                                        item.title,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontFamily: "font1",
                                            fontSize: 20),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ))
                      .toList(),
                ))
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation1, animation2) =>
                  const Qvideoscreen(),
              transitionDuration: Duration.zero,
            ),
          );
        },
        label: const Text('Random'),
        icon: const Icon(Icons.compare_arrows),
        backgroundColor: mPrimaryColor,
      ),
    );
  }
}
