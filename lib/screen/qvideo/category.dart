import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qstar/constant.dart';
import 'package:qstar/screen/qvideo/qvideo.dart';

class CategoryVid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CategoryVideo(),
    );
  }
}

class CategoryVideo extends StatefulWidget {
  @override
  _CategoryVideo2 createState() => _CategoryVideo2();
}

class _CategoryVideo2 extends State<CategoryVideo>
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
        leadingWidth: 100,
        backgroundColor: Colors.white,
        leading: Container(
          padding: EdgeInsets.only(left: 20, top: 15),
          width: 100,
          child: Text(
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
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
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
                                        Qvideoscreen(),
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
                                    child: Container(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Align(
                                                alignment: Alignment.center,
                                                child: IconButton(
                                                  icon: Icon(
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
                                                            Qvideoscreen(),
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
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
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
              pageBuilder: (context, animation1, animation2) => Qvideoscreen(),
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
