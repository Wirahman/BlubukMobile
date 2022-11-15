import 'package:flutter/material.dart';

import 'package:blubuk/pengguna/teman/controller/teman.dart';
import 'package:blubuk/pengguna/biografi/controller/biografiTeman.dart';
import 'package:blubuk/pengguna/chat/controller/balasChat.dart';

// ignore: must_be_immutable
class TampilanTeman extends StatelessWidget {
  Teman teman;
  TemanState temanState;

  TampilanTeman(this.temanState);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Flexible(
          child: ListView.builder(
            itemCount: temanState.items.length + 1,
            itemBuilder: (BuildContext context,int index) {
              if(index == temanState.items.length) {
                return _buildProgressIndicator();
              } else {
                return Padding(
                  padding: EdgeInsets.all(5.0),
                  child: new Column(
                    children: [
                      new ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(temanState.items[index].fotoProfil),
                          ),
                          title: new Text(temanState.items[index].name),
                          // subtitle: new Text(temanState.items[index].userID),
                      ),
                      new Row(
                        children: [
                          TextButton(
                            onPressed: () {
                              BiografiTemanState.userID = temanState.items[index].userID;
                              Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) =>
                                    new BiografiTeman()), //When Authorized Navigate to the next screen
                              );
                            },
                            onLongPress: () {
                              BiografiTemanState.userID = temanState.items[index].userID;
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
                              BalasChatState.userIDTemanStatic = temanState.items[index].userID;
                              BalasChatState.namaTemanStatic = temanState.items[index].name;
                              BalasChatState.fotoTemanStatic = temanState.items[index].fotoProfil;
                              Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) =>
                                    new BalasChat()), //When Authorized Navigate to the next screen
                              );
                            },
                            onLongPress: () {
                              BalasChatState.userIDTemanStatic = temanState.items[index].userID;
                              BalasChatState.namaTemanStatic = temanState.items[index].name;
                              BalasChatState.fotoTemanStatic = temanState.items[index].fotoProfil;
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
                      ),
                    ],
                  ),
                );
              }
            },
            controller: temanState.scrollController,
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
          opacity: temanState.isPerformingRequest ? 1.0 : 0.0,
          child: new CircularProgressIndicator(),
        ),
      ),
    );
  }


}




