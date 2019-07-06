import 'package:flutter/material.dart';


class Teman extends StatelessWidget {
  void _cariTeman(namaTeman){
    print(namaTeman);

  }
  @override
  Widget build(BuildContext context) => new Center(
      child: new Container(
        alignment: FractionalOffset.topLeft,
        child: new TextField(
          decoration: new InputDecoration(
            hintText: 'Masukkan Nama Teman Anda',
          ),
          maxLines: null,
          keyboardType: TextInputType.multiline,
          onChanged: (namaTeman) => _cariTeman(namaTeman),
        ),
      ),
    );

}