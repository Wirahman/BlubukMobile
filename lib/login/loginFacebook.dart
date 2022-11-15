import 'dart:async';
import 'dart:convert';
import 'dart:io';
// import 'package:http/http.dart' as http;
// import 'package:flutter/foundation.dart' show kIsWeb;
// import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

import 'package:blubuk/globals.dart' as globals;



//file ada di blubuk/lib/login
class LoginFacebookUtility {
  // Lokasi ubah settingan Facebook Developer
  // C:\StudioProjects\blubuk\android\app\src\main\res\values\styles.xml atau android\app\src\main\res\values\styles.xml
  bool fbLoggedIn = false;

  static void onLoginStatusChanged(bool fbLoggedIn) {
    fbLoggedIn = fbLoggedIn;
    globals.fbLoggedIn = fbLoggedIn;
  }

  static Future<dynamic> apiLoginFacebookBerhasil() async {
    Map _userObj = {};
    print("API Login Facebook");

    await FacebookAuth.instance.login(
        permissions: ["public_profile", "email"]).then((value) {
      FacebookAuth.instance.getUserData().then((userData) {
        globals.fbLoggedIn = true;
        _userObj = userData;
        print("Berhasil Login");
        print(_userObj);
      });
    });
    return _userObj;
  }

  static Future<dynamic> apiLoginFacebook() async {
    print("API Login Facebook");
    Map profile = {};

    await FacebookAuth.instance.login(
        permissions: ["public_profile", "email"]).then((value) {
      FacebookAuth.instance.getUserData().then((userData) {
        profile = userData;
        print("profile");
        print(profile);
        print("Berhasil Login");

        onLoginStatusChanged(true);
        globalsFacebookLogin(
            "${profile['id']}",
            "${profile['name']}",
            "${profile['email']}",
            "${profile['id']}" + "${profile['name']}" + "${profile['email']}",
            "${profile['picture']['data']['url']}");
      });
    });

    return profile;
  }

  static Future globalsFacebookLogin(String id, String name, String email, String accessToken, String fotoProfil) async {
    print("globalsFacebookLogin");
    print("ID = " + id);
    print("Nama = " + name);
    print("Email = " + email);
    print("Foto = " + fotoProfil);
    String result = "";
    result = await apiLogin(id, name, email, accessToken, fotoProfil);

    Map<String, dynamic> hasilJSON = json.decode(result);

    print("Hasil JSON");
    print(hasilJSON);

    globals.isLoggedIn = true;
    globals.fbLoggedIn = true;
    globals.oauthUid = '${hasilJSON['Pengguna']['oauth_uid']}';
    globals.oauthProvider = '${hasilJSON['Pengguna']['oauth_provider']}';
    globals.userid = '${hasilJSON['Pengguna']['userid']}';
    globals.email = '${hasilJSON['Pengguna']['email']}';
    globals.username = '${hasilJSON['Pengguna']['username']}';
    globals.status = '${hasilJSON['Pengguna']['status']}';
    globals.idRole = '${hasilJSON['Pengguna']['id_role']}';
    globals.fotoProfil = '${hasilJSON['Pengguna']['foto_profil']}';
    globals.tanggalLahir = '${hasilJSON['Pengguna']['tanggalLahir']}';
    globals.bulanLahir = '${hasilJSON['Pengguna']['bulanLahir']}';
    globals.tahunLahir = '${hasilJSON['Pengguna']['tahunLahir']}';
    globals.agama = '${hasilJSON['Pengguna']['agama']}';
    globals.telpon = '${hasilJSON['Pengguna']['telpon']}';
    globals.ponsel = '${hasilJSON['Pengguna']['ponsel']}';
    globals.alamat = '${hasilJSON['Pengguna']['alamat']}';
    globals.kodePos = '${hasilJSON['Pengguna']['kodePos']}';
    globals.jenisKelamin = '${hasilJSON['Pengguna']['jenisKelamin']}';
    globals.idProvinsi = '${hasilJSON['Pengguna']['idProvinsi']}';
    globals.provinsi = '${hasilJSON['Pengguna']['provinsi']}';
    globals.logoProvinsi = '${hasilJSON['Pengguna']['logoProvinsi']}';
    globals.idKabupaten = '${hasilJSON['Pengguna']['idKabupaten']}';
    globals.kabupaten = '${hasilJSON['Pengguna']['kabupaten']}';
    globals.logoKabupaten = '${hasilJSON['Pengguna']['logoKabupaten']}';

    globals.token = '${hasilJSON['Pengguna']['token']}';
    return true;
  }

  static Future<String> apiLogin(String id, String name,String email, String accessToken, String fotoProfil) async {
    print("apiLogin");
    print("ID = " + id);
    print("Nama = " + name);
    print("Email = " + email);
    print("Foto = " + fotoProfil);
    var url = globals.apiURL + '/ApiLogin/loginFacebook';
    Map bodyJson = {
      'id': id,
      'name': name,
      'email': email,
      'access_token': accessToken,
      'fotoProfil': fotoProfil
    };

    HttpClient httpClient = new HttpClient();
    httpClient.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json');
    request.headers.set('Blubuk-API', 'www.blubuk.com');
    request.add(utf8.encode(json.encode(bodyJson)));
    HttpClientResponse response = await request.close();
    // todo - you should check the response.statusCode
    String result = await response.transform(utf8.decoder).join();
    httpClient.close();

    return result;
  }
}
