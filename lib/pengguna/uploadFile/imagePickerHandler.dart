import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:blubuk/pengguna/uploadFile/imagePickerDialog.dart';
// import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import 'package:blubuk/globals.dart' as globals;
import 'package:blubuk/pengguna/biografi/controller/biografi.dart';

class ImagePickerHandler {
  ImagePickerDialog imagePicker;
  AnimationController _controller;
  ImagePickerListener _listener;
  final ImagePicker imgPicker = ImagePicker();

  ImagePickerHandler(this._listener, this._controller);
  XFile image;
  List<XFile> imageFileList = [];
  XFile croppedFile;

  openCamera() async {
    imagePicker.dismissDialog();
    image = await ImagePicker().pickImage(source: ImageSource.camera);
    if(image == null){
      return;
    }else{
      Image.file(File(image.path));
    }
  }

  openGallery() async {
    imagePicker.dismissDialog();
    final List<XFile> selectedImages = await imgPicker.pickMultiImage();
    if (selectedImages.isNotEmpty) {
      imageFileList.addAll(selectedImages);
    }
  }

  void init() {
    imagePicker = new ImagePickerDialog(this, _controller);
    imagePicker.initState();
  }



  Future cropImage(XFile image) async {
    // croppedFile = await ImageCropper().cropImage(
    //   sourcePath: image.path,
    //   // ratioX: 1.0,
    //   // ratioY: 1.0,
    //   maxWidth: 512,
    //   maxHeight: 512,
    // );
    globals.fotoUpload = croppedFile;
    _listener.userImage(croppedFile);
    globals.fotoUpload = croppedFile;
    _listener.userImage(croppedFile);
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
  userImage(XFile _image);
}