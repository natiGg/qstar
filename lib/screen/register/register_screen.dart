import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:qstar/constant.dart';
import 'package:qstar/screen/register/Privacypolicy.dart';
import 'package:qstar/screen/register/TermofService.dart';
import 'package:qstar/screen/register/birthday.dart';
import 'package:qstar/screen/register/widget/register_button.dart';
import 'package:qstar/screen/register/widget/register_form.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
    bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  var fname;
  var lname;
  @override
  Widget build(BuildContext context) {

     const textStyle = TextStyle(
      color: Colors.white,
    );
    return Scaffold(
      resizeToAvoidBottomInset: false,
<<<<<<< HEAD
      body: Form(
                  key: _formKey,

        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center, //Center Column contents vertically,
          children: <Widget>[
            Text(
              "Sign Up",
              style: TextStyle(
                // we use the [TextStyle] widget to customize text
                color: mPrimaryColor, // set the color
                fontSize: 32.0,
                fontFamily: 'font1', // and the font size
              ),
            ),
            SizedBox(height: 20),
      Container(
        padding: const EdgeInsets.symmetric(
          vertical: 20,
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
                autofocus: false,
                decoration: InputDecoration(
                    hintText: 'First Name',
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(color: Colors.white, width: 3.0))),
                          validator: (fnameval) {
                            if (fnameval!.isEmpty) {
                              return "Please put your firstname";
                            }
                            fname = fnameval.toString();
                            return null;
                          },
                        
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Material(
              elevation: 20.0,
              shadowColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0)),
              child: TextFormField(
                autofocus: false,
                decoration: InputDecoration(
                    hintText: 'Last Name',
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(color: Colors.white, width: 3.0))),
                                  validator: (lnameval) {
                            if (lnameval!.isEmpty) {
                              return "Please put your lastname";
                            }
                            lname = lnameval.toString();
                            return null;
                          },
              ),
            ),
          ],
        ),
          ),          Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 45,
                vertical: 16,
              ),
              alignment: Alignment.center,
              child: RichText(
                text: TextSpan(style: TextStyle(color: Colors.grey), children: [
                  TextSpan(
                      text:
                          'By tapping Next  & accept you acknowledge that you have read the'),
                  TextSpan(
                    text: ' Privacy policy',
                    style: TextStyle(
                      color: mPrimaryColor,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation1, animation2) {
                              return Privacypolicy();
                            },
                          ),
                        );
                      },
                  ),
                  TextSpan(text: ' and agree to the'),
                  TextSpan(
                    text: ' Term of Service',
                    style: TextStyle(
                      color: mPrimaryColor,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation1, animation2) {
                              return TermofService();
                            },
                          ),
                        );
                      },
                  ),
                ]),
              ),
=======
      body: Column(
        mainAxisAlignment:
            MainAxisAlignment.center, //Center Column contents vertically,
        children: <Widget>[
          const Text(
            "Sign Up",
            style: TextStyle(
              // we use the [TextStyle] widget to customize text
              color: mPrimaryColor, // set the color
              fontSize: 32.0,
              fontFamily: 'font1', // and the font size
            ),
          ),
          const SizedBox(height: 20),
          const RegisterForm(),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 45,
              vertical: 16,
            ),
            alignment: Alignment.center,
            child: RichText(
              text: TextSpan(
                  style: const TextStyle(color: Colors.grey),
                  children: [
                    const TextSpan(
                        text:
                            'By tapping Next  & accept you acknowledge that you have read the'),
                    TextSpan(
                      text: ' Privacy policy',
                      style: const TextStyle(
                        color: mPrimaryColor,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation1, animation2) {
                                return Privacypolicy();
                              },
                            ),
                          );
                        },
                    ),
                    const TextSpan(text: ' and agree to the'),
                    TextSpan(
                      text: ' Term of Service',
                      style: const TextStyle(
                        color: mPrimaryColor,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation1, animation2) {
                                return const TermofService();
                              },
                            ),
                          );
                        },
                    ),
                  ]),
>>>>>>> 57e38ff90290600f0e436d80119d372eef9f6169
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
                      print(fname+lname);
                    Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation1, animation2) {
                  return BirthDay(fname: fname, lname: lname);
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
<<<<<<< HEAD
          ],
        ),
=======
          const RegisterButton(),
        ],
>>>>>>> 57e38ff90290600f0e436d80119d372eef9f6169
      ),
    );
  }
}
