import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:qstar/constant.dart';
import 'package:qstar/screen/register/Privacypolicy.dart';
import 'package:qstar/screen/register/termsofservice.dart';
import 'package:qstar/screen/register/birthday.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  // ignore: prefer_typing_uninitialized_variables
  var fname;
  // ignore: prefer_typing_uninitialized_variables
  var lname;
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
                          contentPadding:
                              const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: const BorderSide(
                                  color: Colors.white, width: 3.0))),
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
                          contentPadding:
                              const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: const BorderSide(
                                  color: Colors.white, width: 3.0))),
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
            ),
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
                                  return const Privacypolicy();
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
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              // ignore: deprecated_member_use
              child: FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(36),
                ),
                color: mPrimaryColor,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
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
                  child: const Text(
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
}
