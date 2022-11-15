import 'dart:io';
import 'package:flutter/material.dart';
import 'package:blubuk/pengguna/uploadFile/imagePickerHandler.dart';

import 'package:blubuk/globals.dart' as globals;
import 'package:blubuk/pengguna/grup/tampilan/tampilanGrup.dart';

class Grup extends StatefulWidget {
  Grup({Key key, this.title}) : super(key: key);
  final String title;
  @override
  GrupState createState() => new GrupState();
}

class GrupState extends State<Grup> with TickerProviderStateMixin,ImagePickerListener {
  String userID = globals.userid;
  String menuGrup = "Group";

  File fotoFile;
  AnimationController animationcontroller;
  ImagePickerHandler imagePicker;

  bool isPerformingRequest = false;

  @override
  void initState() {
    print("Awal Menu Forum");
    super.initState();
    animationcontroller = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    imagePicker=new ImagePickerHandler(this,animationcontroller);
    imagePicker.init();
  }

  @override
  void dispose() {
    animationcontroller.dispose();
    super.dispose();
  }


  @override
  userImage(fotoFile) {
    setState(() {
      // this.fotoFile = fotoFile;
    });
  }

  @override
  Widget build(BuildContext context) => new TampilanGrup(this);

}
