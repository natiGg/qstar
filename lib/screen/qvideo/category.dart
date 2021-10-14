import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qstar/constant.dart';

void main() =>
    runApp(MaterialApp(debugShowCheckedModeBanner: false, home: CategoryVid()));

class CategoryVid extends StatefulWidget {
  @override
  _CategoryVidState createState() => _CategoryVidState();
}

class _CategoryVidState extends State<CategoryVid> {
  final List<String> _listItem = [
    'assets/images/profile1.jpg',
    'assets/images/profile2.jpg',
    'assets/images/profile3.jpg',
    'assets/images/profile4.jpg',
    'assets/images/profile5.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      //   leading: Icon(Icons.menu),
      //   title: Text("Home"),
      //   actions: <Widget>[
      //     Padding(
      //       padding: EdgeInsets.all(10.0),
      //       child: Container(
      //         width: 36,
      //         height: 30,
      //         decoration: BoxDecoration(
      //           color: Colors.grey[800],
      //           borderRadius: BorderRadius.circular(10)
      //         ),
      //         child: Center(child: Text("0")),
      //       ),
      //     )
      //   ],
      // ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Expanded(
                  child: GridView.count(
                crossAxisCount: 2,

             
               
                children: _listItem
                    .map((item) => Card(
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
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Align(
                                              alignment: Alignment.center,
                                              child: IconButton(
                                                icon: Icon(
                                                  Icons.play_arrow_rounded,
                                                  color: Colors.white,
                                                  size: 40.0,
                                                ),
                                                onPressed: () {},
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
                        ))
                    .toList(),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
