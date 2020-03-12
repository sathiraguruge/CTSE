import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';

// this class contains all the common input widgets used in the app
class CommonInputWidgets {

  // this function returns a TextField
  Container getTextField(String labelText, String hintText, IconData icon,
      TextEditingController controller) {
    return (Container(
      height: 100,
      child: TextField(
        decoration: InputDecoration(
            labelText: labelText, hintText: hintText, icon: Icon(icon)),
        controller: controller,
      ),
    ));
  }

  // this function return a date picker
  Container getDatePicker(
      String label, IconData icon, TextEditingController controller) {
    final format = DateFormat("dd MMMM, yyyy");

    return Container(
      margin: const EdgeInsets.only(bottom: 30),
      child: Column(children: <Widget>[
        Container(
          alignment: Alignment(-1, -1),
          child: Text(label),
          margin: const EdgeInsets.only(left: 40),
        ),
        Row(
          children: <Widget>[
            Container(
              child: new Icon(icon),
            ),
            Container(
              width: 335,
              margin: const EdgeInsets.only(left: 20),
              child: DateTimeField(
                format: format,
                controller: controller,
                onShowPicker: (context, currentValue) {
                  return showDatePicker(
                      context: context,
                      firstDate: DateTime(1900),
                      initialDate: currentValue ?? DateTime.now(),
                      lastDate: DateTime(2100));
                },
              ),
            )
          ],
        )
      ]),
    );
  }

  // this function returns a Number Text Field
  // if the parameter onlyDigits is true , only digits can be entered (not point values)
  Container getNumberTextField(String labelText, String hintText, IconData icon,
      bool onlyDigits, TextEditingController controller) {
    return (Container(
      height: 100,
      child: TextField(
        decoration: InputDecoration(
            labelText: labelText, hintText: hintText, icon: Icon(icon)),
        controller: controller,
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          if (onlyDigits) WhitelistingTextInputFormatter.digitsOnly
        ],
      ),
    ));
  }

  // this function returns a Text Area
  Container getTextArea(String labelText, String hintText, IconData icon,
      TextEditingController controller) {
    return (Container(
        margin: const EdgeInsets.only(bottom: 30),
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment(-.8, -1),
              child: Text(labelText),
              margin: const EdgeInsets.only(bottom: 15),
            ),
            Row(
              children: <Widget>[
                Container(
                  child: new Icon(icon),
                ),
                Container(
                  width: 355,
                  child: Card(
                      color: Colors.white,
                      margin: const EdgeInsets.only(left: 5),
                      child: Padding(
                        padding: EdgeInsets.all(1.0),
                        child: TextField(
                          maxLines: 8,
                          decoration: InputDecoration(hintText: hintText),
                          controller: controller,
                        ),
                      )),
                )
              ],
            )
          ],
        )));
  }

}
