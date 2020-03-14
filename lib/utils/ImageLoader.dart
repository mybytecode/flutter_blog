import 'package:flutter/material.dart';

class ImageLoader {
  Widget articleListImage(double height, double width, String url) {
    if (url == null) {
      return Image.asset(
        'assets/images/logo.png',
        height: height,
        width: width,
      );
    } else {
      return Image.network(url, width: height, height: width, loadingBuilder:
          (BuildContext ctx, Widget child, ImageChunkEvent pre) {
        if (pre == null) {
          return child;
        } else {
          return Container(
            height: height,
            width: width,
            child: Center(child: CircularProgressIndicator()),
          );
        }
      });
    }
  }
}
