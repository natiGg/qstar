import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:qstar/constant.dart';
import 'package:qstar/screen/feed/feed.dart';
import 'package:qstar/screen/profile/PerfectMatch/personalinfoform.dart';

class Privacypolicy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          "Privacy policy",
          style: const TextStyle(
            color: mPrimaryColor,
            fontSize: 27,
            fontFamily: 'font1',
          ),
        ),
      ),
      body: OnBoardingPage(),
    );
  }
}

class OnBoardingPage extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 18.0),
        child: RichText(
          overflow: TextOverflow.clip,
          text: TextSpan(
            text:
                'This policy describes the information we process to support Facebook, Instagram, Messenger and other products and features offered by Facebook (Facebook Products or Products). You can find additional tools and information in the Facebook Settings and Instagram Settings.\n',
            style: DefaultTextStyle.of(context).style,
            children: <TextSpan>[
              TextSpan(
                  text: 'I. What kinds of information do we collect?\n',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(
                  text:
                      'Things you and others do and provide.Information and content you provide. We collect the content, communications and other information you provide when you use our Products, including when you sign up for an account, create or share content, and message or communicate with others. This can include information in or about the content you provide (like metadata), such as the location of a photo or the date a file was created. It can also include what you see through features we provide, such as our camera, so we can do things like suggest masks and filters that you might like, or give you tips on using camera formats. Our systems automatically process content and communications you and others provide to analyze context and whats in them for the purposes described below. Learn more about how you can control who can see the things you share.'),
              TextSpan(
                  text:
                      'Networks and connections. We collect information about the people, Pages, accounts, hashtags and groups you are connected to and how you interact with them across our Products, such as people you communicate with the most or groups you are part of. We also collect contact information if you choose to upload, sync or import it from a device (such as an address book or call log or SMS log history), which we use for things like helping you and others find people you may know and for the other purposes listed below.'),
              TextSpan(
                  text:
                      'Your usage. We collect information about how you use our Products, such as the types of content you view or engage with; the features you use; the actions you take; the people or accounts you interact with; and the time, frequency and duration of your activities. For example, we log when youre using and have last used our Products, and what posts, videos and other content you view on our Products. We also collect information about how you use features like our camera.'),
              TextSpan(
                  text:
                      'Information about transactions made on our Products. If you use our Products for purchases or other financial transactions (such as when you make a purchase in a game or make a donation), we collect information about the purchase or transaction. This includes payment information, such as your credit or debit card number and other card information; other account and authentication information; and billing, shipping and contact details.Things others do and information they provide about you. We also receive and analyze content, communications and information that other people provide when they use our Products. This can include information about you, such as when others share or comment on a photo of you, send a message to you, or upload, sync or import your contact information.'),
            ],
          ),
        ),
      ),
    );
  }
}
