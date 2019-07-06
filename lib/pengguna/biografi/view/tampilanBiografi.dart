import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:Blubuk/pengguna/biografi/controller/biografi.dart';
import 'package:Blubuk/pengguna/biografi/view/uploadFoto.dart';
import 'package:Blubuk/pengguna/biografi/view/tampilanUbahBiografi.dart';

class TampilanBiografi extends StatelessWidget {
  Biografi biografi;
  BiografiState biografiState;

  TampilanBiografi(this.biografiState);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: biografiState.biografiScaffoldKey,
      body: new Container(
      child: new ListView(
        physics: new AlwaysScrollableScrollPhysics(),
        key: new PageStorageKey("Divider 1"),
        children: <Widget>[
          new Container(height: 20.0),
          new UploadFoto(biografiState),
          new Container(height: 20.0),
          new TampilanUbahBiografi(biografiState),
          new Container(height: 20.0),
          new Container(height: 10.0),
          new Padding(
            padding: const EdgeInsets.all(8.0),
            child: new RaisedButton(
              color: Colors.blue,
              onPressed: biografiState.klikUpdateBiografi,
              child: new Text(
                'Update Biografi',
                style: new TextStyle(color: Colors.white),
              ),
            ),
          ),          
        ],
      )),
    );
  }
  

}

