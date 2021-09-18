import 'dart:html';

import 'package:flutter/material.dart';
import "package:flutter_svg/svg.dart";

import 'components/rounded_input.dart';
import 'components/rounded_password_input.dart';
import 'components/rounded_button.dart';

class LoginScreen extends StatefulWidget {
    const LoginScreen({Key? key}):super(key: key);
  @override
  _LoginScreenState createState() => _LoginScreenState();

}
class _LoginScreenState extends State<LoginScreen>{


  @override 
  Widget build(BuildContext context){
    Size size =MediaQuery.of(context).size;
    double viewInset =MediaQuery.of(context).viewInsets.bottom;
    double defaultLongSize = size.height -(size.height*0.2);
    double defaultRegisterSize = size.height -(size.height*0.1);


    return  Scaffold(
      body: Stack(
        children: [
          //Login
          Align(
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Container(
                width:size.width,
                height: defaultLongSize,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                   const Text("Welcome",
                    style: TextStyle(
                      fontWeight:FontWeight.bold ,
                      fontSize: 24),
                    ),
                   const SizedBox(height:40),
                    SvgPicture.asset("assets/images/login.jpg"),
                   const SizedBox(height: 40,),
                  const  RoundedInput(icon: Icons.mail,hint: "Username",),
                  const  RoundedPasswordInput(icon: Icons.lock,hint: "password",),
                 const RoundedButton(title: 'Login')


                  ],)
                
                 ,) ,),
          ),
          //Register
        Align(
            alignment: Alignment.bottomCenter,
            child:  Container(
              width: double.infinity,
              height: size.height * 0.1,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(100),
                  topRight: Radius.circular(100),
                ),
                color: Colors.grey
              ),
              alignment: Alignment.center,
              child:GestureDetector(
                onTap: (){},
                child:Text(
                  "Don't have an accout? Sign up",
                  style: TextStyle(
                    color: Colors.purple[700],
                    fontSize: 18
                  ),
                ) 
                ,) 
                ,),
          )
        ],
      ),

    );
  }
}
