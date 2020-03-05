import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:igamer/pageTitle.dart';

void main() => runApp(AddGame());

final title = 'Add Game Review';

class AddGame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: new CustomizedAppBar(title).getAppBar(),
        body: AddGameForm(),
      ),
    );
  }
}

// Create a Form widget.
class AddGameForm extends StatefulWidget {
  @override
  AddGameFormState createState() {
    return AddGameFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class AddGameFormState extends State<AddGameForm> {
  final _formKey = GlobalKey<FormState>();

  Container getTextField(String labelText, String hintText) {
    return (Container(
      height: 100,
      child: TextField(
        decoration: InputDecoration(
            labelText: labelText, hintText: hintText, icon: Icon(Icons.games)),
      ),
    ));
  }

  Container getNumberTextField(String labelText, String hintText) {
    return (Container(
      height: 100,
      child: TextField(
        decoration: InputDecoration(
            labelText: labelText, hintText: hintText, icon: Icon(Icons.games)),
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          WhitelistingTextInputFormatter.digitsOnly
        ],
      ),
    ));
  }

  Container getDropDown(String labelText, String hintText) {
    return (Container(
      height: 100,
      child: TextField(
        decoration: InputDecoration(
            labelText: labelText, hintText: hintText, icon: Icon(Icons.games)),
      ),
    ));
  }

  Card getTextArea(String labelText, String hintText) {
    return (Card(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.all(1.0),
          child: TextField(
            maxLines: 8,
            decoration:
                InputDecoration(hintText: hintText, labelText: labelText),
          ),
        )));
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            getTextField("Game Title", "Forza Horizon"),
            getTextField("Genre", "Racing, Simulation, Automobile"),
            getTextField("Released Date", "2 Oct, 2020"),
            getTextField("Published Date", "2 Oct, 2020"),
            getNumberTextField("No Of Users", "2"),
            getTextArea("Brief Description", "This will appear on main screen"),
            getTextArea(
                "Full Description", "This will appear on detail screen"),
            getTextField("ESRB Rating", "E"),
            getTextField("Developer", "Playground Games"),
            getTextField("User Score", "7.8"),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: RaisedButton(
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    Scaffold.of(context).showSnackBar(
                        SnackBar(content: Text('Adding New Game Review')));
                  }
                },
                child: Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
