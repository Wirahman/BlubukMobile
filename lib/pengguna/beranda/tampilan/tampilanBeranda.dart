import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:collection/collection.dart';

import 'package:blubuk/globals.dart' as globals;
import 'package:blubuk/emote/controller/emote.dart' as emote;
import 'package:blubuk/emote/model/emote.dart';
import 'package:blubuk/pengguna/beranda/controller/beranda.dart';

// ignore: must_be_immutable
class TampilanBeranda extends StatelessWidget {
  Beranda beranda;
  BerandaState berandaState;

  TampilanBeranda(this.berandaState);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Form(
          key: berandaState.formStatus,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: berandaState.textEditingControllerStatus,
                decoration: new InputDecoration(
                  hintText: berandaState.hintTextStatus,
                ),
                maxLines: null,
                keyboardType: TextInputType.multiline,
                validator: (val) => val.length < 1 ? 'Harap Masukkan Status Anda Terlebih Dahulu' : null,
                onSaved: (val) => berandaState.status = val,
              ),
              Padding(
                padding: EdgeInsets.all(5.0),
                child: new Row(
                  children: <Widget>[
                    new Expanded(
                      child: new Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: new ElevatedButton(
                          onPressed: berandaState.updateStatus,
                          style: ElevatedButton.styleFrom(
                            primary: Colors.blue,
                          ),
                          child: new Text(
                            'Update Status',
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
                      onTap: () => berandaState.imagePicker.showDialog(context),
                      child: new Center(
                          child: berandaState.fotoFile == null ?
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
                                image: new ExactAssetImage(berandaState.fotoFile.path),
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
            itemCount: berandaState.items.length + 1,
            itemBuilder: (BuildContext context,int index) {
              if (index == berandaState.items.length) {
                return _buildProgressIndicator();
              } else {
                return Padding(
                  padding: EdgeInsets.all(5.0),
                  child: new Column(
                    children: [
                      new ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(berandaState.items[index].fotoProfil),
                        ),
                        title: new Text(berandaState.items[index].name),
                        subtitle: new Text(berandaState.items[index].waktu),
                      ),

                      this.berandaState.items[index].fotoStatus == 'Ada' ?
                      new Column(
                          children: <Widget>[
                            CarouselSlider(
                              items: this.berandaState.itemsFotoStatus.map((item) => Container(
                                child:
                                berandaState.items[index].idStatus == item.idStatus ?
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
                              carouselController: this.berandaState.buttonCarouselController,
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
                            //       onPressed: () => this.berandaState.buttonCarouselController.previousPage(
                            //           duration: Duration(milliseconds: 300), curve: Curves.linear),
                            //       onLongPress: () => this.berandaState.buttonCarouselController.previousPage(
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
                            //       onPressed: () => this.berandaState.buttonCarouselController.nextPage(
                            //           duration: Duration(milliseconds: 300), curve: Curves.linear),
                            //       onLongPress: () => this.berandaState.buttonCarouselController.nextPage(
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
                              emote.Emote().periksaEmote(berandaState.items[index].isi),
                        ),
                      ),
                      new Row(
                        children: [
                          TextButton(
                            onPressed: () => berandaState.tampilKomentarStatus(berandaState.items[index].idStatus),
                            onLongPress: () => berandaState.tampilKomentarStatus(berandaState.items[index].idStatus),
                            child: Icon(Icons.comment),
                          ),
                          TextButton(
                            onPressed: () => berandaState.fungsiUbahSukaBenciStatus(berandaState.items[index].idStatus, 'suka', index),
                            onLongPress: () => berandaState.fungsiUbahSukaBenciStatus(berandaState.items[index].idStatus, 'suka', index),
                            child: berandaState.items[index].suka == '1'? Icon(Icons.thumb_up_sharp) : Icon(Icons.thumb_up_outlined),
                          ),
                          TextButton(
                              onPressed: () => berandaState.fungsiUbahSukaBenciStatus(berandaState.items[index].idStatus, 'benci', index),
                              onLongPress: () => berandaState.fungsiUbahSukaBenciStatus(berandaState.items[index].idStatus, 'benci', index),
                              child: berandaState.items[index].benci == '1'? Icon(Icons.thumb_down_sharp) : Icon(Icons.thumb_down_outlined)
                          ),
                          TextButton(
                              onPressed: () {
                                if(globals.userid == berandaState.items[index].userID){
                                  hapusPesan(context, index, berandaState.items[index].idStatus);
                                }
                              },
                              onLongPress: () {
                                if(globals.userid == berandaState.items[index].userID){
                                  hapusPesan(context, index, berandaState.items[index].idStatus);
                                }
                              },
                              child: globals.userid == berandaState.items[index].userID ? Icon(Icons.delete_forever) : Text(""),
                          )
                        ],
                      ),
                    ],
                  ),
                );
              }
            },
            controller: berandaState.scrollController,
          ),
        ),
      ],
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
                        String a = berandaState.textEditingControllerStatus.text;
                        String b = emote.nama;
                        print('$a $b');
                        berandaState.textEditingControllerStatus.text = ' $a $b';
                      },
                      onLongPress: () {
                        String a = berandaState.textEditingControllerStatus.text;
                        String b = emote.nama;
                        print('$a $b');
                        berandaState.textEditingControllerStatus.text = ' $a $b';
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

  hapusPesan(BuildContext context, noArray, idStatus) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title : Text('Apakah anda yakin menghapus pesan ini?'),
          content: Text("Apakah anda yakin menghapus pesan ini?"),
          actions: <Widget>[
            new TextButton(
              onPressed: () => berandaState.hapusStatus(noArray, idStatus),
              onLongPress: () => berandaState.hapusStatus(noArray, idStatus),
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
          opacity: berandaState.isPerformingRequest ? 1.0 : 0.0,
          child: new CircularProgressIndicator(),
        ),
      ),
    );
  }


}

