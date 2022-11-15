import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';

import 'package:blubuk/globals.dart' as globals;
import 'package:blubuk/api/login/pendaftaran.dart' as apipendaftaran;
import 'package:blubuk/pengguna/menu.dart';
import 'package:blubuk/login/perjanjian.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HalamanPendaftaran extends StatefulWidget {
  @override
  HalamanPendaftaranState createState() => new HalamanPendaftaranState();
}

class HalamanPendaftaranState extends State<HalamanPendaftaran> {
  final formKey = new GlobalKey<FormState>();
  final _scaffoldKey = new GlobalKey<ScaffoldState>();

  String _username;
  String _email;
  String _password;
  String _passwordKonfirmasi;
  String _tanggalLahir = "";
  String _bulanLahir = "";
  String _tahunLahir = "";
  String _jamLahir = "";

  List<String> _jenisKelamin = <String>['Jenis Kelamin', 'Laki - Laki', 'Perempuan'];
  String _jkelamin = 'Jenis Kelamin';

  void openTermsAndConditions() {
    Navigator.of(context).push(new MaterialPageRoute<Null>(
        builder: (BuildContext context) {
          return new HalamanPerjanjian();
        },
        fullscreenDialog: true));
  }

  bool autovalidate = false;

  void _buttonPendaftaran() {
    final FormState form = formKey.currentState;
    if (!form.validate()) {
      autovalidate = true; // Start validating on every change.
      showInSnackBar('Harap Lengkapi Kolom yang Kosong');
    } else {
      form.save();
      _performPendaftaran();
    }
  }

  void _performPendaftaran() async {
    // This is just a demo, so no actual login here.
    final snackbar = new SnackBar(
      duration: new Duration(seconds: 10),
      content: new Row(
        children: <Widget>[
          new CircularProgressIndicator(),
          new Text(" Pendaftaran Sedang Dilakukan...")
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
    await pendaftaranPengguna(_username, _email, _password, _jkelamin, _tanggalLahir, _bulanLahir, _tahunLahir);
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

  pendaftaranPengguna(String username, String email, String password, String jenisKelamin, String tanggalLahir, String bulanLahir, String tahunLahir) async {
    
    await permintaanPendaftaran(username, email, password, jenisKelamin, tanggalLahir, bulanLahir, tahunLahir);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print('pendaftaranPengguna');

    if (globals.hasil == 'Data Sudah Dibuat') {
      setState(() {
        globals.isLoggedIn = true;
        globals.userid = prefs.getString('userid');
        globals.email = prefs.getString('email') ;
        globals.username = prefs.getString('username');
        globals.status = prefs.getString('status');
        globals.idRole = prefs.getString('idRole');
        globals.fotoProfil = prefs.getString('fotoProfil');
        globals.token = prefs.getString('token');
        globals.jenisKelamin = prefs.getString('jenisKelamin');
        globals.tanggalLahir = prefs.getString('tanggalLahir');
        globals.bulanLahir = prefs.getString('bulanLahir');
        globals.tahunLahir = prefs.getString('tahunLahir');
      });

      Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) =>
            new Menu()), //When Authorized Navigate to the next screen
      );
    } else {
      setState(() {
        globals.isLoggedIn = false;
      });
      if (_tanggalLahir == ''){
        globals.error = "Harap Isi Tanggal Lahir Anda";
      }else if(_jkelamin == 'Jenis Kelamin'){
        globals.error = "Harap Pilih Jenis Kelamin Anda";
      }else if (_password != _passwordKonfirmasi){
        globals.error = "Password dan Password Konfirmasi Anda Tidak Sesuai";
      }else{
        globals.error = "Pendaftaran Gagal Dilakukan/";
      }
      globals.Utility.showAlertPopup(context, "Info", "Harap coba kembali... \n" + globals.error);
    }
  }

  Future<bool> permintaanPendaftaran(String username, String email, String password, String jenisKelamin, String tanggalLahir, String bulanLahir, String tahunLahir) async {
    String result = "";
    result = await apipendaftaran.PendaftaranUtility.apiPendaftaran(username, email, password, jenisKelamin, tanggalLahir, bulanLahir, tahunLahir);
    try {
      Map<String, dynamic> hasilJSON = json.decode(result);
      SharedPreferences prefs = await SharedPreferences.getInstance();

      if ('${hasilJSON['Pengguna']['hasil']}' == 'Data Sudah Dibuat'){
        globals.hasil = '${hasilJSON['Pengguna']['hasil']}';
        prefs.setString('userid', '${hasilJSON['Pengguna']['userid']}');
        prefs.setString('email', '${hasilJSON['Pengguna']['email']}');
        prefs.setString('username', '${hasilJSON['Pengguna']['username']}');
        prefs.setString('status', '${hasilJSON['Pengguna']['status']}');
        prefs.setString('idRole', '${hasilJSON['Pengguna']['id_role']}');
        prefs.setString('fotoProfil', '${hasilJSON['Pengguna']['foto_profil']}');
        prefs.setString('token', '${hasilJSON['Pengguna']['token']}');
        prefs.setString('jenisKelamin', '${hasilJSON['Pengguna']['jenisKelamin']}');
        prefs.setString('tanggalLahir', '${hasilJSON['Pengguna']['tanggalLahir']}');
        prefs.setString('bulanLahir', '${hasilJSON['Pengguna']['bulanLahir']}');
        prefs.setString('tahunLahir', '${hasilJSON['Pengguna']['tahunLahir']}');
      }else{
        globals.error = '${hasilJSON['Pengguna']['hasil']}';
        showInSnackBar('${hasilJSON['Pengguna']['hasil']}');
      }
    } catch (exception) {
      return false;
    }
    return true;
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

  void pasangTanggalLahir(date) {
    // 1903-01-03 12:25:00.0000
    print(date);

    print("${date.day}/${date.month}\n ${date.year}");
    _tanggalLahir = splitTanggalLahir("${date.day}");
    _bulanLahir = splitTanggalLahir("${date.month}");
    _tahunLahir = "${date.year}";
    _jamLahir  = "${date.hour}:${date.minute}:${date.second}";
    print("Tanggal = ${date.day}");
    print("Bulan = ${date.month}");
    print("Tahun = ${date.year}");
    print("Jam Lahir = ${date.hour}:${date.minute}:${date.second}");
      showInSnackBar('Tanggal Lahir Anda = ' + _tanggalLahir +
          _bulanLahir + _tahunLahir + _jamLahir);

  }

  splitTanggalLahir(tanggalLahir){
    if(tanggalLahir == '1'){
      return '01';
    }else if(tanggalLahir == '2'){
      return '02';
    }else if(tanggalLahir == '3'){
      return '03';
    }else if(tanggalLahir == '4'){
      return '04';
    }else if(tanggalLahir == '5'){
      return '05';
    }else if(tanggalLahir == '6'){
      return '06';
    }else if(tanggalLahir == '7'){
      return '07';
    }else if(tanggalLahir == '8'){
      return '08';
    }else if(tanggalLahir == '9'){
      return '09';
    }else{
      return tanggalLahir;
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        title: const Text('Buat Akun Baru'),
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
                    new Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: new Form(
                        key: formKey,
                        child: new Column(
                          children: [
                            new TextFormField(
                              decoration:
                              new InputDecoration(labelText: 'Nama'),
                              validator: (val) =>
                              val.length < 1 ? 'Harap Lengkapi Nama Anda' : null,
                              onSaved: (val) => _username = val,
                              obscureText: false,
                              keyboardType: TextInputType.text,
                              autocorrect: false,
                            ),
                            new Container(
                              height: 10.0,
                            ),
                            new TextFormField(
                              decoration:
                              new InputDecoration(
                                labelText: 'Alamat Email'
                              ),
                              // validator: this._validateEmail,
                              validator: (val) =>
                              val.length < 1 ? 'Harap Lengkapi Email' : null,
                              onSaved: (val) => _email = val,
                              obscureText: false,
                              keyboardType: TextInputType.emailAddress,
                              autocorrect: false,
                            ),
                            new Container(height: 10.0),
                            new TextFormField(
                              decoration:
                              new InputDecoration(
                                labelText: 'Kata Sandi'
                              ),
                              // validator: this._validatePassword,
                              validator: (val) =>
                              val.length < 1 ? 'Harap Lengkapi Kata Sandi Anda' : null,
                              onSaved: (val) => _password = val,
                              obscureText: true,
                              keyboardType: TextInputType.text,
                              autocorrect: false,
                            ),
                            new Container(
                              height: 10.0,
                            ),
                            new TextFormField(
                              decoration:
                              new InputDecoration(labelText: 'Konfirmasi Password'),
                              // validator: this._validatePassword,
                              validator: (val) =>
                              val.length < 1 ? 'Harap Lengkapi Konfirmasi Password Anda' : null,
                              onSaved: (val) => _passwordKonfirmasi = val,
                              obscureText: true,
                              keyboardType: TextInputType.text,
                              autocorrect: false,
                            ),
                            new Container(height: 10.0),
                            new Text('Tanggal Lahir'),
                            DateTimeField(
                              format: DateFormat("yyyy-MM-dd  HH:mm"),
                              onShowPicker: (context, currentValue) async {
                                final date = await showDatePicker(
                                    context: context,
                                    firstDate: DateTime(1900),
                                    initialDate: currentValue ?? DateTime.now(),
                                    lastDate: DateTime(2100));
                                if (date != null) {
                                  final time = await showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                                  );
                                  return DateTimeField.combine(date, time);
                                } else {
                                  return currentValue;
                                }
                              },
                              onChanged: (date) => pasangTanggalLahir(date),
                            ),

                            // new DatePicker(
                            //   key: dobKey,
                            //   setDate: _setDateOfBirth,
                            // ),

                            new Container(height: 10.0),
                            new DropdownButton<String>(
                              value: _jkelamin,
                            //  isDense: true,
                              onChanged: (String newValue) {
                                setState(() {
                                  _jkelamin = newValue;
                                });
                              },
                              items: _jenisKelamin.map((String value) {
                                return new DropdownMenuItem<String>(
                                  value: value,
                                  child: new Text(value),
                                );
                              }).toList(),
                            ),
                            new Container(height: 5.0),
                            new TextButton(
                                onPressed: openTermsAndConditions,
                                child: new Text("HalamanPerjanjian",
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
                    ),
                  ],
                ),
              ),
            ),
            new Padding(
              padding: EdgeInsets.all(20.0),
              child: new Row(
                children: <Widget>[
                  new Expanded(
                    child: new Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: new ElevatedButton(
                        onPressed: _buttonPendaftaran,
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue,
                        ),
                        child: new Text(
                          'Daftar',
                          style: new TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
