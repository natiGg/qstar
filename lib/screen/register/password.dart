// ignore_for_file: deprecated_member_use
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:qstar/constant.dart';
import 'package:qstar/screen/api/network_utils/api.dart';
import 'package:qstar/screen/register/hobbieselector.dart';
import 'package:qstar/screen/register/suggested.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:qstar/screen/register/phone.dart';

class Password extends StatefulWidget {
  final String fname;
  final String lname;
  final String date;
  final String email;
  final String uname;
  const Password(
      {Key? key,
      required this.fname,
      required this.lname,
      required this.date,
      required this.email,
      required this.uname})
      : super(key: key);

  @override
  _SetPState createState() => _SetPState();
}

class _SetPState extends State<Password> {
  bool _isObscure = true;
  bool _isLoading = true;
  final _formKey = GlobalKey<FormState>();
  var password;

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
      color: Colors.white,
    );
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center, //Center Column contents vertically,
          children: <Widget>[
            Text(
              "Set password",
              style: TextStyle(
                // we use the [TextStyle] widget to customize text
                color: mPrimaryColor, // set the color
                fontSize: 25.0,
                fontFamily: 'font1', // and the font size
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Your password should at least contain 8 characters",
              style: TextStyle(
                // we use the [TextStyle] widget to customize text
                color: mPrimaryColor, // set the color
                fontSize: 10.0, // and the font size
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 30,
              ),
              child: Material(
                elevation: 20.0,
                shadowColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0)),
                child: TextFormField(
                  obscureText: _isObscure,
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
                      suffixIcon: IconButton(
                          icon: Icon(_isObscure
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              _isObscure = !_isObscure;
                            });
                          })),
                  validator: (passwordval) {
                    if (passwordval!.isEmpty) {
                      return "Please put your email";
                    }
                    password = passwordval.toString();
                    return null;
                  },
                ),
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
                  if (_formKey.currentState!.validate()) 
                  {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation1, animation2) {
    
                          return Hobbieselector(
                              fname: widget.fname,
                              lname: widget.lname,
                              date: widget.date,
                              email: widget.email,
                              uname: widget.uname,
                              password: password,);
                        },
                      ),
                    );

                  }
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
      ),
    );
  }

  void _register() async {
    setState(() {
      _isLoading = true;
    });
    var data = {
      'name': widget.fname,
      'email': widget.email,
      'username': widget.uname,
      'password': password,
      'password_confirmation': password,
      'hobbies': "playing games"
    };

    var res = await Network().authData(data, 'register/email');
    var body = json.decode(res.body);
    print(body);
    if (res.statusCode == 200) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('token', json.encode(body['token']));
      localStorage.setString('user', json.encode(body['user']));
      Navigator.push(
        context,
        new MaterialPageRoute(builder: (context) => Suggested()),
      );
    }

    setState(() {
      _isLoading = false;
    });
  }
}
