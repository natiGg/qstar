import 'dart:async';
import 'dart:io';

// ignore: import_of_legacy_library_into_null_safe
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qstar/screen/Chat/home_screen.dart';
import 'package:qstar/screen/main/main_screen.dart';
import 'package:qstar/screen/profilesetting/localstring.dart';
import 'package:qstar/screen/qvideo/category.dart';

import 'package:qstar/screen/splash/error.dart';
import 'package:qstar/screen/splash/splash_screen.dart';
import 'package:qstar/constant.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() {
  runApp(const MyApp());
  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..customAnimation = CustomAnimation();
}

class CustomAnimation extends EasyLoadingAnimation {
  CustomAnimation();

  @override
  Widget buildWidget(
    Widget child,
    AnimationController controller,
    AlignmentGeometry alignment,
  ) {
    return Opacity(
      opacity: controller.value,
      child: RotationTransition(
        turns: controller,
        child: child,
      ),
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

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
    switch (_source.keys.toList()[0]) {
      case ConnectivityResult.none:
        setState(() {
          isconected = false;
        });

        // ignore: avoid_print

        break;
      case ConnectivityResult.mobile:
        setState(() {
          isconected = true;
        });
        // ignore: avoid_print

        break;
      case ConnectivityResult.wifi:
        setState(() {
          isconected = true;
        });
      // ignore: avoid_print

    }
    return isconected
        ? GetMaterialApp(
            translations: LocaleString(),
            locale: const Locale('en', 'US'),
            title: 'Coffee',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              scaffoldBackgroundColor: mBackgroundColor,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            routes: {
              // When navigating to the "/" route, build the FirstScreen widget.
              '/home': (context) => const MyHomePage(),
              '/video': (context) => const CategoryVid(),
              '/login': (context) => const HomeScreen(),
            },
            home: const SplashScreen(),
            builder: EasyLoading.init(),
          )
        : buildUnAuthScreen();
  }

  buildUnAuthScreen() {
    return GetMaterialApp(
      translations: LocaleString(),
      locale: const Locale('en', 'US'),
      title: 'Coffee',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: mBackgroundColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const ConnectionFaildScreen(),
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
      } else {
        isOnline = false;
      }
    } on SocketException catch (_) {
      isOnline = false;
    }
    controller.sink.add({result: isOnline});
  }

  void disposeStream() => controller.close();
}
