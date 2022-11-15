import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:blubuk/pengguna/uploadFile/imagePickerHandler.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:blubuk/globals.dart' as globals;
import 'package:blubuk/api/beranda/apistatus.dart' as apistatus;
import 'package:blubuk/api/upload/uploadFoto.dart' as apiUploadFoto;
import 'package:blubuk/pengguna/beranda/model/fotoStatus.dart';
import 'package:blubuk/pengguna/beranda/model/fotoKomentarStatus.dart';
import 'package:blubuk/pengguna/beranda/model/komentarStatus.dart';
import 'package:blubuk/pengguna/beranda/tampilan/tampilanKomentarStatus.dart';

class KomentarStatus extends StatefulWidget {
  KomentarStatus({Key key, this.title}) : super(key: key);
  final String title;
  @override
  KomentarStatusState createState() => new KomentarStatusState();
}

class KomentarStatusState extends State<KomentarStatus> with TickerProviderStateMixin,ImagePickerListener {
  final formKomentarStatus = new GlobalKey<FormState>();
  // final _scaffoldKey = new GlobalKey<ScaffoldState>();

  bool autovalidate = false;
  String userID = globals.userid;
  String komentarStatus;

  String userIDPengirimStatus;
  String namaPengirimStatus;
  String emailPengirimStatus;
  String isiStatus;
  String fotoPengirimStatus;
  String waktuStatus;
  String fotoStatus;

  File fotoFile;
  AnimationController animationcontroller;
  ImagePickerHandler imagePicker;

  int urutanKomentarStatus = 0;
  int banyakKomentarStatus = 10;
  List<VariabelKomentarStatus> items = [];
  List<VariabelFotoStatus> itemsFotoStatus = [];
  List<VariabelFotoKomentarStatus> itemsFotoKomentarStatus = [];
  ScrollController scrollController = new ScrollController();
  bool isPerformingRequest = false;
  CarouselController buttonCarouselControllerStatus = CarouselController();
  CarouselController buttonCarouselKomentarController = CarouselController();

  String hintTextKomentarStatus = 'Masukkan Komentar Anda';
  final TextEditingController textEditingControllerKomentarStatus = new TextEditingController();
  @override
  void initState() {
    // print("Awal");
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        // print("Scroll Controllers");
        _tampilKomentarStatus();
      }
    });
    ambilSatuStatus();
    _tampilKomentarStatus();
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

  ambilSatuStatus() async {
    String userID = globals.userid;
    String idStatus = globals.idStatus;
    String result = "";
    result = await apistatus.StatusUtility.ambilSatuStatus(userID, idStatus);
    try{
      Map<String, dynamic> hasilJSON = json.decode(result);

      userIDPengirimStatus = '${hasilJSON['Pengguna'][0]['userID']}';
      namaPengirimStatus = '${hasilJSON['Pengguna'][0]['name']}';
      emailPengirimStatus = '${hasilJSON['Pengguna'][0]['email']}';
      isiStatus = '${hasilJSON['Pengguna'][0]['isi']}';
      fotoPengirimStatus = '${hasilJSON['Pengguna'][0]['fotoProfil']}';
      waktuStatus = '${hasilJSON['Pengguna'][0]['waktu']}';
      fotoStatus = '${hasilJSON['Pengguna'][0]['fotoStatus']}';
    } catch (e) {
      throw('Error');
    }

    List<VariabelFotoStatus> newEntriesFotoStatus = await tampilFotoStatus(idStatus);
    try {
      setState(() {
        itemsFotoStatus.addAll(newEntriesFotoStatus);
      });
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

  fungsiUbahSukaBenciKomentarStatus(String idKomentarStatus, String tipe, int noArray) async {
    String userID = globals.userid;
    String result = "";
    print("ID Komentar Status = " + idKomentarStatus);
    print("Tipe = " + tipe);

    result = await apistatus.StatusUtility.ubahSukaBenciKomentarStatus(userID, idKomentarStatus, tipe);
    try{
      Map<String, dynamic> hasilJSON = json.decode(result);
      print("Result Ubah Suka Benci Komentar Status");
      print(result);
      print("hasilJSON Ubah Suka Benci Komentar Status");
      print(hasilJSON);

      if ( '${hasilJSON['pesan_api']}'== 'Anda sudah berhasil menyukai komentar status ini') {
        print('1');
        setState(() {
          items[noArray].statusSuka = '1';
        });
      } else if ( '${hasilJSON['pesan_api']}'== 'Anda sudah membatalkan menyukai komentar status ini') {
        print('0');
        setState(() {
          items[noArray].statusSuka = '0';
        });
      } else if ( '${hasilJSON['pesan_api']}'== 'Anda sudah berhasil membenci komentar status ini') {
        print('1');
        setState(() {
          items[noArray].statusBenci = '1';
        });
      } else if ( '${hasilJSON['pesan_api']}'== 'Anda sudah membatalkan membenci komentar status ini') {
        print('0');
        setState(() {
          items[noArray].statusBenci = '0';
        });
      }

    } catch (e) {
      throw('Error');
    }
  }

  _tampilKomentarStatus() async {
    print("_tampilKomentarStatus");
    if (!isPerformingRequest) {
      setState(() => isPerformingRequest = true);
      List<VariabelKomentarStatus> newEntries = await tampilKomentarStatus(items.length, banyakKomentarStatus); //returns empty list
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
        List<VariabelFotoKomentarStatus> newEntriesFotoKomentarStatus = await tampilFotoKomentarStatus(items[i].idKomentarStatus);
        try {
          setState(() {
            itemsFotoKomentarStatus.addAll(newEntriesFotoKomentarStatus);
          });
        } catch (e) {
          throw('Error');
        }
      }
    }
    urutanKomentarStatus = urutanKomentarStatus + 10;
  }

  Future<List<VariabelKomentarStatus>> tampilKomentarStatus(int urutanKomentarStatus, int banyakKomentarStatus) async {
    print("tampilKomentarStatus");
    var result = await apistatus.StatusUtility.apiKomentarStatus(userID,globals.idStatus, urutanKomentarStatus, banyakKomentarStatus);
    print("User ID = " + userID);
    print("ID Status = " + globals.idStatus);
    print("Urutan Komentar Status =" + urutanKomentarStatus.toString());
    print("Banyak Komentar Status =" + banyakKomentarStatus.toString());
    try {
      var hasilJSON = (json.decode(result)['Pengguna'] as List);
      print(hasilJSON);
      List<VariabelKomentarStatus> products = hasilJSON.map((newEntries) => new VariabelKomentarStatus.fromJson(newEntries)).toList();
      return products;
    } catch (e) {
      throw('Error');
    }
  }

  Future<List<VariabelFotoKomentarStatus>> tampilFotoKomentarStatus(String idKomentarStatus) async {
    var result = await apistatus.StatusUtility.apiAmbilFotoKomentarStatus(globals.userid, idKomentarStatus);
    try {
      var hasilJSON = (json.decode(result)['arrayFotoKomentarStatus'] as List);
      print(hasilJSON);
      List<VariabelFotoKomentarStatus> products = hasilJSON.map((newEntries) => new VariabelFotoKomentarStatus.fromJson(newEntries)).toList();
      return products;
    } catch (e) {
      throw('Error');
    }
  }

  void updateKomentarStatus(){
    final FormState form = formKomentarStatus.currentState;
    if (!form.validate()) {
      autovalidate = true; // Start validating on every change.
    } else {
      form.save();
      _kirimKomentarStatus();
    }
  }

  _kirimKomentarStatus() async {
    String isiKomentarStatus = komentarStatus;
    String userID = globals.userid;
    String idStatus = globals.idStatus;
    String fotoUser = globals.fotoProfil;
    String result = "";
    result = await apistatus.StatusUtility.buatKomentarStatus(userID, idStatus, fotoUser, isiKomentarStatus);
    try {
      Map<String, dynamic> hasilJSON = json.decode(result);
      // print(hasilJSON);
      if ('${hasilJSON['pesan_api']}' == "Berhasil") {
        print("Update Status Berhasil");
        setState(() {
          items.clear();
          // items.removeRange(0, urutanKomentarStatus);
          isPerformingRequest = false;
        });
        formKomentarStatus.currentState.reset();
        urutanKomentarStatus = 0;
        if(imagePicker.image != null){
          kirimImage('${hasilJSON['idJenis']}', '${hasilJSON['idKomentarJenis']}');
        }else if(imagePicker.imageFileList != null){
          for (var i = 0; i < imagePicker.imageFileList.length; i++) {
            imagePicker.image = imagePicker.imageFileList[i];
            kirimImage('${hasilJSON['idJenis']}', '${hasilJSON['idKomentarJenis']}');
          }
        }else {

        }
        setState(() {
          imagePicker.image = null;
          imagePicker.imageFileList = null;
          hintTextKomentarStatus = 'Masukkan Komentar Anda';
        });
        _tampilKomentarStatus();
      }else{
        print("Gagal Update Status");
      }
    }catch (exception) {
      return false;
    }
  }

  hapusKomentarStatus(idKomentarStatus, int noArray) async {
    String userID = globals.userid;
    String result = "";
    final snackbar = new SnackBar(
      duration: new Duration(seconds: 10),
      content: new Row(
        children: <Widget>[
          new CircularProgressIndicator(),
          new Text(" Menghapus Komentar Status...")
        ],
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
    result = await apistatus.StatusUtility.hapusKomentarStatus(userID, idKomentarStatus);
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    try {
      Map<String, dynamic> hasilJSON = json.decode(result);
      // print(hasilJSON);
      if ('${hasilJSON['pesan_api']}' == "Berhasil") {
        setState(() {
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

  kirimImage(String idJenis, String idKomentarJenis) {
    apiUploadFoto.UploadFotoUtility.uploadFotoKomentar(globals.userid, userIDPengirimStatus, imagePicker.image, "/ApiBeranda/uploadFotoKomentarStatus", "komentar_status", "Single", idJenis, idKomentarJenis);
  }

  @override
  userImage(fotoFile) {
    setState(() {
      // this.fotoFile = fotoFile;
    });
  }

  @override
  Widget build(BuildContext context) => new TampilanKomentarStatus(this);



}