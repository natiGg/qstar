// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:qstar/constant.dart';

import 'package:qstar/screen/register/email.dart';

class Username extends StatefulWidget {
  const Username({Key? key}) : super(key: key);

  @override
  State<Username> createState() => _UsernameState();
}

class _UsernameState extends State<Username> {
  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
      color: Colors.white,
    );

    List<String> _kOptions = <String>[
      'aardvark',
      'bobcat',
      'chameleon',
    ];

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        mainAxisAlignment:
            MainAxisAlignment.center, //Center Column contents vertically,
        children: <Widget>[
          const Text(
            "Your username",
            style: TextStyle(
              // we use the [TextStyle] widget to customize text
              color: mPrimaryColor, // set the color
              fontSize: 25.0,
              fontFamily: 'font1', // and the font size
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            "Your username is how friends find you on Q star",
            style: TextStyle(
              // we use the [TextStyle] widget to customize text
              color: mPrimaryColor, // set the color
              fontSize: 10.0, // and the font size
            ),
          ),
          // Container(
          //   padding: const EdgeInsets.symmetric(
          //     vertical: 20,
          //     horizontal: 30,
          //   ),
          //   child: Material(
          //     elevation: 20.0,
          //     shadowColor: Colors.white,
          //     shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(25.0)),
          //     child: TextFormField(
          //       obscureText: false,
          //       controller: _controller,
          //       autofocus: true,
          //       decoration: InputDecoration(
          //           prefixText: "@",
          //           fillColor: Colors.white,
          //           filled: true,
          //           contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          //           enabledBorder: OutlineInputBorder(
          //               borderRadius: BorderRadius.circular(25.0),
          //               borderSide:
          //                   BorderSide(color: Colors.white, width: 3.0))),
          //     ),

          //   ),
          // ),
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
              child: InputDecorator(
                decoration: InputDecoration(
                  prefixText: "@",
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding:
                      const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide:
                          const BorderSide(color: Colors.white, width: 3.0)),
                  hintText: "Search..",
                ),
                child: Autocomplete(
                  optionsBuilder: (TextEditingValue textEditingValue) {
                    if (textEditingValue.text == '') {
                      return const Iterable<String>.empty();
                    }
                    return _kOptions.where((String option) {
                      return option
                          .contains(textEditingValue.text.toLowerCase());
                    });
                  },
                  //   onSelected: (User selection) {
                  //   //   print(
                  //   //       'You just selected ${_displayStringForOption(selection)}');
                  //   // },
                  // ),
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 45,
              vertical: 16,
            ),
            alignment: Alignment.center,
          ),

          const SizedBox(
            height: 30,
          ),
          // Text(_selectedAnimal != null
          //     ? _selectedAnimal
          //     : 'Type something (a, b, c, etc)'),
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
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) {
                      return const Email();
                    },
                  ),
                );
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
    );
  }
}
