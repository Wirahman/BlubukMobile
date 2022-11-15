import 'package:flutter/material.dart';

import 'package:blubuk/globals.dart' as globals;
import 'package:blubuk/pengguna/biografi/controller/biografi.dart';

// ignore: must_be_immutable
class UploadFoto extends StatelessWidget {
  Biografi biografi;
  BiografiState biografiState;

  UploadFoto(this.biografiState);

  @override
  // ignore: non_constant_identifier_names
  Widget build(BuildContext) {
    return 
      new GestureDetector(
        onTap: () => biografiState.imagePicker.showDialog(BuildContext),
        child: new Center(
          child: biografiState.fotoBiografi == null ?
          new Container(
            height: 160.0,
            width: 160.0,
            decoration: new BoxDecoration(
              color: Colors.blue,
              image: new DecorationImage(
                image: new NetworkImage(globals.fotoProfil),
                fit: BoxFit.cover,
              ),
              border: Border.all(color: Colors.red, width: 5.0),
              borderRadius:
                  new BorderRadius.all(const Radius.circular(80.0)),
            ),
          ) : new Container(
            height: 160.0,
            width: 160.0,
            decoration: new BoxDecoration(
              color: Colors.blue,
              image: new DecorationImage(
                image: new ExactAssetImage(biografiState.fotoBiografi.path),
                fit: BoxFit.cover,
              ),
              border: Border.all(color: Colors.red, width: 5.0),
              borderRadius:
                  new BorderRadius.all(const Radius.circular(80.0)),
            ),
          )
        ),
      );
  }

}
