import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;



import 'package:blubuk/globals.dart' as globals;

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

  static Future uploadFoto(String userID,String userID2, XFile imageFile,String path,String jenisFoto,String jumlahFoto,String idJenis) async {
    var uploadURL = globals.apiURL + path;
    var stream  = new http.ByteStream(imageFile.openRead());
    stream.cast();
    var length = await imageFile.length();
    var url = Uri.parse(uploadURL);
    Map<String, String> headers = {
      globals.contentTypeItem : "multipart/form-data; charset=utf-8",
      globals.apiKeyItem : globals.apiKey
    };
    var request = new http.MultipartRequest("POST", url);

    request.headers.addAll(headers);
    request.fields['userID'] = userID;
    request.fields['userID2'] = userID2;
    request.fields['jenisFoto'] = jenisFoto;
    request.fields['jumlahFoto'] = jumlahFoto;
    request.fields['idJenis'] = idJenis;

    var multipartFile = new http.MultipartFile("image", stream, length, filename: basename(imageFile.path));
    request.files.add(multipartFile);

    var streamedResponse = await request.send();
    var response = await streamedResponse.stream.bytesToString();
    // print(response);
    return response;
  }

  static Future uploadFotoKomentar(String userID,String userID2, XFile imageFile,String path,String jenisFoto,String jumlahFoto,String idJenis, String idKomentarJenis) async {
    var uploadURL = globals.apiURL + path;
    var stream  = new http.ByteStream(imageFile.openRead());
    stream.cast();
    var length = await imageFile.length();
    var url = Uri.parse(uploadURL);
    Map<String, String> headers = {
      globals.contentTypeItem : "multipart/form-data; charset=utf-8",
      globals.apiKeyItem : globals.apiKey
    };
    var request = new http.MultipartRequest("POST", url);

    request.headers.addAll(headers);
    request.fields['userID'] = userID;
    request.fields['userID2'] = userID2;
    request.fields['jenisFoto'] = jenisFoto;
    request.fields['jumlahFoto'] = jumlahFoto;
    request.fields['idJenis'] = idJenis;
    request.fields['idKomentarJenis'] = idKomentarJenis;

    var multipartFile = new http.MultipartFile("image", stream, length, filename: basename(imageFile.path));
    request.files.add(multipartFile);

    var streamedResponse = await request.send();
    var response = await streamedResponse.stream.bytesToString();
    print(response);
    return response;
  }











}