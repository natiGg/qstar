import 'package:flutter/material.dart';

// In this tutorial we implement a multi page form
// based on the IndexedStack and TextField widgets.
//
// For detailed explanation and step by step guide,
// please have a look at the respective article
// on medium.com
//
//
//
// This tutorial follows 5 simple steps:
//
// Step 1 - Set Up The UI
// Step 2 - Switch Between TextFields
// Step 3 - Fetch User Input
// Step 4 - Validate User Input
// Step 5 - Save The Form

// Step 1 - Set Up The UI
void main() => runApp(MyApps());

class MyApps extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Multi Page Form'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  /// Tracks the active widget shown in the stack
  int _formIndex = 0;

  // Step 2 - Switch Between TextFields
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  // Step 3 - Fetch User Input
  var _email = '';
  var _password = '';

  // Step 4 - Validate User Input
  var _emailValid = false;
  var _emailError = '';
  var _passwordValid = false;
  var _passwordError = '';

  // Step 2 - Switch Between TextFields
  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  /// Switches InputField by setting [_formIndex] to [newIndex]
  void _switchInputField(int newIndex) {
    setState(() {
      _formIndex = newIndex;
    });
    newIndex == 0
        ? FocusScope.of(context).requestFocus(_emailFocusNode)
        : FocusScope.of(context).requestFocus(_passwordFocusNode);
  }

  // Step 4 - Validate User Input
  /// Checks if email input fits common email pattern
  void _validateEmail() {
    if (RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(_email)) {
      setState(() {
        _emailValid = true;
        _emailError = '';
      });
    } else {
      setState(() {
        _emailValid = false;
        _emailError = 'Please enter a valid email address';
      });
    }
  }

  /// Checks if password input has at least 5 characters
  void _validatePassword() {
    if (_password.length >= 5) {
      setState(() {
        _passwordValid = true;
        _passwordError = '';
      });
    } else {
      setState(() {
        _passwordValid = false;
        _passwordError = 'Your password should contain at least 5 characters';
      });
    }
  }

  // Step 5 - Save The Form
  void _saveForm() {
    print("saved");
    // implement your logic here
    // Future <builder> showDialog(
    //     context: context,
    //     child: SimpleDialog(
    //       contentPadding: EdgeInsets.all(8),
    //       children: <Widget>[
    //         Text('You succesfully saved your form.'),
    //         RaisedButton(
    //           onPressed: () => Navigator.pop(context),
    //           child: Text('Cool, thanks.'),
    //         ),
    //       ],
    //     ),
    //   );
  }

  // Step 1 - Set Up The UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Card(
          elevation: 4,
          child: Container(
            height: 160,
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                IndexedStack(
                  index: _formIndex,
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(labelText: 'eMail'),
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,

                      // Step 3 - Fetch User Input
                      onChanged: (value) {
                        setState(() {
                          _email = value;
                        });
                      },

                      // Step 4 - Validate User Input
                      onSubmitted: (value) {
                        _validateEmail();

                        // Step 2 - Switch Between TextFields
                        if (_emailValid) {
                          _switchInputField(_formIndex + 1);
                        }
                      },

                      // Step 2 - Switch Between TextFields
                      focusNode: _emailFocusNode,
                    ),
                    TextField(
                      decoration: InputDecoration(labelText: 'Password'),
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      textInputAction: TextInputAction.done,

                      // Step 3 - Fetch User Input
                      onChanged: (value) {
                        setState(() {
                          _password = value;
                        });
                      },

                      // Step 4 - Validate User Input
                      onSubmitted: (value) {
                        _validatePassword();
                        if (_passwordValid) {
                          _saveForm();
                        } else {
                          // Focus the TextField again after unsuccessful submit
                          FocusScope.of(context)
                              .requestFocus(_passwordFocusNode);
                        }
                      },

                      // Step 2 - Switch Between TextFields
                      focusNode: _passwordFocusNode,
                    ),
                  ],
                ),
                Container(
                  child: _formIndex == 0
                      ? Text(_emailError)
                      : Text(_passwordError),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    _formIndex == 0
                        ? Container()
                        : FlatButton(
                            onPressed: () {
                              _switchInputField(_formIndex - 1);
                            },
                            child: const Text('Back'),
                          ),

                    // Step 5 - Save The Form
                    _formIndex == 1
                        ? FlatButton(
                            onPressed: () {
                              _validatePassword();
                              if (_passwordValid) {
                                _saveForm();
                              }
                            },
                            child: const Text('Submit'),
                          )
                        : FlatButton(
                            onPressed: () {
                              _validateEmail();
                              if (_emailValid) {
                                // Step 2 - Switch Between TextFields
                                _switchInputField(_formIndex + 1);
                              }
                            },
                            child: const Text('Next'),
                          ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
