import 'package:flutter/material.dart';
import 'package:qstar/constant.dart';

class Searchlocation extends StatelessWidget {
  const Searchlocation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: mPrimaryColor,
            onPressed: () {
              // Navigator.push(
              //   context,
              //   PageRouteBuilder(
              //     pageBuilder: (context, animation1, animation2) =>
              //         const SettingPostPage(),
              //     transitionDuration: Duration.zero,
              //   ),
              // );
            }),
        automaticallyImplyLeading: false,
        elevation: 8,
        // ignore: prefer_const_constructors
        iconTheme: IconThemeData(
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
                hintText: "Search location",
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Divider(
              height: 10,
            ),
            ListTile(
              title: const Text('Addis ababa,Ethiopia'),
              dense: true,
              onTap: () {},
            ),
            ListTile(
              title: const Text('Mexico,Addis ababa'),
              dense: true,
              onTap: () {},
            ),
            ListTile(
              title: const Text('Ledeta'),
              dense: true,
              onTap: () {},
            ),
            ListTile(
              title: const Text('Adama'),
              dense: true,
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
