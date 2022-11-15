import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:collection/collection.dart';

import 'package:blubuk/globals.dart' as globals;
import 'package:blubuk/emote/controller/emote.dart' as emote;
import 'package:blubuk/emote/model/emote.dart';
import 'package:blubuk/pengguna/chat/controller/balasChat.dart';

// ignore: must_be_immutable
class TampilanBalasChat extends StatelessWidget {
  BalasChat balasChat;
  BalasChatState balasChatState;

  TampilanBalasChat(this.balasChatState);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        // here we display the title corresponding to the fragment
        // you can instead choose to have a static title
        title: new Text('Pesan'),
      ),
      body: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Form(
            key: balasChatState.formBalasChat,
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: balasChatState.textEditingControllerBalasChat,
                  decoration: new InputDecoration(
                    hintText: balasChatState.hintTextBalasChat,
                  ),
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  validator: (val) => val.length < 1 ? 'Harap Masukkan Pesan Anda Terlebih Dahulu' : null,
                  onSaved: (val) => balasChatState.balasChat = val,
                ),
                Padding(
                  padding: EdgeInsets.all(5.0),
                  child: new Row(
                    children: <Widget>[
                      new Expanded(
                        child: new Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: new ElevatedButton(
                            onPressed: balasChatState.kirimBalasChat,
                            style: ElevatedButton.styleFrom(
                              primary: Colors.blue,
                            ),
                            child: new Text(
                              'Kirim Pesan',
                              style: new TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      new GestureDetector(
                        onTap: () => tampilSemuaEmote(context),
                        child: new Center(
                            child: new Stack(
                              children: <Widget>[
                                new Center(
                                  child: new Icon(Icons.emoji_emotions_outlined),
                                ),
                              ],
                            )
                        ),
                      ),
                      SizedBox(width: 20),
                      new GestureDetector(
                        onTap: () => balasChatState.imagePicker.showDialog(context),
                        child: new Center(
                            child: balasChatState.fotoFile == null ?
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
                                  image: new ExactAssetImage(balasChatState.fotoFile.path),
                                  fit: BoxFit.cover,
                                ),
                                border: Border.all(color: Colors.red, width: 5.0),
                                borderRadius:
                                new BorderRadius.all(const Radius.circular(80.0)),
                              ),
                            )
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            child: ListView.builder(
              itemCount: balasChatState.items.length + 1,
              itemBuilder: (BuildContext context,int index) {
                if (index == balasChatState.items.length) {
                  return _buildProgressIndicator();
                } else {
                  return Padding(
                    padding: EdgeInsets.all(5.0),
                    child: new Column(
                      children: [
                        new ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(balasChatState.items[index].fotoProfil),
                            ),
                            title: new Text(balasChatState.items[index].nama),
                            subtitle: new Text(balasChatState.items[index].waktu),
                            // trailing: Icon(Icons.comment)
                        ),
                        this.balasChatState.items[index].fotoBalasChat == 'Ada' ?
                        new Column(
                            children: <Widget>[
                              CarouselSlider(
                                items: this.balasChatState.itemsFotoBalasChat.map((item) => Container(
                                  child:
                                  balasChatState.items[index].idBalasChat == item.idBalasChat ?
                                  Column(
                                    children: [
                                      Center(
                                          child: Image.network(item.namaFile, fit: BoxFit.cover, width: 300, height: 150,)
                                      )
                                    ],
                                  )
                                      :
                                  Text(''),
                                )).toList(),
                                carouselController: this.balasChatState.buttonCarouselController,
                                options: CarouselOptions(
                                  height: 200.0,
                                  autoPlay: true,
                                  autoPlayInterval: Duration(seconds: 3),
                                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                                  autoPlayCurve: Curves.fastOutSlowIn,
                                  pauseAutoPlayOnTouch: true,
                                  enlargeCenterPage: true,
                                  viewportFraction: 0.9,
                                  aspectRatio: 2.0,
                                  initialPage: 2,
                                ),
                              ),
                              // new Row(
                              //   children: [
                              //     TextButton(
                              //       onPressed: () => this.balasChatState.buttonCarouselController.previousPage(
                              //           duration: Duration(milliseconds: 300), curve: Curves.linear),
                              //       onLongPress: () => this.balasChatState.buttonCarouselController.previousPage(
                              //           duration: Duration(milliseconds: 300), curve: Curves.linear),
                              //       child: new Text("←",
                              //         textAlign: TextAlign.center,
                              //         style:  const TextStyle(
                              //             color: Colors.blue,
                              //             fontSize: 14.0,
                              //             fontFamily: "Roboto",
                              //             fontWeight: FontWeight.bold),
                              //       ),
                              //     ),
                              //     TextButton(
                              //       onPressed: () => this.balasChatState.buttonCarouselController.nextPage(
                              //           duration: Duration(milliseconds: 300), curve: Curves.linear),
                              //       onLongPress: () => this.balasChatState.buttonCarouselController.nextPage(
                              //           duration: Duration(milliseconds: 300), curve: Curves.linear),
                              //       child: new Text("→",
                              //         textAlign: TextAlign.center,
                              //         style:  const TextStyle(
                              //             color: Colors.blue,
                              //             fontSize: 14.0,
                              //             fontFamily: "Roboto",
                              //             fontWeight: FontWeight.bold),
                              //       ),
                              //     )
                              //   ],
                              // )
                            ]
                        )
                            :
                        Text(''),
                        new ListTile(
                          title: Row(
                            children:
                            emote.Emote().periksaEmote(balasChatState.items[index].pesan),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            if(globals.userid == balasChatState.items[index].userID){
                              hapusPesan(context, index, balasChatState.items[index].idBalasChat);
                              // hapusPesan(context, index, balasChatState.items[index].idKomentarChat);
                            }
                          },
                          onLongPress: () {
                            if(globals.userid == balasChatState.items[index].userID){
                              hapusPesan(context, index, balasChatState.items[index].idBalasChat);
                              // hapusPesan(context, index, balasChatState.items[index].idKomentarChat);
                            }
                          },
                          child: Container(
                              alignment: Alignment.centerLeft,
                              child: globals.userid == balasChatState.items[index].userID ? Icon(Icons.delete_forever) : Text(""),
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
              controller: balasChatState.scrollController,
            ),
          ),
        ],
      )
    );
  }

  tampilSemuaEmote(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title : Text('Emote Blubuk'),
            content:
            Wrap(
              spacing: 10,
              children: (
                  globals.listSemuaEmote.mapIndexed((index, VariabelEmote emote) =>
                      Flexible(
                          child:
                          GestureDetector(
                            onTap: (){
                              String a = balasChatState.textEditingControllerBalasChat.text;
                              String b = emote.nama;
                              print('$a $b');
                              balasChatState.textEditingControllerBalasChat.text = ' $a $b';
                            },
                            onLongPress: () {
                              String a = balasChatState.textEditingControllerBalasChat.text;
                              String b = emote.nama;
                              print('$a $b');
                              balasChatState.textEditingControllerBalasChat.text = ' $a $b';
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

  hapusPesan(BuildContext context, noArray, idBalasChat) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title : Text('Apakah anda yakin menghapus pesan ini?'),
            content: Text("Apakah anda yakin menghapus pesan ini?"),
            actions: <Widget>[
              new TextButton(
                onPressed: () => balasChatState.hapusPesan(noArray, idBalasChat),
                onLongPress: () => balasChatState.hapusPesan(noArray, idBalasChat),
                child: new Text("Yes",
                  textAlign: TextAlign.center,
                  style:  const TextStyle(
                      color: Colors.blue,
                      fontSize: 14.0,
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.bold),
                ),
              ), new TextButton(
                onPressed: () => Navigator.of(context).pop(),
                onLongPress: () => Navigator.of(context).pop(),
                child: new Text("No",
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


  Widget _buildProgressIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: new Opacity(
          opacity: balasChatState.isPerformingRequest ? 1.0 : 0.0,
          child: new CircularProgressIndicator(),
        ),
      ),
    );
  }


}

