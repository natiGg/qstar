import 'dart:ui';
import 'dart:convert';
// ignore_for_file: deprecated_member_use, duplicate_ignore

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:qstar/constant.dart';
import 'package:qstar/screen/feed/feed.dart';
import 'package:qstar/screen/login/widget/login_button.dart';
import 'package:qstar/screen/login/widget/login_form.dart';
import 'package:qstar/screen/login/widget/welcome_back.dart';
import 'package:qstar/screen/register/register_screen.dart';
import 'package:qstar/screen/api/network_utils/api.dart';
import 'forgotpassword.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:qstar/constant.dart';
import 'package:qstar/screen/feed/feed.dart';
import 'package:qstar/screen/main/main_screen.dart';
import 'package:qstar/screen/splash/recommend_users.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  var email;
  var password;
  @override
  Widget build(BuildContext context) {
    Future<bool> _onBackPressed() async {
      // This dialog will exit your app on saying yes
      return (await showDialog(
            context: context,
            builder: (context) => new AlertDialog(
              title: new Text('Are you sure?'),
              content: new Text('Do you want to exit an App'),
              actions: <Widget>[
                new FlatButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: new Text('No'),
                ),
                new FlatButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: new Text('Yes'),
                ),
              ],
            ),
          )) ??
          false;
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: WillPopScope(
        onWillPop: _onBackPressed,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              WelcomeBack(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                ),
                child: Column(
                  children: <Widget>[
                    Material(
                      elevation: 20.0,
                      shadowColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0)),
                      child: TextFormField(
                        obscureText: false,
                        decoration: InputDecoration(
                            prefixText: "@",
                            hintText: "Username",
                            fillColor: Colors.white,
                            filled: true,
                            contentPadding:
                                EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide: BorderSide(
                                    color: Colors.white, width: 3.0))),
                        validator: (emailval) {
                          if (emailval!.isEmpty) {
                            return "Please put your email";
                          }
                          email = emailval.toString();
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Material(
                      elevation: 20.0,
                      shadowColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0)),
                      child: TextFormField(
                        obscureText: true,
                        autofocus: false,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          fillColor: Colors.white,
                          filled: true,
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide:
                                  BorderSide(color: Colors.white, width: 3.0)),
                        ),
                        validator: (passwordval) {
                          if (passwordval!.isEmpty) {
                            return "Please put your email";
                          }
                          password = passwordval.toString();
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation1, animation2) {
                          return Forgotpassword();
                        },
                      ),
                    );
                  },
                  child: Text(
                    'Forgot password?',
                    style: TextStyle(color: mPrimaryColor),
                  ),
                ),
              ),
              SizedBox(
                height: 60,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(36),
                  ),
                  color: mPrimaryColor,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _login();
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    alignment: Alignment.center,
                    child:_isLoading==false? Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ):
                  Container(
                    height: 20,
                    width: 20,
                    child: Center(
                    
          child:  CircularProgressIndicator(
            color: Colors.white,
          ),
          ),
                  ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 16,
                ),
                alignment: Alignment.center,
                child: RichText(
                  text:
                      TextSpan(style: TextStyle(color: Colors.grey), children: [
                    TextSpan(text: 'Don\'t you have an account? '),
                    TextSpan(
                      text: 'Signup',
                      style: TextStyle(
                        color: mPrimaryColor,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation1, animation2) {
                                return RegisterScreen();
                              },
                            ),
                          );
                        },
                    ),
                  ]),
                ),
              ),
              
            ],
          ),
        ),
      ),
    );
  }

  void _login() async {
    print(password);
    setState(() {
      _isLoading = true;
    });
    var data = {'username': email, 'password': password};
    var res = await Network().authData(data, "login");
    var body = json.decode(res.body);
    print(body.toString());

    if (res.statusCode == 200) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('token', json.encode(body['token']));
      localStorage.setString('user', json.encode(body['user']));

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MyHomePage(),
        ),
      );
    } else if (body["message"] == "Invalid login credentials!") 
    {
      showDialog(
            context: context,
            builder: (context) => new AlertDialog(
              title: new Text('Are you sure?'),
              content: new Text(body["message"]),
              actions: <Widget>[
                new FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                    setState(() {
                      _isLoading=false;
                    });
                  } ,
                  child: new Text('ok'),
                ),
              ],
            ),
          ) ??
          false;
    }
  }
}
