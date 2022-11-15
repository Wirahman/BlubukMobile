import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:blubuk/pengguna/uploadFile/imagePickerHandler.dart';

import 'package:blubuk/globals.dart' as globals;
import 'package:blubuk/api/teman/apiTeman.dart' as apiteman;
import 'package:blubuk/pengguna/teman/model/teman.dart';
import 'package:blubuk/pengguna/teman/tampilan/tampilanTeman.dart';

class Teman extends StatefulWidget {
  Teman({Key key, this.title}) : super(key: key);
  final String title;
  @override
  TemanState createState() => new TemanState();
}

class TemanState extends State<Teman> with TickerProviderStateMixin,ImagePickerListener {
  String userID = globals.userid;

  File fotoFile;
  AnimationController animationcontroller;
  ImagePickerHandler imagePicker;

  int urutanTeman = 0;
  int banyakTeman = 10;
  // List<int> items = List.generate(10, (i) => i);
  List<VariabelTeman> items = [];
  ScrollController scrollController = new ScrollController();
  bool isPerformingRequest = false;

  @override
  void initState() {
    print("Awal");
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        // print("Scroll Controllers");
        _tampilTeman();
      }
    });
    _tampilTeman();
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

  _tampilTeman() async {
    print("Function _tampilTeman");
    if (!isPerformingRequest) {
      setState(() => isPerformingRequest = true);
      List<VariabelTeman> newEntries = await tampilTeman(items.length, banyakTeman); //returns empty list
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
    urutanTeman = urutanTeman + 10;
  }

  Future<List<VariabelTeman>> tampilTeman(int urutanTeman, int banyakTeman) async {
    print("Function tampilTeman");
    var result = await apiteman.TemanUtility.apiTeman(userID, urutanTeman, banyakTeman);
    print("User ID = " + userID);
    print("Urutan Teman =" + urutanTeman.toString());
    print("Banyak Teman =" + banyakTeman.toString());
    try {
      var hasilJSON = (json.decode(result)['Teman'] as List);
      print(hasilJSON);
      List<VariabelTeman> products = hasilJSON.map((newEntries) => new VariabelTeman.fromJson(newEntries)).toList();
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
  Widget build(BuildContext context) => new TampilanTeman(this);







}




// class Teman extends StatelessWidget {
//   void _cariTeman(namaTeman){
//     print(namaTeman);
//
//   }
//   @override
//   Widget build(BuildContext context) => new Center(
//     child: new Container(
//       alignment: FractionalOffset.topLeft,
//       child: new TextField(
//         decoration: new InputDecoration(
//           hintText: 'Masukkan Nama Teman Anda',
//         ),
//         maxLines: null,
//         keyboardType: TextInputType.multiline,
//         onChanged: (namaTeman) => _cariTeman(namaTeman),
//       ),
//     ),
//   );
//
// }