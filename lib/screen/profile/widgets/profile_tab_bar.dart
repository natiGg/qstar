// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:qstar/constant.dart';

class ProfileTabBar extends StatefulWidget implements PreferredSizeWidget {
  final double height;
  final ValueChanged<int> onTap;

  // ignore: use_key_in_widget_constructors
  const ProfileTabBar({
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
  bool isPost = true;
  bool isTv = false;
  bool isTag = false;

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
                        Icons.grid_on,
                        color: isPost ? _selectedColor : _unSelectedColor,
                      ),
                    ),
                    isPost
                        ? Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              height: 2,
                              color: mPrimaryColor,
                            ),
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
              onTap: () {
                if (!isPost) {
                  setState(() {
                    setFlags(tabName: 'post');
                    widget.onTap(0);
                  });
                }
              }),
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
                      : const SizedBox(),
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
          GestureDetector(
            child: Container(
              color: mPrimaryColor,
              width: _screenWidth / 3,
              height: widget.height,
              child: Stack(
                children: <Widget>[
                  Align(
                    child: Icon(
                      Feather.save,
                      color: isTag ? _selectedColor : _unSelectedColor,
                    ),
                  ),
                  isTag
                      ? Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            height: 2,
                            color: mPrimaryColor,
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
            ),
            onTap: () {
              if (!isTag) {
                setState(() {
                  setFlags(tabName: 'tag');
                  widget.onTap(2);
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
      case 'post':
        isTv = false;
        isTag = false;
        isPost = true;
        break;

      case 'tv':
        isTv = true;
        isTag = false;
        isPost = false;
        break;

      case 'tag':
        isTv = false;
        isTag = true;
        isPost = false;
        break;
    }
  }
}
