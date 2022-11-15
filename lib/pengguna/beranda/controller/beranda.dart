import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:blubuk/pengguna/uploadFile/imagePickerHandler.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:blubuk/globals.dart' as globals;
import 'package:blubuk/api/beranda/apistatus.dart' as apistatus;
import 'package:blubuk/api/upload/uploadFoto.dart' as apiUploadFoto;
import 'package:blubuk/pengguna/beranda/model/status.dart';
import 'package:blubuk/pengguna/beranda/model/fotoStatus.dart';
import 'package:blubuk/pengguna/beranda/tampilan/tampilanBeranda.dart';
import 'package:blubuk/pengguna/beranda/controller/komentarStatus.dart';

class Beranda extends StatefulWidget {
  Beranda({Key key, this.title}) : super(key: key);
  final String title;
  @override
  BerandaState createState() => new BerandaState();
}

class BerandaState extends State<Beranda> with TickerProviderStateMixin,ImagePickerListener {
  final formStatus = new GlobalKey<FormState>();
  final _scaffoldKey = new GlobalKey<ScaffoldState>();

  bool autovalidate = false;
  String userID = globals.userid;
  String status;

  File fotoFile;
  AnimationController animationcontroller;
  ImagePickerHandler imagePicker;
  
  int urutanStatus = 0;
  int banyakStatus = 10;
  // List<int> items = List.generate(10, (i) => i);
  List<VariabelStatus> items = [];
  List<VariabelFotoStatus> itemsFotoStatus = [];
  ScrollController scrollController = new ScrollController();
  bool isPerformingRequest = false;

  CarouselController buttonCarouselController = CarouselController();
  String hintTextStatus = 'Masukkan Status Anda';
  final TextEditingController textEditingControllerStatus = new TextEditingController();

  @override
  void initState() {
    // print("Awal");
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        // print("Scroll Controllers");
        _tampilStatus();
      }
    });
    _tampilStatus();
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
    scrollController.dispose();
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

  void updateStatus(){
    final FormState form = formStatus.currentState;
    if (!form.validate()) {
      autovalidate = true; // Start validating on every change.
    } else {
      form.save();
      _kirimStatus();
    }
  }

  _kirimStatus() async {
    String isiStatus = status;
    String userID = globals.userid;
    String email = globals.email;
    String name = globals.username;
    String fotoUser = globals.fotoProfil;
    String result = "";
    result = await apistatus.StatusUtility.buatStatus(userID, email, name, fotoUser, isiStatus);
    try {
      Map<String, dynamic> hasilJSON = json.decode(result);
      // print(hasilJSON);
      if ('${hasilJSON['pesan_api']}' == "Berhasil") {
        setState(() {
          items.clear();
          // items.removeRange(0, urutanStatus);
          isPerformingRequest = false;
        });
        formStatus.currentState.reset();
        urutanStatus = 0;
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
          hintTextStatus = 'Masukkan Status Anda';
        });
        _tampilStatus();
      }else{
        print("Gagal Update Status");
      }
    }catch (exception) {
      return false;
    }
  }

  _tampilStatus() async {
    print("_tampilStatus");
    if (!isPerformingRequest) {
      setState(() => isPerformingRequest = true);
      List<VariabelStatus> newEntries = await tampilStatus(items.length, banyakStatus); //returns empty list
      try {
        if (newEntries.isEmpty) {
          double edge = 50.0;
          double offsetFromBottom = scrollController.position.maxScrollExtent - scrollController.position.pixels;
          if (offsetFromBottom < edge) {
            scrollController.animateTo(
                scrollController.offset - (edge -offsetFromBottom),
                duration: new Duration(milliseconds: 500),
                curve: Curves.easeOut);
          }
        }
        setState(() {
          items.addAll(newEntries);
          isPerformingRequest = false;
        });
      } catch (e) {
        throw('Error');
      }
      for(var i = 0; i < items.length; i++){
        List<VariabelFotoStatus> newEntriesFotoStatus = await tampilFotoStatus(items[i].idStatus);
        try {
          setState(() {
            itemsFotoStatus.addAll(newEntriesFotoStatus);
          });
        } catch (e) {
          throw('Error');
        }
      }
    }
    urutanStatus = urutanStatus + 10;
  }

  Future<List<VariabelStatus>> tampilStatus(int urutanStatus, int banyakStatus) async {
    print("tampilStatus");
    var result = await apistatus.StatusUtility.apiStatus(userID, urutanStatus, banyakStatus);
    print("User ID = " + userID);
    print("Urutan Status =" + urutanStatus.toString());
    print("Banyak Status =" + banyakStatus.toString());
    try {
      var hasilJSON = (json.decode(result)['Pengguna'] as List);
      print(hasilJSON);
      List<VariabelStatus> products = hasilJSON.map((newEntries) => new VariabelStatus.fromJson(newEntries)).toList();
      return products;
    } catch (e) {
      throw('Error');
    }
  }

  Future<List<VariabelFotoStatus>> tampilFotoStatus(String idStatus) async {
    var result = await apistatus.StatusUtility.apiAmbilFotoStatus(globals.userid, idStatus);
    try {
      var hasilJSON = (json.decode(result)['arrayFotoStatus'] as List);
      print(hasilJSON);
      List<VariabelFotoStatus> products = hasilJSON.map((newEntries) => new VariabelFotoStatus.fromJson(newEntries)).toList();
      return products;
    } catch (e) {
      throw('Error');
    }
  }

  tampilKomentarStatus(idstatus) async {
    print("Tampil Komentar Status");
    print("ID Status 1 = " + idstatus);
    globals.idStatus = idstatus;
    print("ID Status 2 = " + globals.idStatus);
    Navigator.of(context).push(new MaterialPageRoute<Null>(
        builder: (BuildContext context) {
          return new KomentarStatus();
        },
        fullscreenDialog: true));
  }

  fungsiUbahSukaBenciStatus(String idStatus, String tipe, int noArray) async {
    String userID = globals.userid;
    String result = "";
    print("ID Status = " + idStatus);
    print("Tipe = " + tipe);
    result = await apistatus.StatusUtility.ubahSukaBenciStatus(userID, idStatus, tipe);
    try{
      Map<String, dynamic> hasilJSON = json.decode(result);
      print("Result Ubah Suka Benci Status");
      print(result);
      print("hasilJSON Ubah Suka Benci Status");
      print(hasilJSON);

      if ( '${hasilJSON['pesan_api']}'== 'Anda sudah berhasil menyukai status ini') {
        setState(() {
          items[noArray].suka = '1';
        });
      } else if ( '${hasilJSON['pesan_api']}'== 'Anda sudah membatalkan menyukai status ini') {
        setState(() {
          items[noArray].suka = '0';
        });
      } else if ( '${hasilJSON['pesan_api']}'== 'Anda sudah berhasil membenci status ini') {
        setState(() {
          items[noArray].benci = '1';
        });
      } else if ( '${hasilJSON['pesan_api']}'== 'Anda sudah membatalkan membenci status ini') {
        setState(() {
          items[noArray].benci = '0';
        });
      }

    } catch (e) {
      throw('Error');
    }
  }

  hapusStatus(noArray, idStatus) async {
    String userID = globals.userid;
    String result = "";
    final snackbar = new SnackBar(
      duration: new Duration(seconds: 10),
      content: new Row(
        children: <Widget>[
          new CircularProgressIndicator(),
          new Text(" Menghapus Status...")
        ],
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
    result = await apistatus.StatusUtility.hapusStatus(userID, idStatus);
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    try {
      Map<String, dynamic> hasilJSON = json.decode(result);
      // print(hasilJSON);
      if ('${hasilJSON['pesan_api']}' == "Berhasil") {
        print("Berhasil Hapus Status");
        setState(() {
          // BerandaState().items.removeAt(index);
          items.removeAt(noArray);
        });
        Navigator.of(context).pop();
      }else{
        print("Gagal Hapus Status");
        Navigator.of(context).pop();
      }
    }catch (exception) {
      return false;
    }
  }

  checkImage() {
    print("1 Image");
    print(imagePicker.image);
    print("Multi Image");
    print(imagePicker.imageFileList);
  }

  kirimImage(String idJenis) {
    apiUploadFoto.UploadFotoUtility.uploadFoto(globals.userid, globals.userid, imagePicker.image, "/ApiBeranda/uploadFotoStatus", "status", "Single", idJenis);
  }

  @override
  userImage(fotoFile) {
    setState(() {
      // this.fotoFile = fotoFile;
    });
  }


  @override
  Widget build(BuildContext context) => new TampilanBeranda(this);







}

