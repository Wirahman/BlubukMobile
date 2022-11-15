import 'package:flutter/material.dart';

class HalamanInformasi extends StatefulWidget {
  @override
  HalamanInformasiState createState() => new HalamanInformasiState();
}

class HalamanInformasiState extends State<HalamanInformasi> {
  String isiInformasi =
      'Blubuk adalah sebuah sosial media yang dibuat untuk berbagi mengenai informasi dan ilmu. '
      'Blubuk terdiri berbagai macam fitur, diantaranya : Chat, pertemanan, forum, update status, dan lain sebagainya.\n'
      '<b>Fitur Forum</b>\n'
      'Fitur yang menyediakan wadah untuk pengguna untuk berbagi pikiran dan menuangkannya didalam artikel sehingga dapat dibagikan kepada banyak orang';
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: const Text('Informasi'),
      ),
      body: new Center(
        child: new Column(
          children: <Widget>[
            new Padding(
              padding: new EdgeInsets.all(10.0),
              child: new Text(
                'Informasi Sosial Media Blubuk',
                textAlign: TextAlign.center,
                style: new TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
            ),
            new Padding(
              padding: new EdgeInsets.all(10.0),
              child: new Text(
                isiInformasi,
                textAlign: TextAlign.center,
                style: new TextStyle(
                  color: Colors.black,
                  fontSize: 15.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
