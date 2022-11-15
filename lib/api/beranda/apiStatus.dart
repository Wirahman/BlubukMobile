import 'dart:async';
import 'dart:convert';
import 'dart:io';
// import 'package:http/http.dart' as http;

import 'package:blubuk/globals.dart' as globals;

class StatusUtility {
  // Fungsi API untuk Status
  static Future<String> apiStatus(String userID, int awalStatus, int akhirStatus) async {
    print("Function Api Status");
    print("User ID = " + userID);
    print("Awal Status =" + awalStatus.toString());
    print("Akhir Status =" + akhirStatus.toString());
    var url = globals.apiURL + '/ApiBeranda/ambil_status';
    Map bodyJson = {
      'userID' : userID,
      'awalStatus': awalStatus,
      'akhirStatus': akhirStatus
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

  static Future<String> apiAmbilFotoStatus(String userID, String idStatus) async {
    var url = globals.apiURL + '/ApiBeranda/ambilFotoStatus';
    Map bodyJson = {
      'userID' : userID,
      'idStatus': idStatus
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

  static Future<String> buatStatus(String userID, String email, String name, String fotoUser, String isiStatus) async {
    print("Function Api Buat Status");
    print("User ID = " + userID);
    print("Email = " + email);
    print("Name = " + name);
    print("Foto User = " + fotoUser);
    print("Isi Status " + isiStatus);
    var url = globals.apiURL + '/ApiBeranda/buat_status';
    Map bodyJson = {
      'userID' : userID,
      'email': email,
      'name': name,
      'fotoUser': fotoUser,
      'isiStatus': isiStatus
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

  static Future<String> ambilSatuStatus(String userID, String idStatus) async {
    print("Function Api Ambil Satu Status");
    print("User ID = " + userID);
    print("ID Status =" + idStatus);
    var url = globals.apiURL + '/ApiBeranda/ambil_satu_status';
    Map bodyJson = {
      'userID' : userID,
      'idStatus': idStatus
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

  static Future<String> hapusStatus(String userID, String idStatus) async {
    print("Function API Hapus Status");
    print("User ID = " + userID);
    print("ID Status = " + idStatus);
    var url = globals.apiURL + '/ApiBeranda/hapus_status';
    Map bodyJson = {
      'userID' : userID,
      'idStatus' : idStatus
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

  static Future<String> ubahSukaBenciStatus(String userID, String idStatus, String tipe) async {
    print("Function Api Suka Status");
    print("User ID = " + userID);
    print("ID Status " + idStatus);
    print("Tipe = " + tipe);
    var url = globals.apiURL + '/ApiBeranda/ubah_suka_benci_status';
    Map bodyJson = {
      'userID' : userID,
      'idStatus': idStatus,
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







  //Fungsi API untuk Komentar Status
  static Future<String> apiKomentarStatus(String userID, String idStatus, int awalKomentarStatus, int akhirKomentarStatus) async {
    print("Function Api Komentar Status");
    print("User ID = " + userID);
    print("ID Status = " + idStatus);
    print("Awal Komentar Status =" + awalKomentarStatus.toString());
    print("Akhir Komentar Status =" + akhirKomentarStatus.toString());
    var url = globals.apiURL + '/ApiBeranda/ambil_komentar_status';
    Map bodyJson = {
      'userID' : userID,
      'idStatus' : idStatus,
      'awalKomentarStatus': awalKomentarStatus,
      'akhirKomentarStatus': akhirKomentarStatus
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

  static Future<String> buatKomentarStatus(String userID,String idStatus, String fotoUser, String isiKomentarStatus) async {
    print("Function Buat Status");
    print("User ID = " + userID);
    print("ID Status = " + idStatus);
    print("Foto User = " + fotoUser);
    print("Isi Komentar Status " + isiKomentarStatus);
    var url = globals.apiURL + '/ApiBeranda/buat_komentar_status';
    Map bodyJson = {
      'userID' : userID,
      'idStatus' : idStatus,
      'fotoUser': fotoUser,
      'isiKomentarStatus': isiKomentarStatus
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

  static Future<String> hapusKomentarStatus(String userID, String idKomentarStatus) async {
    print("Function Hapus Komentar Status");
    print("User ID = " + userID);
    print("ID Komentar Status = " + idKomentarStatus);
    var url = globals.apiURL + '/ApiBeranda/hapus_komentar_status';
    Map bodyJson = {
      'userID' : userID,
      'idKomentarStatus' : idKomentarStatus
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

  static Future<String> ubahSukaBenciKomentarStatus(String userID, String idKomentarStatus, String tipe) async {
    print("Function Api Suka Status");
    print("User ID = " + userID);
    print("ID Komentar Status " + idKomentarStatus);
    print("Tipe = " + tipe);
    var url = globals.apiURL + '/ApiBeranda/ubah_suka_benci_komentar_status';
    Map bodyJson = {
      'userID' : userID,
      'idKomentarStatus': idKomentarStatus,
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

  static Future<String> apiAmbilFotoKomentarStatus(String userID, String idKomentarStatus) async {
    print("apiAmbilFotoKomentarStatus");
    print("userID = " + userID);
    print("idKomentarStatus = " + idKomentarStatus);
    var url = globals.apiURL + '/ApiBeranda/ambilFotoKomentarStatus';
    Map bodyJson = {
      'userID' : userID,
      'idKomentarStatus': idKomentarStatus
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
