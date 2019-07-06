import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:async/async.dart';

import 'package:Blubuk/globals.dart' as globals;
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class BiografiUtility {
  
  static Future apiFotoBiografi(String userID, File fotoProfil) async {
    var stream = new http.ByteStream(DelegatingStream.typed(fotoProfil.openRead()));
    var length = await fotoProfil.length();
    var url = Uri.parse(globals.apiURL + '/ApiBiografi/update_foto_biografi');
    Map<String, String> headers = { 
      globals.contentTypeItem : "multipart/form-data; charset=utf-8",
      globals.apiKeyItem : globals.apiKey
    };
    var request = new http.MultipartRequest("POST", url);

    request.headers.addAll(headers);
    request.fields['userID'] = userID;

    var multipartFile = new http.MultipartFile("image", stream, length, filename: basename(fotoProfil.path));
    request.files.add(multipartFile);

    var response = await request.send();
    var hasil = "";
    if (response.statusCode == 200) {
      hasil = "Berhasil";
    }else{
      hasil = "Gagal";
    }
    return hasil;
  }

  static Future<String> apiUpdateBiografi(String namaLengkap, String jenisKelamin, String telpon, String ponsel, String alamat, String kodePos, String idProvinsi) async {
    var url = globals.apiURL + '/ApiBiografi/updateBiografi';
    Map bodyJson = {
      'userID' : globals.userid,
      'namaLengkap' : namaLengkap,
      'jenisKelamin' : jenisKelamin,
      'telpon'       : telpon,
      'ponsel'       : ponsel,
      'alamat'       : alamat,
      'kodePos'      : kodePos,
      'idProvinsi'   : idProvinsi
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

  static Future<String> apiUpdateTanggalLahirBiografi(String tanggalLahir) async {
    var url = globals.apiURL + '/ApiBiografi/updateTanggalLahirBiografi';
    Map bodyJson = {
      'userID' : globals.userid,
      'tanggalLahir' : tanggalLahir
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
    print(result);

    return result;
  }

  static Future<String> apiAmbilDaftarAgama(String userID) async {
    var url = globals.apiURL + '/ApiBiografi/ambilDaftarAgama';
    Map bodyJson = {
      'userID' : userID
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

  static Future<String> apiAmbilDaftarProvinsi(String userID) async {
    var url = globals.apiURL + '/ApiBiografi/ambilDaftarProvinsi';
    Map bodyJson = {
      'userID' : userID
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

  static Future<String> apiAmbilDaftarKabupaten(String userID, String idProvinsi) async {
    var url = globals.apiURL + '/ApiBiografi/ambilDaftarKabupaten';
    Map bodyJson = {
      'userID' : userID,
      'idProvinsi' : idProvinsi
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
