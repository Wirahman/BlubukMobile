import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:blubuk/emote/controller/emote.dart' as emote;
import 'package:blubuk/pengguna/chat/controller/chat.dart';
import 'package:blubuk/pengguna/biografi/controller/biografiTeman.dart';
import 'package:blubuk/pengguna/chat/controller/balasChat.dart';

// ignore: must_be_immutable
class TampilanChat extends StatelessWidget {
  Chat chat;
  ChatState chatState;

  TampilanChat(this.chatState);

  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Flexible(
          child: ListView.builder(
            itemCount: chatState.items.length + 1,
            itemBuilder: (BuildContext context,int index) {
              if(index == chatState.items.length) {
                return _buildProgressIndicator();
              } else {
                return Padding(
                  padding: EdgeInsets.all(5.0),
                  child: new Column(
                    children: [
                      new ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(chatState.items[index].fotoProfilTeman),
                          ),
                          title: new Text(chatState.items[index].namaTeman),
                          subtitle: new Text(chatState.items[index].waktu),
                      ),
                      this.chatState.items[index].fotoChat == 'Ada' ?
                      new Column(
                          children: <Widget>[
                            CarouselSlider(
                              items: this.chatState.itemsFotoChat.map((item) => Container(
                                child:
                                chatState.items[index].idBalasChat == item.idBalasChat ?
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
                              carouselController: this.chatState.buttonCarouselController,
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
                            //       onPressed: () => this.chatState.buttonCarouselController.previousPage(
                            //           duration: Duration(milliseconds: 300), curve: Curves.linear),
                            //       onLongPress: () => this.chatState.buttonCarouselController.previousPage(
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
                            //       onPressed: () => this.chatState.buttonCarouselController.nextPage(
                            //           duration: Duration(milliseconds: 300), curve: Curves.linear),
                            //       onLongPress: () => this.chatState.buttonCarouselController.nextPage(
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
                          emote.Emote().periksaEmote(chatState.items[index].pesan),
                        ),
                      ),
                      new Row(
                        children: [
                          TextButton(
                            onPressed: () {
                              BiografiTemanState.userID = chatState.items[index].userIDTeman;
                              Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) =>
                                    new BiografiTeman()), //When Authorized Navigate to the next screen
                              );
                            },
                            onLongPress: () {
                              BiografiTemanState.userID = chatState.items[index].userIDTeman;
                              Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) =>
                                    new BiografiTeman()), //When Authorized Navigate to the next screen
                              );
                            },
                            child: Icon(Icons.people),
                          ),
                          TextButton(
                            onPressed: () {
                              BalasChatState.userIDTemanStatic = chatState.items[index].userIDTeman;
                              BalasChatState.namaTemanStatic = chatState.items[index].namaTeman;
                              BalasChatState.fotoTemanStatic = chatState.items[index].fotoProfilTeman;
                              Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) =>
                                    new BalasChat()), //When Authorized Navigate to the next screen
                              );
                            },
                            onLongPress: () {
                              BalasChatState.userIDTemanStatic = chatState.items[index].userIDTeman;
                              BalasChatState.namaTemanStatic = chatState.items[index].namaTeman;
                              BalasChatState.fotoTemanStatic = chatState.items[index].fotoProfilTeman;
                              Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) =>
                                    new BalasChat()), //When Authorized Navigate to the next screen
                              );
                            },
                            child: Icon(Icons.comment),
                          )
                        ],
                      )
                    ],
                  ),
                );
              }
            },
            controller: chatState.scrollController,
          ),
        ),
      ],
    );
  }

  Widget _buildProgressIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: new Opacity(
          opacity: chatState.isPerformingRequest ? 1.0 : 0.0,
          child: new CircularProgressIndicator(),
        ),
      ),
    );
  }


}




