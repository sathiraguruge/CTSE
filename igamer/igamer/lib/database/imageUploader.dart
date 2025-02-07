// This class is used for uploading an Image to firebase
import 'package:firebase_storage/firebase_storage.dart'; // For File Upload To Firestoreker
import 'package:path/path.dart' as Path;
import 'dart:io';

class ImageUploader {
  String _imagePath;
  File _image;
  String __uploadedFileURL = "null";
  final String _remotePath = "images/";

  // Constructor
  ImageUploader(this._imagePath, this._image);

  // this function upload the image to the firebase a returns the downloadable image link in return
  Future<String> uploadFile() async {
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('$_remotePath/${Path.basename(_imagePath)}');
    StorageUploadTask uploadTask = storageReference.putFile(_image);
    await uploadTask.onComplete;

    await storageReference.getDownloadURL().then((fileURL) {
      this.__uploadedFileURL = fileURL;
    });
    return this.__uploadedFileURL;
  }
}
