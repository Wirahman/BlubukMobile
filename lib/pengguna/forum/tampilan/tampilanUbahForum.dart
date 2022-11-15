import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

import 'package:blubuk/globals.dart' as globals;
import 'package:blubuk/emote/model/emote.dart';
import 'package:blubuk/pengguna/forum/controller/ubahForum.dart';

// ignore: must_be_immutable
class TampilanUbahForum extends StatelessWidget {
  UbahForum ubahForum;
  UbahForumState ubahForumState;

  TampilanUbahForum(this.ubahForumState);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Ubah Forum'),
      ),
      body: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Form(
              key: ubahForumState.formUbahForum,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new TextFormField(
                    controller: ubahForumState.textEditingControllerJudulForum,
                    decoration: new InputDecoration(labelText: 'Judul Forum'),
                    validator: (val) => val.length < 1 ? 'Harap Lengkapi Judul Forum' : null,
                    onSaved: (val) => ubahForumState.judulForum = val,
                    maxLines: null,
                    obscureText: false,
                    keyboardType: TextInputType.text,
                    autocorrect: false,
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
                    controller: ubahForumState.textEditingControllerIsiForum,
                    decoration: new InputDecoration(labelText: 'Isi Forum'),
                    validator: (val) => val.length < 1 ? 'Harap Lengkapi Isi Forum' : null,
                    onSaved: (val) => ubahForumState.isiForum = val,
                    obscureText: false,
                    autocorrect: false,
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
                            onPressed: ubahForumState.ubahForum,
                            style: ElevatedButton.styleFrom(
                              primary: Colors.blue,
                            ),
                            child: new Text(
                              'Ubah Forum',
                              style: new TextStyle(color: Colors.white),
                            ),
                          ),
                          SizedBox(width: 20),
                          new GestureDetector(
                            onTap: () => ubahForumState.imagePicker.showDialog(context),
                            child: new Center(
                                child: ubahForumState.fotoFile == null ?
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
                                      image: new ExactAssetImage(ubahForumState.fotoFile.path),
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
                  new GestureDetector(
                    onTap: () => tampilSemuaFotoUbahForum(context),
                    child: new Container(
                        child: new Stack(
                          children: <Widget>[
                            new Container(
                              child: new Text("Lihat Foto Forum"),
                            ),
                          ],
                        )
                    ),
                  ),
                ],
              ),
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
                              String a = ubahForumState.textEditingControllerJudulForum.text;
                              String b = emote.nama;
                              print('$a $b');
                              ubahForumState.textEditingControllerJudulForum.text = ' $a $b';
                            },
                            onLongPress: () {
                              String a = ubahForumState.textEditingControllerJudulForum.text;
                              String b = emote.nama;
                              print('$a $b');
                              ubahForumState.textEditingControllerJudulForum.text = ' $a $b';
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
                              String a = ubahForumState.textEditingControllerIsiForum.text;
                              String b = emote.nama;
                              print('$a $b');
                              ubahForumState.textEditingControllerIsiForum.text = ' $a $b';
                            },
                            onLongPress: () {
                              String a = ubahForumState.textEditingControllerIsiForum.text;
                              String b = emote.nama;
                              print('$a $b');
                              ubahForumState.textEditingControllerIsiForum.text = ' $a $b';
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

  tampilSemuaFotoUbahForum(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title : Text('Foto Forum'),
            content:
            Wrap(
                spacing: 10,
                children: (
                    ubahForumState.itemsFotoForum.mapIndexed((index, element) =>
                        Flexible(
                          child:
                          GestureDetector(
                            onTap: (){
                              tampilHapusFoto(context, element);
                            },
                            onLongPress: () {
                              tampilHapusFoto(context, element);
                            },
                            child: Image.network(
                              element,
                              height: 50,
                              width: 50,
                            ),
                          ),
                        )
                    ).toList()
                )
            ),
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


  tampilHapusFoto(BuildContext context, element) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title : Text('Hapus Foto'),
            content:
            Text("Anda Yakin Menghapus foto ini?"),
            actions: <Widget>[
              new TextButton(
                onPressed: () => Navigator.of(context).pop(),
                onLongPress: () => Navigator.of(context).pop(),
                child: new Text("Tidak",
                  textAlign: TextAlign.center,
                  style:  const TextStyle(
                      color: Colors.blue,
                      fontSize: 14.0,
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.bold),
                ),
              ),
              new TextButton(
                onPressed: () => ubahForumState.hapusFotoForum(element),
                onLongPress: () => ubahForumState.hapusFotoForum(element),
                child: new Text("Ya",
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


