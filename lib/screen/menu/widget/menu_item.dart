import 'package:flutter/material.dart';
import 'package:qstar/constant.dart';
import 'package:qstar/screen/preferences/preferences_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MenuItem extends StatelessWidget {
  const MenuItem({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return PreferencesScreen(index);
            },
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(30),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: mPrimaryTextColor.withOpacity(0.2),
              width: 1,
            ),
          ),
        ),
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 55,
              height: 55,
              child: SvgPicture.asset('assets/icons/${coffeeNames[index]}.svg'),
            ),
            const SizedBox(
              width: 30,
            ),
            Expanded(
              child: Text(
                coffeeNames[index],
                style: TextStyle(
                  color: mTitleTextColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const Icon(
              Icons.keyboard_arrow_right,
              color: mPrimaryColor,
            )
          ],
        ),
      ),
    );
  }
}
