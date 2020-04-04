import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:igamer/common_ui_widgets/drawer.dart';
import 'package:igamer/common_ui_widgets/inputWidgets.dart';
import 'package:igamer/database/crud.dart';
import 'package:igamer/database/gameRecord.dart';
import 'package:igamer/database/imageUploader.dart';
import '../common_ui_widgets/appBar.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'main.dart';

// Name of the page
final title = 'Add Game Review';

// Main method
void main() => runApp(AddGame());

class AddGame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: new CustomizedAppBar(title).getAppBar(),
        //getting custom built app bar
        body: AddGameForm(title: title),
        drawer: new CustomizedDrawer(context)
            .getDrawer(), //getting custom built app drawer
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
  FocusNode focusNode;
  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _selectedESRBRating;
  File _image;
  bool _greyOutBackground = false;

  //Initializing text editing controllers
  TextEditingController _titleController = new TextEditingController();
  TextEditingController _genreController = new TextEditingController();
  TextEditingController _relDateController = new TextEditingController();
  TextEditingController _pubDateController = new TextEditingController();
  TextEditingController _noOfUsersController = new TextEditingController();
  TextEditingController _briefDescController = new TextEditingController();
  TextEditingController _fullDescController = new TextEditingController();
  TextEditingController _developerController = new TextEditingController();
  TextEditingController _userScoreController = new TextEditingController();
  CommonInputWidgets _commonInputWidgets = new CommonInputWidgets();

  //Initializing drop down values for ESRB Ratings
  List _ratings = [
    "RP - Rating Pending",
    "EC - Early Childhood",
    "E - Everyone",
    "E10+ - Everyone 10+",
    "T - Teen",
    "M - Mature",
    "AO - Adults Only"
  ];

  // initializing local variables at the beginning of the screen
  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
    _dropDownMenuItems = _buildAndGetDropDownMenuItems(_ratings);
    _selectedESRBRating = _dropDownMenuItems[0].value;
    _image = null;
    _greyOutBackground = false;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor:
          _greyOutBackground == true ? Colors.grey : Colors.transparent,
      body: new GestureDetector(
        onTap: (){
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Stack(
          children: <Widget>[
            if (_greyOutBackground) _getCircularProgressIndicator(),
            Form(
              key: _formKey,
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _getImagePicker(),
                    _commonInputWidgets.getTextField(
                        "Game Title",
                        "Forza Horizon",
                        Icons.label,
                        _titleController,
                        "Game title field cannot be empty",
                        focusNode),
                    _commonInputWidgets.getTextField(
                        "Genre",
                        "Racing, Simulation, Automobile",
                        Icons.view_agenda,
                        _genreController,
                        "Genre field cannot be empty",
                        focusNode),
                    _commonInputWidgets.getDatePicker(
                        "Released Date",
                        Icons.calendar_today,
                        _relDateController,
                        "Released Date field cannot be empty",
                        focusNode),
                    _commonInputWidgets.getDatePicker(
                        "Published Date",
                        Icons.new_releases,
                        _pubDateController,
                        "Published Date field cannot be empty",
                        focusNode),
                    _commonInputWidgets.getNumberTextField(
                        "No Of Users",
                        "2",
                        Icons.person,
                        true,
                        _noOfUsersController,
                        "No. of users field cannot be empty",
                        focusNode),
                    _commonInputWidgets.getTextArea(
                        "Brief Description",
                        "This will appear on main screen",
                        Icons.assignment,
                        _briefDescController,
                        "Brief Description field cannot be empty",
                        focusNode),
                    _commonInputWidgets.getTextArea(
                        "Full Description",
                        "This will appear on detail screen",
                        Icons.videogame_asset,
                        _fullDescController,
                        "Full Description field cannot be empty",
                        focusNode),
                    _getDropDown("ESRB Rating", Icons.rate_review),
                    _commonInputWidgets.getTextField(
                        "Developer",
                        "Playground Games",
                        Icons.build,
                        _developerController,
                        "Developer field cannot be empty",
                        focusNode),
                    _commonInputWidgets.getNumberTextField(
                        "User Score",
                        "7.8",
                        Icons.score,
                        false,
                        _userScoreController,
                        "User Score field cannot be empty",
                        focusNode),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        new RaisedButton(
                            padding: const EdgeInsets.all(10.0),
                            onPressed: () async {
                              setState(() {
                                _greyOutBackground = true;
                              });
                              if (_formKey.currentState.validate()) {
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text('Adding New Game Review'),
                                ));
                                ImageUploader uploader = new ImageUploader(
                                    _titleController.text +
                                        "-" +
                                        _generateID().toString(),
                                    _image);
                                var imageURL = await uploader.uploadFile();
                                GameRecord game = new GameRecord(
                                    _generateID(),
                                    _titleController.text,
                                    _pubDateController.text,
                                    _briefDescController.text,
                                    imageURL,
                                    _genreController.text,
                                    _developerController.text,
                                    _relDateController.text,
                                    _fullDescController.text,
                                    _selectedESRBRating,
                                    _userScoreController.text,
                                    _noOfUsersController.text,
                                    null);
                                await CRUD().addGame(game);
                                setState(() {
                                  _greyOutBackground = false;
                                });
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MyHomePage()));
                              }
                            },
                            child: new Text('Submit'),
                            color: Colors.orange.withOpacity(0.9),
                            shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(10.0))),
                        new RaisedButton(
                            padding: const EdgeInsets.all(10.0),
                            onPressed: () {
                              _formKey.currentState.reset();
                              _clearImage();
                              _titleController.clear();
                              _genreController.clear();
                              _relDateController.clear();
                              _pubDateController.clear();
                              _noOfUsersController.clear();
                              _briefDescController.clear();
                              _fullDescController.clear();
                              _getlist();
                              _developerController.clear();
                              _userScoreController.clear();
                            },
                            child: new Text('Reset'),
                            color: Colors.orange.withOpacity(0.9),
                            shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(10.0)))
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      )
    );
  }

  // this function returns a random integer between 0 and 10000
  int _generateID() {
    var random = Random();
    return random.nextInt(10000);
  }

  // this function brings the drop down list to its initial state
  Future _getlist() async {
    return setState(() {
      _dropDownMenuItems = _buildAndGetDropDownMenuItems(_ratings);
      _selectedESRBRating = _dropDownMenuItems[0].value;
    });
  }

  // this function gets an image from the camera and set to _image
  Future _getImageFromCamera() async {
    return ImagePicker.pickImage(source: ImageSource.camera).then((file) {
      setState(() {
        _image = file;
      });
    });
  }

  // this function picks an image from the gallery and set to _image
  Future _getImageFromGallery() async {
    return ImagePicker.pickImage(source: ImageSource.gallery).then((file) {
      setState(() {
        _image = file;
      });
    });
  }

  // the function removes the selected image from the gallery
  Future _clearImage() async {
    setState(() {
      _image = null;
    });
  }

  // this function returns a Column having an Image Picker
  Column _getImagePicker() {
    return (new Column(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(bottom: 20),
          child: Text(
            'Cover Image',
            style: TextStyle(fontSize: 25),
          ),
        ),
        _image == null ? new Text('No image selected.') : Image.file(_image, height: 187, width: 400, fit: BoxFit.fitWidth,),
        // if no image is selected show Text else show the image
        _image == null // if no image is selected, show Choose Image button
            ? new Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            FloatingActionButton(
              heroTag: 'btn_camera',
              onPressed: _getImageFromCamera,
              tooltip: 'Pick Image',
              child: Icon(Icons.add_a_photo),
            ),
            FloatingActionButton(
              heroTag: 'btn_gallery',
              onPressed: _getImageFromGallery,
              tooltip: 'Pick Image',
              child: Icon(Icons.wallpaper),),],)
            : Container(),
        _image != null // if image is selected, show Remove Button
            ? new Container(
                margin: const EdgeInsets.only(top: 10, bottom: 20),
                child: new RaisedButton(
                    child: Container(
                      width: 85,
                      height: 40,
                      child: Row(
                        children: <Widget>[Icon(Icons.delete), Text('Remove')],
                        mainAxisAlignment: MainAxisAlignment.center,
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        _clearImage();
                      });
                    },
                    color: Colors.red.withOpacity(0.80),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10.0))),
              )
            : Container()
      ],
    ));
  }

  // this function adds items in the ratings list to the Drop down menu item
  List<DropdownMenuItem<String>> _buildAndGetDropDownMenuItems(List ratings) {
    List<DropdownMenuItem<String>> items = List();
    for (String rating in ratings) {
      items.add(DropdownMenuItem(value: rating, child: Text(rating)));
    }
    return items;
  }

  // this function returns a dropdown list
  Container _getDropDown(String label, IconData icon) {
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
                    setState(() {
                      _selectedESRBRating = pickedValue;
                    });
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

  Center _getCircularProgressIndicator() {
    return Center(
        child: new Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 50,
          width: 50,
          child: CircularProgressIndicator(),
        ),
        Container(
          margin: const EdgeInsets.only(top: 10),
          child: Text(
            "Please wait",
            style: TextStyle(fontSize: 18),
          ),
        )
      ],
    ));
  }
}
