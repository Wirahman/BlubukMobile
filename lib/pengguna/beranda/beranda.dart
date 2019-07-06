import 'dart:async';
import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:Blubuk/pengguna/uploadFile/imagePickerHandler.dart';
import 'package:Blubuk/globals.dart' as globals;
import 'package:Blubuk/api/beranda/apistatus.dart' as apistatus;
import 'package:Blubuk/pengguna/beranda/Variabel/status.dart';

import 'package:Blubuk/pengguna/beranda/tampilan/tampilanBeranda.dart';


class Beranda extends StatefulWidget {
  Beranda({Key key, this.title}) : super(key: key);
  final String title;
  @override
  BerandaState createState() => new BerandaState();
}

class BerandaState extends State<Beranda> with TickerProviderStateMixin,ImagePickerListener {
  final formStatus = new GlobalKey<FormState>();
                                                                                                                                                                             
  bool autovalidate = false;
  String userID = globals.userid;
  String status;
  
  File fotoFile;
  AnimationController animationcontroller;
  ImagePickerHandler imagePicker;
  
  int urutanStatus = 0;
  int banyakStatus = 10;
  // List<int> items = List.generate(10, (i) => i);
  List<VariabelStatus> items = new List();
  ScrollController scrollController = new ScrollController();
  bool isPerformingRequest = false;

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
  
  void updateStatus(){
    final FormState form = formStatus.currentState;
    if (!form.validate()) {
      autovalidate = true; // Start validating on every change.
    } else {
      form.save();
      _kirimStatus();
    }
  }

  void _kirimStatus() {
    String isiStatus = status;
    String userId = globals.userid;
    // print(globals.kepalaTokenItem);
    // print(globals.kepalaToken + globals.token);
    // print(isiStatus);
    // print(userId);
  }

  _tampilStatus() async {
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
    }
    urutanStatus = urutanStatus + 10;
  }

  Future<List<VariabelStatus>> tampilStatus(int urutanStatus, int banyakStatus) async {
    var result = await apistatus.StatusUtility.apiStatus(userID, urutanStatus, banyakStatus);
    try {
      var hasilJSON = (json.decode(result)['Pengguna'] as List);
      List<VariabelStatus> products = hasilJSON.map((newEntries) => new VariabelStatus.fromJson(newEntries)).toList();
      return products;
    } catch (e) {
      throw('Error');
    }
  }

  @override
  userImage(File fotoFile) {
    setState(() {
      this.fotoFile = fotoFile;
    });
  }


  @override
  Widget build(BuildContext context) => new TampilanBeranda(this);







}

