import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
final title = 'Update Game Review';

// Main method
void main() => runApp(UpdateGame());

class UpdateGame extends StatelessWidget {
  final GameRecord game;

  const UpdateGame({Key key, this.game}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: new CustomizedAppBar(title).getAppBar(),
        //getting custom built app bar
        body: UpdateGameForm(title: title, gameRecord: game),
        drawer: new CustomizedDrawer(context)
            .getDrawer(), //getting custom built app drawer
      ),
    );
  }
}

// Create a Form widget.
class UpdateGameForm extends StatefulWidget {
  final String title;
  final GameRecord gameRecord;

  UpdateGameForm({Key key, this.title, this.gameRecord}) : super(key: key);

  @override
  UpdateGameFormState createState() {
    return UpdateGameFormState();
  }
}

class UpdateGameFormState extends State<UpdateGameForm> {
  final _formKey = GlobalKey<FormState>();
  FocusNode focusNode;
  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _selectedESRBRating;
  File _image;
  bool _greyOutBackground = false;

  //Initializing text editing controllers for update operation
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
    _selectedESRBRating = widget.gameRecord.esrbRating;
    _greyOutBackground = false;
    //_image = null;

    _image = new File(widget.gameRecord.imageLink);
    Image.file(_image);

    //setting values through constructor
    _titleController = TextEditingController(text: widget.gameRecord.title != null ? widget.gameRecord.title : '');
    _genreController = TextEditingController(text: widget.gameRecord.genre != null ? widget.gameRecord.genre : '');
    _relDateController = TextEditingController(text: widget.gameRecord.releaseDate != null ? widget.gameRecord.releaseDate : '');
    _pubDateController = TextEditingController(text: widget.gameRecord.publishedDate != null ? widget.gameRecord.publishedDate : '');
    _briefDescController = TextEditingController(text: widget.gameRecord.gameDescription != null ? widget.gameRecord.gameDescription : '');
    _fullDescController = TextEditingController(text: widget.gameRecord.fullDescription != null ? widget.gameRecord.fullDescription : '');
    _noOfUsersController = TextEditingController(text: widget.gameRecord.noOfUsers != null ? widget.gameRecord.noOfUsers : '');
    _developerController = TextEditingController(text: widget.gameRecord.developer != null ? widget.gameRecord.developer : '');
    _userScoreController = TextEditingController(text: widget.gameRecord.userScore != null ? widget.gameRecord.userScore : '');
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor:
      _greyOutBackground == true ? Colors.grey : Colors.transparent,
      body: Stack(
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
                                content: Text('Updating Existing Game Review'),
                              ));
                              ImageUploader uploader = new ImageUploader(
                                  _titleController.text +
                                      "-" +
                                      widget.gameRecord.gameID.toString(),
                                  _image);
                              var imageURL = await uploader.uploadFile();
                              GameRecord game = new GameRecord(
                                widget.gameRecord.gameID,
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
                              widget.gameRecord.reference);
                              await CRUD().editGame(game, game.reference);
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
    );
  }

  // this function brings the drop down list to its initial state
  Future _getlist() async {
    return
      setState(() {
        _dropDownMenuItems = _buildAndGetDropDownMenuItems(_ratings);
        _selectedESRBRating = _dropDownMenuItems[0].value;
      });
  }

  // this function picks an image from the gallery and set to _image
  Future _getImage() async {
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
        _image == null ? new Text('No image selected.') : Image.file(_image), // if no image is selected show Text else show the image
        _image == null // if no image is selected, show Choose Image button
            ? new RaisedButton(
            child: Text('Choose Image'),
            onPressed: () {
              _getImage();
            },
            color: Colors.cyan.withOpacity(0.9),
            shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(10.0)))
            : Container(),
        _image != null // if image is selected, show Remove Button
            ? new Container(
          margin: const EdgeInsets.only(top: 10, bottom: 20),
          child: RaisedButton(
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
              color: Colors.red.withOpacity(0.9),
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
