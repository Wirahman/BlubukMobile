import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';
import 'pincode/pincode_verify.dart';
import 'pincode/pincode_create.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:blubuk/globals.dart' as globals;
import 'package:blubuk/api/login/login.dart' as apilogin;
import 'package:blubuk/login/loginFacebook.dart' as loginFB;
import 'package:blubuk/login/informasi.dart';
import 'package:blubuk/login/pendaftaran.dart';
import 'package:blubuk/pengguna/beranda/controller/beranda.dart';
import 'package:blubuk/pengguna/biografi/controller/biografi.dart';
import 'pengguna/menu.dart';
import 'package:blubuk/emote/model/emote.dart';

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

void main() {
  HttpOverrides.global = new MyHttpOverrides();
  runApp(new MaterialApp(
    home: new LoginPage(),
    routes: <String, WidgetBuilder>{
      '/main': (BuildContext context) => new LoginPage(),
      '/menu': (BuildContext context) => new Menu(),
      '/beranda': (BuildContext context) => new Beranda(),
      '/biografi': (BuildContext context) => new Biografi()
    },
  ));
}

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  LoginPageState createState() => new LoginPageState();
}

class LoginPageState extends State<LoginPage> with AfterLayoutMixin<LoginPage> {
  final formKey = new GlobalKey<FormState>();
  final _scaffoldKey = new GlobalKey<ScaffoldState>();

  String _username;
  String _password;
  String userID;

  bool autovalidate = false;

  bool _ingatSaya = false;

  //we omitted the brackets '{}' and are using fat arrow '=>' instead, this is dart syntax
  void checkBoxIngatSaya(bool value) => setState(() => _ingatSaya = value);

  void _handleSubmitted() {
    final FormState form = formKey.currentState;
    if (!form.validate()) {
      autovalidate = true; // Start validating on every change.
      showInSnackBar('Harap Isi Kolom yang Kosong Terlebih Dahulu');
      setState(() {
        globals.isLoggedIn = false;
      });
    } else {
      form.save();
      _performLogin();
    }
  }

  void showInSnackBar(String value) {
    ScaffoldMessenger(
        key: _scaffoldKey,
        child: Scaffold(
          backgroundColor: Colors.blue,
          body: SafeArea(
              child: new Text(value)
          ),
        )
    );
  }

  void _performLogin() async {
    final snackbar = new SnackBar(
      duration: new Duration(seconds: 10),
      content: new Row(
        children: <Widget>[
          new CircularProgressIndicator(),
          new Text(" Masuk Aplikasi...")
        ],
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
    await tryLogin(_username, _password);
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }

  tryLogin(String username, String password) async {
    print('Function TryLogin');
    print('Username = ' + username);
    print('Password = ' + password);
    await _loginRequest(username, password);
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (globals.hasil == 'Data Ada') {
      setState(() {
        globals.isLoggedIn = true;
        globals.userid = prefs.getString('userid');
        globals.email = prefs.getString('email');
        globals.username = prefs.getString('username');
        globals.status = prefs.getString('status');
        globals.idRole = prefs.getString('idRole');
        globals.fotoProfil = prefs.getString('fotoProfil');
        globals.jenisKelamin = prefs.getString('jenisKelamin');
        globals.tanggalLahir = prefs.getString('tanggalLahir');
        globals.bulanLahir = prefs.getString('bulanLahir');
        globals.tahunLahir = prefs.getString('tahunLahir');
        globals.idAgama = prefs.getString('idAgama');
        globals.agama = prefs.getString('agama');
        globals.telpon = prefs.getString('telpon');
        globals.ponsel = prefs.getString('ponsel');
        globals.alamat = prefs.getString('alamat');
        globals.kodePos = prefs.getString('kodePos');
        globals.token = prefs.getString('token');
        globals.idProvinsi = prefs.getString('idProvinsi');
        globals.provinsi = prefs.getString('provinsi');
        globals.logoProvinsi = prefs.getString('logoProvinsi');
        globals.idKabupaten = prefs.getString('idKabupaten');
        globals.kabupaten = prefs.getString('kabupaten');
        globals.logoKabupaten = prefs.getString('logoKabupaten');
      });
      navigateToScreen('Menu');
    } else {
      print(globals.hasil);
      print('Gagal Login');
      setState(() {
        globals.isLoggedIn = false;
      });
      globals.error = "Harap cek kembali email dan password anda/";
      globals.Utility.showAlertPopup(
          context, "Info", "Proses Login Gagal \n" + globals.error);
    }
  }

  Future<bool> _loginRequest(String username, String password) async {
    print('Function _loginRequest');
    print('Username = ' + username);
    print('Password = ' + password);
    String nilaiIngatSaya = "";
    String result = "";

    if (_ingatSaya == true) {
      nilaiIngatSaya = "Ingat Saya";
    } else if (_ingatSaya == false) {
      nilaiIngatSaya = "Lupa";
    }

    result = await apilogin.LoginUtility.apiLogin(username, password, nilaiIngatSaya);
    print("Result");
    print(result);
    try {
      Map<String, dynamic> hasilJSON = json.decode(result);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      // print(hasilJSON);
      globals.hasil = '${hasilJSON['Pengguna']['hasil']}';
      prefs.setString('userid', '${hasilJSON['Pengguna']['userid']}');
      prefs.setString('email', '${hasilJSON['Pengguna']['email']}');
      prefs.setString('username', '${hasilJSON['Pengguna']['username']}');
      prefs.setString('status', '${hasilJSON['Pengguna']['status']}');
      prefs.setString('idRole', '${hasilJSON['Pengguna']['id_role']}');
      prefs.setString('fotoProfil', '${hasilJSON['Pengguna']['foto_profil']}');
      prefs.setString('token', '${hasilJSON['Pengguna']['token']}');
      prefs.setString(
          'jenisKelamin', '${hasilJSON['Pengguna']['jenisKelamin']}');
      prefs.setString(
          'tanggalLahir', '${hasilJSON['Pengguna']['tanggalLahir']}');
      prefs.setString('bulanLahir', '${hasilJSON['Pengguna']['bulanLahir']}');
      prefs.setString('tahunLahir', '${hasilJSON['Pengguna']['tahunLahir']}');
      prefs.setString('idAgama', '${hasilJSON['Pengguna']['idAgama']}');
      prefs.setString('agama', '${hasilJSON['Pengguna']['agama']}');
      prefs.setString('telpon', '${hasilJSON['Pengguna']['telpon']}');
      prefs.setString('ponsel', '${hasilJSON['Pengguna']['ponsel']}');
      prefs.setString('alamat', '${hasilJSON['Pengguna']['alamat']}');
      prefs.setString('kodePos', '${hasilJSON['Pengguna']['kodePos']}');
      prefs.setString('idProvinsi', '${hasilJSON['Pengguna']['idProvinsi']}');
      prefs.setString('provinsi', '${hasilJSON['Pengguna']['provinsi']}');
      prefs.setString(
          'logoProvinsi', '${hasilJSON['Pengguna']['logoProvinsi']}');
      prefs.setString('idKabupaten', '${hasilJSON['Pengguna']['idKabupaten']}');
      prefs.setString('kabupaten', '${hasilJSON['Pengguna']['kabupaten']}');
      prefs.setString(
          'logoKabupaten', '${hasilJSON['Pengguna']['logoKabupaten']}');

      prefs.setString('error', '${hasilJSON['error']}');
    } catch (exception) {
      return false;
    }
    // Ambil semua Emote
    var resultEmote = await apilogin.LoginUtility.ambilSemuaEmote();
    try {
      var hasilJSON = (json.decode(resultEmote)['Emote'] as List);
      print(hasilJSON);
      List<VariabelEmote> products = hasilJSON.map((newEntries) => new VariabelEmote.fromJson(newEntries)).toList();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      globals.listSemuaEmote = products;
      prefs.setStringList('emote', hasilJSON);
    } catch (e) {
      return false;
    }
    return true;
  }

  Future<Null> navigateToScreen(String name) async {
    if (name.contains('Menu')) {
      Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) =>
                new Menu()), //When Authorized Navigate to the next screen
      );
    } else if (name.contains('Create Pin')) {
      Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) =>
                new PinCodeCreate()), //When Authorized Navigate to the next screen
      );
    } else if (name.contains('Verify Pin')) {
      Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) =>
                new PinCodeVerify()), //When Authorized Navigate to the next screen
      );
    } else {
      print('Error: $name');
    }
  }

  Future<Null> showAlertPopup() async {
    return showDialog<Null>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (_) => new AlertDialog(
        title: new Text('Info'),
        content: new SingleChildScrollView(
          child: new ListBody(
            children: <Widget>[
              new Text('Would you like to set a Pin Code for a faster log in?'),
              new Text('Once a Pin is set you can unlock with biometrics'),
            ],
          ),
        ),
        actions: <Widget>[
          new TextButton(
            child: new Text('Yes'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          new TextButton(
            child: new Text('No'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  void pendaftaranAkun() {
    Navigator.of(context).push(new MaterialPageRoute<Null>(
        builder: (BuildContext context) {
          return new HalamanPendaftaran();
        },
        fullscreenDialog: true));
  }

  void informasiBlubuk() {
    Navigator.of(context).push(new MaterialPageRoute<Null>(
        builder: (BuildContext context) {
          return new HalamanInformasi();
        },
        fullscreenDialog: true));
  }

  void loginFacebook() async {
    final snackbar = new SnackBar(
      duration: new Duration(seconds: 10),
      content: new Row(
        children: <Widget>[
          new CircularProgressIndicator(),
          new Text(" Menghubungkan ke Facebook")
        ],
      ),
    );
    ScaffoldMessenger(
        key: _scaffoldKey,
        child: Scaffold(
          backgroundColor: Colors.blue,
          body: SafeArea(
              child: snackbar
          ),
        )
    );
    sessionFacebookLogin();
    ScaffoldMessenger(
        key: _scaffoldKey,
        child: Scaffold(
          backgroundColor: Colors.blue,
          body: SafeArea(
              child: new Text("")
          ),
        )
    );
  }
  
  sessionFacebookLogin() async {
    print("sessionFacebookLogin");
    loginFacebookOauth();

    SharedPreferences session = await SharedPreferences.getInstance();

    if (session.getString('fbLoggedIn') == 'FB Log In') {
      navigateToScreen('Menu');
    }
  }

  loginFacebookOauth() async {
    print("loginFacebookOauth");
    loginFB.LoginFacebookUtility.apiLoginFacebook();
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('isLoggedIn', 'Log In');
      prefs.setString('fbLoggedIn', 'FB Log In');
      prefs.setString('oauth_uid', globals.oauthUid);
      prefs.setString('oauth_provider', globals.oauthProvider);
      prefs.setString('userid', globals.userid);
      prefs.setString('email', globals.email);
      prefs.setString('username', globals.username);
      prefs.setString('status', globals.status);
      prefs.setString('idRole', globals.idRole);
      prefs.setString('fotoProfil', globals.fotoProfil);
      prefs.setString('jenisKelamin', globals.jenisKelamin);
      prefs.setString('tanggalLahir', globals.tanggalLahir);
      prefs.setString('bulanLahir', globals.bulanLahir);
      prefs.setString('tahunLahir', globals.tahunLahir);
      prefs.setString('idAgama', globals.idAgama);
      prefs.setString('agama', globals.agama);
      prefs.setString('telpon', globals.telpon);
      prefs.setString('ponsel', globals.ponsel);
      prefs.setString('alamat', globals.alamat);
      prefs.setString('kodePos', globals.kodePos);
      prefs.setString('token', globals.token);
      prefs.setString('idProvinsi', globals.idProvinsi);
      prefs.setString('provinsi', globals.provinsi);
      prefs.setString('logoProvinsi', globals.logoProvinsi);
      prefs.setString('idKabupaten', globals.idKabupaten);
      prefs.setString('kabupaten', globals.kabupaten);
      prefs.setString('logoKabupaten', globals.logoKabupaten);
    } catch (exception) {
      return false;
    }

    // Ambil semua Emote
    var resultEmote = await apilogin.LoginUtility.ambilSemuaEmote();
    try {
      var hasilJSON = (json.decode(resultEmote)['Emote'] as List);
      print(hasilJSON);
      List<VariabelEmote> products = hasilJSON.map((newEntries) => new VariabelEmote.fromJson(newEntries)).toList();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      globals.listSemuaEmote = products;
      prefs.setStringList('emote', hasilJSON);
    } catch (e) {
      return false;
    }
    return true;
  }

  // itemList() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   var items = <String>["item1", "item2", "item3"];
  //   prefs.setStringList('items', items);
  // }




  Future<List<VariabelEmote>> ambilSemuaEmote() async {
    var result = await apilogin.LoginUtility.ambilSemuaEmote();
    try {
      var hasilJSON = (json.decode(result)['Emote'] as List);
      print(hasilJSON);
      List<VariabelEmote> products = hasilJSON.map((newEntries) => new VariabelEmote.fromJson(newEntries)).toList();
      return products;
    } catch (e) {
      throw('Error');
    }
  }

















  pasangParameterGlobals() async {
    SharedPreferences session = await SharedPreferences.getInstance();
    String hasil = "";
    hasil = await globals.Utility.ambilParameterGlobals(
        session.getString('userid'));
    try {
      Map<String, dynamic> hasilJson = json.decode(hasil);
      if ('${hasilJson['Pengguna']['ingat_saya']}' == 'Ingat Saya' ||
          '${hasilJson['Pengguna']['oauth_uid']}' != "") {
        globals.isLoggedIn = true;
        globals.fbLoggedIn = true;
        globals.oauthUid = '${hasilJson['Pengguna']['oauth_uid']}';
        globals.oauthProvider = '${hasilJson['Pengguna']['oauth_provider']}';
        globals.userid = '${hasilJson['Pengguna']['userid']}';
        globals.email = '${hasilJson['Pengguna']['email']}';
        globals.username = '${hasilJson['Pengguna']['username']}';
        globals.status = '${hasilJson['Pengguna']['status']}';
        globals.idRole = '${hasilJson['Pengguna']['id_role']}';
        globals.fotoProfil = '${hasilJson['Pengguna']['foto_profil']}';
        globals.jenisKelamin = '${hasilJson['Pengguna']['jenisKelamin']}';
        globals.token = '${hasilJson['Pengguna']['token']}';
        globals.tanggalLahir = '${hasilJson['Pengguna']['tanggalLahir']}';
        globals.bulanLahir = '${hasilJson['Pengguna']['bulanLahir']}';
        globals.tahunLahir = '${hasilJson['Pengguna']['tahunLahir']}';
        globals.idAgama = '${hasilJson['Pengguna']['idAgama']}';
        globals.agama = '${hasilJson['Pengguna']['agama']}';
        globals.telpon = '${hasilJson['Pengguna']['telpon']}';
        globals.ponsel = '${hasilJson['Pengguna']['ponsel']}';
        globals.alamat = '${hasilJson['Pengguna']['alamat']}';
        globals.kodePos = '${hasilJson['Pengguna']['kodePos']}';
        globals.idProvinsi = '${hasilJson['Pengguna']['idProvinsi']}';
        globals.provinsi = '${hasilJson['Pengguna']['provinsi']}';
        globals.logoProvinsi = '${hasilJson['Pengguna']['logoProvinsi']}';
        globals.idKabupaten = '${hasilJson['Pengguna']['idKabupaten']}';
        globals.kabupaten = '${hasilJson['Pengguna']['kabupaten']}';
        globals.logoKabupaten = '${hasilJson['Pengguna']['logoKabupaten']}';
        navigateToScreen('Menu');
      } else {
        hapusSession();
      }
    } catch (exception) {
      return false;
    }
    return true;
  }

  Future<bool> pasangApiKeyGlobals() async {
    String hasil = "";
    hasil = await globals.Utility.pasangApiKeyGlobals();
    print(hasil);
    try {
      Map<String, dynamic> hasilJson = json.decode(hasil);
      print(hasilJson);
      globals.contentTypeItem = '${hasilJson['contentTypeItem']}';
      globals.contentType = '${hasilJson['contentType']}';
      globals.apiKeyItem = '${hasilJson['apiKeyItem']}';
      globals.apiKey = '${hasilJson['apiKey']}';
      globals.kepalaTokenItem = '${hasilJson['kepalaTokenItem']}';
      globals.kepalaToken = '${hasilJson['kepalaToken']}';
    } catch (exception) {
      return false;
    }
    return true;
  }

  redirectMenu() async {
    try {
      SharedPreferences session = await SharedPreferences.getInstance();
      if (session.getString('fotoProfil') != null) {
        navigateToScreen('Menu');
      }
    } catch (exception) {
      print("Tidak Ada Session");
    }
  }

  checkApiKeyGlobals() {
    try {
      print(globals.isLoggedIn);
      print("Ini Globals Content Type Item = " + globals.contentTypeItem);
      print("Ini Globals Content Type = " + globals.contentType);
      print("Ini Globals Api Key Item = " + globals.apiKeyItem);
      print("Ini Globals Api Key = " + globals.apiKey);
      print("Ini Globals Kepala Token Item = " + globals.kepalaTokenItem);
      print("Ini Globals Kepala Token = " + globals.kepalaToken);
    } catch (exception) {
      print('Tidak Ada Nilai');
    }
  }

  checkGlobalParameter() {
    try {
      print(globals.isLoggedIn);
      print("Ini Globals Hasil = " + globals.hasil);
      print("Ini Globals UserID = " + globals.userid);
      print("Ini Globals Email = " + globals.email);
      print("Ini Globals Username = " + globals.username);
      print("Ini Globals Status = " + globals.status);
      print("Ini Globals ID Role = " + globals.idRole);
      print("Ini Globals Foto Profil = " + globals.fotoProfil);
      print("Ini Globals Token = " + globals.token);
      print("Ini Globals Jenis Kelamin = " + globals.jenisKelamin);
      print("Ini Globals Telpon = " + globals.telpon);
      print("Ini Globals Ponsel = " + globals.ponsel);
      print("Ini Globals Alamat = " + globals.alamat);
      print("Ini Globals Kode Pos = " + globals.kodePos);
      print("Ini Globals ID Provinsi = " + globals.idProvinsi);
      print("Ini Globals Provinsi = " + globals.provinsi);
      print("Ini Globals Logo Provinsi = " + globals.logoProvinsi);
    } catch (exception) {
      print('Tidak Ada Nilai');
    }
  }

  checkSession() async {
    try {
      SharedPreferences session = await SharedPreferences.getInstance();
      print("Ini Session Is Logged In = " + session.getString('isLoggedIn'));
      print("Ini Session FB Logged In = " + session.getString('fbLoggedIn'));
      print("Ini Session Oauth ID = " + session.getString('oauth_uid'));
      print("Ini Session Oauth Provider = " +
      session.getString('oauth_provider'));
      print("Ini Session Hasil = " + session.getString('hasil'));
      print("Ini Session User ID = " + session.getString('userid'));
      print("Ini Session Email = " + session.getString('email'));
      print("Ini Session Username = " + session.getString('username'));
      print("Ini Session Status = " + session.getString('status'));
      print("Ini Session ID Role = " + session.getString('idRole'));
      print("Ini Session Foto Profil = " + session.getString('fotoProfil'));
      print("Ini Session Jenis Kelamin = " + session.getString('jenisKelamin'));
      print("Ini Session Telp = " + session.getString('telpon'));
      print("Ini Session Ponsel = " + session.getString('ponsel'));
      print("Ini Session Alamat = " + session.getString('alamat'));
      print("Ini Session Kode Pos = " + session.getString('kodePos'));
      print("Ini Session Token = " + session.getString('token'));
      print("Ini Session ID Provinsi = " + session.getString('idProvinsi'));
      print("Ini Session Provinsi = " + session.getString('provinsi'));
      print("Ini Session Logo Provinsi = " + session.getString('logoProvinsi'));
    } catch (exception) {
      print("Tidak Ada Session");
    }
  }

  hapusSession() async {
    try {
      SharedPreferences session = await SharedPreferences.getInstance();
      // print('Username: $username Password $password.');
      session.remove('isLoggedIn');
      session.remove('fbLoggedIn');
      session.remove('oauth_uid');
      session.remove('oauth_provider');
      session.remove('userid');
      session.remove('email');
      session.remove('username');
      session.remove('status');
      session.remove('idRole');
      session.remove('fotoProfil');
      session.remove('jenisKelamin');
      session.remove('telpon');
      session.remove('ponsel');
      session.remove('alamat');
      session.remove('kodePos');
      session.remove('token');
      session.remove('idProvinsi');
      session.remove('provinsi');
      session.remove('logoProvinsi');
    } catch (exception) {
      return false;
    }
    return true;
  }

  @override
  void afterFirstLayout(BuildContext context) {
    pasangApiKeyGlobals();
    pasangParameterGlobals();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        title: new Text('Blubuk'),
      ),
      body: new Container(
        color: Colors.grey[300],
        child: new ListView(
          physics: new AlwaysScrollableScrollPhysics(),
          key: new PageStorageKey("Divider 1"),
          children: <Widget>[
            new Container(
              height: 20.0,
            ),
            new Padding(
              padding: EdgeInsets.all(20.0),
              child: new Card(
                child: new Column(
                  children: <Widget>[
                    new Container(height: 30.0),
                    new CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 48.0,
                      child: Image.asset('assets/Foto/Logo/logo.png'),
                    ),
                    new Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: new Form(
                        key: formKey,
                        child: new Column(
                          children: [
                            new TextFormField(
                              decoration:
                                  new InputDecoration(labelText: 'Email'),
                              validator: (val) =>
                                  val.length < 1 ? 'Email Required' : null,
                              onSaved: (val) => _username = val,
                              obscureText: false,
                              keyboardType: TextInputType.text,
                              autocorrect: false,
                            ),
                            new Container(height: 10.0),
                            new TextFormField(
                              decoration:
                                  new InputDecoration(labelText: 'Password'),
                              validator: (val) =>
                                  val.length < 1 ? 'Password Required' : null,
                              onSaved: (val) => _password = val,
                              obscureText: true,
                              keyboardType: TextInputType.text,
                              autocorrect: false,
                            ),
                            new Container(height: 5.0),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            new Container(
              padding: new EdgeInsets.all(32.0),
              child: new Center(
                child: new Column(
                  children: <Widget>[
                    new CheckboxListTile(
                      value: _ingatSaya,
                      onChanged: checkBoxIngatSaya,
                      title: new Text('Ingat Saya'),
                      controlAffinity: ListTileControlAffinity.leading,
                      // subtitle: new Text('Subtitle'),
                      // secondary: new Icon(Icons.archive),
                      activeColor: Colors.blue,
                    ),
                  ],
                ),
              ),
            ),
            new Padding(
              padding: EdgeInsets.all(0.20),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new TextButton(
                    onPressed: loginFacebook,
                    child: new Text("Login Dengan Facebook",
                      textAlign: TextAlign.center,
                      style:  const TextStyle(
                          color: Colors.black,
                          fontSize: 14.0,
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),

            // new Padding(
            //   padding: EdgeInsets.all(0.20),
            //   child: new Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: <Widget>[
            //       new TextButton(
            //         onPressed: checkGlobalParameter,
            //         child: new Text("Check Global Parameter",
            //           textAlign: TextAlign.center,
            //           style:  const TextStyle(
            //               color: Colors.black,
            //               fontSize: 14.0,
            //               fontFamily: "Roboto",
            //               fontWeight: FontWeight.bold),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            // new Padding(
            //   padding: EdgeInsets.all(0.20),
            //   child: new Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: <Widget>[
            //       new TextButton(
            //         onPressed: checkApiKeyGlobals,
            //         child: new Text("Check Api Key Global",
            //           textAlign: TextAlign.center,
            //           style:  const TextStyle(
            //               color: Colors.black,
            //               fontSize: 14.0,
            //               fontFamily: "Roboto",
            //               fontWeight: FontWeight.bold),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            // new Padding(
            //   padding: EdgeInsets.all(0.20),
            //   child: new Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: <Widget>[
            //       new TextButton(
            //         onPressed: pasangApiKeyGlobals,
            //         child: new Text("Pasang Api Key Global",
            //           textAlign: TextAlign.center,
            //           style:  const TextStyle(
            //               color: Colors.black,
            //               fontSize: 14.0,
            //               fontFamily: "Roboto",
            //               fontWeight: FontWeight.bold),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            new Padding(
              padding: EdgeInsets.all(20.0),
              child: new Row(
                children: <Widget>[
                  new Expanded(
                    child: new Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: new ElevatedButton(
                        onPressed: _handleSubmitted,
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue,
                        ),
                        child: new Text(
                          'Login',
                          style: new TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            new Padding(
              padding: EdgeInsets.all(20.0),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new TextButton(
                    onPressed: pendaftaranAkun,
                    child: new Text("Buat Akun Baru",
                      textAlign: TextAlign.center,
                      style:  const TextStyle(
                          color: Colors.black,
                          fontSize: 14.0,
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  new TextButton(
                    onPressed: informasiBlubuk,
                    child: new Text("Informasi Blubuk",
                      textAlign: TextAlign.center,
                      style:  const TextStyle(
                          color: Colors.black,
                          fontSize: 14.0,
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
