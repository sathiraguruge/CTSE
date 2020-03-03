import 'package:flutter/material.dart';

class CustomizedAppBar {
  final Color backgroundColor = Colors.orange;
  String title;

  CustomizedAppBar(this.title);

  Widget getAppBar() {
    return new AppBar(
      title: Text(title),
      backgroundColor: backgroundColor,
    );
  }
}
