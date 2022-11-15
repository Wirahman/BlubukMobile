import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:blubuk/pengguna/uploadFile/imagePickerHandler.dart';
import 'package:intl/intl.dart';

import 'package:blubuk/globals.dart' as globals;
import 'package:blubuk/pengguna/menu.dart';
import 'package:blubuk/api/forum/apiForum.dart' as apiForum;
import 'package:blubuk/api/upload/uploadFoto.dart' as apiUploadFoto;
import 'package:blubuk/pengguna/forum/tampilan/tampilanUbahForum.dart';


class UbahForum extends StatefulWidget {
  UbahForum({Key key, this.title}) : super(key: key);
  final String title;
  @override
  UbahForumState createState() => new UbahForumState();
}

class UbahForumState extends State<UbahForum> with TickerProviderStateMixin,ImagePickerListener {
  String userID = globals.userid;
  final formUbahForum = new GlobalKey<FormState>();
  // final formKey = new GlobalKey<FormState>();
  final ubahForumScaffoldKey = new GlobalKey<ScaffoldState>();
  bool autovalidate = false;
  final dateFormat = DateFormat("dd-M-yyyy");
  final dateSqlFormat = DateFormat("yyyy-M-dd");

  File fotoFile;
  AnimationController animationcontroller;
  ImagePickerHandler imagePicker;

  bool isPerformingRequest = false;
  static String idForumStatic;
  static String idGroupForumStatic;
  static String judulForumStatic;
  static String isiForumStatic;

  String idForum = idForumStatic;
  String idGroupForum = idGroupForumStatic;
  String judulForum = judulForumStatic;
  String isiForum = isiForumStatic;

  List<dynamic> itemsFotoForum = [];

  TextEditingController textEditingControllerJudulForum;
  TextEditingController textEditingControllerIsiForum;
  @override
  void initState() {
    print("Awal Menu Forum");
    super.initState();
    textEditingControllerJudulForum = new TextEditingController(text: judulForumStatic);
    textEditingControllerIsiForum = new TextEditingController(text: isiForumStatic);
    animationcontroller = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _ambilFotoForum();
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
        key: ubahForumScaffoldKey,
        child: Scaffold(
          backgroundColor: Colors.blue,
          body: SafeArea(
              child: new Text(value)
          ),
        )
    );
  }

  void ambilFotoForum() async {
    itemsFotoForum.clear();
    _ambilFotoForum();
  }

  _ambilFotoForum() async {
    var result = await apiForum.ForumUtility.ambilFotoForum(userID, idForum);
    try {
      Map<String, dynamic> hasilJSON = json.decode(result);
      hasilJSON['arrayFotoForum'].forEach((item){
        itemsFotoForum.add(item['namaFile']);
      });
      print("itemsFotoForum");
      print(itemsFotoForum);
    }catch (exception) {
      return false;
    }
  }

  void ubahForum() async {
    final FormState form = formUbahForum.currentState;
    if (!form.validate()) {
      autovalidate = true; // Start validating on every change.
      showInSnackBar('Harap Lengkapi Kolom yang Kosong');
    } else {
      form.save();
      prosesUbahForum();
    }
  }

  prosesUbahForum() async {
    String result = "";
    result = await apiForum.ForumUtility.updateForum(idForum, idGroupForum, judulForum, isiForum);
    try {
      Map<String, dynamic> hasilJSON = json.decode(result);
      print(hasilJSON);
      if(imagePicker.image != null){
        kirimImage(idForum);
      }else if(imagePicker.imageFileList != null){
        for (var i = 0; i < imagePicker.imageFileList.length; i++) {
          imagePicker.image = imagePicker.imageFileList[i];
          kirimImage(idForum);
        }
      }else {

      }
      globals.menu = "Forum";
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

  hapusFotoForum(String urlFoto) {
    print(urlFoto);
    String dbFoto = 'foto';
    String jenisFoto = 'forum';
    apiForum.ForumUtility.apiHapusFotoForum(userID, urlFoto, dbFoto, jenisFoto);
    Navigator.push(
      context,
      new MaterialPageRoute(
          builder: (context) =>
          new Menu()), //When Authorized Navigate to the next screen
    );
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
  Widget build(BuildContext context) => new TampilanUbahForum(this);

}
