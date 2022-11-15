import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

import 'package:blubuk/globals.dart' as globals;
import 'package:blubuk/emote/model/emote.dart';
import 'package:blubuk/pengguna/forum/controller/buatForum.dart';

// ignore: must_be_immutable
class TampilanBuatForum extends StatelessWidget {
  BuatForum buatForum;
  BuatForumState buatForumState;

  TampilanBuatForum(this.buatForumState);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Buat Forum Baru'),
      ),
      body: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Form(
            key: buatForumState.formBuatForum,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new TextFormField(
                  controller: buatForumState.textEditingControllerJudulForum,
                  decoration: new InputDecoration(
                    hintText: buatForumState.hintTextJudulForum,
                  ),
                  validator: (val) => val.length < 1 ? 'Harap Lengkapi Judul Forum' : null,
                  onSaved: (val) => buatForumState.judulForum = val,
                  maxLines: null,
                  obscureText: false,
                  keyboardType: TextInputType.multiline,
                  autocorrect: false,
                  // initialValue: buatForumState.judulForum,
                ),
                new GestureDetector(
                  onTap: () => tampilSemuaEmoteJudulForum(context),
                  child: new Container(
                      child: new Stack(
                        children: <Widget>[
                          new Container(
                            child: new Icon(Icons.emoji_emotions_outlined),
                          ),
                        ],
                      )
                  ),
                ),
                SizedBox(width: 20),
                new Container(height: 10.0),
                new TextFormField(
                  minLines: 6,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  controller: buatForumState.textEditingControllerIsiForum,
                  decoration: new InputDecoration(
                    hintText: buatForumState.hintTextIsiForum,
                  ),
                  validator: (val) => val.length < 1 ? 'Harap Lengkapi Isi Forum' : null,
                  onSaved: (val) => buatForumState.isiForum = val,
                  obscureText: false,
                  autocorrect: false,
                  // initialValue: buatForumState.isiForum,
                ),
                new GestureDetector(
                  onTap: () => tampilSemuaEmoteIsiForum(context),
                  child: new Container(
                      child: new Stack(
                        children: <Widget>[
                          new Container(
                            child: new Icon(Icons.emoji_emotions_outlined),
                          ),
                        ],
                      )
                  ),
                ),
                new Container(height: 10.0),
                Padding(
                  padding: EdgeInsets.all(5.0),
                  child: new Row(
                      children: <Widget>[
                        new ElevatedButton(
                          onPressed: buatForumState.buatForum,
                          style: ElevatedButton.styleFrom(
                            primary: Colors.blue,
                          ),
                          child: new Text(
                            'Buat Forum Baru',
                            style: new TextStyle(color: Colors.white),
                          ),
                        ),
                        SizedBox(width: 20),
                        new GestureDetector(
                          onTap: () => buatForumState.imagePicker.showDialog(context),
                          child: new Center(
                              child: buatForumState.fotoFile == null ?
                              new Stack(
                                children: <Widget>[
                                  new Center(
                                    child: new Icon(Icons.add_a_photo),
                                  ),
                                ],
                              ) : new Container(
                                height: 160.0,
                                width: 160.0,
                                decoration: new BoxDecoration(
                                  color: Colors.blue,
                                  image: new DecorationImage(
                                    image: new ExactAssetImage(buatForumState.fotoFile.path),
                                    fit: BoxFit.cover,
                                  ),
                                  border: Border.all(color: Colors.red, width: 5.0),
                                  borderRadius:
                                  new BorderRadius.all(const Radius.circular(80.0)),
                                ),
                              )
                          ),
                        ),
                      ]
                  ),
                ),
              ],
            )
          )
        ],
      ),
    );
  }

  tampilSemuaEmoteJudulForum(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title : Text('Emote Judul Forum'),
            content:
            Wrap(
              spacing: 10,
              children: (
                  globals.listSemuaEmote.mapIndexed((index, VariabelEmote emote) =>
                      Flexible(
                          child:
                          GestureDetector(
                            onTap: (){
                              String a = buatForumState.textEditingControllerJudulForum.text;
                              String b = emote.nama;
                              print('$a $b');
                              buatForumState.textEditingControllerJudulForum.text = ' $a $b';
                            },
                            onLongPress: () {
                              String a = buatForumState.textEditingControllerJudulForum.text;
                              String b = emote.nama;
                              print('$a $b');
                              buatForumState.textEditingControllerJudulForum.text = ' $a $b';
                            },
                            child: Image.asset(
                              emote.url,
                              fit: BoxFit.cover,
                              height: 20,
                              width: 20,
                            ),
                          )
                      )
                  ).toList()
              ),
            ),

            // content: Text("Buat isi Emote Blubuk"),
            actions: <Widget>[
              new TextButton(
                onPressed: () => Navigator.of(context).pop(),
                onLongPress: () => Navigator.of(context).pop(),
                child: new Text("Oke",
                  textAlign: TextAlign.center,
                  style:  const TextStyle(
                      color: Colors.blue,
                      fontSize: 14.0,
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          );
        }
    );
  }

  tampilSemuaEmoteIsiForum(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title : Text('Emote Isi Forum'),
            content:
            Wrap(
              spacing: 10,
              children: (
                  globals.listSemuaEmote.mapIndexed((index, VariabelEmote emote) =>
                      Flexible(
                          child:
                          GestureDetector(
                            onTap: (){
                              String a = buatForumState.textEditingControllerIsiForum.text;
                              String b = emote.nama;
                              print('$a $b');
                              buatForumState.textEditingControllerIsiForum.text = ' $a $b';
                            },
                            onLongPress: () {
                              String a = buatForumState.textEditingControllerIsiForum.text;
                              String b = emote.nama;
                              print('$a $b');
                              buatForumState.textEditingControllerIsiForum.text = ' $a $b';
                            },
                            child: Image.asset(
                              emote.url,
                              fit: BoxFit.cover,
                              height: 20,
                              width: 20,
                            ),
                          )
                      )
                  ).toList()
              ),
            ),

            // content: Text("Buat isi Emote Blubuk"),
            actions: <Widget>[
              new TextButton(
                onPressed: () => Navigator.of(context).pop(),
                onLongPress: () => Navigator.of(context).pop(),
                child: new Text("Oke",
                  textAlign: TextAlign.center,
                  style:  const TextStyle(
                      color: Colors.blue,
                      fontSize: 14.0,
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          );
        }
    );
  }


}


