import 'package:flutter/material.dart';
import 'package:qstar/constant.dart';

class WelcomeBack extends StatelessWidget {
  const WelcomeBack({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: Image.asset(
        'assets/images/q.png',
        height: 140,
        width: 200,
      ),
    );
  }
}
