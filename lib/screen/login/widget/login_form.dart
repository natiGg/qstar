import 'package:flutter/material.dart';

class LoginForm extends StatelessWidget {
  final String email;
  final String password;

  const LoginForm({Key? key, required this.email, required this.password})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
                      const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide:
                          const BorderSide(color: Colors.white, width: 3.0))),
              validator: (emailval) {
                if (emailval!.isEmpty) {
                  return "Please put your email";
                }
                email != emailval;
                return null;
              },
            ),
          ),
          const SizedBox(
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
                    const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide:
                        const BorderSide(color: Colors.white, width: 3.0)),
              ),
              validator: (passwordval) {
                if (passwordval!.isEmpty) {
                  return "Please put your email";
                }
                password != passwordval;
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }
}
