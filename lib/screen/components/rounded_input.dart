import 'package:flutter/material.dart';

import 'input_container.dart';

class RoundedInput extends StatelessWidget {
  const RoundedInput({
    Key? key,

    required this.icon,
     required this.hint
    

  }) : super(key: key);

  final IconData icon;
  final String hint;
  

  @override
  Widget build(BuildContext context) {
    return InputContainer(child:TextField(
      cursorColor: Colors.purple[700],
      decoration: InputDecoration(
        icon: Icon(Icons.email,color: Colors.purple[700],),
        hintText: hint,
        border: InputBorder.none
      )
      ,));
  }
}

