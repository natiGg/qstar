// ignore_for_file: unused_local_variable

import 'dart:io';
import 'dart:typed_data';
import 'package:photofilters/filters/filters.dart';
import 'package:photofilters/photofilters.dart';
import 'package:qstar/constant.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:qstar/screen/post/camera_screen.dart';
import 'package:qstar/screen/post/setting_post_page.dart';
import 'package:path/path.dart';
import 'package:image/image.dart' as imageLib;
import 'package:uri_to_file/uri_to_file.dart';

class PreviewImageScreen extends StatefulWidget {
  final String imagePath;

  const PreviewImageScreen({required this.imagePath});

  @override
  _PreviewImageScreenState createState() => _PreviewImageScreenState();
}

class _PreviewImageScreenState extends State<PreviewImageScreen> {
  late String fileName;
  List<Filter> filters = presetFiltersList;
  File? imageFile;

  @override
  void initState() {
    super.initState();
    getImage(context);
  }

  Future getImage(context) async {
    //  imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    Uri uri = Uri.parse(widget.imagePath.toString());
    fileName = basename(widget.imagePath);

    imageFile = await toFile(uri);

    var image = imageLib.decodeImage(imageFile!.readAsBytesSync());
    image = imageLib.copyResize(image!, width: 600);
    Map imagefile = await Navigator.push(
      context,
      new MaterialPageRoute(
        builder: (context) => new PhotoFilterSelector(
          title: Text("Photo Filter "),
          image: image!,
          filters: presetFiltersList,
          filename: fileName,
          loader: Center(child: CircularProgressIndicator()),
          fit: BoxFit.contain,
        ),
      ),
    );
    if (imagefile != null && imagefile.containsKey('image_filtered')) {
      setState(() {
        imageFile = imagefile['image_filtered'];
      });
      print(imageFile!.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (imageFile == null) {
      getImage(context);
    }
    return new Scaffold(
      resizeToAvoidBottomInset: false,
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
            icon: Icon(Icons.arrow_forward),
            iconSize: 30.0,
            color: mPrimaryColor,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SettingPostPage()));
            },
          ),
        ],
      ),
      body: Center(
        child: new Container(
          child: imageFile == null
              ? Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Expanded(
                          flex: 2, child: Image.file(File(widget.imagePath))),
                      SizedBox(height: 5.0),
                    ],
                  ),
                )
              : Image.file(imageFile!),
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: () => getImage(context),
        tooltip: 'refreshe',
        child: new Icon(Icons.edit),
      ),
    );
  }
}
