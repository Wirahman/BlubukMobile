library api;

import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

import 'package:blubuk/emote/model/emote.dart';

String contentType = "application/json";
String apiKey = "www.blubuk.com";
String contentTypeItem = "content-type";
String apiKeyItem = "Blubuk-API";
String kepalaToken = "Wirahman-RKSLANKERS-";
String kepalaTokenItem = "Token";
String token = "";
String domain = "";

// 10.0.2.2 = 127.0.0.1
String namaAplikasi = '/blubuk';
String localhost = "https://10.0.2.2:4433" + namaAplikasi;
String localUrl = "https://192.168.0.104:4433" + namaAplikasi;
String smartphone = "https://192.168.43.204:4433" + namaAplikasi;
String production = "https://192.168.1.113" + namaAplikasi;
String nGROX = "https://fc2a-103-152-238-130.ap.ngrok.io/" + namaAplikasi;
String url = localUrl;

String apiURL = url + "/Api";

//Variables
bool isLoggedIn = false;
bool fbLoggedIn = false;
bool termsChecked = false;

String error = "";
String hasil = "";

// Biografi Pengguna
String userid = "0";
String email = "Email Pengguna";
String username = "Username Pengguna";
String fotoProfil = url + "/images/foto_profil/no_profil.jpg";
String idRole = "ID Role Pengguna";
String status = "Status Pengguna";
String oauthUid = "0";
String oauthProvider = "";
String menu = "";
String jenisKelamin = 'Jenis Kelamin';
String idAgama = '';
String agama = '';
String idProvinsi = '';
String provinsi = '';
String logoProvinsi = '';
String idKabupaten = '';
String kabupaten = '';
String logoKabupaten = '';
String tanggalLahir = '';
String bulanLahir = '';
String tahunLahir = '';
String telpon = '';
String ponsel = '';
String alamat = '';
String kodePos = '';
// File fotoUpload = "" as File;
XFile fotoUpload;
List<VariabelEmote> listSemuaEmote = [];

String idStatus = '';

class Utility {
  static Future<Null> showAlertPopup(
      BuildContext context, String title, String detail) async {
    return showDialog<Null>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (_) => new AlertDialog(
        title: new Text(title),
        content: new SingleChildScrollView(
          child: new ListBody(
            children: <Widget>[
              new Text(detail),
            ],
          ),
        ),
        actions: <Widget>[
          new TextButton(
            child: new Text('Selesai'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      ),
    );
  }

  static Future<String> pasangApiKeyGlobals() async {
    var url = apiURL + '/ApiLogin/pasangApiKeyGlobals';
    print(url);
    Map bodyJson = {};

    HttpClient httpClient = new HttpClient();
    httpClient.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json');
    request.headers.set('Blubuk-API', 'www.blubuk.com');
    request.add(utf8.encode(json.encode(bodyJson)));
    HttpClientResponse response = await request.close();
    // todo - you should check the response.statusCode
    String result = await response.transform(utf8.decoder).join();
    httpClient.close();

    return result;
  }

  static Future<String> ambilParameterGlobals(String userID) async {
    var url = apiURL + '/ApiLogin/ambilParameterGlobals';
    Map bodyJson = {'userID': userID};

    HttpClient httpClient = new HttpClient();
    httpClient.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json');
    request.headers.set('Blubuk-API', 'www.blubuk.com');
    request.add(utf8.encode(json.encode(bodyJson)));
    HttpClientResponse response = await request.close();
    // todo - you should check the response.statusCode
    String result = await response.transform(utf8.decoder).join();
    httpClient.close();

    return result;
  }

  static Future<String> ambilDataPenggunaTerbaru(String userID) async {
    var url = apiURL + '/ApiBiografi/ambilDataPenggunaTerbaru';
    Map bodyJson = {'userID': userID};

    HttpClient httpClient = new HttpClient();
    httpClient.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
    request.headers.set(contentTypeItem, contentType);
    request.headers.set(apiKeyItem, apiKey);
    request.add(utf8.encode(json.encode(bodyJson)));
    HttpClientResponse response = await request.close();
    // todo - you should check the response.statusCode
    String result = await response.transform(utf8.decoder).join();
    httpClient.close();

    return result;
  }

  static Widget newTextButton(String title, VoidCallback onPressed) {
    return
    new TextButton(
      child: new Text(title,
          textAlign: TextAlign.center,
          style: const TextStyle(
              color: Colors.black,
              fontSize: 14.0,
              fontFamily: "Roboto",
              fontWeight: FontWeight.bold)),
        onPressed: onPressed
    );
  }

  static void showInSnackBar(String value) {
    final _scaffoldKey = new GlobalKey<ScaffoldState>();
    ScaffoldMessenger(
        key: _scaffoldKey,
        child: Scaffold(
          backgroundColor: Colors.blue,
          body: SafeArea(
              child: new Text(value)
          ),
        )
    );
  }
}
