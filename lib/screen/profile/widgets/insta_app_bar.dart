import 'package:flutter/material.dart';

class InstaAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final bool isProfileScreen;
  final Widget leading;
  final Widget center;
  final Widget trailing;
  final Color backgroundColor;

  const InstaAppBar({
    required this.height,
    required this.leading,
    required this.center,
    required this.trailing,
    this.isProfileScreen = false,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20),
      height: height,
      // ignore: unnecessary_null_comparison
      color: backgroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: isProfileScreen
                ? Container()
                : Align(
                    alignment: Alignment.centerLeft,
                    child: leading,
                  ),
          ),
          Expanded(
            child: Align(
              child: center,
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: trailing,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
