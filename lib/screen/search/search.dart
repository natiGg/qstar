import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class Search extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                hintText: "Search",
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
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Container(
              height: 30,
              margin: EdgeInsets.only(top: 13, bottom: 5),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  _tagItem("User"),
                  _tagItem("Video"),
                  _tagItem("Posts"),
                  _tagItem("Page"),
                  _tagItem("Hastag"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tagItem(String title) {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      child: Container(
        child: Text(title),
        margin: EdgeInsets.all(5),
      ),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.grey),
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
      ),
    );
  }

  Widget _gridItem(int i) {
    return Image.asset(
      "assets/images/$i.jpg",
      fit: BoxFit.cover,
    );
  }
}
