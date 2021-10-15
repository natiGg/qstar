import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qstar/screen/profile/widgets/bottomsheet/app_context.dart';

import 'package:qstar/screen/profile/widgets/profile_tab_bar.dart';
import 'package:qstar/screen/profile/widgets/profile_widgets.dart';
import 'package:qstar/screen/profile/widgets/textfield_widget.dart';

import 'package:qstar/screen/profile/widgets/bottomsheet/bottom_sheet_action.dart';
import 'package:qstar/widget/utils.dart';

import 'package:qstar/screen/profile/widgets/insta_app_bar.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:qstar/constant.dart';
import 'package:flutter/gestures.dart';



class EditProfilePage extends StatefulWidget {
  const EditProfilePage({ Key? key }) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 100,
        backgroundColor: Colors.white,
        leading: Container(
          padding: EdgeInsets.only(left: 20, top: 15),
          width: 100,
          child: Text(
            "User Name",
            style: TextStyle(
              color: mPrimaryColor,
              fontSize: 23,
              fontFamily: 'font1',
            ),
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
              },
              icon: Icon(Icons.menu),
              color: mPrimaryColor)
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              
              SizedBox(
                height: 15,
              ),
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 4,
                              color: Theme.of(context).scaffoldBackgroundColor),
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 2,
                                blurRadius: 10,
                                color: Colors.black.withOpacity(0.1),
                                offset: Offset(0, 10))
                          ],
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                "https://images.pexels.com/photos/3307758/pexels-photo-3307758.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=250",
                              ))),
                    ),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 4,
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                            color: mPrimaryColor,
                          ),
                          child: Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                        )),
                    
                  ],
                ),
              ),
                  Center(child:Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                "Betty G zonozonka",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
                  ) ,)
                  ,
              SizedBox(
                height: 35,
              ),
                              const SizedBox(height: 24),
                TextFieldWidget(
                  label: 'Full Name',
                  text: "nati",
                  onChanged: (name) {},
                ),
                Container(
            padding: const EdgeInsets.all(8),
            alignment: Alignment.center,
            child: RichText(
              text: TextSpan(style: TextStyle(color: Colors.grey), children: [
                TextSpan(text: "Help people disocver your account by using the name you're known by: either your full name,nickname or business name"),
              
              ]),
            ),
          ),
          const SizedBox(height:2),
           Container(
            padding: EdgeInsets.all(8),
            alignment: Alignment.centerLeft,
            child: RichText(
              text: TextSpan(style: TextStyle(color: Colors.grey), children: [
                TextSpan(text: "you can only change your name twice within 14 days"),
              
              ]),
            ),
          ),


                  const SizedBox(height: 24),
                TextFieldWidget(
                  label: 'Username',
                  text: "natiG",
                  onChanged: (email) {},
                ),
                Container(
            padding: const EdgeInsets.all(8),
            alignment: Alignment.center,
            child: RichText(
              text: TextSpan(style: TextStyle(color: Colors.grey), children: [
                TextSpan(text: "In most cases,you'll be able to change your username back to natig for another 14 days."),
                TextSpan(
                  text: 'Findout more',
                  style: TextStyle(
                    color: mPrimaryColor,
                  ),
                
                  recognizer: TapGestureRecognizer()..onTap = () {
                    Navigator.pop(context);
                  },
                ),
              
              ]),
            ),
          ),
                  const SizedBox(height: 24),
                TextFieldWidget(
                  label: 'About',
                  text: "mnshe nw",
                  onChanged: (email) {},
                ),
             const SizedBox(height: 24),
                TextFieldWidget(
                  label: 'Website',
                  text: "mnshe nw",
                  onChanged: (email) {},
                ),
                  Container(
            padding: const EdgeInsets.all(8),
            alignment: Alignment.center,
            child: RichText(
              text: TextSpan(style: TextStyle(color: Colors.grey), children: [
                TextSpan(text: "In most cases,you'll be able to change your username back to natig for another 14 days."),

              ]),
            ),
          ),
              SizedBox(
                height: 35,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 35,
                  ),
                  RaisedButton.icon(
                    onPressed: () {
                      
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    label: Text(
                      'Update Profile',
                      style: TextStyle(color: Colors.white),
                    ),
                    icon: Icon(
                      Icons.update,
                      color: Colors.white,
                    ),
                    textColor: mPrimaryColor,
                    splashColor: Colors.white,
                    color: mPrimaryColor,
                  ),
                  RaisedButton.icon(
                    onPressed: () {},
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    label: Text(
                      'Cancel  ',
                      style: TextStyle(color: mPrimaryColor),
                    ),
                    icon: Icon(
                      Icons.cancel,
                      color: mPrimaryColor,
                    ),
                    textColor: mPrimaryColor,
                    splashColor: mPrimaryColor,
                    color: Colors.white,
                  ), 
                  SizedBox(
                    height: 35,
                  ),
                ],
              ) ],
          ),
        ),
      ),
    );
  }

 
}