import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:qstar/constant.dart';

class ProfileTabBar extends StatefulWidget implements PreferredSizeWidget {
  final double height;
  final ValueChanged<int> onTap;

  ProfileTabBar({
    required this.height,
    required this.onTap,
    Color? color,
  });

  @override
  _ProfileTabBarState createState() => _ProfileTabBarState();

  @override
  Size get preferredSize => Size.fromHeight(height);
}

class _ProfileTabBarState extends State<ProfileTabBar> {
  bool isTv = false;

  final Color _selectedColor = Colors.white;
  final Color _unSelectedColor = Colors.black;

  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: widget.height,
      color: mPrimaryColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          GestureDetector(
            child: Container(
              color: mPrimaryColor,
              width: _screenWidth / 3,
              height: widget.height,
              child: Stack(
                children: <Widget>[
                  Align(
                    child: Icon(
                      Feather.tv,
                      color: isTv ? _selectedColor : _unSelectedColor,
                    ),
                  ),
                  isTv
                      ? Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            height: 2,
                            color: mPrimaryColor,
                          ),
                        )
                      : SizedBox(),
                ],
              ),
            ),
            onTap: () {
              if (!isTv) {
                setState(() {
                  setFlags(tabName: 'tv');
                  widget.onTap(1);
                });
              }
            },
          ),
        ],
      ),
    );
  }

  setFlags({required String tabName}) {
    switch (tabName) {
      case 'tv':
        isTv = true;

        break;
    }
  }
}
