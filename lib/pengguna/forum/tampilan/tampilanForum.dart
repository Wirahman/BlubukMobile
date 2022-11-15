import 'package:flutter/material.dart';

import 'package:blubuk/globals.dart' as globals;
import 'package:blubuk/emote/controller/emote.dart' as emote;
import 'package:blubuk/pengguna/forum/controller/forum.dart';
import 'package:blubuk/pengguna/forum/controller/komentarForum.dart';
import 'package:blubuk/pengguna/forum/controller/buatForum.dart';
import 'package:blubuk/pengguna/forum/controller/ubahForum.dart';


// ignore: must_be_immutable
class TampilanForum extends StatelessWidget {
  Forum forum;
  ForumState forumState;
  KomentarForum komentarForum;
  BuatForum buatForum;
  UbahForum ubahForum;

  TampilanForum(this.forumState);

  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new ListTile(
          title: new Text("Buat Forum"),
          onTap: () {
            Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (context) =>
                  new BuatForum()), //When Authorized Navigate to the next screen
            );
          },
          onLongPress: (){
            Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (context) =>
                  new BuatForum()), //When Authorized Navigate to the next screen
            );
          },
          trailing: Icon(Icons.add),
        ),
        Flexible(
          child: ListView.builder(
            itemCount: forumState.items.length + 1,
            itemBuilder: (BuildContext context,int index) {
              if(index == forumState.items.length) {
                return _buildProgressIndicator();
              } else {
                return Padding(
                  padding: EdgeInsets.all(5.0),
                  child: new Column(
                    children: [
                      new ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(forumState.items[index].fotoPembuat),
                          ),
                          title: new Text(forumState.items[index].namaPembuat),
                      ),

                      new ListTile(
                        title: Row(
                          children:
                          emote.Emote().periksaEmote(forumState.items[index].judulForum),
                        ),
                      ),

                      new Row(
                        children: [
                          TextButton(
                            onPressed: () {
                              KomentarForumState.idForumStatic = forumState.items[index].idForum ;
                              KomentarForumState.idGroupForumStatic = forumState.items[index].idGroupForum;
                              KomentarForumState.userIdPembuatStatic = forumState.items[index].userIdPembuat;
                              KomentarForumState.judulForumStatic = forumState.items[index].judulForum;
                              KomentarForumState.isiForumStatic = forumState.items[index].isiForum;
                              KomentarForumState.fotoForumStatic = forumState.items[index].fotoForum;
                              KomentarForumState.waktuForumStatic = forumState.items[index].waktu;
                              KomentarForumState.statusSukaForumStatic = forumState.items[index].statusSuka;
                              KomentarForumState.statusBenciForumStatic = forumState.items[index].statusBenci;
                              KomentarForumState.jumlahPenontonForumStatic = forumState.items[index].jumlahPenonton;
                              KomentarForumState.jumlahKomentarForumStatic = forumState.items[index].jumlahKomentar;
                              KomentarForumState.emailPembuatForumStatic = forumState.items[index].emailPembuat;
                              KomentarForumState.namaPembuatForumStatic = forumState.items[index].namaPembuat;
                              KomentarForumState.fotoPembuatForumStatic = forumState.items[index].fotoPembuat;
                              Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) =>
                                    new KomentarForum()), //When Authorized Navigate to the next screen
                              );
                            },
                            onLongPress: () {
                              KomentarForumState.idForumStatic = forumState.items[index].idForum ;
                              KomentarForumState.idGroupForumStatic = forumState.items[index].idGroupForum;
                              KomentarForumState.userIdPembuatStatic = forumState.items[index].userIdPembuat;
                              KomentarForumState.judulForumStatic = forumState.items[index].judulForum;
                              KomentarForumState.isiForumStatic = forumState.items[index].isiForum;
                              KomentarForumState.fotoForumStatic = forumState.items[index].fotoForum;
                              KomentarForumState.waktuForumStatic = forumState.items[index].waktu;
                              KomentarForumState.statusSukaForumStatic = forumState.items[index].statusSuka;
                              KomentarForumState.statusBenciForumStatic = forumState.items[index].statusBenci;
                              KomentarForumState.jumlahPenontonForumStatic = forumState.items[index].jumlahPenonton;
                              KomentarForumState.jumlahKomentarForumStatic = forumState.items[index].jumlahKomentar;
                              KomentarForumState.emailPembuatForumStatic = forumState.items[index].emailPembuat;
                              KomentarForumState.namaPembuatForumStatic = forumState.items[index].namaPembuat;
                              KomentarForumState.fotoPembuatForumStatic = forumState.items[index].fotoPembuat;
                              Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) =>
                                    new KomentarForum()), //When Authorized Navigate to the next screen
                              );
                            },
                            child: Icon(Icons.comment),
                          ),

                          globals.userid == forumState.items[index].userIdPembuat ?
                          TextButton(
                            onPressed: () {
                              UbahForumState.idForumStatic = forumState.items[index].idForum;
                              UbahForumState.idGroupForumStatic = forumState.items[index].idGroupForum;
                              UbahForumState.judulForumStatic = forumState.items[index].judulForum;
                              UbahForumState.isiForumStatic = forumState.items[index].isiForum;
                              Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) =>
                                    new UbahForum()), //When Authorized Navigate to the next screen
                              );
                            },
                            onLongPress: () {
                              UbahForumState.idForumStatic = forumState.items[index].idForum;
                              UbahForumState.idGroupForumStatic = forumState.items[index].idGroupForum;
                              UbahForumState.judulForumStatic = forumState.items[index].judulForum;
                              UbahForumState.isiForumStatic = forumState.items[index].isiForum;
                              Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) =>
                                    new UbahForum()), //When Authorized Navigate to the next screen
                              );
                            },
                            child: Icon(Icons.article_outlined),
                          )
                              :
                          new Container(

                          ),
                          globals.userid == forumState.items[index].userIdPembuat ?
                          TextButton(
                            onPressed: () {
                              hapusForum(context, index, forumState.items[index].idForum);
                            },
                            onLongPress: () {
                              hapusForum(context, index, forumState.items[index].idForum);
                            },
                            child: Icon(Icons.delete_forever),
                          )
                              :
                          new Container(

                          ),
                        ]
                      )
                    ],
                  ),
                );
              }
            },
            controller: forumState.scrollController,
          ),
        ),
      ],
    );
  }

  hapusForum(BuildContext context, noArray, idForum) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title : Text('Apakah anda yakin menghapus forum ini?'),
            content: Text("Apakah anda yakin menghapus forum ini?"),
            actions: <Widget>[
              new TextButton(
                onPressed: () => forumState.hapusForum(noArray, idForum),
                onLongPress: () => forumState.hapusForum(noArray, idForum),
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
          opacity: forumState.isPerformingRequest ? 1.0 : 0.0,
          child: new CircularProgressIndicator(),
        ),
      ),
    );
  }


}


