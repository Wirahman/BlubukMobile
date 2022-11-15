import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:blubuk/pengguna/uploadFile/imagePickerHandler.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:blubuk/globals.dart' as globals;
import 'package:blubuk/api/chat/apiChat.dart' as apichat;
import 'package:blubuk/api/upload/uploadFoto.dart' as apiUploadFoto;
import 'package:blubuk/pengguna/chat/model/balasChat.dart';
import 'package:blubuk/pengguna/chat/model/fotoBalasChat.dart';
import 'package:blubuk/pengguna/chat/tampilan/tampilanBalasChat.dart';

class BalasChat extends StatefulWidget {
  BalasChat({Key key, this.title}) : super(key: key);
  final String title;
  @override
  BalasChatState createState() => new BalasChatState();
}

class BalasChatState extends State<BalasChat> with TickerProviderStateMixin,ImagePickerListener {
  final formBalasChat = new GlobalKey<FormState>();
  final _scaffoldKey = new GlobalKey<ScaffoldState>();

  bool autovalidate = false;
  String userID = globals.userid;

  String balasChat;
  File fotoFile;

  static String idChat;
  static String userIDTemanStatic;
  static String namaTemanStatic;
  static String fotoTemanStatic;

  String userIDTeman = userIDTemanStatic;
  String namaTeman = namaTemanStatic;
  String fotoTeman = fotoTemanStatic;

  AnimationController animationcontroller;
  ImagePickerHandler imagePicker;

  int urutanBalasChat = 0;
  int banyakBalasChat = 10;
  // List<int> items = List.generate(10, (i) => i);
  List<VariabelBalasChat> items = [];
  List<VariabelFotoBalasChat> itemsFotoBalasChat = [];
  ScrollController scrollController = new ScrollController();
  bool isPerformingRequest = false;

  CarouselController buttonCarouselController = CarouselController();
  String hintTextBalasChat = 'Masukkan Pesan Anda';
  final TextEditingController textEditingControllerBalasChat = new TextEditingController();
  @override
  void initState() {
    // print("Awal");
    super.initState();
    _pasangIDChat();
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        // print("Scroll Controllers");
        _tampilBalasChat();
      }
    });
    _tampilBalasChat();
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

  _pasangIDChat() async {
    String result = "";
    result = await apichat.ChatUtility.pasangIDChat(userID, userIDTeman);
    try {
      Map<String, dynamic> hasilJSON = json.decode(result);
      print(hasilJSON);
      if ('${hasilJSON['pesan_api']}' == "Sukses") {
        idChat = '${hasilJSON['IdChat']}';
      }else{
        print("Gagal Ambil ID Chat");
      }
      print("idChat = " + idChat);
    }catch (exception) {
      return false;
    }
  }

  void kirimBalasChat(){
    final FormState form = formBalasChat.currentState;
    if (!form.validate()) {
      autovalidate = true; // Start validating on every change.
    } else {
      form.save();
      _kirimBalasChat();
    }
  }

  _kirimBalasChat() async {
    String isiBalasChat = balasChat;
    String result = "";
    result = await apichat.ChatUtility.kirimBalasChat(userIDTeman, idChat, isiBalasChat, fotoTeman);
    print(result);
    try {
      Map<String, dynamic> hasilJSON = json.decode(result);
      print(hasilJSON);
      if ('${hasilJSON['pesan_api']}' == "Berhasil") {
        setState(() {
          items.clear();
          isPerformingRequest = false;
        });
        formBalasChat.currentState.reset();
        urutanBalasChat = 0;
        if(imagePicker.image != null){
          kirimImage('${hasilJSON['idJenis']}', '${hasilJSON['userIDTeman']}');
        }else if(imagePicker.imageFileList != null){
          for (var i = 0; i < imagePicker.imageFileList.length; i++) {
            imagePicker.image = imagePicker.imageFileList[i];
            kirimImage('${hasilJSON['idJenis']}', '${hasilJSON['userIDTeman']}');
          }
        }else {

        }
        setState(() {
          imagePicker.image = null;
          imagePicker.imageFileList = null;
          hintTextBalasChat = 'Masukkan Pesan Anda';
        });
        _tampilBalasChat();
      }else{
        print("Gagal Balas Chat");
      }
    }catch (exception) {
      return false;
    }
  }

  _tampilBalasChat() async {
    print("_tampilBalasChat");
    if (!isPerformingRequest) {
      setState(() => isPerformingRequest = true);
      List<VariabelBalasChat> newEntries = await tampilBalasChat(items.length, banyakBalasChat); //returns empty list
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
        List<VariabelFotoBalasChat> newEntriesFotoBalasChat = await tampilFotoBalasChat(items[i].idBalasChat);
        try {
          setState(() {
            itemsFotoBalasChat.addAll(newEntriesFotoBalasChat);
          });
        } catch (e) {
          throw('Error');
        }
      }
    }
    urutanBalasChat = urutanBalasChat + 10;
  }

  Future<List<VariabelBalasChat>> tampilBalasChat(int urutanBalasChat, int banyakBalasChat) async {
    print("tampilBalasChat");
    var result = await apichat.ChatUtility.apiBalasChat(userID, userIDTeman, urutanBalasChat, banyakBalasChat);
    print("User ID = " + userID);
    print("Urutan Balas Chat = " + urutanBalasChat.toString());
    print("Banyak Balas Chat = " + banyakBalasChat.toString());
    try {
      var hasilJSON = (json.decode(result)['BalasChat'] as List);
      print(hasilJSON);
      List<VariabelBalasChat> products = hasilJSON.map((newEntries) => new VariabelBalasChat.fromJson(newEntries)).toList();
      return products;
    } catch (e) {
      throw('Error');
    }
  }

  hapusPesan(noArray, idBalasChat) async {
    String result = "";
    final snackbar = new SnackBar(
      duration: new Duration(seconds: 10),
      content: new Row(
        children: <Widget>[
          new CircularProgressIndicator(),
          new Text(" Menghapus Chat...")
        ],
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
    result = await apichat.ChatUtility.hapusBalasChat(idBalasChat);
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    try {
      Map<String, dynamic> hasilJSON = json.decode(result);
      // print(hasilJSON);
      if ('${hasilJSON['pesan_api']}' == "Berhasil") {
        print("Berhasil Hapus Chat");
        setState(() {
          items.removeAt(noArray);
        });
        Navigator.of(context).pop();
      }else{
        print("Gagal Hapus Chat");
        Navigator.of(context).pop();
      }
    }catch (exception) {
      return false;
    }
  }

  Future<List<VariabelFotoBalasChat>> tampilFotoBalasChat(String idBalasChat) async {
    var result = await apichat.ChatUtility.apiAmbilFotoBalasChat(globals.userid, idBalasChat);
    try {
      var hasilJSON = (json.decode(result)['arrayFotoBalasChat'] as List);
      print(hasilJSON);
      List<VariabelFotoBalasChat> products = hasilJSON.map((newEntries) => new VariabelFotoBalasChat.fromJson(newEntries)).toList();
      return products;
    } catch (e) {
      throw('Error');
    }
  }

  kirimImage(String idJenis, String userIDTemanBalasChat) {
    apiUploadFoto.UploadFotoUtility.uploadFoto(globals.userid, userIDTemanBalasChat, imagePicker.image, "/ApiChat/uploadFotoBalasChat", "balas_chat", "Single", idJenis);
  }

  @override
  userImage(fotoFile) {
    setState(() {
      // this.fotoFile = fotoFile;
    });
  }


  @override
  Widget build(BuildContext context) => new TampilanBalasChat(this);







}

