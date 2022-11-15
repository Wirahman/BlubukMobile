import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:blubuk/globals.dart' as globals;
// import 'package:http/http.dart' as http;
// import 'package:path/path.dart';

class ChatUtility {

  static Future<String> pasangIDChat(String userID, String userIDTeman) async {
    var url = globals.apiURL + '/ApiChat/pasangIDChat';
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


  static Future<String> apiSemuaChat(String userID, int urutanChat, int banyakChat) async {
    var url = globals.apiURL + '/ApiChat/ambilSemuaChat';
    Map bodyJson = {
      'userID' : globals.userid,
      'urutanChat' : urutanChat,
      'banyakChat' : banyakChat
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

  static Future<String> apiBalasChat(String userID, String userIDTeman, int urutanBalasChat, int banyakBalasChat) async {
    var url = globals.apiURL + '/ApiChat/ambilBalasChat';
    Map bodyJson = {
      'userID' : globals.userid,
      'userIDTeman' : userIDTeman,
      'urutanBalasChat' : urutanBalasChat,
      'banyakBalasChat' : banyakBalasChat
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

  static Future<String> kirimBalasChat(String userIDTeman, String idChat, String isiBalasChat, String fotoTeman) async {
    var url = globals.apiURL + '/ApiChat/kirimBalasChat';
    Map bodyJson = {
      'userID' : globals.userid,
      'userIDTeman' : userIDTeman,
      'idChat' : idChat,
      'isiBalasChat' : isiBalasChat,
      'fotoTeman' : fotoTeman
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

  static Future<String> hapusBalasChat(String idBalasChat) async {
    var url = globals.apiURL + '/ApiChat/hapusBalasChat';
    Map bodyJson = {
      'userID' : globals.userid,
      'idBalasChat' : idBalasChat
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

  static Future<String> apiAmbilFotoBalasChat(String userID, String idBalasChat) async {
    var url = globals.apiURL + '/ApiChat/ambilFotoBalasChat';
    Map bodyJson = {
      'userID' : userID,
      'idBalasChat': idBalasChat
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
