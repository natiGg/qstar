import 'package:flutter/material.dart';
import 'package:qstar/screen/login/widget/input_text_field.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
            ),
          ),
        ],
      ),
    );
  }
}
