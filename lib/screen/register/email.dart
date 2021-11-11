// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:qstar/constant.dart';
import 'package:qstar/screen/register/phonevarification.dart';
import 'dart:convert';
import 'package:qstar/network_utils/api.dart';
import 'package:qstar/screen/register/password.dart';
import 'package:email_validator/email_validator.dart';

class Email extends StatefulWidget {
  final String fname;
  final String lname;
  final String date;
  final String uname;
  const Email(
      {Key? key,
      required this.fname,
      required this.lname,
      required this.date,
      required this.uname})
      : super(key: key);

  @override
  State<Email> createState() => _EmailState();
}

class _EmailState extends State<Email> {
  // ignore: prefer_typing_uninitialized_variables
  var email;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center, //Center Column contents vertically,
          children: <Widget>[
            const Text(
              "What's your email address",
              style: TextStyle(
                // we use the [TextStyle] widget to customize text
                color: mPrimaryColor, // set the color
                fontSize: 25.0,
                fontFamily: 'font1', // and the font size
              ),
            ),
            const SizedBox(height: 20),
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
                  autofocus: false,
                  decoration: InputDecoration(
                      hintText: 'Email',
                      fillColor: Colors.white,
                      filled: true,
                      contentPadding:
                          const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: const BorderSide(
                              color: Colors.white, width: 3.0))),
                  validator: (emailval) {
                    if (emailval!.isEmpty) {
                      return "Please put your email";
                    } else if (EmailValidator.validate(emailval) == false) {
                      return "invalid email";
                    }
                    email = emailval.toString();
                    return null;
                  },
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 45,
                vertical: 16,
              ),
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) {
                        return const Phonevarification();
                      },
                    ),
                  );
                },
                child: const Text(
                  "Sign up with phone instead",
                  style: TextStyle(
                    // we use the [TextStyle] widget to customize text
                    color: mPrimaryColor, // set the color
                    fontSize: 10.0, // and the font size
                  ),
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
                  if (_formKey.currentState!.validate()) {
                    _checkEmail();
                  }
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  alignment: Alignment.center,
                  child: _isLoading == false
                      ? const Text(
                          'Next',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        )
                      : const Text(
                          'Checking...',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _checkEmail() async {
    setState(() {
      _isLoading = true;
    });
    var data = {'email': email};
    var res = await Network().authData(data, "validateEmail");
    var body = json.decode(res.body);
    // ignore: avoid_print

    if (res.statusCode == 200) {
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) {
            return Password(
                fname: widget.fname,
                lname: widget.lname,
                date: widget.date,
                email: email,
                uname: widget.uname);
          },
        ),
      );
    } else if (res.statusCode == 422) {
      Map<String, dynamic> map = body["errors"];
      List<dynamic> data = map["email"];

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('info'),
          content: Text(data[0].toString()),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop(true);
                setState(() {
                  _isLoading = false;
                });
              },
              child: const Text('ok'),
            ),
          ],
        ),
      );
    }
  }
}
