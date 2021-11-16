// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:qstar/constant.dart';
import 'package:qstar/screen/main/main_screen.dart';

void main() {
  runApp(const Recommend());
}

class Recommend extends StatelessWidget {
  const Recommend({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coffee',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: mBackgroundColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const RecommendUser(),
    );
  }
}

class RecommendUser extends StatelessWidget {
  const RecommendUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: const EdgeInsets.only(
          top: 170,
        ),
        child: Column(
          children: [
            Text(
              "Suggested friends",
              style: Theme.of(context).textTheme.headline4,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.all(20),
              child: Container(
                margin: const EdgeInsets.only(
                  left: 20.0,
                  top: 10.0,
                ),
                child: Row(
                  children: [
                    RecomendPlantCard(
                      image: "assets/images/profile1.jpg",
                      title: "Samantha",
                      country: "Russia",
                      price: 440,
                      press: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MyHomePage(),
                          ),
                        );
                      },
                    ),
                    RecomendPlantCard(
                      image: "assets/images/profile2.jpg",
                      title: "Samantha",
                      country: "Russia",
                      price: 440,
                      press: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MyHomePage(),
                          ),
                        );
                      },
                    ),
                    RecomendPlantCard(
                      image: "assets/images/profile3.jpg",
                      title: "Samantha",
                      country: "Russia",
                      price: 440,
                      press: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MyHomePage(),
                          ),
                        );
                      },
                    ),
                    RecomendPlantCard(
                      image: "assets/images/profile4.jpg",
                      title: "Samantha",
                      country: "Russia",
                      price: 440,
                      press: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MyHomePage(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RecomendPlantCard extends StatelessWidget {
  const RecomendPlantCard({
    Key? key,
    required this.image,
    required this.title,
    required this.country,
    required this.price,
    required this.press,
  }) : super(key: key);

  final String image, title, country;
  final int price;
  final Function press;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    const textStyle = TextStyle(
      color: Colors.white,
    );
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const MyHomePage(),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(
          left: 20.0,
          top: 5.0 / 2,
          bottom: 20.0 * 2.5,
        ),
        height: size.height * 0.4,
        width: size.width * 0.4,
        child: Column(
          children: <Widget>[
            Expanded(
                child: Image.asset(image,
                    width: double.infinity, fit: BoxFit.fill)),
            Container(
              padding: const EdgeInsets.all(20.0 / 2),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 10),
                    blurRadius: 50,
                    color: const Color(0xFF58269f).withOpacity(0.23),
                  ),
                ],
              ),
              child: Row(
                children: <Widget>[
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: "$title\n".toUpperCase(),
                            style: Theme.of(context).textTheme.button),
                        TextSpan(
                          text: country.toUpperCase(),
                          style: TextStyle(
                            color: const Color(0xFF58269f).withOpacity(0.5),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '$price\ffollowers',
                    style: Theme.of(context).textTheme.button,
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(36),
                ),
                color: mPrimaryColor,
                onPressed: () {},
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  alignment: Alignment.center,
                  child: const Text(
                    'Follow',
                    style: textStyle,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
