import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:blubuk/globals.dart' as globals;

class LoginUtility {
  static Future<String> apiLogin(String username, String password, String ingatSaya) async {
    var url = globals.apiURL + '/ApiLogin/login';
    print(url);
    Map bodyJson = {
      'email': username,
      'password': password,
      'ingatSaya': ingatSaya
    };
    print(bodyJson);

    HttpClient httpClient = new HttpClient();
    httpClient.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
    request.headers.set(globals.contentTypeItem, globals.contentType);
    request.headers.set(globals.apiKeyItem, globals.apiKey);
    request.add(utf8.encode(json.encode(bodyJson)));
    HttpClientResponse response = await request.close();
    // todo - you should check the response.statusCode
    String result = await response.transform(utf8.decoder).join();
    httpClient.close();
    print("Result API");
    print(result);

    return result;
  }


  static Future<String> ambilSemuaEmote() async {
    var url = globals.apiURL + '/ApiLogin/ambilSemuaEmote';
    print(url);
    Map bodyJson = {

    };
    print(bodyJson);

    HttpClient httpClient = new HttpClient();
    httpClient.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
    request.headers.set(globals.contentTypeItem, globals.contentType);
    request.headers.set(globals.apiKeyItem, globals.apiKey);
    request.add(utf8.encode(json.encode(bodyJson)));
    HttpClientResponse response = await request.close();
    // todo - you should check the response.statusCode
    String result = await response.transform(utf8.decoder).join();
    httpClient.close();
    print("Result API");
    print(result);

    return result;
  }



}
