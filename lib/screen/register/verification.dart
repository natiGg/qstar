// ignore_for_file: deprecated_member_use

import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:qstar/constant.dart';

import 'package:pin_code_fields/pin_code_fields.dart';

import 'dart:async';

class Verification extends StatefulWidget {
  const Verification({Key? key}) : super(key: key);

  @override
  _SetPState createState() => _SetPState();
}

class _SetPState extends State<Verification> {
  TextEditingController textEditingController = TextEditingController();
  // ..text = "123456";

  // ignore: close_sinks
  StreamController<ErrorAnimationType>? errorController;

  bool hasError = false;
  String currentText = "";
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController!.close();

    super.dispose();
  }

  // snackBar Widget
  snackBar(String? message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message!),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
      color: Colors.white,
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment:
            MainAxisAlignment.center, //Center Column contents vertically,
        children: <Widget>[
          const SizedBox(height: 8),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              "Phone Number Verification",
              style: TextStyle(
                // we use the [TextStyle] widget to customize text
                color: mPrimaryColor, // set the color
                fontSize: 25.0,
                fontFamily: 'font1', // and the font size
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            "Enter the code sent to: the phone number you enterd",
            style: TextStyle(
              // we use the [TextStyle] widget to customize text
              color: mPrimaryColor, // set the color
              fontSize: 10.0, // and the font size
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Form(
            key: formKey,
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 30),
                child: PinCodeTextField(
                  appContext: context,
                  pastedTextStyle: const TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                  length: 6,
                  obscureText: false,
                  obscuringCharacter: '*',

                  blinkWhenObscuring: true,
                  animationType: AnimationType.fade,
                  validator: (v) {
                    if (v!.length < 3) {
                      return " validator";
                    } else {
                      return null;
                    }
                  },
                  pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 50,
                      fieldWidth: 40,
                      activeFillColor: Colors.white,
                      activeColor: Colors.white,
                      inactiveColor: mPrimaryColor,
                      inactiveFillColor: Colors.white,
                      selectedFillColor: Colors.white,
                      selectedColor: mPrimaryColor),
                  cursorColor: Colors.black,
                  animationDuration: const Duration(milliseconds: 300),
                  enableActiveFill: true,
                  errorAnimationController: errorController,
                  controller: textEditingController,
                  keyboardType: TextInputType.number,
                  boxShadows: const [
                    BoxShadow(
                      offset: Offset(0, 1),
                      color: Colors.black12,
                      blurRadius: 10,
                    )
                  ],
                  onCompleted: (v) {
                    // ignore: avoid_print
                    print("Completed");
                  },
                  // onTap: () {
                  //   print("Pressed");
                  // },
                  onChanged: (value) {
                    // ignore: avoid_print
                    print(value);
                    setState(() {
                      currentText = value;
                    });
                  },
                  beforeTextPaste: (text) {
                    // ignore: avoid_print
                    print("Allowing to paste $text");
                    //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                    //but you can show anything you want here, like your pop up saying wrong paste format or etc
                    return true;
                  },
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 350.0),
            child: Flexible(
                child: TextButton(
              child: const Text(
                "Clear",
                style: TextStyle(color: mPrimaryColor),
              ),
              onPressed: () {
                textEditingController.clear();
              },
            )),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Text(
              hasError ? "*Please fill up all the cells properly" : "",
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w400),
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Didn't receive the code? ",
                style: TextStyle(color: Colors.black54, fontSize: 15),
              ),
              TextButton(
                  onPressed: () => snackBar("OTP resend!!"),
                  child: const Text(
                    "RESEND",
                    style: TextStyle(
                        color: mPrimaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ))
            ],
          ),
          const SizedBox(
            height: 14,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(36),
              ),
              color: mPrimaryColor,
              onPressed: () {
                // Navigator.push(
                //   context,
                //   PageRouteBuilder(
                //     pageBuilder: (context, animation1, animation2) {
                //       return Hobbieselector();
                //     },
                //   ),
                // );
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

          // Container(
          //   margin:
          //       const EdgeInsets.symmetric(vertical: 16.0, horizontal: 30),
          //   child: ButtonTheme(
          //     height: 50,
          //     child: TextButton(
          //       onPressed: () {
          //         formKey.currentState!.validate();
          //         // conditions for validating
          //         if (currentText.length != 6 || currentText != "123456") {
          //           errorController!.add(ErrorAnimationType
          //               .shake); // Triggering error shake animation
          //           setState(() => hasError = true);
          //         } else {
          //           setState(
          //             () {
          //               hasError = false;
          //               snackBar("OTP Verified!!");
          //             },
          //           );
          //         }
          //       },
          //       child: Center(
          //           child: Text(
          //         "VERIFY".toUpperCase(),
          //         style: TextStyle(
          //             color: Colors.white,
          //             fontSize: 18,
          //             fontWeight: FontWeight.bold),
          //       )),
          //     ),
          //   ),
          //   decoration: BoxDecoration(
          //       color: Colors.green.shade300,
          //       borderRadius: BorderRadius.circular(5),
          //       boxShadow: [
          //         BoxShadow(
          //             color: Colors.green.shade200,
          //             offset: Offset(1, -2),
          //             blurRadius: 5),
          //         BoxShadow(
          //             color: Colors.green.shade200,
          //             offset: Offset(-1, 2),
          //             blurRadius: 5)
          //       ]),
          // ),
          const SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }
}
