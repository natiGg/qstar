import 'package:flutter/material.dart';
import 'package:qstar/constant.dart';

class Address extends StatelessWidget {
  const Address({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Address',
            style: TextStyle(
              color: mTitleTextColor,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 6,
          ),
          Text(
            '3 Michel Bakhoum\nDokki,Cairo',
            style: TextStyle(
              color: mTitleTextColor,
            ),
          )
        ],
      ),
    );
  }
}
