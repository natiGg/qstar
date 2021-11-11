import 'dart:async';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:qstar/screen/Chat/home_screen.dart';
import 'package:qstar/screen/feed/feed.dart';
import 'package:qstar/screen/main/main_screen.dart';
import 'package:qstar/screen/splash/error.dart';
import 'package:qstar/screen/splash/splash_screen.dart';
import 'package:qstar/constant.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

Map _source = {ConnectivityResult.none: false};
MyConnectivity _connectivity = MyConnectivity.instance;

class _MyHomePageState extends State<MyApp> {
  bool isconected = false;

  @override
  void initState() {
    super.initState();
    _connectivity.initialise();
    _connectivity.myStream.listen((source) {
      setState(() => _source = source);
    });
  }

  @override
  Widget build(BuildContext context) {
    String string;
    switch (_source.keys.toList()[0]) {
      case ConnectivityResult.none:
        setState(() {
          string = "Offline";
          isconected = false;
        });

        print("Offline");
        break;
      case ConnectivityResult.mobile:
        setState(() {
          string = "Online";
          isconected = true;
        });
        print("Online");
        break;
      case ConnectivityResult.wifi:
        setState(() {
          string = "Online";
          isconected = true;
        });
        print("Online");
    }
    return isconected
        ? MaterialApp(
            title: 'Coffee',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              scaffoldBackgroundColor: mBackgroundColor,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            routes: {
              // When navigating to the "/" route, build the FirstScreen widget.
              '/home': (context) => const MyHomePage(),
              '/login': (context) => const HomeScreen(),
            },
            home: const SplashScreen(),
          )
        : buildUnAuthScreen();
  }

  // void cheack() async {
  //   try {
  //     final result = await InternetAddress.lookup('google.com');
  //     if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
  //       setState(() {
  //         isconected = true;
  //       });
  //     }
  //   } on SocketException catch (_) {
  //     setState(() {
  //       isconected = false;
  //     });
  //   }
  // }

  buildUnAuthScreen() {
    return MaterialApp(
      title: 'Coffee',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: mBackgroundColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ConnectionFaildScreen(),
    );
  }
}

class MyConnectivity {
  MyConnectivity._internal();

  static final MyConnectivity _instance = MyConnectivity._internal();

  static MyConnectivity get instance => _instance;

  Connectivity connectivity = Connectivity();

  StreamController controller = StreamController.broadcast();

  Stream get myStream => controller.stream;

  void initialise() async {
    ConnectivityResult result = await connectivity.checkConnectivity();
    _checkStatus(result);
    connectivity.onConnectivityChanged.listen((result) {
      _checkStatus(result);
    });
  }

  void _checkStatus(ConnectivityResult result) async {
    bool isOnline = false;
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        isOnline = true;
      } else
        isOnline = false;
    } on SocketException catch (_) {
      isOnline = false;
    }
    controller.sink.add({result: isOnline});
  }

  void disposeStream() => controller.close();
}
