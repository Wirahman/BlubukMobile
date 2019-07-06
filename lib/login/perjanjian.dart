import 'package:flutter/material.dart';
class HalamanPerjanjian extends StatefulWidget {
  @override
  HalamanPerjanjianState createState() => new HalamanPerjanjianState();
}

class HalamanPerjanjianState extends State<HalamanPerjanjian> {
  String termsOfUse =
      'Dengan Membaca ini maka anda mengakui bahwa anda bersedia untuk memberikan informasi pribadi anda yang ada diBlubuk kepada pihak Blubuk.'
      '/n Harap Ceklist dibawah untuk melanjutkan pendaftaran';
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: const Text('Halaman Perjanjian'),
      ),
      body: new Center(
        child: new Column(
          children: <Widget>[
            new Padding(
              padding: new EdgeInsets.all(10.0),
              child: new Text(
                termsOfUse,
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
