import 'package:flutter/material.dart';
import 'package:qstar/constant.dart';
import 'package:qstar/screen/post/setting_post_page.dart';

class Searchlocation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: mPrimaryColor,
            onPressed: () {
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) =>
                      SettingPostPage(),
                  transitionDuration: Duration.zero,
                ),
              );
            }),
        automaticallyImplyLeading: false,
        elevation: 8,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        title: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 0.5),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: Container(
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
            Divider(
              height: 10,
            ),
            ListTile(
              title: Text('Addis ababa,Ethiopia'),
              dense: true,
              onTap: () {},
            ),
            ListTile(
              title: Text('Mexico,Addis ababa'),
              dense: true,
              onTap: () {},
            ),
            ListTile(
              title: Text('Ledeta'),
              dense: true,
              onTap: () {},
            ),
            ListTile(
              title: Text('Adama'),
              dense: true,
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
