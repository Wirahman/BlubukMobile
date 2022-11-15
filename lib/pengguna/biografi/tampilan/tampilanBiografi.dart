import 'package:flutter/material.dart';

import 'package:blubuk/pengguna/biografi/controller/biografi.dart';
import 'package:blubuk/pengguna/biografi/tampilan/uploadFoto.dart';
import 'package:blubuk/pengguna/biografi/tampilan/tampilanUbahBiografi.dart';

// ignore: must_be_immutable
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
            child: new ElevatedButton(
              onPressed: biografiState.klikUpdateBiografi,
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
              ),
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

