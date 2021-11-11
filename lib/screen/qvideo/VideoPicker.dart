import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qstar/constant.dart';
import 'package:qstar/screen/qvideo/qvideo.dart';
import 'package:qstar/screen/qvideo/videopreview.dart';

class VideoRecorderExample extends StatefulWidget {
  const VideoRecorderExample({Key? key}) : super(key: key);

  @override
  _VideoRecorderExampleState createState() {
    return _VideoRecorderExampleState();
  }
}

class _VideoRecorderExampleState extends State<VideoRecorderExample> {
  File? _cameraVideo;

  ImagePicker picker = ImagePicker();

  // This funcion will helps you to pick a Video File from Camera
  _pickVideoFromCamera() async {
    // ignore: deprecated_member_use
    PickedFile? pickedFile = await picker.getVideo(source: ImageSource.camera);

    _cameraVideo = File(pickedFile!.path);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            PreviewImageScreengallery(imagePath: pickedFile.path),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: mPrimaryColor,
            onPressed: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) =>
                      const Qvideoscreen(),
                  transitionDuration: Duration.zero,
                ),
              );
            }),
        // ignore: prefer_const_constructors
        title: Text(
          "Recored Video",
          style: const TextStyle(
            color: mPrimaryColor,
            fontSize: 27,
            fontFamily: 'font1',
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              color: Colors.black,
              child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: Center(
                  child: _cameraPreviewWidget(),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _captureControlRowWidget(),
              _galleryWidget(),
            ],
          ),
        ],
      ),
    );
  }

  _galleryWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: 100.0),
      child: IconButton(
          icon: const Icon(Icons.monochrome_photos),
          color: mPrimaryColor,
          onPressed: () {
            _pickVideo();
          }),
    );
  }

  _playVideo(file) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PreviewImageScreengallery(imagePath: file),
      ),
    );
  }

  Widget _cameraPreviewWidget() {
    return const Text(
      'Loading',
      style: TextStyle(
        color: Colors.white,
        fontSize: 20.0,
        fontWeight: FontWeight.w900,
      ),
    );
  }

  _pickVideo() async {
    ImagePicker picker = ImagePicker();
    // ignore: deprecated_member_use
    PickedFile? pickedFile = await picker.getVideo(source: ImageSource.gallery);

    // _video = File(pickedFile!.path);
    await _playVideo(pickedFile!.path);
  }

  Widget _captureControlRowWidget() {
    return Align(
      alignment: Alignment.center,
      child: IconButton(
          icon: const Icon(Icons.videocam),
          color: mPrimaryColor,
          onPressed: () {
            _pickVideoFromCamera();
          }),
    );
  }
}
