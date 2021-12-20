import 'package:flutter/cupertino.dart';

class BottomSheetAction {
  // ignore: constant_identifier_names
  static const TAG = 'BottomSheetAction';

  IconData iconData;

  String title;

  int id;

  BottomSheetAction({
    required this.iconData,
    required this.title,
    required this.id,
  });
}

class BottomSheetAction2 {
  // ignore: constant_identifier_names
  static const TAG = 'BottomSheetAction';

  IconData iconData;

  String title;

  int id;
  String unFlwid;

  BottomSheetAction2({
    required this.iconData,
    required this.title,
    required this.id,
    required this.unFlwid
  });
}
