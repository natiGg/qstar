// ignore_for_file: sized_box_for_whitespace

import 'dart:async';
import 'dart:convert';
// import 'package:provider/provider.dart';
import 'dart:io';
import 'package:qstar/constant.dart';
import 'package:flutter/material.dart';
import 'file.dart';

import 'package:camera/camera.dart';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

// ignore: import_of_legacy_library_into_null_safe
import "package:storage_path/storage_path.dart" show StoragePath;
import 'package:qstar/screen/feed/feed.dart';
import 'package:qstar/screen/post/setting_post_page.dart';
import 'package:qstar/screen/post/preview_screen_gallery.dart';
import 'package:qstar/screen/post/camera_screen.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late FileModel selectedModel;
  late String image;
  List<FileModel>? files;

  @override
  void initState() {
    super.initState();

    // Timer(const Duration(seconds: 5), () {
    //   _getImagesPath();
    // });

    _getImagesPath();
  }

  _getImagesPath() async {
    var imagePath = await StoragePath.imagesPath;

    var images = jsonDecode(imagePath) as List;
    files = images.map<FileModel>((e) => FileModel.fromJson(e)).toList();
    print(files.toString());
    if (files != null && files!.length > 0) {
      setState(() {
        selectedModel = files![0];
        image = files![0].files[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final decoration = BoxDecoration(
      shape: BoxShape.circle,
      color: Colors.black54,
    );
    if (files == null) {
      return Scaffold();
    } else {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              color: mPrimaryColor,
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) =>
                        UsersFeed(),
                    transitionDuration: Duration.zero,
                  ),
                );
              }),
          // ignore: prefer_const_constructors
          title: Text(
            "Post",
            style: const TextStyle(
              color: mPrimaryColor,
              fontSize: 27,
              fontFamily: 'font1',
            ),
          ),
        ),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      SizedBox(width: 10),
                      DropdownButtonHideUnderline(
                          child: DropdownButton<FileModel>(
                        items: getIO(),
                        onChanged: (d) {
                          assert(d!.files.length > 0);
                          image = d!.files[0];
                          setState(() {
                            selectedModel = d;
                          });
                        },
                        value: selectedModel,
                      ))
                    ],
                  ),
                  // ignore: prefer_const_constructors
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    // ignore: unnecessary_new
                    child: new GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PreviewImageScreengallery(
                                      imagePath: image,
                                    )));
                      },
                      child: new Text(
                        'Next',
                        style: TextStyle(color: mPrimaryColor),
                      ),
                    ),
                  )
                ],
              ),
              const Divider(),
              Container(
                  height: MediaQuery.of(context).size.height * 0.25,
                  child: image != null
                      ? Image.file(File(image),
                          height: MediaQuery.of(context).size.height * 0.25,
                          width: MediaQuery.of(context).size.width)
                      : Container()),
              Positioned(
                child: Container(
                  padding: EdgeInsets.all(6),
                  child: Row(
                    children: [
                      Container(
                          child: IconButton(
                              icon: Icon(
                                Icons.zoom_out_map,
                                size: 16,
                                color: Colors.white,
                              ),
                              onPressed: () {}),
                          decoration: decoration),
                      Expanded(child: Container()),
                      Container(
                          child: IconButton(
                              icon: Icon(Icons.camera,
                                  size: 16, color: Colors.white),
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder:
                                        (context, animation1, animation2) =>
                                            CameraScreen(),
                                    transitionDuration: Duration.zero,
                                  ),
                                );
                              }),
                          decoration: decoration),
                      SizedBox(
                        width: 16,
                      ),
                      Container(
                        child: IconButton(
                          icon: Icon(Icons.content_copy,
                              size: 16, color: Colors.white),
                          onPressed: () {},
                          tooltip: "Select multiple",
                        ),
                        decoration: decoration,
                      )
                    ],
                  ),
                ),
                bottom: 0,
                left: 0,
                right: 0,
              ),

              const Divider(),
              // ignore: unnecessary_null_comparison, prefer_is_empty
              if (selectedModel == null && selectedModel.files.length < 1)
                Container()
              else
                Container(
                  height: MediaQuery.of(context).size.height * 0.30,
                  child: GridView.builder(
                      gridDelegate:
                          // ignore: prefer_const_constructors
                          SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              crossAxisSpacing: 4,
                              mainAxisSpacing: 4),
                      itemBuilder: (_, i) {
                        var file = selectedModel.files[i];
                        return GestureDetector(
                          child: Image.file(
                            File(file),
                            fit: BoxFit.cover,
                          ),
                          onTap: () {
                            setState(() {
                              image = file;
                            });
                          },
                        );
                      },
                      itemCount: selectedModel.files.length),
                )
            ],
          ),
        ),
      );
    }
  }

  getIO() {
    return files!
        .map((e) => DropdownMenuItem(
              child: Text(
                e.folder,
                style: const TextStyle(color: mPrimaryColor),
              ),
              value: e,
            ))
        .toList();
  }

  // ignore: non_constant_identifier_names

}
