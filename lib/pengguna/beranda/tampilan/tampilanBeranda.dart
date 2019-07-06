import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

import 'package:Blubuk/pengguna/beranda/beranda.dart';
class TampilanBeranda extends StatelessWidget {
  Beranda beranda;
  BerandaState berandaState;

  TampilanBeranda(this.berandaState);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Form(
          key: berandaState.formStatus, 
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: new InputDecoration(
                  hintText: 'Masukkan Status Anda',
                ),
                maxLines: null,
                keyboardType: TextInputType.multiline,
                validator: (val) => val.length < 1 ? 'Harap Masukkan Status Anda Terlebih Dahulu' : null,
                onSaved: (val) => berandaState.status = val,
              ),
            
              Padding(
                padding: EdgeInsets.all(5.0),
                child: new Row(
                  children: <Widget>[
                    new Expanded(
                      child: new Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: new RaisedButton(
                          color: Colors.blue,
                          onPressed: berandaState.updateStatus,
                          child: new Text(
                            'Update Status',
                            style: new TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    new GestureDetector(
                      onTap: () => berandaState.imagePicker.showDialog(context),
                      child: new Center(
                        child: berandaState.fotoFile == null ?
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
                              image: new ExactAssetImage(berandaState.fotoFile.path),
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

              // GestureDetector(
              //   onTap: () => berandaState.imagePicker.showDialog(context),
              //   child: new Center(
              //     child: berandaState.fotoFile == null ?
              //     new Stack(
              //       children: <Widget>[
              //         new Center(
              //           child: new Icon(Icons.add_a_photo),
              //         ),
              //       ],
              //     ) : new Container(
              //       height: 160.0,
              //       width: 160.0,
              //       decoration: new BoxDecoration(
              //         color: Colors.blue,
              //         image: new DecorationImage(
              //           image: new ExactAssetImage(berandaState.fotoFile.path),
              //           fit: BoxFit.cover,
              //         ),
              //         border: Border.all(color: Colors.red, width: 5.0),
              //         borderRadius:
              //             new BorderRadius.all(const Radius.circular(80.0)),
              //       ),
              //     )
              //   ),
              // )
    
            ],
          ),
        ),
        Flexible(
          child: ListView.builder(
            itemCount: berandaState.items.length + 1,
            itemBuilder: (BuildContext context,int index) {
              if (index == berandaState.items.length) {
                return _buildProgressIndicator();
              } else {
                return ListTile(
                  title: new Text(berandaState.items[index].isi)
                );
              }
            },
            controller: berandaState.scrollController,
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
          opacity: berandaState.isPerformingRequest ? 1.0 : 0.0,
          child: new CircularProgressIndicator(),
        ),
      ),
    );
  }


}

