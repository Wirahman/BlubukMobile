import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import 'package:Blubuk/globals.dart' as globals;
import 'package:Blubuk/pengguna/uploadFile/imagePickerHandler.dart';
import 'package:Blubuk/pengguna/biografi/model/agama.dart';
import 'package:Blubuk/pengguna/biografi/model/provinsi.dart';
import 'package:Blubuk/pengguna/biografi/model/kabupaten.dart';
import 'package:Blubuk/pengguna/biografi/view/tampilanBiografi.dart';
import 'package:Blubuk/api/upload/uploadfoto.dart';
import 'package:Blubuk/pengguna/biografi/model/apibiografi.dart' as apibiografi;
import 'package:Blubuk/pengguna/menu.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';

class Biografi extends StatefulWidget {
  Biografi({Key key, this.title}) : super(key: key);
  final String title;
  @override
  BiografiState createState() => new BiografiState();
}

class BiografiState extends State<Biografi> with TickerProviderStateMixin,ImagePickerListener {
  AnimationController animationcontroller;
  ImagePickerHandler imagePicker;
  final formUbahBiografiKey = new GlobalKey<FormState>();
  // final formKey = new GlobalKey<FormState>();
  final biografiScaffoldKey = new GlobalKey<ScaffoldState>();
  bool autovalidate = false;
  final dateFormat = DateFormat("dd-M-yyyy");
  final dateSqlFormat = DateFormat("yyyy-M-dd");

  File fotoBiografi;
  File fotoUpload;
  String userID = globals.userid;
  String namaLengkap;
  List<String> listJenisKelamin = <String>['Jenis Kelamin', 'Laki - Laki', 'Perempuan'];
  String jenisKelamin = globals.jenisKelamin;
  
  AutoCompleteTextField agamaTextField;
  GlobalKey<AutoCompleteTextFieldState<Agama>> keyAgama = new GlobalKey();

  static List<Agama> daftarAgama = new List<Agama>();
  bool loadingDaftarAgama = true;
  String agama = globals.agama;

  String tanggalLahir;
  String telpon;
  String ponsel;
  String alamat;
  String kodePos;

  AutoCompleteTextField provinsiTextField;
  GlobalKey<AutoCompleteTextFieldState<Provinsi>> keyProvinsi = new GlobalKey();

  static List<Provinsi> daftarProvinsi = new List<Provinsi>();
  bool loadingDaftarProvinsi = true;
  String provinsi = globals.provinsi;
  String idProvinsi = globals.idProvinsi;
  String logoProvinsi = globals.logoProvinsi;

  AutoCompleteTextField kabupatenTextField;
  GlobalKey<AutoCompleteTextFieldState<Kabupaten>> keyKabupaten = new GlobalKey();

  static List<Kabupaten> daftarKabupaten = new List<Kabupaten>();
  bool loadingDaftarKabupaten = true;
  bool dataDaftarKabupaten = false;
  
  String kabupaten = globals.kabupaten;
  String idKabupaten = globals.idKabupaten;
  String logoKabupaten = globals.logoKabupaten;

  String fotoProfil;

  @override
  void initState() {
    _ambilDaftarAgama();
    _ambilDaftarProvinsi();
    _ambilDaftarKabupaten();
    animationcontroller = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    imagePicker=new ImagePickerHandler(this,animationcontroller);
    imagePicker.init();
    
    super.initState();
  }

  @override
  void dispose() {
    animationcontroller.dispose();
    super.dispose();
  }

  void showInSnackBar(String value) {
    biografiScaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(value)));
  }

  void _ambilDaftarAgama() async{
    await ambilDaftarAgama();
  }

  Future ambilDaftarAgama() async{
    var result = await apibiografi.BiografiUtility.apiAmbilDaftarAgama(globals.userid);
    try{
      daftarAgama = new List<Agama>();
      Map mapJSON = json.decode(result);
      var hasilJSON = mapJSON['Agama'] as List;
      // print(hasilJSON);
      
      for (int i = 0; i < hasilJSON.length; i++) {
        // Kesalahan terletak di agama.dart, id tidak bisa dalam bentuk int
        // print("Agama ke - ");
        // print([i]);
        // print(hasilJSON[i]);
        daftarAgama.add(new Agama.fromJson(hasilJSON[i]));
      }
      setState(() {
        loadingDaftarAgama = false;
      });
    } catch (e) {
      print(e);
    }
  }

  void _ambilDaftarProvinsi() async{
    await ambilDaftarProvinsi();
  }

  Future ambilDaftarProvinsi() async{
    var result = await apibiografi.BiografiUtility.apiAmbilDaftarProvinsi(globals.userid);
    try{
      daftarProvinsi = new List<Provinsi>();
      Map mapJSON = json.decode(result);
      var hasilJSON = mapJSON['Provinsi'] as List;
      // print(hasilJSON);
      
      for (int i = 0; i < hasilJSON.length; i++) {
        daftarProvinsi.add(new Provinsi.fromJson(hasilJSON[i]));
      }
      setState(() {
        loadingDaftarProvinsi = false;
      });
    } catch (e) {
      print(e);
    }
    
  }

  void _ambilDaftarKabupaten() async{
    await ambilDaftarKabupatenPerProvinsi();
  }

  Future ambilDaftarKabupaten() async{
      var result = await apibiografi.BiografiUtility.apiAmbilDaftarKabupaten(globals.userid, globals.idProvinsi);
      try{
        daftarKabupaten = new List<Kabupaten>();
        Map mapJSON = json.decode(result);
        var hasilJSON = mapJSON['Kabupaten'] as List;
        // print(hasilJSON);
        
        for (int i = 0; i < hasilJSON.length; i++) {
          daftarKabupaten.add(new Kabupaten.fromJson(hasilJSON[i]));
        }
        setState(() {
          loadingDaftarKabupaten = false;
        });
      } catch (e) {
        print(e);
      }
    
  }

  void _ambilDaftarKabupatenPerProvinsi() async{
    await ambilDaftarKabupatenPerProvinsi();
  }

  Future ambilDaftarKabupatenPerProvinsi() async{
    var result = await apibiografi.BiografiUtility.apiAmbilDaftarKabupaten(globals.userid, idProvinsi);
    try{
      daftarKabupaten = new List<Kabupaten>();
      Map mapJSON = json.decode(result);
      if ('${mapJSON['pesan_api']}' == "Sukses"){
        dataDaftarKabupaten = true;
      }else{
        dataDaftarKabupaten = false;
      }
      
      if (dataDaftarKabupaten == true) {
         var hasilJSON = mapJSON['Kabupaten'] as List;
        
        for (int i = 0; i < hasilJSON.length; i++) {
          // print(hasilJSON[i]);
          daftarKabupaten.add(new Kabupaten.fromJson(hasilJSON[i]));
          // print("Data Ada");
        }
      }else{
        print("Data Tidak Ada");
      }

      print(daftarKabupaten.length);
      
      setState(() {
        if(daftarKabupaten.length != 0){
          daftarKabupaten.addAll(daftarKabupaten);
        }
        
        loadingDaftarKabupaten = false;
      });
    } catch (e) {
      print(e);
    }
  
  }

  Future updateFotoBiografi() async {
    var pesan = "";
    var hasil = await apibiografi.BiografiUtility.apiFotoBiografi(userID, globals.fotoUpload);
    if (hasil == "Berhasil") {
      pesan = "Biografi anda sudah diubah";      
    }else if (hasil == "Gagal") {
      pesan = "Biografi anda gagal diubah, terjadi kesalahan system";
    }
    var ambilDataTerbaru = await globals.Utility.ambilDataPenggunaTerbaru(userID);

    try {
      Map<String, dynamic> hasilJSON = json.decode(ambilDataTerbaru);
      globals.fotoProfil = '${hasilJSON['Pengguna']['fotoProfil']}';
    } catch (exception) {
      throw("Error");
    }
    
    return new Biografi();
  }

  Future klikUpdateBiografi() async {
    final FormState formUbahBiografi = formUbahBiografiKey.currentState;
    if (!formUbahBiografi.validate()) {
      autovalidate = true; // Start validating on every change.
      showInSnackBar('Harap Lengkapi Kolom yang Kosong');
    } else {
      // Validasi buat nanti

      // if (_tanggalLahir == ''){
      //   showInSnackBar("Harap Isi Tanggal Lahir Anda");
      // }else if(_jkelamin == 'Jenis Kelamin'){
      //   showInSnackBar("Harap Pilih Jenis Kelamin Anda");
      // }else if (_password != _passwordKonfirmasi){
      //   showInSnackBar("Password dan Password Konfirmasi Anda Tidak Sesuai");
      // }else{
      //   formUbahBiografi.save();
      //   prosesUpdateBiografi();
      // }

      if(jenisKelamin == 'Jenis Kelamin'){
        showInSnackBar("Harap Pilih Jenis Kelamin Anda");
      }else{
        formUbahBiografi.save();
        prosesUpdateBiografi();          
        // Navigator.push(
        //   context,
        //   new MaterialPageRoute<String>(
        //   builder: (BuildContext context) => new Menu(),
        //   fullscreenDialog: true,
        // ));
      }

    }
    
  }
  
  void prosesUpdateBiografi() async {
    final snackbar = new SnackBar(
      duration: new Duration(seconds: 10),
      content: new Row(
        children: <Widget>[
          new CircularProgressIndicator(),
          new Text(" Update Biografi Sedang Dilakukan...")
        ],
      ),
    );
    biografiScaffoldKey.currentState.showSnackBar(snackbar);
    await updateBiografi(namaLengkap, jenisKelamin, telpon, ponsel, alamat, kodePos, idProvinsi);
    biografiScaffoldKey.currentState.hideCurrentSnackBar();
  }

  updateBiografi(String namaLengkap, String jenisKelamin, String telpon, String ponsel, String alamat, String kodePos, String idProvinsi) async {
    String hasil = "";
    hasil = await apibiografi.BiografiUtility.apiUpdateBiografi(namaLengkap, jenisKelamin, telpon, ponsel, alamat, kodePos, idProvinsi);
    try {
      Map<String, dynamic> hasilJson = json.decode(hasil);
      print('${hasilJson['Pengguna']['hasil']}');
      if('${hasilJson['Pengguna']['hasil']}' == 'Data Sudah Diubah') {
        globals.username = '${hasilJson['Pengguna']['namaLengkap']}';
        globals.jenisKelamin = '${hasilJson['Pengguna']['jenisKelamin']}';
        globals.telpon = '${hasilJson['Pengguna']['telpon']}';
        globals.ponsel = '${hasilJson['Pengguna']['ponsel']}';
        globals.alamat = '${hasilJson['Pengguna']['alamat']}';
        globals.kodePos = '${hasilJson['Pengguna']['kodePos']}';

        globals.idProvinsi = '${hasilJson['Pengguna']['idProvinsi']}';
        globals.provinsi = '${hasilJson['Pengguna']['provinsi']}';
        globals.logoProvinsi = '${hasilJson['Pengguna']['logoProvinsi']}';
        provinsi = globals.provinsi;
        logoProvinsi = globals.logoProvinsi;
        print('ID Provinsi');
        print(globals.idProvinsi);
        print('Nama Provinsi');
        print(globals.provinsi);
        print('Logo Provinsi');
        print(globals.logoProvinsi);
        showInSnackBar('Biografi anda sudah diubah');
      }else{
        String pesanUpdateBiografi = '${hasilJson['Pengguna']['hasil']}';
        print(pesanUpdateBiografi);
      }
    } catch (e) {
      throw(e);
    }

  }

  Future<File> checkFotoProfil() async {
    try {
      if (globals.fotoUpload != null){
        fotoUpload = globals.fotoUpload;
      }
    } catch (e) {
      print("Belum ada foto yang diupload");
    }
    return(fotoUpload);
    
  }

  Future uploadFotoGalleryStatus() async{
    var fotoBiografi = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      fotoBiografi = fotoBiografi;
    });
    print("Uploaded Image: $fotoBiografi");
    UploadFotoUtility.uploadFotoCameraStatus(fotoBiografi).then((val) => setState(()
    {
      print("API result: $val");
    }));

  }

  Future pasangTanggalLahir({DateTime ttl}) async {
    
    String formatSqlTanggalLahir = dateSqlFormat.format(ttl);
    print(formatSqlTanggalLahir);
    apibiografi.BiografiUtility.apiUpdateTanggalLahirBiografi(formatSqlTanggalLahir);
    var splitTTL = formatSqlTanggalLahir.split('-') as List;

    globals.tahunLahir = splitTTL[0];
    globals.bulanLahir = splitTTL[1];
    globals.tanggalLahir = splitTTL[2];
  }

  // void _setDateOfBirth() {
  //   if ('${dobKey.currentState.dobMonth}' == '0' || '${dobKey.currentState.dobMonth}' == ''){
  //     _bulanLahir = '01';
  //   } else if ('${dobKey.currentState.dobMonth}' == '1'){
  //     _bulanLahir = '02';
  //   } else if ('${dobKey.currentState.dobMonth}' == '2'){
  //     _bulanLahir = '03';
  //   } else if ('${dobKey.currentState.dobMonth}' == '3'){
  //     _bulanLahir = '04';
  //   } else if ('${dobKey.currentState.dobMonth}' == '4'){
  //     _bulanLahir = '05';
  //   } else if ('${dobKey.currentState.dobMonth}' == '5'){
  //     _bulanLahir = '06';
  //   } else if ('${dobKey.currentState.dobMonth}' == '6'){
  //     _bulanLahir = '07';
  //   } else if ('${dobKey.currentState.dobMonth}' == '7'){
  //     _bulanLahir = '08';
  //   } else if ('${dobKey.currentState.dobMonth}' == '8'){
  //     _bulanLahir = '09';
  //   } else if ('${dobKey.currentState.dobMonth}' == '9'){
  //     _bulanLahir = '10';
  //   } else if ('${dobKey.currentState.dobMonth}' == '10'){
  //     _bulanLahir = '11';
  //   } else if ('${dobKey.currentState.dobMonth}' == '11'){
  //     _bulanLahir = '12';
  //   } else {
  //     _bulanLahir = '';
  //   }

  //   _tanggalLahir =  '${dobKey.currentState.dobDate}';
  //   _tahunLahir = '${dobKey.currentState.dobYear}';

  //   showInSnackBar('Tanggal Lahir Anda = ' + ' ${dobKey.currentState.dobDate} ' +
  //       dobKey.currentState.dobStrMonth +
  //       ' ${dobKey.currentState.dobYear}');
  // }

  @override
  Widget build(BuildContext context) => new TampilanBiografi(this);

  @override
  userImage(File fotoBiografi) {
    setState(() {
      this.fotoBiografi = fotoBiografi;
    });
  }


}
  