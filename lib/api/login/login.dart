import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:Blubuk/globals.dart' as globals;

class LoginUtility {

  static Future<String> apiLogin(String username, String password, String ingatSaya) async {
    var url = globals.apiURL + '/ApiLogin/login';
    Map bodyJson = {
      'email': username,
      'password': password,
      'ingatSaya':ingatSaya
    };

    HttpClient httpClient = new HttpClient();
    httpClient.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
    request.headers.set(globals.contentTypeItem, globals.contentType);
    request.headers.set(globals.apiKeyItem, globals.apiKey);
    request.add(utf8.encode(json.encode(bodyJson)));
    HttpClientResponse response = await request.close();
    // todo - you should check the response.statusCode
    String result = await response.transform(utf8.decoder).join();
    httpClient.close();

    return result;
  }

  static Future<String> apiLogin1(String username, String password) async {
    var url = globals.apiURL + '/ApiLogin/login';
    var body = json.encode({
      "email"             : username,
      "password"          : password
    });

    Map headers = {
      'Content-type' : 'application/json',
      'Accept': 'application/json',
      'Blubuk-API': 'www.blubuk.com'
    };

    final response = await http.post(url, body:body, headers: headers);


    if (response.statusCode >= 400) {
      throw ('Error: ' + response.body);
    }

    try {
      final jsonResponse = json.decode(response.body);
      return jsonResponse;
    } catch (exception) {
      print(response.body);
      throw ('An error occurred');
    }


  }



}
