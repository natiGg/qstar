import 'package:flutter/material.dart';
import 'package:qstar/screen/main/widget/address.dart';
import 'package:qstar/screen/main/widget/my_line.dart';
import 'package:qstar/screen/main/widget/store_name.dart';
import 'package:qstar/screen/main/widget/view_menu.dart';

class MainScreen extends StatelessWidget {
    const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/map.png'),
                  fit: BoxFit.cover),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.fromLTRB(16, 6, 16, 60),
              decoration: const  BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(9),
                  topRight: Radius.circular(9),
                ),
              ),
              child: Column(
                children: const <Widget>[
                  MyLine(),
                  StoreName(),
                  ViewMenu(),
                  Address()
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

