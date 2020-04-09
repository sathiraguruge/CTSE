// this class contains attributes and method for an Alert Box
import 'package:flutter/material.dart';

class AppAlertBox {
  BuildContext context;
  String title;
  String message;
  String buttonText;

  // Constructor
  AppAlertBox(this.context, this.title, this.message, this.buttonText);

  // this function pops up Alert Box
  showAlertDialog() {
    Widget okButton = FlatButton(
      child: Text(this.buttonText),
      onPressed: () {
        Navigator.pop(this.context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(this.title),
      content: Text(this.message),
      actions: [
        okButton,
      ],
    );

    // show the AlertDialog
    showDialog(
      context: this.context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
