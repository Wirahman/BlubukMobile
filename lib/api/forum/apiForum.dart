import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:blubuk/globals.dart' as globals;
// import 'package:http/http.dart' as http;
// import 'package:path/path.dart';

class ForumUtility {
  static Future<String> pasangIDForum(String userID, String userIDTeman) async {
    var url = globals.apiURL + '/ApiForum/pasangIDForum';
    Map bodyJson = {
      'userID' : globals.userid,
      'userIDTeman' : userIDTeman
    };

    HttpClient httpClient = new HttpClient();
    httpClient.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
    request.headers.set(globals.contentTypeItem, globals.contentType);
    request.headers.set(globals.apiKeyItem, globals.apiKey);
    request.headers.set(globals.kepalaTokenItem, globals.kepalaToken + globals.token);
    request.add(utf8.encode(json.encode(bodyJson)));
    HttpClientResponse response = await request.close();
    // todo - you should check the response.statusCode
    String result = await response.transform(utf8.decoder).join();
    httpClient.close();

    return result;
  }

  static Future<String> buatForum(String idGroupForum, String judulForum, String isiForum) async {
    var url = globals.apiURL + '/ApiForum/buatForum';
    Map bodyJson = {
      'userID' : globals.userid,
      'idGroupForum' : idGroupForum,
      'judulForum' : judulForum,
      'isiForum' : isiForum
    };

    HttpClient httpClient = new HttpClient();
    httpClient.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
    request.headers.set(globals.contentTypeItem, globals.contentType);
    request.headers.set(globals.apiKeyItem, globals.apiKey);
    request.headers.set(globals.kepalaTokenItem, globals.kepalaToken + globals.token);
    request.add(utf8.encode(json.encode(bodyJson)));
    HttpClientResponse response = await request.close();
    // todo - you should check the response.statusCode
    String result = await response.transform(utf8.decoder).join();
    httpClient.close();

    return result;
  }

  static Future<String> updateForum(String idForum, String idGroupForum, String judulForum, String isiForum) async {
    var url = globals.apiURL + '/ApiForum/updateForum';
    Map bodyJson = {
      'userID' : globals.userid,
      'idForum' : idForum,
      'idGroupForum' : idGroupForum,
      'judulForum' : judulForum,
      'isiForum' : isiForum
    };

    HttpClient httpClient = new HttpClient();
    httpClient.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
    request.headers.set(globals.contentTypeItem, globals.contentType);
    request.headers.set(globals.apiKeyItem, globals.apiKey);
    request.headers.set(globals.kepalaTokenItem, globals.kepalaToken + globals.token);
    request.add(utf8.encode(json.encode(bodyJson)));
    HttpClientResponse response = await request.close();
    // todo - you should check the response.statusCode
    String result = await response.transform(utf8.decoder).join();
    httpClient.close();

    return result;
  }

  static Future<String> hapusForum(String idForum) async {
    var url = globals.apiURL + '/ApiForum/hapusForum';
    Map bodyJson = {
      'userID' : globals.userid,
      'idForum' : idForum
    };

    HttpClient httpClient = new HttpClient();
    httpClient.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
    request.headers.set(globals.contentTypeItem, globals.contentType);
    request.headers.set(globals.apiKeyItem, globals.apiKey);
    request.headers.set(globals.kepalaTokenItem, globals.kepalaToken + globals.token);
    request.add(utf8.encode(json.encode(bodyJson)));
    HttpClientResponse response = await request.close();
    // todo - you should check the response.statusCode
    String result = await response.transform(utf8.decoder).join();
    httpClient.close();

    return result;
  }

  static Future<String> ambilFotoForum(String userID, String idForum) async {
    var url = globals.apiURL + '/ApiForum/ambilFotoForum';
    Map bodyJson = {
      'userID' : globals.userid,
      'idForum' : idForum
    };

    HttpClient httpClient = new HttpClient();
    httpClient.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
    request.headers.set(globals.contentTypeItem, globals.contentType);
    request.headers.set(globals.apiKeyItem, globals.apiKey);
    request.headers.set(globals.kepalaTokenItem, globals.kepalaToken + globals.token);
    request.add(utf8.encode(json.encode(bodyJson)));
    HttpClientResponse response = await request.close();
    // todo - you should check the response.statusCode
    String result = await response.transform(utf8.decoder).join();
    httpClient.close();

    return result;
  }


  static Future<String> apiAmbilSemuaForum(int urutanForum, int banyakForum) async {
    print("Api Ambil Semua Forum");
    var url = globals.apiURL + '/ApiForum/ambil_semua_forum';
    Map bodyJson = {
      'userID' : globals.userid,
      'jenis' : 'umum',
      'tipe' : '',
      'awalForum' : urutanForum,
      'akhirForum' : banyakForum
    };

    HttpClient httpClient = new HttpClient();
    httpClient.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
    request.headers.set(globals.contentTypeItem, globals.contentType);
    request.headers.set(globals.apiKeyItem, globals.apiKey);
    request.headers.set(globals.kepalaTokenItem, globals.kepalaToken + globals.token);
    request.add(utf8.encode(json.encode(bodyJson)));
    HttpClientResponse response = await request.close();
    // todo - you should check the response.statusCode
    String result = await response.transform(utf8.decoder).join();
    httpClient.close();

    return result;
  }

  static Future<String> ubahSukaBenciForum(String userID, String idForum, String tipe) async {
    print("Function Api Suka Status");
    print("User ID = " + userID);
    print("ID Forum " + idForum);
    print("Tipe = " + tipe);
    var url = globals.apiURL + '/ApiForum/ubah_suka_benci_satu_forum';
    Map bodyJson = {
      'userID' : userID,
      'idForum': idForum,
      'tipe': tipe
    };
    HttpClient httpClient = new HttpClient();
    httpClient.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
    request.headers.set(globals.contentTypeItem, globals.contentType);
    request.headers.set(globals.apiKeyItem, globals.apiKey);
    request.headers.set(globals.kepalaTokenItem, globals.kepalaToken + globals.token);
    request.add(utf8.encode(json.encode(bodyJson)));
    HttpClientResponse response = await request.close();
    // todo - you should check the response.statusCode
    String result = await response.transform(utf8.decoder).join();
    httpClient.close();
    print("result");
    print(result);

    return result;
  }









  static Future<String> apiAmbilKomentarForum(String userID, String idForum, int urutanKomentarForum, int banyakKomentarForum) async {
    var url = globals.apiURL + '/ApiForum/ambilKomentarForum';
    Map bodyJson = {
      'userID' : globals.userid,
      'idForum' : idForum,
      'urutanKomentarForum' : urutanKomentarForum,
      'banyakKomentarForum' : banyakKomentarForum
    };

    HttpClient httpClient = new HttpClient();
    httpClient.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
    request.headers.set(globals.contentTypeItem, globals.contentType);
    request.headers.set(globals.apiKeyItem, globals.apiKey);
    request.headers.set(globals.kepalaTokenItem, globals.kepalaToken + globals.token);
    request.add(utf8.encode(json.encode(bodyJson)));
    HttpClientResponse response = await request.close();
    // todo - you should check the response.statusCode
    String result = await response.transform(utf8.decoder).join();
    httpClient.close();

    return result;
  }

  static Future<String> kirimKomentarForum(String idForum, String userIDPembuatForum, String isiKomentarForum) async {
    var url = globals.apiURL + '/ApiForum/kirimKomentarForum';
    Map bodyJson = {
      'userID' : globals.userid,
      'idForum' : idForum,
      'userIDPembuatForum' : userIDPembuatForum,
      'isiKomentarForum' : isiKomentarForum
    };

    HttpClient httpClient = new HttpClient();
    httpClient.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
    request.headers.set(globals.contentTypeItem, globals.contentType);
    request.headers.set(globals.apiKeyItem, globals.apiKey);
    request.headers.set(globals.kepalaTokenItem, globals.kepalaToken + globals.token);
    request.add(utf8.encode(json.encode(bodyJson)));
    HttpClientResponse response = await request.close();
    // todo - you should check the response.statusCode
    String result = await response.transform(utf8.decoder).join();
    httpClient.close();

    return result;
  }

  static Future<String> hapusKomentarForum(String idKomentarForum) async {
    var url = globals.apiURL + '/ApiForum/hapusKomentarForum';
    Map bodyJson = {
      'userID' : globals.userid,
      'idKomentarForum' : idKomentarForum
    };

    HttpClient httpClient = new HttpClient();
    httpClient.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
    request.headers.set(globals.contentTypeItem, globals.contentType);
    request.headers.set(globals.apiKeyItem, globals.apiKey);
    request.headers.set(globals.kepalaTokenItem, globals.kepalaToken + globals.token);
    request.add(utf8.encode(json.encode(bodyJson)));
    HttpClientResponse response = await request.close();
    // todo - you should check the response.statusCode
    String result = await response.transform(utf8.decoder).join();
    httpClient.close();

    return result;
  }

  static Future<String> ubahSukaBenciKomentarForum(String userID, String idKomentarForum, String tipe) async {
    print("Function Api Suka Status");
    print("User ID = " + userID);
    print("ID Komentar Forum " + idKomentarForum);
    print("Tipe = " + tipe);
    var url = globals.apiURL + '/ApiForum/ubah_suka_benci_komentar_forum';
    Map bodyJson = {
      'userID' : userID,
      'idKomentarForum': idKomentarForum,
      'tipe': tipe
    };
    HttpClient httpClient = new HttpClient();
    httpClient.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
    request.headers.set(globals.contentTypeItem, globals.contentType);
    request.headers.set(globals.apiKeyItem, globals.apiKey);
    request.headers.set(globals.kepalaTokenItem, globals.kepalaToken + globals.token);
    request.add(utf8.encode(json.encode(bodyJson)));
    HttpClientResponse response = await request.close();
    // todo - you should check the response.statusCode
    String result = await response.transform(utf8.decoder).join();
    httpClient.close();
    print("result");
    print(result);

    return result;
  }

  static Future<String> apiAmbilFotoKomentarForum(String userID, String idKomentarForum) async {
    print("apiAmbilFotoKomentarForum");
    print("userID = " + userID);
    print("idKomentarForum = " + idKomentarForum);
    var url = globals.apiURL + '/ApiForum/ambilFotoKomentarForum';
    Map bodyJson = {
      'userID' : userID,
      'idKomentarForum': idKomentarForum
    };

    HttpClient httpClient = new HttpClient();
    httpClient.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
    request.headers.set(globals.contentTypeItem, globals.contentType);
    request.headers.set(globals.apiKeyItem, globals.apiKey);
    request.headers.set(globals.kepalaTokenItem, globals.kepalaToken + globals.token);
    request.add(utf8.encode(json.encode(bodyJson)));
    HttpClientResponse response = await request.close();
    // todo - you should check the response.statusCode
    String result = await response.transform(utf8.decoder).join();
    httpClient.close();
    print("result");
    print(result);

    return result;
  }

  static Future<String> apiHapusFotoForum(String userID, String urlFoto, String dbFoto, String jenisFoto) async {
    var url = globals.apiURL + '/ApiForum/hapusFotoForum';
    Map bodyJson = {
      'userID' : userID,
      'urlFoto': urlFoto,
      'dbFoto' : dbFoto,
      'jenisFoto' : jenisFoto
    };

    HttpClient httpClient = new HttpClient();
    httpClient.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
    request.headers.set(globals.contentTypeItem, globals.contentType);
    request.headers.set(globals.apiKeyItem, globals.apiKey);
    request.headers.set(globals.kepalaTokenItem, globals.kepalaToken + globals.token);
    request.add(utf8.encode(json.encode(bodyJson)));
    HttpClientResponse response = await request.close();
    // todo - you should check the response.statusCode
    String result = await response.transform(utf8.decoder).join();
    httpClient.close();
    print("result");
    print(result);

    return result;
  }





}
