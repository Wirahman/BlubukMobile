import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:Blubuk/globals.dart' as globals;

class UploadFotoUtility {
  
  static Future<String> uploadFotoCameraStatus(_foto) async {
    var url = globals.apiURL + '/ApiLogin/login';
    Map bodyJson = {
        'foto':_foto
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




}