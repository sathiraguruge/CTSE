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
final title = 'Update Game Review';

// Main method
void main() => runApp(UpdateGame());

class UpdateGame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: new CustomizedAppBar(title).getAppBar(),
        //getting custom built app bar
        body: UpdateGameForm(title: title),
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

  const UpdateGameForm({Key key, this.title, this.gameRecord}) : super(key: key);

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

  //Initializing text editing controllers
  TextEditingController _titleController;
  TextEditingController _genreController;
  TextEditingController _developerController;
  TextEditingController _noOfUsersController;
  TextEditingController _userScoreController;
  TextEditingController _briefDescController;
  TextEditingController _fullDescController;
  TextEditingController _pubDateController;
  TextEditingController _relDateController;
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

    _titleController = TextEditingController(text: widget.gameRecord != null ? widget.gameRecord.title:'');
    _genreController = TextEditingController(text: widget.gameRecord != null ? widget.gameRecord.genre:'');
    _developerController = TextEditingController(text: widget.gameRecord != null ? widget.gameRecord.developer:'');
    _noOfUsersController = TextEditingController(text: widget.gameRecord != null ? widget.gameRecord.noOfUsers:'');
    _userScoreController = TextEditingController(text: widget.gameRecord != null ? widget.gameRecord.userScore:'');
    _briefDescController = TextEditingController(text: widget.gameRecord != null ? widget.gameRecord.gameDescription:'');
    _fullDescController = TextEditingController(text: widget.gameRecord != null ? widget.gameRecord.fullDescription:'');
    _pubDateController = TextEditingController(text: widget.gameRecord != null ? widget.gameRecord.publishedDate:'');
    _relDateController = TextEditingController(text: widget.gameRecord != null ? widget.gameRecord.releaseDate:'');
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
            _getImagePicker(),
            _commonInputWidgets.getTextField(
                "Game Title", "Forza Horizon", Icons.label, _titleController, "Game title field cannot be empty", focusNode),
            _commonInputWidgets.getTextField(
                "Genre",
                "Racing, Simulation, Automobile",
                Icons.view_agenda,
                _genreController, "Genre field cannot be empty", focusNode),
            _commonInputWidgets.getDatePicker(
                "Released Date", Icons.calendar_today, _relDateController, "Released Date field cannot be empty", focusNode),
            _commonInputWidgets.getDatePicker(
                "Published Date", Icons.new_releases, _pubDateController, "Published Date field cannot be empty", focusNode),
            _commonInputWidgets.getNumberTextField(
                "No Of Users", "2", Icons.person, true, _noOfUsersController, "No. of users field cannot be empty", focusNode),
            _commonInputWidgets.getTextArea(
                "Brief Description",
                "This will appear on main screen",
                Icons.assignment,
                _briefDescController, "Brief Description field cannot be empty", focusNode),
            _commonInputWidgets.getTextArea(
                "Full Description",
                "This will appear on detail screen",
                Icons.videogame_asset,
                _fullDescController, "Full Description field cannot be empty", focusNode),
            _getDropDown("ESRB Rating", Icons.rate_review),
            _commonInputWidgets.getTextField("Developer", "Playground Games",
                Icons.build, _developerController, "Developer field cannot be empty", focusNode),
            _commonInputWidgets.getNumberTextField(
                "User Score", "7.8", Icons.score, false, _userScoreController, "User Score field cannot be empty", focusNode),

            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new RaisedButton(
                    padding: const EdgeInsets.all(10.0),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text('Updating Game Review'),
                          duration: const Duration(seconds: 1),
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
                        await CRUD().editGame(game);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyHomePage()));
                      }
                    },
                    child: new Text('Update'),
                    color: Colors.orange.withOpacity(0.9),
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10.0))),

                new RaisedButton(
                    padding: const EdgeInsets.all(10.0),
                    onPressed: (){
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
                        borderRadius: new BorderRadius.circular(10.0)))],
            ),
          ],
        ),
      ),
    );
  }

  // this function returns a random integer between 0 and 10000
  int _generateID() {
    var random = Random();
    return random.nextInt(10000);
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
}
