// ignore_for_file: unused_local_variable

import 'dart:io';
import 'dart:typed_data';
import 'package:photofilters/filters/filters.dart';
import 'package:photofilters/photofilters.dart';
import 'package:qstar/constant.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:qstar/screen/post/camera_screen.dart';
import 'package:path/path.dart';
import 'package:image/image.dart' as imageLib;

class PreviewImageScreen extends StatefulWidget {
  final String imagePath;

  const PreviewImageScreen({required this.imagePath});

  @override
  _PreviewImageScreenState createState() => _PreviewImageScreenState();
}

class _PreviewImageScreenState extends State<PreviewImageScreen> {
  List<Filter> filters = presetFiltersList;
  imageLib.Image? _image;
  late String fileName;
  late Filter _filter;

  @override
  void initState() {
    super.initState();
    getImage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: mPrimaryColor,
            onPressed: () {
              Navigator.popUntil(context, (route) => route.isFirst);
            }),
        title: Text(
          "Preview",
          style: TextStyle(
            color: mPrimaryColor,
            fontSize: 27,
            fontFamily: 'font1',
          ),
        ),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.check),
            iconSize: 30.0,
            color: mPrimaryColor,
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
                flex: 2,
                child: Image.file(File(widget.imagePath), fit: BoxFit.fill)),
            SizedBox(height: 5.0),
            Flexible(
              flex: 1,
              child: Container(
                alignment: Alignment(0.0, 0.0),
                child: _image == null
                    ? new Text('filter unavalable.')
                    // ignore: unnecessary_new
                    : new PhotoFilterSelector(
                        title: Text("f"),
                        image: _image!,
                        filters: presetFiltersList,
                        filename: fileName,
                        loader: Center(child: CircularProgressIndicator()),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<ByteData> getBytesFromFile() async {
    Uint8List bytes = File(widget.imagePath).readAsBytesSync() as Uint8List;
    return ByteData.view(bytes.buffer);
  }

  void getImage() async {
    setState(() {
      //var image = imageLib.decodeImage(Image.file(File(widget.imagePath).readAsBytesSync());
      _image = widget.imagePath as imageLib.Image?;
    });
  }
}
