import 'package:flutter/material.dart';

// This class contains attributes and methods for a Customized App Bar
class CustomizedAppBar {
  final Color backgroundColor = Colors.orange;
  String title;

  // Constructor
  CustomizedAppBar(this.title);

  // this function returns the Customized App Bar
  Widget getAppBar() {
    return new AppBar(
      title: Text(title, style: TextStyle(fontSize: 25, fontFamily: 'SanFrancisco'),),
      backgroundColor: backgroundColor,
    );
  }
}
