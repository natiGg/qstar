import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qstar/constant.dart';
import 'package:qstar/screen/qvideo/qvideo.dart';

class CategoryVid extends StatefulWidget {
  const CategoryVid({Key? key}) : super(key: key);

  @override
  _CategoryVideo2 createState() => _CategoryVideo2();
}

class _CategoryVideo2 extends State<CategoryVid>
    with SingleTickerProviderStateMixin {
  final List<String> _listItem = [
    'assets/images/profile1.jpg',
    'assets/images/profile2.jpg',
    'assets/images/profile3.jpg',
    'assets/images/profile4.jpg',
    'assets/images/profile5.jpg',
    'assets/images/profile2.jpg',
    'assets/images/profile1.jpg',
    'assets/images/profile4.jpg',
  ];

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
        title: Container(
          child: const Text(
            "Q video",
            style: TextStyle(
              color: mPrimaryColor,
              fontSize: 27,
              fontFamily: 'font1',
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: <Widget>[
              Expanded(
                  child: GridView.count(
                crossAxisCount: 2,
                children: _listItem
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
                            child: Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(item),
                                      fit: BoxFit.cover)),
                              child: Stack(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                            begin: Alignment.bottomRight,
                                            colors: [
                                          Colors.black.withOpacity(.9),
                                          Colors.black.withOpacity(.1),
                                        ])),
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
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Text(
                                        "#Funny",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: "font1",
                                            fontSize: 20),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ))
                    .toList(),
              ))
            ],
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
