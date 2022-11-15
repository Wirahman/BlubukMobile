import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:collection/collection.dart';

import 'package:blubuk/globals.dart' as globals;
import 'package:blubuk/emote/controller/emote.dart' as emote;
import 'package:blubuk/emote/model/emote.dart';
import 'package:blubuk/pengguna/forum/controller/komentarForum.dart';

// ignore: must_be_immutable
class TampilanKomentarForum extends StatelessWidget {
  KomentarForum komentarForum;
  KomentarForumState komentarForumState;

  TampilanKomentarForum(this.komentarForumState);
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('Komentar Forum'),
        ),
        body: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
          this.komentarForumState.fotoForum == 'Ada' ?
              new Column(
                  children: <Widget>[
                    CarouselSlider(
                      items: this.komentarForumState.itemsFotoForum.map((item) => Container(
                        child: Center(
                            child: Image.network(item, fit: BoxFit.cover, width: 1000)
                        ),
                      )).toList(),
                      carouselController: this.komentarForumState.buttonCarouselController,
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
                    //       onPressed: () => this.komentarForumState.buttonCarouselController.previousPage(
                    //           duration: Duration(milliseconds: 300), curve: Curves.linear),
                    //       onLongPress: () => this.komentarForumState.buttonCarouselController.previousPage(
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
                    //       onPressed: () => this.komentarForumState.buttonCarouselController.nextPage(
                    //           duration: Duration(milliseconds: 300), curve: Curves.linear),
                    //       onLongPress: () => this.komentarForumState.buttonCarouselController.nextPage(
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
            Flexible(
                child: ListTile(
                  title: Row(
                    children:
                    emote.Emote().periksaEmote(this.komentarForumState.judulForum),
                  ),
                ),
            ),
            new Container(height: 10.0),
            new ListTile(
              title: Row(
                children:
                emote.Emote().periksaEmote(this.komentarForumState.isiForum),
              ),
            ),
            new Container(height: 10.0),
            Expanded(
              child: TextField(
                maxLines: null,
                expands: true,
                decoration: InputDecoration.collapsed(hintText: "Penulis = " + this.komentarForumState.namaPembuat),
              ),
            ),
            new Row(
              children: [
                TextButton(
                  onPressed: () => komentarForumState.fungsiUbahSukaBenciForum(komentarForumState.idForum, 'suka'),
                  onLongPress: () => komentarForumState.fungsiUbahSukaBenciForum(komentarForumState.idForum, 'suka'),
                  child: komentarForumState.statusSuka == 'Suka'? Icon(Icons.thumb_up_sharp) : Icon(Icons.thumb_up_outlined),
                ),
                TextButton(
                  onPressed: () => komentarForumState.fungsiUbahSukaBenciForum(komentarForumState.idForum, 'benci'),
                  onLongPress: () => komentarForumState.fungsiUbahSukaBenciForum(komentarForumState.idForum, 'benci'),
                  child: komentarForumState.statusBenci == 'Benci'? Icon(Icons.thumb_down_sharp) : Icon(Icons.thumb_down_outlined)
                )
              ],
            ),
            new Container(height: 10.0),
            Form(
              key: komentarForumState.formKomentarForum,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: komentarForumState.textEditingControllerKomentarForum,
                    decoration: new InputDecoration(
                      hintText: komentarForumState.hintTextKomentarForum,
                    ),
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    validator: (val) => val.length < 1 ? 'Harap Masukkan Status Anda Terlebih Dahulu' : null,
                    onSaved: (val) => komentarForumState.komentarForum = val,
                  ),
                  Padding(
                    padding: EdgeInsets.all(5.0),
                    child: new Row(
                      children: <Widget>[
                        new Expanded(
                          child: new Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: new ElevatedButton(
                              onPressed: komentarForumState.kirimKomentarForum,
                              style: ElevatedButton.styleFrom(
                                primary: Colors.blue,
                              ),
                              child: new Text(
                                'Kirim Komentar',
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
                          onTap: () => komentarForumState.imagePicker.showDialog(context),
                          child: new Center(
                              child: komentarForumState.fotoFile == null ?
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
                                    image: new ExactAssetImage(komentarForumState.fotoFile.path),
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
                itemCount: komentarForumState.items.length + 1,
                itemBuilder: (BuildContext context,int index) {
                  if (index == komentarForumState.items.length) {
                    return _buildProgressIndicator();
                  } else {
                    return Padding(
                      padding: EdgeInsets.all(5.0),
                      child: new Column(
                        children: [
                          new ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(komentarForumState.items[index].fotoProfilPemberiKomentar),
                            ),
                            title: new Text(komentarForumState.items[index].namaPemberiKomentar),
                            subtitle: new Text(komentarForumState.items[index].waktu),
                            // trailing: Icon(Icons.comment)
                          ),
                          this.komentarForumState.items[index].fotoKomentarForum == 'Ada' ?
                          new Column(
                              children: <Widget>[
                                CarouselSlider(
                                  items: this.komentarForumState.itemsFotoKomentarForum.map((item) => Container(
                                    child:
                                    komentarForumState.items[index].idKomentarForum == item.idKomentarForum ?
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
                                  carouselController: this.komentarForumState.buttonCarouselKomentarController,
                                  options: CarouselOptions(
                                    height: 200.0,
                                    autoPlay: true,
                                    autoPlayInterval: Duration(seconds: 20),
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
                                //       onPressed: () => this.komentarForumState.buttonCarouselKomentarController.previousPage(
                                //           duration: Duration(milliseconds: 300), curve: Curves.linear),
                                //       onLongPress: () => this.komentarForumState.buttonCarouselKomentarController.previousPage(
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
                                //       onPressed: () => this.komentarForumState.buttonCarouselKomentarController.nextPage(
                                //           duration: Duration(milliseconds: 300), curve: Curves.linear),
                                //       onLongPress: () => this.komentarForumState.buttonCarouselKomentarController.nextPage(
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
                              emote.Emote().periksaEmote(komentarForumState.items[index].isiKomentarForum),
                            ),
                          ),

                          new Row(
                            children: [
                              TextButton(
                                onPressed: () {
                                  komentarForumState.fungsiUbahSukaBenciKomentarForum(komentarForumState.items[index].idKomentarForum, 'suka', index);
                                },
                                onLongPress: () {
                                  komentarForumState.fungsiUbahSukaBenciKomentarForum(komentarForumState.items[index].idKomentarForum, 'suka', index);
                                },
                                child: komentarForumState.items[index].statusSuka == '1'? Icon(Icons.thumb_up_sharp) : Icon(Icons.thumb_up_outlined),
                              ),
                              TextButton(
                                onPressed: () {
                                  komentarForumState.fungsiUbahSukaBenciKomentarForum(komentarForumState.items[index].idKomentarForum, 'benci', index);
                                },
                                onLongPress: () {
                                  komentarForumState.fungsiUbahSukaBenciKomentarForum(komentarForumState.items[index].idKomentarForum, 'benci', index);
                                },
                                child: komentarForumState.items[index].statusBenci == '1'? Icon(Icons.thumb_down_sharp) : Icon(Icons.thumb_down_outlined),
                              ),

                              TextButton(
                                onPressed: () {
                                  if(globals.userid == komentarForumState.items[index].userIDPemberiKomentar){
                                    hapusKomentarForum(context, index, komentarForumState.items[index].idKomentarForum);
                                  }
                                },
                                onLongPress: () {
                                  if(globals.userid == komentarForumState.items[index].userIDPemberiKomentar){
                                    hapusKomentarForum(context, index, komentarForumState.items[index].idKomentarForum);
                                  }
                                },
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: globals.userid == komentarForumState.items[index].userIDPemberiKomentar ? Icon(Icons.delete_forever) : Text(""),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  }
                },
                controller: komentarForumState.scrollController,
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
                              String a = komentarForumState.textEditingControllerKomentarForum.text;
                              String b = emote.nama;
                              print('$a $b');
                              komentarForumState.textEditingControllerKomentarForum.text = ' $a $b';
                            },
                            onLongPress: () {
                              String a = komentarForumState.textEditingControllerKomentarForum.text;
                              String b = emote.nama;
                              print('$a $b');
                              komentarForumState.textEditingControllerKomentarForum.text = ' $a $b';
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

  hapusKomentarForum(BuildContext context, noArray, idKomentarForum) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title : Text('Apakah anda yakin menghapus pesan ini?'),
            content: Text("Apakah anda yakin menghapus pesan ini?"),
            actions: <Widget>[
              new TextButton(
                onPressed: () => komentarForumState.hapusKomentarForum(noArray, idKomentarForum),
                onLongPress: () => komentarForumState.hapusKomentarForum(noArray, idKomentarForum),
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
          opacity: komentarForumState.isPerformingRequest ? 1.0 : 0.0,
          child: new CircularProgressIndicator(),
        ),
      ),
    );
  }


}

