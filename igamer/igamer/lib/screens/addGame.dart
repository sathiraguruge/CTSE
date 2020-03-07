import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:igamer/database/crud.dart';
import 'package:igamer/database/gameRecord.dart';
import 'package:igamer/database/imageUploader.dart';
import '../common_ui_widgets/appBar.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

import 'main.dart';

void main() => runApp(AddGame());

final title = 'Add Game Review';

class AddGame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: new CustomizedAppBar(title).getAppBar(),
        body: AddGameForm(title: title),
      ),
    );
  }
}

// Create a Form widget.
class AddGameForm extends StatefulWidget {
  final String title;

  AddGameForm({Key key, this.title}) : super(key: key);

  @override
  AddGameFormState createState() {
    return AddGameFormState();
  }
}

class AddGameFormState extends State<AddGameForm> {
  final _formKey = GlobalKey<FormState>();
  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _selectedESRBRating;
  File _image;
  TextEditingController titleController = new TextEditingController();
  TextEditingController genreController = new TextEditingController();
  TextEditingController developerController = new TextEditingController();
  TextEditingController noOfUsersController = new TextEditingController();
  TextEditingController userScoreController = new TextEditingController();
  TextEditingController briefDescriptionController =
      new TextEditingController();
  TextEditingController fullDescriptionController = new TextEditingController();
  TextEditingController publishedDateController = new TextEditingController();
  TextEditingController releasedDateController = new TextEditingController();

  List _ratings = [
    "RP - Rating Pending",
    "EC - Early Childhood",
    "E - Everyone",
    "E10+ - Everyone 10+",
    "T - Teen",
    "M - Mature",
    "AO - Adults Only"
  ];

  @override
  void initState() {
    super.initState();
    _dropDownMenuItems = buildAndGetDropDownMenuItems(_ratings);
    _selectedESRBRating = _dropDownMenuItems[0].value;
    _image = null;
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
            getTextField(
                "Game Title", "Forza Horizon", Icons.label, titleController),
            getTextField("Genre", "Racing, Simulation, Automobile",
                Icons.view_agenda, genreController),
            getDatePicker(
                "Released Date", Icons.calendar_today, releasedDateController),
            getDatePicker(
                "Published Date", Icons.new_releases, publishedDateController),
            getNumberTextField(
                "No Of Users", "2", Icons.person, true, noOfUsersController),
            getTextArea("Brief Description", "This will appear on main screen",
                Icons.assignment, briefDescriptionController),
            getTextArea("Full Description", "This will appear on detail screen",
                Icons.videogame_asset, fullDescriptionController),
            getDropDown("ESRB Rating", Icons.rate_review),
            getTextField("Developer", "Playground Games", Icons.build,
                developerController),
            getNumberTextField(
                "User Score", "7.8", Icons.score, false, userScoreController),
            getImagePicker(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: RaisedButton(
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text('Adding New Game Review'),
                      duration: const Duration(seconds: 1),
                    ));
                    var random = Random();
                    var n1 = random.nextInt(10000);
                    ImageUploader uploader = new ImageUploader(
                        titleController.text + "-" + n1.toString(), _image);
                    var imageURL = await uploader.uploadFile();
                    GameRecord game = new GameRecord(
                        8,
                        titleController.text,
                        publishedDateController.text,
                        briefDescriptionController.text,
                        imageURL,
                        genreController.text,
                        developerController.text,
                        releasedDateController.text,
                        fullDescriptionController.text,
                        _selectedESRBRating,
                        userScoreController.text,
                        noOfUsersController.text,
                        null);
                    await CRUD().addGame(game);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MyHomePage()));
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

  Future _getImage() async {
    return ImagePicker.pickImage(source: ImageSource.gallery).then((file) {
      setState(() {
        _image = file;
      });
    });
  }

  Future _clearImage() async {
    setState(() {
      _image = null;
    });
  }

  Column getImagePicker() {
    return (new Column(
      children: <Widget>[
        _image == null ? new Text('No image selected.') : Image.file(_image),
        _image == null
            ? new RaisedButton(
                child: Text('Choose File'),
                onPressed: () {
                  _getImage();
                },
                color: Colors.cyan,
              )
            : Container(),
        _image != null
            ? new RaisedButton(
                child: Text('Remove'),
                onPressed: () {
                  setState(() {
                    _clearImage();
                  });
                },
                color: Colors.cyan,
              )
            : Container(),
        _image != null
            ? RaisedButton(
                child: Text('Upload File'),
                onPressed: () {
                  var random = Random();
                  var n1 = random.nextInt(10000);
                  new ImageUploader(
                          titleController.text + "-" + n1.toString(), _image)
                      .uploadFile();
                },
                color: Colors.cyan,
              )
            : Container()
      ],
    ));
  }

  List<DropdownMenuItem<String>> buildAndGetDropDownMenuItems(List ratings) {
    List<DropdownMenuItem<String>> items = List();
    for (String rating in ratings) {
      items.add(DropdownMenuItem(value: rating, child: Text(rating)));
    }
    return items;
  }

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

  Container getDropDown(String label, IconData icon) {
    return (Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment(-1, -1),
            margin: const EdgeInsets.only(top: 30, bottom: 10, left: 35),
            child: Text(label),
          ),
          Row(
            children: <Widget>[
              Container(
                child: Icon(icon),
              ),
              Container(
                width: 330,
                margin: const EdgeInsets.only(left: 12),
                child: DropdownButton(
                  value: _selectedESRBRating,
                  items: _dropDownMenuItems,
                  onChanged: (pickedValue) {
                    _selectedESRBRating = pickedValue;
                  },
                  isExpanded: true,
                ),
              )
            ],
          )
        ],
      ),
    ));
  }

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
}
