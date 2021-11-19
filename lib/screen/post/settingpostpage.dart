import 'dart:io';

import 'package:flutter/material.dart';
import 'location_selector_widget.dart';
import 'post_create_view_model.dart';

import 'package:qstar/constant.dart';
import 'write_caption_widget.dart';

import 'package:qstar/screen/post/tag.dart';
import 'package:qstar/screen/post/location.dart';
import 'package:qstar/screen/post/setting.dart';

class SettingPostPage extends StatefulWidget {
  // ignore: constant_identifier_names
  static const ROUTE_NAME = 'SettingPostPage';
  final String imagePath;

  // ignore: use_key_in_widget_constructors
  const SettingPostPage({required this.imagePath});

  @override
  _SettingPostPageState createState() => _SettingPostPageState();
}

class _SettingPostPageState extends State<SettingPostPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: mPrimaryColor,
            onPressed: () {
              Navigator.popUntil(context, (route) => route.isFirst);
            }),
        title: const Text(
          "New Post",
          style: TextStyle(
            color: mPrimaryColor,
            fontSize: 27,
            fontFamily: 'font1',
          ),
        ),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.check),
            iconSize: 30.0,
            color: mPrimaryColor,
            onPressed: () {},
          ),
        ],
      ),
      body: Column(children: [
        Expanded(flex: 2, child: Image.file(File(widget.imagePath))),
        const SizedBox(height: 5.0),
        Column(
          children: [
            const WriteCaptionWidget(),
            SizedBox(
              height: MediaQuery.of(this.context).viewInsets.bottom,
            ),
            const Divider(
              height: 1,
            ),
            ListTile(
              title: const Text('Tag People'),
              dense: true,
              onTap: () {},
            ),
            const Divider(
              height: 1,
            ),
            ListTile(
              title: const Text('Add Location'),
              dense: true,
              onTap: () {},
            ),
            const Divider(
              height: 1,
            ),
            ListTile(
              title: const Text('Setting'),
              dense: true,
              onTap: () {
                Navigator.push(
                  this.context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) =>
                        const SettingsScreen(),
                    transitionDuration: Duration.zero,
                  ),
                );
              },
            ),
          ],
        ),
      ]),
    );
  }
}
