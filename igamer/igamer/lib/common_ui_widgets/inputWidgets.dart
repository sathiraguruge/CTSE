import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:igamer/screens/addGame.dart';
import 'package:intl/intl.dart';

// this class contains all the common input widgets used in the app
class CommonInputWidgets {

  // this function returns a TextField
  Container getTextField(String labelText, String hintText, IconData icon,
      TextEditingController controller, String validator, FocusNode focusNode) {
    return (Container(
      height: 100,
      child: TextFormField(
        textInputAction: TextInputAction.next,
        onEditingComplete: (){
          FocusScope.of(new AddGameFormState().context).requestFocus(focusNode);
        },
        focusNode: new AddGameFormState().focusNode,
        decoration: InputDecoration(
            labelText: labelText, hintText: hintText, icon: Icon(icon)),
        controller: controller,
        autocorrect: true,
        autofocus: true,
        autovalidate: true,
        validator: (value){
          if(value == null || value.isEmpty){
            return validator;
          }
          if(value.trim() == ""){
            return "Only Space is Not Valid !!!";
          }
          return null;
        },
      ),
    ));
  }

  // this function return a date picker
  Container getDatePicker(
      String label, IconData icon, TextEditingController controller, String validator, FocusNode focusNode) {
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
                onShowPicker: (context, currentValue) {
                  return showDatePicker(
                      context: context,
                      firstDate: DateTime(1900),
                      initialDate: currentValue ?? DateTime.now(),
                      lastDate: DateTime(2100));
                },
                  controller: controller,
                  autocorrect: true,
                  autofocus: true,
                  autovalidate: true,
                  validator: (value) {
                    if (value != null) {
                      return null;
                    }
                    else {
                      return validator;
                    }
                  }
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
      bool onlyDigits, TextEditingController controller, String validator, FocusNode focusNode ) {
    return (Container(
      height: 100,
      child: TextFormField(
        textInputAction: TextInputAction.next,
        onEditingComplete: (){
          FocusScope.of(new AddGameFormState().context).requestFocus(focusNode);
        },
        focusNode: new AddGameFormState().focusNode,
        decoration: InputDecoration(
            labelText: labelText, hintText: hintText, icon: Icon(icon)),
        controller: controller,
        autocorrect: true,
        autofocus: true,
        autovalidate: true,
        validator: (value){
          if(value == null || value.isEmpty){
            return validator;
          }
          if(value.trim() == ""){
            return "Only Space is Not Valid !!!";
          }
          return null;
        },
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          if (onlyDigits) WhitelistingTextInputFormatter.digitsOnly
        ],
      ),
    ));
  }

  // this function returns a Text Area
  Container getTextArea(String labelText, String hintText, IconData icon,
      TextEditingController controller, String validator, FocusNode focusNode) {
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
                  width: 335,
                  child: Card(
                      color: Colors.transparent,
                      elevation: 0,
                      margin: const EdgeInsets.only(left: 5),
                      child: Padding(
                        padding: EdgeInsets.all(1.0),
                        child: TextFormField(
                          maxLines: 8,
                          textInputAction: TextInputAction.next,
                          onEditingComplete: (){
                            FocusScope.of(new AddGameFormState().context).requestFocus(focusNode);
                          },
                          focusNode: new AddGameFormState().focusNode,
                          decoration: InputDecoration(hintText: hintText),
                          controller: controller,
                          autocorrect: true,
                          autofocus: true,
                          autovalidate: true,
                          validator: (value){
                            if(value == null || value.isEmpty){
                              return validator;
                            }
                            if(value.trim() == ""){
                              return "Only Space is Not Valid !!!";
                            }
                            return null;
                          },
                        ),
                      )),
                )
              ],
            )
          ],
        )));
  }
}
