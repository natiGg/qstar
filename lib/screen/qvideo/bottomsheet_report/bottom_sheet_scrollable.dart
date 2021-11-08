import 'package:flutter/material.dart';

import 'bottom_sheet_action_widget.dart';

import 'bottom_sheet_action.dart';

class BottomSheetScrollable extends StatelessWidget {
  final List<BottomSheetAction> actions;
  final ScrollController scrollController;

  // ignore: use_key_in_widget_constructors
  const BottomSheetScrollable(
      {required this.actions, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 100),
          child: Container(
            width: 64,
            height: 4,
            decoration: ShapeDecoration(
                shape: const StadiumBorder(),
                color: Theme.of(context).dialogBackgroundColor),
          ),
        ),
        Expanded(
            child: Container(
          padding: const EdgeInsets.only(top: 16),
          decoration: ShapeDecoration(
              shape: const RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(16))),
              color: Theme.of(context).dialogBackgroundColor),
          child: Material(
            color: Theme.of(context).dialogBackgroundColor,
            child: SafeArea(
                child: ListView(
              shrinkWrap: true,
              controller: scrollController,
              children: actions
                  .map((action) => BottomSheetActionWidget(action))
                  .toList(),
            )),
          ),
        ))
      ],
    );
  }
}
