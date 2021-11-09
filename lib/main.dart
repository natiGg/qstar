import 'package:flutter/material.dart';
import 'package:qstar/screen/Chat/home_screen.dart';
import 'package:qstar/screen/feed/feed.dart';
import 'package:qstar/screen/main/main_screen.dart';
import 'package:qstar/screen/splash/splash_screen.dart';
import 'package:qstar/constant.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
    );
  }
}
