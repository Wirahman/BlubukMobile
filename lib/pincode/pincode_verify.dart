import 'package:flutter/material.dart';

class PinCodeVerify extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Verify Pin"),
        ),
        body: new GridView.count(
          primary: false,
          padding: const EdgeInsets.all(20.0),
          crossAxisSpacing: 10.0,
          crossAxisCount: 3,
          children: <Widget>[
            new Padding(
              padding: new EdgeInsets.all(20.0),
              child: new FloatingActionButton(
                  elevation: 0.0,
                  heroTag: "1",
                  child: new Text('1',
                      style: new TextStyle(
                        fontSize: 40.0,
                        fontFamily: 'Roboto',
                        color: Colors.white,
                      )),
                  backgroundColor: new Color(0xFFE57373),
                  onPressed: () {}),
            ),
            new Padding(
              padding: new EdgeInsets.all(20.0),
              child: new FloatingActionButton(
                  elevation: 0.0,
                  heroTag: "2",
                  child: new Text('2',
                      style: new TextStyle(
                        fontSize: 40.0,
                        fontFamily: 'Roboto',
                        color: Colors.white,
                      )),
                  backgroundColor: new Color(0xFFE57373),
                  onPressed: () {}),
            ),
            new Padding(
              padding: new EdgeInsets.all(20.0),
              child: new FloatingActionButton(
                  elevation: 0.0,
                  heroTag: "3",
                  child: new Text('3',
                      style: new TextStyle(
                        fontSize: 40.0,
                        fontFamily: 'Roboto',
                        color: Colors.white,
                      )),
                  backgroundColor: new Color(0xFFE57373),
                  onPressed: () {}),
            ),
            new Padding(
              padding: new EdgeInsets.all(20.0),
              child: new FloatingActionButton(
                  elevation: 0.0,
                  heroTag: "4",
                  child: new Text('4',
                      style: new TextStyle(
                        fontSize: 40.0,
                        fontFamily: 'Roboto',
                        color: Colors.white,
                      )),
                  backgroundColor: new Color(0xFFE57373),
                  onPressed: () {}),
            ),
            new Padding(
              padding: new EdgeInsets.all(20.0),
              child: new FloatingActionButton(
                  elevation: 0.0,
                  heroTag: "5",
                  child: new Text('5',
                      style: new TextStyle(
                        fontSize: 40.0,
                        fontFamily: 'Roboto',
                        color: Colors.white,
                      )),
                  backgroundColor: new Color(0xFFE57373),
                  onPressed: () {}),
            ),
            new Padding(
              padding: new EdgeInsets.all(20.0),
              child: new FloatingActionButton(
                  elevation: 0.0,
                  heroTag: "6",
                  child: new Text('6',
                      style: new TextStyle(
                        fontSize: 40.0,
                        fontFamily: 'Roboto',
                        color: Colors.white,
                      )),
                  backgroundColor: new Color(0xFFE57373),
                  onPressed: () {}),
            ),
            new Padding(
              padding: new EdgeInsets.all(20.0),
              child: new FloatingActionButton(
                  elevation: 0.0,
                  heroTag: "7",
                  child: new Text('7',
                      style: new TextStyle(
                        fontSize: 40.0,
                        fontFamily: 'Roboto',
                        color: Colors.white,
                      )),
                  backgroundColor: new Color(0xFFE57373),
                  onPressed: () {}),
            ),
            new Padding(
              padding: new EdgeInsets.all(20.0),
              child: new FloatingActionButton(
                  elevation: 0.0,
                  heroTag: "8",
                  child: new Text('8',
                      style: new TextStyle(
                        fontSize: 40.0,
                        fontFamily: 'Roboto',
                        color: Colors.white,
                      )),
                  backgroundColor: new Color(0xFFE57373),
                  onPressed: () {}),
            ),
            new Padding(
              padding: new EdgeInsets.all(20.0),
              child: new FloatingActionButton(
                  elevation: 0.0,
                  heroTag: "9",
                  child: new Text('9',
                      style: new TextStyle(
                        fontSize: 40.0,
                        fontFamily: 'Roboto',
                        color: Colors.white,
                      )),
                  backgroundColor: new Color(0xFFE57373),
                  onPressed: () {}),
            ),
            new Text(''),
            new Padding(
              padding: new EdgeInsets.all(20.0),
              child: new FloatingActionButton(
                  elevation: 0.0,
                  heroTag: "0",
                  child: new Text('0',
                      style: new TextStyle(
                        fontSize: 40.0,
                        fontFamily: 'Roboto',
                        color: Colors.white,
                      )),
                  backgroundColor: new Color(0xFFE57373),
                  onPressed: () {}),
            ),
            new Text(''),
          ],
        ),
        );
  }
}
