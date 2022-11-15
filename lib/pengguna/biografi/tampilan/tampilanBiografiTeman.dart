import 'package:flutter/material.dart';

import 'package:blubuk/pengguna/biografi/controller/biografiTeman.dart';

// ignore: must_be_immutable
class TampilanBiografiTeman extends StatelessWidget {
  BiografiTeman biografiTeman;
  BiografiTemanState biografiTemanState;

  TampilanBiografiTeman(this.biografiTemanState);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
          child: new ListView(
            physics: new AlwaysScrollableScrollPhysics(),
            key: new PageStorageKey("Divider 1"),
            children: <Widget>[
              Column(
                children: [

                  if (this.biografiTemanState.fotoProfil != null)
                    new Container(
                      height: 300.0,
                      width: 300.0,
                      decoration: new BoxDecoration(
                        color: Colors.blue,
                        image: new DecorationImage(
                          image: new NetworkImage(this.biografiTemanState.fotoProfil),
                          fit: BoxFit.cover,
                        ),
                        border: Border.all(color: Colors.red, width: 5.0),
                        borderRadius:
                        new BorderRadius.all(const Radius.circular(40.0)),
                      ),
                    ),
                  new Container(height: 10.0),
                  new TextFormField(
                      decoration: new InputDecoration(labelText: this.biografiTemanState.namaLengkap),
                      readOnly: true
                  ),
                  new Container(height: 10.0),
                  new TextFormField(
                      decoration: new InputDecoration(labelText: this.biografiTemanState.jenisKelamin),
                      readOnly: true
                  ),
                  new Container(height: 10.0),
                  if (this.biografiTemanState.agama != '')
                    Column(
                      children: <Widget>[
                        TextFormField(
                            decoration: InputDecoration(
                              labelText: this.biografiTemanState.agama,
                            ),
                            readOnly: true
                        )
                      ],
                    ),
                  new Container(height: 10.0),
                  new TextFormField(
                      decoration: new InputDecoration(labelText: this.biografiTemanState.tanggalLahir),
                      readOnly: true
                  ),
                  new Container(height: 10.0),
                  if (this.biografiTemanState.telpon != 'null')
                    Column(
                      children: <Widget>[
                        TextFormField(
                            decoration: InputDecoration(
                              labelText: this.biografiTemanState.telpon,
                            ),
                            readOnly: true
                        )
                      ],
                    ),
                  new Container(height: 10.0),
                  if (this.biografiTemanState.alamat != 'null')
                    Column(
                      children: <Widget>[
                        TextFormField(
                            decoration: InputDecoration(
                              labelText: this.biografiTemanState.alamat,
                            ),
                            readOnly: true
                        )
                      ],
                    ),
                  new Container(height: 10.0),
                  if (this.biografiTemanState.kodePos != 'null')
                    Column(
                      children: <Widget>[
                        TextFormField(
                            decoration: InputDecoration(
                              labelText: this.biografiTemanState.kodePos,
                            ),
                            readOnly: true
                        )
                      ],
                    ),
                  new Container(height: 10.0),
                  if (this.biografiTemanState.provinsi != '')
                    Column(
                      children: <Widget>[
                        TextFormField(
                            decoration: InputDecoration(
                              labelText: this.biografiTemanState.provinsi,
                            ),
                            readOnly: true
                        )
                      ],
                    ),
                  new Container(height: 10.0),
                  if (this.biografiTemanState.kabupaten != '')
                    Column(
                      children: <Widget>[
                        TextFormField(
                            decoration: InputDecoration(
                              labelText: this.biografiTemanState.kabupaten,
                            ),
                            readOnly: true
                        )
                      ],
                    ),
                  new Container(height: 10.0),
                  new Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: new ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      onLongPress: () => Navigator.of(context).pop(),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                      ),
                      child: new Text(
                        'Kembali',
                        style: new TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          )),
    );
  }


}

