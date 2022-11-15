import 'package:flutter/material.dart';

import 'package:blubuk/globals.dart' as globals;
import 'package:blubuk/emote/controller/emote.dart' as emote;


import 'package:blubuk/pengguna/grup/controller/grup.dart';


// ignore: must_be_immutable
class TampilanGrup extends StatelessWidget {
  Grup grup;
  GrupState grupState;

  TampilanGrup(this.grupState);

  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
            padding: EdgeInsets.all(5.0),
            child: Row(
              children: [
                SizedBox(width: 20),
                new GestureDetector(
                  onTap: () => grupState.setState(() => grupState.menuGrup = "Buat Group"),
                  child: new Center(
                      child: new Stack(
                        children: <Widget>[
                          new Center(
                            child: new Icon(Icons.group_add_rounded),
                          ),
                        ],
                      )
                  ),
                ),
                SizedBox(width: 20),
                new GestureDetector(
                  onTap: () => grupState.setState(() => grupState.menuGrup = "Group"),
                  child: new Center(
                      child: new Stack(
                        children: <Widget>[
                          new Center(
                            child: new Icon(Icons.speaker_group_rounded),
                          ),
                        ],
                      )
                  ),
                ),
                SizedBox(width: 20),
                new GestureDetector(
                  onTap: () => grupState.setState(() => grupState.menuGrup = "Group Sendiri"),
                  child: new Center(
                      child: new Stack(
                        children: <Widget>[
                          new Center(
                            child: new Icon(Icons.group_rounded),
                          ),
                        ],
                      )
                  ),
                ),
              ],
            )
        ),
        Flexible(
            child:
              () {
                if(grupState.menuGrup == "Buat Group"){
                  return Text("Buat Group");
                } else if(grupState.menuGrup == "Group"){
                  return Text("Group");
                } else if(grupState.menuGrup == "Group Sendiri"){
                  return Text("Group Sendiri");
                } else {
                  return Text("Error");
                }
              }()
        ),
      ],
    );



  }

  // hapusForum(BuildContext context, noArray, idForum) {
  //   showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           title : Text('Apakah anda yakin menghapus forum ini?'),
  //           content: Text("Apakah anda yakin menghapus forum ini?"),
  //           actions: <Widget>[
  //             new TextButton(
  //               onPressed: () => forumState.hapusForum(noArray, idForum),
  //               onLongPress: () => forumState.hapusForum(noArray, idForum),
  //               child: new Text("Yes",
  //                 textAlign: TextAlign.center,
  //                 style:  const TextStyle(
  //                     color: Colors.blue,
  //                     fontSize: 14.0,
  //                     fontFamily: "Roboto",
  //                     fontWeight: FontWeight.bold),
  //               ),
  //             ), new TextButton(
  //               onPressed: () => Navigator.of(context).pop(),
  //               onLongPress: () => Navigator.of(context).pop(),
  //               child: new Text("No",
  //                 textAlign: TextAlign.center,
  //                 style:  const TextStyle(
  //                     color: Colors.blue,
  //                     fontSize: 14.0,
  //                     fontFamily: "Roboto",
  //                     fontWeight: FontWeight.bold),
  //               ),
  //             ),
  //           ],
  //         );
  //       }
  //   );
  // }

  Widget _buildProgressIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: new Opacity(
          opacity: grupState.isPerformingRequest ? 1.0 : 0.0,
          child: new CircularProgressIndicator(),
        ),
      ),
    );
  }


}


