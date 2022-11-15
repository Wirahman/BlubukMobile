import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:blubuk/globals.dart' as globals;

class PendaftaranUtility {
  static Future<String> apiPendaftaran(String username, String email, String password, String jenisKelamin, String tanggalLahir, String bulanLahir, String tahunLahir) async {
    var url = globals.apiURL + '/Apilogin/pendaftaran';
    Map bodyJson = {
      'username': username,
      'email': email,
      'password': password,
      'jenis_kelamin': jenisKelamin,
      'tanggal_lahir': tanggalLahir,
      'bulan_lahir': bulanLahir,
      'tahun_lahir': tahunLahir
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
