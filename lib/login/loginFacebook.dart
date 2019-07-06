import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:Blubuk/globals.dart' as globals;
import 'package:flutter_facebook_login/flutter_facebook_login.dart';


class LoginFacebookUtility {
  bool fbLoggedIn = false;

  static void onLoginStatusChanged(bool fbLoggedIn) {
    fbLoggedIn = fbLoggedIn;
  }

  static apiLoginFacebook() async {
    print("apiLoginFacebook");
    var facebookLogin = FacebookLogin();
    var facebookLoginResult = await facebookLogin.logInWithReadPermissions(['email']);
    if (facebookLoginResult.status == FacebookLoginStatus.error) {
        print("Error");
        print(facebookLoginResult.errorMessage);
        onLoginStatusChanged(false);
    }else if (facebookLoginResult.status == FacebookLoginStatus.cancelledByUser) {
        print("CancelledByUser");
        onLoginStatusChanged(false);
    }else if (facebookLoginResult.status == FacebookLoginStatus.loggedIn) {
        print("LoggedIn");
        // print("Token Facebook " + facebookLoginResult.accessToken.token);    
        var graphResponse = await http.get(
        'https://graph.facebook.com/v2.12/me?fields=id,email,name,first_name,last_name&access_token=${facebookLoginResult
        .accessToken.token}');

        var profile = json.decode(graphResponse.body);
        // print(profile.toString());
        onLoginStatusChanged(true);
        await globalsFacebookLogin("${profile['id']}", "${profile['email']}", "${profile['name']}", "${profile['first_name']}", "${profile['last_name']}", "${profile['access_token']}");
    }else {
        print("Terjadi kesalahan sistem, aplikasi tidak bisa hubungi facebook api");
    }
  }

  static Future globalsFacebookLogin(String id,String email,String name,String firstName,String lastName,String accessToken) async {
      String result = "";
      result = await apiLogin(id, email, name, firstName, lastName, accessToken); 
      
      Map<String, dynamic> hasilJSON = json.decode(result);
      
      globals.isLoggedIn = true;
      globals.fbLoggedIn = true;
      globals.oauthUid = '${hasilJSON['Pengguna']['oauth_uid']}';
      globals.oauthProvider = '${hasilJSON['Pengguna']['oauth_provider']}';
      globals.userid = '${hasilJSON['Pengguna']['userid']}';
      globals.email = '${hasilJSON['Pengguna']['email']}' ;
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
      globals.idProvinsi= '${hasilJSON['Pengguna']['idProvinsi']}';
      globals.provinsi = '${hasilJSON['Pengguna']['provinsi']}';
      globals.logoProvinsi = '${hasilJSON['Pengguna']['logoProvinsi']}';
      globals.idKabupaten= '${hasilJSON['Pengguna']['idKabupaten']}';
      globals.kabupaten = '${hasilJSON['Pengguna']['kabupaten']}';
      globals.logoKabupaten = '${hasilJSON['Pengguna']['logoKabupaten']}';
      
      globals.token = '${hasilJSON['Pengguna']['token']}'; 
      return true;
  }

  static Future<String> apiLogin(String id,String email,String name,String firstName,String lastName,String accessToken) async {
    var url = globals.apiURL + '/ApiLogin/loginFacebook';
    Map bodyJson = {
      'id': id,
      'email': email,
      'name': name,
      'first_name': firstName,
      'last_name': lastName,
      'access_token': accessToken
    };

    HttpClient httpClient = new HttpClient();
    httpClient.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
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