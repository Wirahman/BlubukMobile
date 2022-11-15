import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:blubuk/pengguna/uploadFile/imagePickerHandler.dart';

import 'package:blubuk/globals.dart' as globals;
import 'package:blubuk/api/grup/apiGrup.dart' as apiGrup;
import 'package:blubuk/pengguna/grup/tampilan/tampilanListGrup.dart';



//yang forum nanti dihapus
import 'package:blubuk/api/forum/apiForum.dart' as apiForum;
import 'package:blubuk/pengguna/forum/model/forum.dart';
import 'package:blubuk/pengguna/forum/tampilan/tampilanForum.dart';


class ListGrup extends StatefulWidget {
  ListGrup({Key key, this.title}) : super(key: key);
  final String title;
  @override
  ListGrupState createState() => new ListGrupState();
}

class ListGrupState extends State<ListGrup> with TickerProviderStateMixin,ImagePickerListener {
  String userID = globals.userid;
  String menuGrup = "Group";

  File fotoFile;
  AnimationController animationcontroller;
  ImagePickerHandler imagePicker;

  int urutanForum = 0;
  int banyakForum = 10;
  List<VariabelSemuaForum> items = [];


  ScrollController scrollController = new ScrollController();
  bool isPerformingRequest = false;

  @override
  void initState() {
    print("Awal Menu Forum");
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        _tampilSemuaForum();
      }
    });
    _tampilSemuaForum();
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

  _tampilSemuaForum() async {
    print("Function _tampilSemuaForum");
    if (!isPerformingRequest) {
      setState(() => isPerformingRequest = true);
      List<VariabelSemuaForum> newEntries = await tampilSemuaForum(items.length, banyakForum); //returns empty list
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
    }
    urutanForum = urutanForum + 10;
  }

  Future<List<VariabelSemuaForum>> tampilSemuaForum(int urutanForum, int banyakForum) async {
    print("Function tampilSemuaForum");
    var result = await apiForum.ForumUtility.apiAmbilSemuaForum(urutanForum, banyakForum);
    print(result);
    try {
      var hasilJSON = (json.decode(result)['array']['forum'] as List);
      print(hasilJSON);
      List<VariabelSemuaForum> products = hasilJSON.map((newEntries) => new VariabelSemuaForum.fromJson(newEntries)).toList();
      return products;
    } catch (e) {
      throw("Error");
    }
  }

  hapusForum(noArray, idForum) async {
    String result = "";
    final snackbar = new SnackBar(
      duration: new Duration(seconds: 10),
      content: new Row(
        children: <Widget>[
          new CircularProgressIndicator(),
          new Text(" Sedang Menghapus Forum...")
        ],
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
    result = await apiForum.ForumUtility.hapusForum(idForum);
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    try {
      Map<String, dynamic> hasilJSON = json.decode(result);
      if ('${hasilJSON['pesan_api']}' == "Forum telah dihapus") {
        print("Berhasil Hapus Forum");
        setState(() {
          items.removeAt(noArray);
        });
        Navigator.of(context).pop();
      }else{
        print("Gagal Hapus Forum");
        Navigator.of(context).pop();
      }
    }catch (exception) {
      return false;
    }
  }



  @override
  userImage(fotoFile) {
    setState(() {
      // this.fotoFile = fotoFile;
    });
  }

  @override
  Widget build(BuildContext context) => new TampilanListGrup(this);

}
