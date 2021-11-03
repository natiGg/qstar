import 'package:flutter/material.dart';
import 'package:qstar/screen/feed/feed.dart';
import 'package:qstar/screen/home/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
    const SplashScreen({
    Key? key
  }) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
    bool isAuth = false;

  @override
  void initState() {
    var d = const Duration(seconds: 3);
    // delayed 3 seconds to next page
    Future.delayed(d, () {
      // to next page and close this page
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context)=>Scaffold(
            body: isAuth?Feed():HomeScreen(),

          ) ,
        ),
        (route) => false,
      );
    });
    _checkIfLoggedIn();

    super.initState();
  }
  
  void _checkIfLoggedIn() async{
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    print(token);
    if(token != null){
      setState(() {
        isAuth = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration:const BoxDecoration(
      
        ),
        child: Center(
          child:Image.asset(
            'assets/images/q.png',
              height: 160,
              width: 160,
          ),
        ),
      ),
    );
  }
}

