import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:blubuk/pengguna/uploadFile/imagePickerHandler.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:blubuk/globals.dart' as globals;
import 'package:blubuk/pengguna/menu.dart';
import 'package:blubuk/api/forum/apiForum.dart' as apiForum;
import 'package:blubuk/api/upload/uploadFoto.dart' as apiUploadFoto;
import 'package:blubuk/pengguna/forum/tampilan/tampilanBuatForum.dart';


class BuatForum extends StatefulWidget {
  BuatForum({Key key, this.title}) : super(key: key);
  final String title;
  @override
  BuatForumState createState() => new BuatForumState();
}

class BuatForumState extends State<BuatForum> with TickerProviderStateMixin,ImagePickerListener {
  final formBuatForum = new GlobalKey<FormState>();
  final _scaffoldKey = new GlobalKey<ScaffoldState>();

  bool autovalidate = false;
  final dateFormat = DateFormat("dd-M-yyyy");
  final dateSqlFormat = DateFormat("yyyy-M-dd");

  String userID = globals.userid;
  File fotoFile;
  AnimationController animationcontroller;
  ImagePickerHandler imagePicker;

  bool isPerformingRequest = false;
  String idGroupForum;
  String judulForum;
  String isiForum;


  CarouselController buttonCarouselController = CarouselController();
  String hintTextJudulForum = 'Judul Forum';
  String hintTextIsiForum = 'Isi Forum';
  final TextEditingController textEditingControllerJudulForum = new TextEditingController();
  final TextEditingController textEditingControllerIsiForum = new TextEditingController();

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

  void showInSnackBar(String value) {
    ScaffoldMessenger(
        key: _scaffoldKey,
        child: Scaffold(
          backgroundColor: Colors.blue,
          body: SafeArea(
              child: new Text(value)
          ),
        )
    );
  }

  void buatForum() async {
    final FormState form = formBuatForum.currentState;
    if (!form.validate()) {
      autovalidate = true; // Start validating on every change.
      showInSnackBar('Harap Lengkapi Kolom yang Kosong');
    } else {
      form.save();
      prosesBuatForum();
    }
  }

  prosesBuatForum() async {
    String result = "";
    // Untuk sementara idGroupForum diisi 2
    idGroupForum = "2";
    result = await apiForum.ForumUtility.buatForum(idGroupForum, judulForum, isiForum);
    try {
      Map<String, dynamic> hasilJSON = json.decode(result);
      print(hasilJSON);
      if(imagePicker.image != null){
        kirimImage('${hasilJSON['idJenis']}');
      }else if(imagePicker.imageFileList != null){
        for (var i = 0; i < imagePicker.imageFileList.length; i++) {
          imagePicker.image = imagePicker.imageFileList[i];
          kirimImage('${hasilJSON['idJenis']}');
        }
      }else {

      }
      setState(() {
        imagePicker.image = null;
        imagePicker.imageFileList = null;
      });
      Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) =>
            new Menu()), //When Authorized Navigate to the next screen
      );
    }catch (exception) {
      return false;
    }
  }

  checkImage() async{
    print("1 Image");
    print(imagePicker.image);
    print("Multi Image");
    print(imagePicker.imageFileList);
  }

  kirimImage(String idJenis) {
    apiUploadFoto.UploadFotoUtility.uploadFoto(globals.userid, globals.userid, imagePicker.image, "/ApiForum/uploadFoto", "forum", "Single", idJenis);
  }

  @override
  userImage(fotoFile) {
    setState(() {
      // this.fotoFile = fotoFile;
    });
  }

  @override
  Widget build(BuildContext context) => new TampilanBuatForum(this);

}
