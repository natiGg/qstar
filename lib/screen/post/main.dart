// ignore_for_file: sized_box_for_whitespace

import 'dart:convert';
// import 'package:provider/provider.dart';
import 'dart:io';
import 'package:qstar/constant.dart';
import 'package:flutter/material.dart';
import 'file.dart';

// ignore: import_of_legacy_library_into_null_safe
import "package:storage_path/storage_path.dart" show StoragePath;

import 'package:qstar/screen/post/preview_screen_gallery.dart';
import 'package:camera_camera/camera_camera.dart';

// import 'package:flutter_easyloading/flutter_easyloading.dart';

class PostPage extends StatefulWidget {
  const PostPage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<PostPage> {
  FileModel? selectedModel;
  String? image;
  List<FileModel>? files;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();

    // Timer(const Duration(seconds: 5), () {
    //   _getImagesPath();
    // });

    _getImagesPath();
  }

  final photos = <File>[];
  _getImagesPath() async {
    var imagePath = await StoragePath.imagesPath;

    var images = jsonDecode(imagePath) as List;
    files = images.map<FileModel>((e) => FileModel.fromJson(e)).toList();
    // ignore: avoid_print
    print(files.toString());
    if (files != null && files!.isNotEmpty) {
      setState(() {
        selectedModel = files![0];
        image = files![0].files[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    const decoration = BoxDecoration(
      shape: BoxShape.circle,
      color: Colors.black54,
    );
    if (files == null) {
      return const Scaffold();
    } else {
      return Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              color: mPrimaryColor,
              onPressed: () {
                Navigator.of(context).pop(true);
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
                      const SizedBox(width: 10),
                      DropdownButtonHideUnderline(
                          child: DropdownButton<FileModel>(
                        items: getIO(),
                        onChanged: (d) {
                          assert(d!.files.isNotEmpty);
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
                    padding: const EdgeInsets.all(16.0),
                    // ignore: unnecessary_new
                    child: new GestureDetector(
                      onTap: () {
                        if (image != null) {
                          // ignore: deprecated_member_use
                          _scaffoldKey.currentState!.showSnackBar(SnackBar(
                            duration: const Duration(seconds: 1),
                            content: Row(
                              children: const <Widget>[
                                CircularProgressIndicator(),
                                Text(" Loading...")
                              ],
                            ),
                          ));
                          _ondelay().whenComplete(() => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      PreviewImageScreengallery(
                                        imagePath: image!,
                                        isfrompost: true,
                                      ))));
                        }
                        // ignore: deprecated_member_use
                      },
                      child: const Text(
                        'Next',
                        style: TextStyle(color: mPrimaryColor),
                      ),
                    ),
                  )
                ],
              ),
              const Divider(),
              Container(
                  height: MediaQuery.of(context).size.height * 0.35,
                  child: image != null
                      ? Image.file(File(image!),
                          height: MediaQuery.of(context).size.height * 0.35,
                          width: MediaQuery.of(context).size.width)
                      : Container()),
              Positioned(
                child: Container(
                  padding: const EdgeInsets.all(6),
                  child: Row(
                    children: [
                      Expanded(child: Container()),
                      Container(
                          child: IconButton(
                              icon: const Icon(Icons.camera,
                                  size: 16, color: Colors.white),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => CameraCamera(
                                              onFile: (file) {
                                                _onCapturePressed(file);

                                                setState(() {});
                                              },
                                            )));
                              }),
                          decoration: decoration),
                      const SizedBox(
                        width: 16,
                      ),
                      Container(
                        child: IconButton(
                          icon: const Icon(Icons.content_copy,
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
              if (selectedModel == null && selectedModel!.files.length < 1)
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
                        var file = selectedModel!.files[i];
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
                      itemCount: selectedModel!.files.length),
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

  _ondelay() {
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PreviewImageScreengallery(
                    imagePath: image!,
                    isfrompost: true,
                  )));
    });
  }

  void _onCapturePressed(File file) {
    String path;
    path = file.path;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PreviewImageScreengallery(
          imagePath: path,
          isfrompost: true,
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names

}
