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
            MainAxisAlignment.start, //Center Column contents vertically,
        children: <Widget>[
          Container(
                        decoration: BoxDecoration(color: mPrimaryLight),

            child: Column(
              children: [
                Column(
                  
            children: [
              Container(
                height: 200,
            decoration: BoxDecoration(color: mPrimaryLight),
            padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 10,
        ), 
           
                child: Column(
                  mainAxisAlignment:
            MainAxisAlignment.end, 
          
                  children: [
                    Text("Find your friends",style:TextStyle(color: Colors.white,fontSize: 20)),
                  ],
                ))
            ],
            
                ),

                
                Container(
                  decoration: BoxDecoration(color: mPrimaryvLight),

                  child: Padding(
                    padding: EdgeInsets.all(20),

                    child: Container(
                      height: 110,

                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          SizedBox(height: 5),
                          Row(children: _users.map((e) => SuggestedUsers(e)).toList())
                        ],
                      ),
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
    return Container(
      child: AspectRatio(
        aspectRatio: 1 / 1,
        child: Container(
          margin: EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(
                image: AssetImage('assets/images/profile${this.user.id}.jpg'),
                fit: BoxFit.cover),
          ),
                   
        
        ),
        
      ),

    );
    
  }
}
