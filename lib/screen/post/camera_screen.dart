import 'dart:io';
import 'package:camera_camera/camera_camera.dart';
import 'package:flutter/material.dart';

import 'package:qstar/screen/post/preview_screen_gallery.dart';

class CameraScreen extends StatelessWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Camera Camera 2.0',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Camera Camera 2.0'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List cameras;
  @override
  void initState() {
    super.initState();
    availableCameras().then((availableCameras) {
      cameras = availableCameras;

      if (cameras.isNotEmpty) {
        setState(() {
          openCamera();
        });
      } else {
        // ignore: avoid_print
        print("No camera available");
      }
    }).catchError((err) {
      // ignore: avoid_print
      print('Error: $err.code\nError Message: $err.message');
    });
  }

  final photos = <File>[];

  void openCamera() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => CameraCamera(
                  onFile: (file) {
                    _onCapturePressed(file);

                    setState(() {});
                  },
                )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      floatingActionButton: FloatingActionButton(
        onPressed: openCamera,
        child: const Icon(Icons.camera_alt),
      ),
    );
  }

  void _onCapturePressed(File file) {
    String path;
    path = file.path;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PreviewImageScreengallery(imagePath: path),
      ),
    );
  }
}
