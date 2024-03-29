import 'package:flutter/material.dart';
import 'package:qstar/constant.dart';
import 'package:qstar/screen/preferences/widget/attribute.dart';
import 'package:qstar/screen/preferences/widget/header.dart';
import 'package:qstar/screen/preferences/widget/name_and_number.dart';
import 'package:qstar/screen/preferences/widget/total_price.dart';
import 'package:qstar/widget/round_button.dart';

class PreferencesScreen extends StatelessWidget {
  final int index;

  // ignore: use_key_in_widget_constructors
  const PreferencesScreen(this.index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: buildAppBar(context),
      body: Column(
        children: <Widget>[
          Header(index: index),
          NameAndNumber(index: index),
          Divider(
            color: mPrimaryTextColor.withOpacity(0.5),
          ),
          const Attribute(
            title: 'Size',
            iconNames: [
              'size1',
              'size2',
              'size3',
            ],
            alignment: Alignment.bottomLeft,
            check: 1,
          ),
          Divider(
            color: mPrimaryTextColor.withOpacity(0.5),
          ),
          const Attribute(
            title: 'Sugar',
            iconNames: ['sugar1', 'sugar2', 'sugar3', 'sugar4'],
            check: 2,
          ),
          Divider(
            color: mPrimaryTextColor.withOpacity(0.5),
          ),
          const Attribute(
            title: 'Additions',
            iconNames: ['additions1', 'additions2'],
            check: 2,
          ),
          Divider(
            color: mPrimaryTextColor.withOpacity(0.5),
          ),
          const TotalPrice(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
            child: RoundButton(
              title: 'Add to cart',
              press: () {},
            ),
          )
        ],
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Text(
        'Preferences',
        style: TextStyle(
          color: mPrimaryTextColor,
        ),
      ),
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: mPrimaryTextColor,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
