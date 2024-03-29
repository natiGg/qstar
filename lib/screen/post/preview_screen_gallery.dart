// ignore_for_file: unused_local_variable

import 'dart:io';

import 'package:get/get.dart';
import 'package:photofilters/filters/filters.dart';
import 'package:photofilters/photofilters.dart';
import 'package:qstar/constant.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:qstar/controllers/postcontroller.dart';

// ignore: library_prefixes
import 'package:image/image.dart' as imageLib;
import 'package:qstar/screen/feed/feed.dart';
import 'package:uri_to_file/uri_to_file.dart';

class PreviewImageScreengallery extends StatefulWidget {
  final String imagePath;
  final bool isfrompost;

  // ignore: use_key_in_widget_constructors
  const PreviewImageScreengallery(
      {required this.imagePath, required this.isfrompost});

  @override
  _PreviewImageScreenState createState() => _PreviewImageScreenState();
}

class _PreviewImageScreenState extends State<PreviewImageScreengallery> {
  late String fileName, filtedpath;
  List<Filter> filters = presetFiltersList;
  File? imageFile;
  PostController postController = Get.find();
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
      MaterialPageRoute(
        builder: (context) => PhotoFilterSelector(
          title: const Text(
            "Filter",
            style: TextStyle(color: Colors.white),
          ),
          image: image!,
          appBarColor: Colors.black,
          filters: presetFiltersList,
          filename: fileName,
          loader: const Center(child: CircularProgressIndicator()),
          fit: BoxFit.contain,
        ),
      ),
    );
    if (imagefile.containsKey('image_filtered')) {
      setState(() {
        imageFile = imagefile['image_filtered'];
        //
        filtedpath = imageFile!.path;
      });
      // ignore: avoid_print
      print(imageFile!.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (imageFile == null) {
      getImage(context);
    }
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
            icon: const Icon(Icons.navigate_next),
            iconSize: 30.0,
            color: mPrimaryColor,
            onPressed: () {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) =>
              //             SettingPostPage(imagePath: filtedpath)));

              if (postController.imagesList.isNotEmpty) {
                if (postController.isCam.value) {
                  postController.imagesList.add(imageFile!);
                  postController.isCam.value = false;
                } else {
                  postController.imagesList[postController.index.value] =
                      imageFile as File;
                }
              } else {
                postController.imagesList.add(imageFile!);
              }
              if (widget.isfrompost == true) {
                FeedState feed = new FeedState();
                feed.postModal(context);
              } else {
                Navigator.of(context).pop(true);
              }
            },
          ),
        ],
      ),
      body: Center(
        child: Container(
          child: imageFile == null
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Expanded(
                        flex: 2, child: Image.file(File(widget.imagePath))),
                    const SizedBox(height: 5.0),
                  ],
                )
              : Image.file(imageFile!),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => getImage(context),
        tooltip: 'refreshe',
        child: const Icon(Icons.edit),
      ),
    );
  }
}
