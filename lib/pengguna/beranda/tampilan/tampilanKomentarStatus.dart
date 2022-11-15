import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:blubuk/emote/controller/emote.dart' as emote;
import 'package:blubuk/emote/model/emote.dart';
import 'package:blubuk/pengguna/beranda/controller/komentarStatus.dart';
import 'package:blubuk/globals.dart' as globals;

// ignore: must_be_immutable
class TampilanKomentarStatus extends StatelessWidget {
  KomentarStatus komentarStatus;
  KomentarStatusState komentarStatusState;

  TampilanKomentarStatus(this.komentarStatusState);
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        // here we display the title corresponding to the fragment
        // you can instead choose to have a static title
        title: new Text("Komentar Status"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Column(
              children: <Widget>[
                new Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                          width:20,
                          height: 20,
                          decoration: new BoxDecoration(
                              shape: BoxShape.circle,
                              image: new DecorationImage(
                                  fit: BoxFit.fill,
                                  image: (komentarStatusState.fotoPengirimStatus == null) ? AssetImage('assets/Foto/Logo/no_profil.jpg') : new NetworkImage(komentarStatusState.fotoPengirimStatus)
                                  // image: new NetworkImage(komentarStatusState.fotoPengirimStatus)
                                // image: new NetworkImage("https://graph.facebook.com/2028029970626254/picture?type=large")
                              )
                          )
                      ),
                      new Text(
                          (komentarStatusState.namaPengirimStatus == null) ? '' : komentarStatusState.namaPengirimStatus,
                        // komentarStatusState.namaPengirimStatus,
                          textAlign: TextAlign.center,
                          style: new TextStyle(
                          color: Colors.black,
                          fontSize: 15.0,
                        ),
                      ),
                      new Text(
                        (komentarStatusState.waktuStatus == null) ? '' : komentarStatusState.waktuStatus,
                        // komentarStatusState.waktuStatus,
                        textAlign: TextAlign.center,
                        style: new TextStyle(
                          color: Colors.black,
                          fontSize: 15.0,
                        ),
                      )
                    ],
                  ),
                ),

                this.komentarStatusState.fotoStatus == 'Ada' ?
                new Column(
                    children: <Widget>[
                      CarouselSlider(
                        items: this.komentarStatusState.itemsFotoStatus.map((item) => Container(
                          child:
                          globals.idStatus == item.idStatus ?
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
                        carouselController: this.komentarStatusState.buttonCarouselControllerStatus,
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
                      new Row(
                        children: [
                          TextButton(
                            onPressed: () => this.komentarStatusState.buttonCarouselControllerStatus.previousPage(
                                duration: Duration(milliseconds: 300), curve: Curves.linear),
                            onLongPress: () => this.komentarStatusState.buttonCarouselControllerStatus.previousPage(
                                duration: Duration(milliseconds: 300), curve: Curves.linear),
                            child: new Text("←",
                              textAlign: TextAlign.center,
                              style:  const TextStyle(
                                  color: Colors.blue,
                                  fontSize: 14.0,
                                  fontFamily: "Roboto",
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          TextButton(
                            onPressed: () => this.komentarStatusState.buttonCarouselControllerStatus.nextPage(
                                duration: Duration(milliseconds: 300), curve: Curves.linear),
                            onLongPress: () => this.komentarStatusState.buttonCarouselControllerStatus.nextPage(
                                duration: Duration(milliseconds: 300), curve: Curves.linear),
                            child: new Text("→",
                              textAlign: TextAlign.center,
                              style:  const TextStyle(
                                  color: Colors.blue,
                                  fontSize: 14.0,
                                  fontFamily: "Roboto",
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      )
                    ]
                )
                    :
                Text(''),

                new ListTile(
                  title:
                  (komentarStatusState.isiStatus == null) ? Flexible(
                    child: Text(' '),
                  ) : Row(
                    children:
                    emote.Emote().periksaEmote(komentarStatusState.isiStatus),
                  ),
                ),
            ],
          ),
          Form(
            key: komentarStatusState.formKomentarStatus,
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: komentarStatusState.textEditingControllerKomentarStatus,
                  decoration: new InputDecoration(
                    hintText: komentarStatusState.hintTextKomentarStatus,
                  ),
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  validator: (val) => val.length < 1 ? 'Harap Masukkan Komentar Anda Terlebih Dahulu' : null,
                  onSaved: (val) => komentarStatusState.komentarStatus = val,
                ),
                Padding(
                  padding: EdgeInsets.all(5.0),
                  child: new Row(
                    children: <Widget>[
                      new Expanded(
                        child: new Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: new ElevatedButton(
                            onPressed: komentarStatusState.updateKomentarStatus,
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
                        onTap: () => komentarStatusState.imagePicker.showDialog(context),
                        child: new Center(
                            child: komentarStatusState.fotoFile == null ?
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
                                  image: new ExactAssetImage(komentarStatusState.fotoFile.path),
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
              itemCount: komentarStatusState.items.length + 1,
              itemBuilder: (BuildContext context,int index) {
                if (index == komentarStatusState.items.length) {
                  return _buildProgressIndicator();
                } else {
                  return Padding(
                    padding: EdgeInsets.all(5.0),
                    child: new Column(
                      children: [
                        ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(komentarStatusState.items[index].fotoProfil),
                          ),
                          title: new Text(komentarStatusState.items[index].name),
                          subtitle: new Text(komentarStatusState.items[index].waktu),
                        ),
                        this.komentarStatusState.items[index].fotoKomentarStatus == 'Ada' ?
                        new Column(
                            children: <Widget>[
                              CarouselSlider(
                                items: this.komentarStatusState.itemsFotoKomentarStatus.map((item) => Container(
                                  child:
                                  komentarStatusState.items[index].idKomentarStatus == item.idKomentarStatus ?
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
                                carouselController: this.komentarStatusState.buttonCarouselKomentarController,
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
                              //       onPressed: () => this.komentarStatusState.buttonCarouselKomentarController.previousPage(
                              //           duration: Duration(milliseconds: 300), curve: Curves.linear),
                              //       onLongPress: () => this.komentarStatusState.buttonCarouselKomentarController.previousPage(
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
                              //       onPressed: () => this.komentarStatusState.buttonCarouselKomentarController.nextPage(
                              //           duration: Duration(milliseconds: 300), curve: Curves.linear),
                              //       onLongPress: () => this.komentarStatusState.buttonCarouselKomentarController.nextPage(
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
                            emote.Emote().periksaEmote(komentarStatusState.items[index].isi),
                          ),
                        ),

                        new Row(
                          children: [
                            TextButton(
                              onPressed: () {
                                komentarStatusState.fungsiUbahSukaBenciKomentarStatus(komentarStatusState.items[index].idKomentarStatus, 'suka', index);
                              },
                              onLongPress: () {
                                komentarStatusState.fungsiUbahSukaBenciKomentarStatus(komentarStatusState.items[index].idKomentarStatus, 'suka', index);
                              },
                              child: komentarStatusState.items[index].statusSuka == '1'? Icon(Icons.thumb_up_sharp) : Icon(Icons.thumb_up_outlined),
                            ),
                            TextButton(
                              onPressed: () {
                                komentarStatusState.fungsiUbahSukaBenciKomentarStatus(komentarStatusState.items[index].idKomentarStatus, 'benci', index);
                              },
                              onLongPress: () {
                                komentarStatusState.fungsiUbahSukaBenciKomentarStatus(komentarStatusState.items[index].idKomentarStatus, 'benci', index);
                              },
                              child: komentarStatusState.items[index].statusBenci == '1'? Icon(Icons.thumb_down_sharp) : Icon(Icons.thumb_down_outlined),
                            ),
                            TextButton(
                              onPressed: () {
                                if(globals.userid == komentarStatusState.items[index].userID){
                                  hapusKomentarPesan(context, komentarStatusState.items[index].idKomentarStatus, index);
                                }
                              },
                              onLongPress: () {
                                if(globals.userid == komentarStatusState.items[index].userID){
                                  hapusKomentarPesan(context, komentarStatusState.items[index].idKomentarStatus, index);
                                }
                              },
                              child: globals.userid == komentarStatusState.items[index].userID ? Icon(Icons.delete_forever) : Text(""),
                            ),
                          ],
                        )

                      ],
                    ),
                  );
                }
              },
              controller: komentarStatusState.scrollController,
            ),
          ),
        ],
      ),
    );
  }

  hapusKomentarPesan(BuildContext context, idStatus, noArray) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title : Text('Apakah anda yakin menghapus komentar pesan ini?'),
            content: Text("Apakah anda yakin menghapus komentar pesan ini?"),
            actions: <Widget>[
              new TextButton(
                onPressed: () => komentarStatusState.hapusKomentarStatus(idStatus, noArray),
                onLongPress: () => komentarStatusState.hapusKomentarStatus(idStatus, noArray),
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
                              String a = komentarStatusState.textEditingControllerKomentarStatus.text;
                              String b = emote.nama;
                              print('$a $b');
                              komentarStatusState.textEditingControllerKomentarStatus.text = ' $a $b';
                            },
                            onLongPress: () {
                              String a = komentarStatusState.textEditingControllerKomentarStatus.text;
                              String b = emote.nama;
                              print('$a $b');
                              komentarStatusState.textEditingControllerKomentarStatus.text = ' $a $b';
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

  Widget _buildProgressIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: new Opacity(
          opacity: komentarStatusState.isPerformingRequest ? 1.0 : 0.0,
          child: new CircularProgressIndicator(),
        ),
      ),
    );
  }


}