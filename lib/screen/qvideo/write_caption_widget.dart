import 'package:flutter/material.dart';

class WriteCaptionWidget extends StatefulWidget {
  // ignore: constant_identifier_names
  static const ROUTE_NAME = 'WriteCaptionWidget';

  const WriteCaptionWidget({Key? key}) : super(key: key);
  @override
  _WriteCaptionWidgetState createState() => _WriteCaptionWidgetState();
}

class _WriteCaptionWidgetState extends State<WriteCaptionWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Row(
        children: [
          Expanded(
              child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Write a caption',
                  hintStyle: TextStyle(color: Colors.white)),
            ),
          )),
        ],
      ),
    );
  }
}
