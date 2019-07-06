import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:Blubuk/pengguna/uploadFile/imagePickerDialog.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import 'package:Blubuk/globals.dart' as globals;
import 'package:Blubuk/pengguna/biografi/controller/biografi.dart';

class ImagePickerHandler {
  ImagePickerDialog imagePicker;
  AnimationController _controller;
  ImagePickerListener _listener;

  ImagePickerHandler(this._listener, this._controller);

  openCamera() async {
    imagePicker.dismissDialog();
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    if(image == null){
      return;
    }else{
      cropImage(image);
    }    
  }

  openGallery() async {
    imagePicker.dismissDialog();
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if(image == null){
      return;
    }else{
      cropImage(image);
    }    
  }

  void init() {
    imagePicker = new ImagePickerDialog(this, _controller);
    imagePicker.initState();
  }

  Future cropImage(File image) async {
    File croppedFile = await ImageCropper.cropImage(
      sourcePath: image.path,
      ratioX: 1.0,
      ratioY: 1.0,
      maxWidth: 512,
      maxHeight: 512,
    );
    globals.fotoUpload = croppedFile;
    _listener.userImage(croppedFile);
    // BiografiState().updateFotoBiografi();
    kumpulanUpdateFoto();
    print(croppedFile);
    print(image);
  }

  kumpulanUpdateFoto() {
    if (globals.menu == "Biografi") {
      BiografiState().updateFotoBiografi();
    }

  }

  showDialog(BuildContext context) {
    imagePicker.getImage(context);
  }
}

abstract class ImagePickerListener {
  userImage(File _image);
}