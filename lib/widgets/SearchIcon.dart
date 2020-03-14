
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blog/Screens/SearchArticle.dart';

class SearchIcon extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10),
      child: IconButton(
        icon: Icon(
          Icons.search,
        ),
        onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SearchArticle())),
        tooltip: "Search Articles",
      ),
    );
  }

}