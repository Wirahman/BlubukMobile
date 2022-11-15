import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:blubuk/pengguna/uploadFile/imagePickerHandler.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:blubuk/globals.dart' as globals;
import 'package:blubuk/api/forum/apiForum.dart' as apiForum;
import 'package:blubuk/api/upload/uploadFoto.dart' as apiUploadFoto;
import 'package:blubuk/pengguna/forum/model/fotoKomentarForum.dart';
import 'package:blubuk/pengguna/forum/model/komentarForum.dart';
import 'package:blubuk/pengguna/forum/tampilan/tampilanKomentarForum.dart';

class KomentarForum extends StatefulWidget {
  KomentarForum({Key key, this.title}) : super(key: key);
  final String title;
  @override
  KomentarForumState createState() => new KomentarForumState();
}

class KomentarForumState extends State<KomentarForum> with TickerProviderStateMixin,ImagePickerListener {
  final formKomentarForum = new GlobalKey<FormState>();
  final _scaffoldKey = new GlobalKey<ScaffoldState>();

  bool autovalidate = false;
  String userID = globals.userid;

  String komentarForum;
  File fotoFile;

  static String idForumStatic;
  static String idGroupForumStatic;
  static String userIdPembuatStatic;
  static String judulForumStatic;
  static String isiForumStatic;
  static String fotoForumStatic;
  static String waktuForumStatic;
  static String statusSukaForumStatic;
  static String statusBenciForumStatic;
  static String jumlahPenontonForumStatic;
  static String jumlahKomentarForumStatic;
  static String emailPembuatForumStatic;
  static String namaPembuatForumStatic;
  static String fotoPembuatForumStatic;

  String idForum = idForumStatic;
  String idGroupForum = idGroupForumStatic;
  String userIdPembuat = userIdPembuatStatic;
  String judulForum = judulForumStatic;
  String isiForum = isiForumStatic;
  String fotoForum = fotoForumStatic;
  String waktu = waktuForumStatic;
  String statusSuka = statusSukaForumStatic;
  String statusBenci = statusBenciForumStatic;
  String jumlahPenonton = jumlahPenontonForumStatic;
  String jumlahKomentar = jumlahKomentarForumStatic;
  String emailPembuat = emailPembuatForumStatic;
  String namaPembuat = namaPembuatForumStatic;
  String fotoPembuat = fotoPembuatForumStatic;

  CarouselController buttonCarouselController = CarouselController();
  AnimationController animationcontroller;
  ImagePickerHandler imagePicker;

  int urutanKomentarForum = 0;
  int banyakKomentarForum = 10;
  int activePage;
  List<VariabelKomentarForum> items = [];
  List<dynamic> itemsFotoForum = [];
  List<VariabelFotoKomentarForum> itemsFotoKomentarForum = [];
  ScrollController scrollController = new ScrollController();
  bool isPerformingRequest = false;

  String hintTextKomentarForum = 'Masukkan Komentar Anda di Forum ini';
  final TextEditingController textEditingControllerKomentarForum = new TextEditingController();
  CarouselController buttonCarouselKomentarController = CarouselController();

  @override
  void initState() {
    // print("Awal");
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        // print("Scroll Controllers");
        _tampilKomentarForum();
      }
    });
    _ambilFotoForum();
    _tampilKomentarForum();
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

  void kirimKomentarForum(){
    final FormState form = formKomentarForum.currentState;
    if (!form.validate()) {
      autovalidate = true; // Start validating on every change.
    } else {
      form.save();
      _kirimKomentarForum();
    }
  }

  _kirimKomentarForum() async {
    String isiKomentarForum = komentarForum;
    String result = "";
    result = await apiForum.ForumUtility.kirimKomentarForum(idForum, userIdPembuat, isiKomentarForum);
    try {
      Map<String, dynamic> hasilJSON = json.decode(result);
      // print(hasilJSON);
      if ('${hasilJSON['pesan_api']}' == "Berhasil") {
        setState(() {
          items.clear();
          isPerformingRequest = false;
        });
        formKomentarForum.currentState.reset();
        urutanKomentarForum = 0;
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
          hintTextKomentarForum = 'Masukkan Komentar Anda di Forum ini';
        });
        _tampilKomentarForum();
      }else{
        print("Gagal Balas Chat");
      }
    }catch (exception) {
      return false;
    }
  }

  fungsiUbahSukaBenciKomentarForum(String idKomentarForum, String tipe, int noArray) async {
    String userID = globals.userid;
    String result = "";
    print("ID Komentar Forum = " + idKomentarForum);
    print("Tipe = " + tipe);

    result = await apiForum.ForumUtility.ubahSukaBenciKomentarForum(userID, idKomentarForum, tipe);
    try{
      Map<String, dynamic> hasilJSON = json.decode(result);
      print("Result Ubah Suka Benci Komentar Status");
      print(result);
      print("hasilJSON Ubah Suka Benci Komentar Status");
      print(hasilJSON);

      if ( '${hasilJSON['pesan_api']}'== 'Anda sudah berhasil menyukai komentar forum ini') {
        print('1');
        setState(() {
          items[noArray].statusSuka = '1';
        });
      } else if ( '${hasilJSON['pesan_api']}'== 'Anda sudah membatalkan menyukai komentar forum ini') {
        print('0');
        setState(() {
          items[noArray].statusSuka = '0';
        });
      } else if ( '${hasilJSON['pesan_api']}'== 'Anda sudah berhasil membenci komentar forum ini') {
        print('1');
        setState(() {
          items[noArray].statusBenci = '1';
        });
      } else if ( '${hasilJSON['pesan_api']}'== 'Anda sudah membatalkan membenci komentar forum ini') {
        print('0');
        setState(() {
          items[noArray].statusBenci = '0';
        });
      }

    } catch (e) {
      throw('Error');
    }
  }

  _tampilKomentarForum() async {
    print("_tampilKomentarForum");
    if (!isPerformingRequest) {
      setState(() => isPerformingRequest = true);
      List<VariabelKomentarForum> newEntries = await tampilKomentarForum(items.length, banyakKomentarForum); //returns empty list
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
        List<VariabelFotoKomentarForum> newEntriesFotoKomentarForum = await tampilFotoKomentarForum(items[i].idKomentarForum);
        try {
          setState(() {
            itemsFotoKomentarForum.addAll(newEntriesFotoKomentarForum);
          });
        } catch (e) {
          throw('Error');
        }
      }
    }
    urutanKomentarForum = urutanKomentarForum + 10;
  }

  Future<List<VariabelKomentarForum>> tampilKomentarForum(int urutanKomentarForum, int banyakKomentarForum) async {
    print("tampilKomentarForum");
    print("User ID = " + userID);
    print("ID Forum = " + idForum);
    var result = await apiForum.ForumUtility.apiAmbilKomentarForum(userID, idForum, urutanKomentarForum, banyakKomentarForum);
    print("User ID = " + userID);
    print("Urutan Komentar Forum = " + urutanKomentarForum.toString());
    print("Banyak Komentar Forum = " + banyakKomentarForum.toString());
    try {
      var hasilJSON = (json.decode(result)['komentarForum'] as List);
      print(hasilJSON);
      List<VariabelKomentarForum> products = hasilJSON.map((newEntries) => new VariabelKomentarForum.fromJson(newEntries)).toList();
      return products;
    } catch (e) {
      throw('Error');
    }
  }

  Future<List<VariabelFotoKomentarForum>> tampilFotoKomentarForum(String idKomentarForum) async {
    var result = await apiForum.ForumUtility.apiAmbilFotoKomentarForum(globals.userid, idKomentarForum);
    try {
      var hasilJSON = (json.decode(result)['arrayFotoKomentarForum'] as List);
      print(hasilJSON);
      List<VariabelFotoKomentarForum> products = hasilJSON.map((newEntries) => new VariabelFotoKomentarForum.fromJson(newEntries)).toList();
      return products;
    } catch (e) {
      throw('Error');
    }
  }

  hapusKomentarForum(noArray, idKomentarForum) async {
    String result = "";
    final snackbar = new SnackBar(
      duration: new Duration(seconds: 10),
      content: new Row(
        children: <Widget>[
          new CircularProgressIndicator(),
          new Text(" Menghapus Komentar Forum...")
        ],
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
    result = await apiForum.ForumUtility.hapusKomentarForum(idKomentarForum);
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    try {
      Map<String, dynamic> hasilJSON = json.decode(result);
      // print(hasilJSON);
      if ('${hasilJSON['pesan_api']}' == "Berhasil") {
        print("Berhasil Hapus Komentar Forum");
        setState(() {
          items.removeAt(noArray);
        });
        Navigator.of(context).pop();
      }else{
        print("Gagal Hapus Komentar Forum");
        Navigator.of(context).pop();
      }
    }catch (exception) {
      return false;
    }
  }

  fungsiUbahSukaBenciForum(String idForum, String tipe) async{
    String userID = globals.userid;
    String result = "";
    print("ID Forum = " + idForum);
    print("Tipe = " + tipe);
    result = await apiForum.ForumUtility.ubahSukaBenciForum(userID, idForum, tipe);
    try{
      Map<String, dynamic> hasilJSON = json.decode(result);
      print("Result Ubah Suka Benci Status");
      print(result);
      print("hasilJSON Ubah Suka Benci Status");
      print(hasilJSON);

      if ( '${hasilJSON['pesan_api']}'== 'Anda sudah berhasil menyukai forum ini') {
        setState(() {
          statusSuka = 'Suka';
        });
      } else if ( '${hasilJSON['pesan_api']}'== 'Anda sudah membatalkan menyukai forum ini') {
        setState(() {
          statusSuka = '0';
        });
      } else if ( '${hasilJSON['pesan_api']}'== 'Anda sudah berhasil membenci forum ini') {
        setState(() {
          statusBenci = 'Benci';
        });
      } else if ( '${hasilJSON['pesan_api']}'== 'Anda sudah membatalkan membenci forum ini') {
        setState(() {
          statusBenci = '0';
        });
      }

    } catch (e) {
      throw('Error');
    }
  }

  kirimImage(String idJenis, String idKomentarJenis) {
    apiUploadFoto.UploadFotoUtility.uploadFotoKomentar(globals.userid, userIdPembuat, imagePicker.image, "/ApiForum/uploadFotoKomentarForum", "komentar_forum", "Single", idJenis, idKomentarJenis);
  }

  @override
  userImage(fotoFile) {
    setState(() {
      // this.fotoFile = fotoFile;
    });
  }


  @override
  Widget build(BuildContext context) => new TampilanKomentarForum(this);







}

