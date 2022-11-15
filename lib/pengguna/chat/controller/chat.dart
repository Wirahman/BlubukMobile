import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:blubuk/pengguna/uploadFile/imagePickerHandler.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:blubuk/globals.dart' as globals;
import 'package:blubuk/api/chat/apichat.dart' as apichat;
import 'package:blubuk/pengguna/chat/model/chat.dart';
import 'package:blubuk/pengguna/chat/model/fotoChat.dart';
import 'package:blubuk/pengguna/chat/tampilan/tampilanChat.dart';

class Chat extends StatefulWidget {
  Chat({Key key, this.title}) : super(key: key);
  final String title;
  @override
  ChatState createState() => new ChatState();
}

class ChatState extends State<Chat> with TickerProviderStateMixin,ImagePickerListener {
  String userID = globals.userid;

  File fotoFile;
  AnimationController animationcontroller;
  ImagePickerHandler imagePicker;

  int urutanChat = 0;
  int banyakChat = 10;
  List<VariabelSemuaChat> items = [];
  ScrollController scrollController = new ScrollController();
  bool isPerformingRequest = false;

  List<VariabelFotoChat> itemsFotoChat = [];
  CarouselController buttonCarouselController = CarouselController();

  @override
  void initState() {
    print("Awal Menu Chat");
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        _tampilSemuaChat();
      }
    });
    _tampilSemuaChat();
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

  _tampilSemuaChat() async {
    print("Function _tampilSemuaChat");
    if (!isPerformingRequest) {
      setState(() => isPerformingRequest = true);
      List<VariabelSemuaChat> newEntries = await tampilSemuaChat(items.length, banyakChat); //returns empty list
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
        List<VariabelFotoChat> newEntriesFotoChat = await tampilFotoChat(items[i].idBalasChat);
        try {
          setState(() {
            itemsFotoChat.addAll(newEntriesFotoChat);
          });
        } catch (e) {
          throw('Error');
        }
      }
    }
    urutanChat = urutanChat + 10;
  }

  Future<List<VariabelSemuaChat>> tampilSemuaChat(int urutanChat, int banyakChat) async {
    print("Function tampilSemuaChat");
    var result = await apichat.ChatUtility.apiSemuaChat(userID, urutanChat, banyakChat);
    print("User ID = " + userID);
    print(result);
    try {
      var hasilJSON = (json.decode(result)['Chat'] as List);
      print(hasilJSON);
      List<VariabelSemuaChat> products = hasilJSON.map((newEntries) => new VariabelSemuaChat.fromJson(newEntries)).toList();
      return products;
    } catch (e) {
      throw("Error");
    }
  }

  Future<List<VariabelFotoChat>> tampilFotoChat(String idBalasChat) async {
    var result = await apichat.ChatUtility.apiAmbilFotoBalasChat(globals.userid, idBalasChat);
    try {
      var hasilJSON = (json.decode(result)['arrayFotoBalasChat'] as List);
      print(hasilJSON);
      List<VariabelFotoChat> products = hasilJSON.map((newEntries) => new VariabelFotoChat.fromJson(newEntries)).toList();
      return products;
    } catch (e) {
      throw('Error');
    }
  }

  @override
  userImage(fotoFile) {
    setState(() {
      // this.fotoFile = fotoFile;
    });
  }

  @override
  Widget build(BuildContext context) => new TampilanChat(this);

}



