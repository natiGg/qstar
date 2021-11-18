import 'package:flutter/material.dart';
import 'package:qstar/constant.dart';

class Search extends StatelessWidget {
  const Search({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: mPrimaryColor,
            onPressed: () {}),
        automaticallyImplyLeading: false,
        elevation: 8,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        title: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 0.5),
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: const SizedBox(
            height: 40,
            width: 800,
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search user",
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.black,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
        ),
      ),
      body: Image.asset('assets/images/post3.jpg'),
    );
  }
}
