// ignore_for_file: prefer_const_constructors

import 'dial_user_pic.dart';
import 'package:flutter/material.dart';

import 'constants.dart';
import 'size_config.dart';

class UserCallingCard extends StatelessWidget {
  const UserCallingCard({
  
    required this.name,
   required this.image,
  });

  final String name, image;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kBackgoundColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DialUserPic(
            size: 112,
            image: image,
          ),
        
          Text(
            name,
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
      
          Text(
            "Calling…",
            style: TextStyle(color: Colors.white60),
          )
        ],
      ),
    );
  }
}
