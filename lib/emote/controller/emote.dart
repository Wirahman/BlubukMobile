import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import 'package:blubuk/globals.dart' as globals;

class Emote {
  String userID = globals.userid;

  List<Widget> periksaEmote(String isi) {
    List<Widget> arrayIsi = [];
    isi.split(' ').map((text) {
      Widget loopingSemuaEmote =
      Flexible(
        child: Text(text + ' '),
      );
      globals.listSemuaEmote.forEachIndexed((index, element) {
        if(text == element.nama){
          loopingSemuaEmote =
              Flexible(
                child: new Image.asset(element.url),
              );
        }
      });
      arrayIsi.add(loopingSemuaEmote);
    }).toList();
    return arrayIsi;
  }



}