import 'package:flutter/material.dart';

class AppAlertBox {
  BuildContext context;
  String title;
  String message;
  String buttonText;

  AppAlertBox(this.context, this.title, this.message, this.buttonText);

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

    // show the dialog
    showDialog(
      context: this.context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
