import 'dart:async';
import 'dart:convert';
import 'dart:io';
// import 'package:http/http.dart' as http;

import 'package:blubuk/globals.dart' as globals;

class TemanUtility {
  // Fungsi API untuk mengambil Daftar Teman
  static Future<String> apiTeman(String userID, int awalTeman, int akhirTeman) async {
    print("Function apiTeman");
    print("User ID = " + userID);
    print("Awal Teman =" + awalTeman.toString());
    print("Akhir Teman =" + akhirTeman.toString());
    var url = globals.apiURL + '/ApiTeman/ambil_teman';
    Map bodyJson = {
      'userID' : userID,
      'awalTeman': awalTeman,
      'akhirTeman': akhirTeman
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
