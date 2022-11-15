import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:blubuk/globals.dart' as globals;
// import 'package:http/http.dart' as http;
// import 'package:path/path.dart';

String apiURL = globals.apiURL + "/ApiGrup";
class GrupUtility {
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





}
