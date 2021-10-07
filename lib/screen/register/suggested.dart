import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:qstar/constant.dart';
import 'package:qstar/screen/register/widget/register_button.dart';
import 'package:qstar/screen/register/widget/register_form.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:qstar/screen/register/verification.dart';
import 'package:qstar/screen/feed/model/user.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';



List<User> _users = [
  User(id: 1, userName: "gelila", storyImage: "", userImage: ""),
  User(id: 2, userName: "natig", storyImage: "", userImage: ""),
  User(id: 3, userName: "bini", storyImage: "", userImage: ""),
  User(id: 4, userName: "yosi", storyImage: "", userImage: ""),
  User(id: 5, userName: "abrsh", storyImage: "", userImage: ""),
];


class Suggested extends StatelessWidget {
  const Suggested({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Remove the debug banner
      debugShowCheckedModeBanner: false,
      title: 'qstar',
      home: SuggestedFriends(),
    );
  }
}

class SuggestedFriends extends StatefulWidget {
  const SuggestedFriends({Key? key}) : super(key: key);

  @override
  _SuggestedFriendsState createState() => _SuggestedFriendsState();
}

class _SuggestedFriendsState extends State<SuggestedFriends> {
   @override
  Widget build(BuildContext context) {
    const textStyle = const TextStyle(
      color: Colors.white,
    );
    return Scaffold(
      body: Column(
        mainAxisAlignment:
            MainAxisAlignment.center, //Center Column contents vertically,
        children: <Widget>[
          Container(
                       

            child: Column(
              children: [
                
                  Text("Friends",style: TextStyle( // we use the [TextStyle] widget to customize text
            color: mPrimaryColor, // set the color
            fontSize: 25.0, // and the font size
            
          ),),
          SizedBox(height: 10,),
          Text("Follow your friends to share stories and experiences",style: TextStyle( // we use the [TextStyle] widget to customize text
            color: mPrimaryColor, // set the color
            fontSize: 15.0, // and the font size
            
          ),),
          SizedBox(height: 25,),
          
              Text("Quick follow",style: TextStyle( // we use the [TextStyle] widget to customize text
            color: mPrimaryColor, // set the color
            fontSize: 25.0, // and the font size
            
          ),),
           SizedBox(height: 10,),

          Text("connect with your best friend on Q star",style: TextStyle( // we use the [TextStyle] widget to customize text
            color: mPrimaryColor, // set the color
            fontSize: 15.0, // and the font size
            
          ),),
                     

          Text("Follow 5 friend to get started",style: TextStyle( // we use the [TextStyle] widget to customize text
            color: mPrimaryColor, // set the color
            fontSize: 15.0, // and the font size
            
          ),),
        
                 Padding(
                    padding: EdgeInsets.all(20),

                    child: Container(
                      height: 500,

                      child: ListView(
                        scrollDirection: Axis.vertical,
                        children: [
                          SizedBox(height: 5),
                          Column(children: _users.map((e) => SuggestedUsers(e)).toList())
                        ],
                      ),
                    ),
                    
                  ),
              
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(36),
              ),
              color: mPrimaryColor,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return Verification();
                    },
                  ),
                );
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16),
                alignment: Alignment.center,
                child: Text(
                  'Next',
                  style: textStyle,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
class SuggestedUsers extends StatelessWidget {
  final User user;

  SuggestedUsers(this.user);

  @override
  Widget build(BuildContext context) {
        Size size = MediaQuery.of(context).size;
        const textStyle = const TextStyle(
      color: Colors.white,
    );
      return Column(
      children: <Widget>[
          Container(
             padding: const EdgeInsets.only(top: 10),
            
            child: Row(
              children: <Widget>[
                
                  Container(
                    height: 110,
                    width: 110,
                    decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(30),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(
                          'assets/images/profile${this.user.id}.jpg',
                        ),
                      ),
                    ),
                  ),
                
                Container(
                  padding: const EdgeInsets.only(top: 20,left: 20),
                  height: 150,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Egele egele",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: mPrimaryColor
                          ),
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RatingBarIndicator(
                      rating: 2.75,
                      itemBuilder: (context, index) => Icon(
                          Icons.star,
                          color: Colors.amber,
                      ),
                      itemCount: 5,
                      itemSize: 20.0,
                      direction: Axis.horizontal,
                ),
                    ),
                
                    
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 100,
                          height: 30,
                          child: FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(36),
              ),
              color: mPrimaryColor,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                        return Verification();
                    },
                  ),
                );
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 5),
                alignment: Alignment.center,
                child: Text(
                  'Follow',
                  style: textStyle,
                ),
              ),
            ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

      ]);
   
    
  }
}
