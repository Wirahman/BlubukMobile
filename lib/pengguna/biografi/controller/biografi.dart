import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';

import 'package:blubuk/globals.dart' as globals;
import 'package:blubuk/pengguna/uploadFile/imagePickerHandler.dart';
import 'package:blubuk/pengguna/menu.dart';
import 'package:blubuk/pengguna/biografi/model/agama.dart';
import 'package:blubuk/pengguna/biografi/model/provinsi.dart';
import 'package:blubuk/pengguna/biografi/model/kabupaten.dart';
import 'package:blubuk/pengguna/biografi/tampilan/tampilanBiografi.dart';
import 'package:blubuk/api/upload/uploadfoto.dart';
import 'package:blubuk/api/biografi/apiBiografi.dart' as apibiografi;

class Biografi extends StatefulWidget {
  Biografi({Key key, this.title}) : super(key: key);
  final String title;
  @override
  BiografiState createState() => new BiografiState();
}

class BiografiState extends State<Biografi> with TickerProviderStateMixin, ImagePickerListener {
  AnimationController animationcontroller;
  ImagePickerHandler imagePicker;
  final formUbahBiografiKey = new GlobalKey<FormState>();
  // final formKey = new GlobalKey<FormState>();
  final biografiScaffoldKey = new GlobalKey<ScaffoldState>();
  bool autovalidate = false;
  final dateFormat = DateFormat("dd-M-yyyy");
  final dateSqlFormat = DateFormat("yyyy-M-dd");

  XFile fotoBiografi;
  XFile fotoUpload;
  String userID = globals.userid;
  String namaLengkap;
  List<String> listJenisKelamin = <String>[
    'Jenis Kelamin',
    'Laki - Laki',
    'Perempuan'
  ];
  String jenisKelamin = globals.jenisKelamin;
  String pesanUpdateFotoBiografi = "";

  AutoCompleteTextField agamaTextField;
  GlobalKey<AutoCompleteTextFieldState<Agama>> keyAgama = new GlobalKey();

  static List<Agama> daftarAgama = [];
  bool loadingDaftarAgama = true;
  String agama = globals.agama;

  String tanggalLahir;
  dynamic currentTanggalLahir = DateTime.parse(globals.tahunLahir + "-" + globals.bulanLahir + "-" + globals.tanggalLahir + " 00:00");
  String telpon;
  String ponsel;
  String alamat;
  String kodePos;

  AutoCompleteTextField provinsiTextField;
  GlobalKey<AutoCompleteTextFieldState<Provinsi>> keyProvinsi = new GlobalKey();

  static List<Provinsi> daftarProvinsi = [];
  bool loadingDaftarProvinsi = true;
  String provinsi = globals.provinsi;
  String idProvinsi = globals.idProvinsi;
  String logoProvinsi = globals.logoProvinsi;
  String idAgama = globals.idAgama;

  AutoCompleteTextField kabupatenTextField;
  GlobalKey<AutoCompleteTextFieldState<Kabupaten>> keyKabupaten = new GlobalKey();

  static List<Kabupaten> daftarKabupaten = [];
  bool loadingDaftarKabupaten = true;
  bool dataDaftarKabupaten = false;

  String kabupaten = globals.kabupaten;
  String idKabupaten = globals.idKabupaten;
  String logoKabupaten = globals.logoKabupaten;
  String namaKabupaten = "";

  String fotoProfil;
  String idProvinsi1;

  @override
  void initState() {
    _ambilDaftarAgama();
    _ambilDaftarProvinsi();
    _ambilDaftarKabupaten();
    _ambilDaftarKabupatenPerProvinsi();
    animationcontroller = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    imagePicker = new ImagePickerHandler(this, animationcontroller);
    imagePicker.init();

    super.initState();
  }

  @override
  void dispose() {
    animationcontroller.dispose();
    super.dispose();
  }

  void showInSnackBar(String value) {
    ScaffoldMessenger(
        key: biografiScaffoldKey,
        child: Scaffold(
          backgroundColor: Colors.blue,
          body: SafeArea(
              child: new Text(value)
          ),
        )
    );
  }

  void _ambilDaftarAgama() async {
    print("_ambilDaftarAgama");
    print(globals.idAgama);
    await ambilDaftarAgama();
  }

  Future ambilDaftarAgama() async {
    print("ambilDaftarAgama");
    var result =
        await apibiografi.BiografiUtility.apiAmbilDaftarAgama(globals.userid);
    try {
      daftarAgama = [];
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

  void _ambilDaftarProvinsi() async {
    print("_ambilDaftarProvinsi");
    await ambilDaftarProvinsi();
  }

  Future ambilDaftarProvinsi() async {
    print("ambilDaftarProvinsi");
    var result = await apibiografi.BiografiUtility.apiAmbilDaftarProvinsi(globals.userid);
    try {
      daftarProvinsi = [];
      Map mapJSON = json.decode(result);
      var hasilJSON = mapJSON['Provinsi'] as List;
      print("Daftar Provinsi");
      print(hasilJSON);

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

  void _ambilDaftarKabupaten() async {
    await ambilDaftarKabupatenPerProvinsi();
  }

  Future ambilDaftarKabupaten() async {
    var result = await apibiografi.BiografiUtility.apiAmbilDaftarKabupaten( globals.userid, globals.idProvinsi);
    try {
      daftarKabupaten = [];
      Map mapJSON = json.decode(result);
      var hasilJSON = mapJSON['Kabupaten'] as List;

      print("Daftar Kabupaten");
      print(hasilJSON);

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

  void _ambilDaftarKabupatenPerProvinsi() async {
    await ambilDaftarKabupatenPerProvinsi();
  }

  Future ambilDaftarKabupatenPerProvinsi() async {
    var result = await apibiografi.BiografiUtility.apiAmbilDaftarKabupaten(globals.userid, idProvinsi);
    try {
      daftarKabupaten = [];
      Map mapJSON = json.decode(result);
      if ('${mapJSON['pesan_api']}' == "Sukses") {
        dataDaftarKabupaten = true;
      } else {
        dataDaftarKabupaten = false;
      }

      if (dataDaftarKabupaten == true) {
        var hasilJSON = mapJSON['Kabupaten'] as List;
        print("Daftar Kabupaten per Provinsi");
        print(hasilJSON);

        for (int i = 0; i < hasilJSON.length; i++) {
          daftarKabupaten.add(new Kabupaten.fromJson(hasilJSON[i]));
        }
      } else {
        print("Data Tidak Ada");
      }

      print(daftarKabupaten.length);

      setState(() {
        loadingDaftarKabupaten = false;
      });
    } catch (e) {
      print(e);
    }
  }

  Future updateFotoBiografi() async {
    var hasil = await apibiografi.BiografiUtility.apiFotoBiografi(
        userID, globals.fotoUpload);
    if (hasil == "Berhasil") {
      pesanUpdateFotoBiografi = "Biografi anda sudah diubah";
    } else if (hasil == "Gagal") {
      pesanUpdateFotoBiografi =
          "Biografi anda gagal diubah, terjadi kesalahan system";
    }
    var ambilDataTerbaru =
        await globals.Utility.ambilDataPenggunaTerbaru(userID);

    try {
      Map<String, dynamic> hasilJSON = json.decode(ambilDataTerbaru);
      globals.fotoProfil = '${hasilJSON['Pengguna']['fotoProfil']}';
    } catch (exception) {
      throw ("Error");
    }

    return new Biografi();
  }


  kirimImageKamera() async {
    String hasil = "";
    hasil = await apibiografi.BiografiUtility.apiFotoBiografi(globals.userid, imagePicker.image);
    print("hasil Kirim Image");
    print(hasil);
    try {
      Map<String, dynamic> hasilJson = json.decode(hasil);
      print("hasilJson");
      print(hasilJson);
      if ('${hasilJson['pesan_api']}' == 'Profil sudah diupdate') {
        globals.fotoProfil = '${hasilJson['Pengguna']['fotoProfil']}';
        showInSnackBar('Biografi anda sudah diubah');
      } else {
        String pesanUpdateBiografi = '${hasilJson['pesan_api']}';
        print(pesanUpdateBiografi);
      }
    } catch (e) {
      throw (e);
    }
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

      if (jenisKelamin == 'Jenis Kelamin') {
        showInSnackBar("Harap Pilih Jenis Kelamin Anda");
        print("Harap Pilih Jenis Kelamin Anda");
      } else if(idAgama == 'idAgama'){
        showInSnackBar("Harap Pilih Agama Anda");
        print("Harap Pilih Agama Anda");
      } else {
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
    await updateBiografi(namaLengkap, jenisKelamin, idAgama, telpon, ponsel, alamat, kodePos, idProvinsi, idKabupaten);
    if(imagePicker.image != null){
      await kirimImageKamera();
    }
    Navigator.push(
      context,
      new MaterialPageRoute(
          builder: (context) =>
          new Menu()), //When Authorized Navigate to the next screen
    );
  }

  updateBiografi(String namaLengkap, String jenisKelamin, String idAgama, String telpon, String ponsel, String alamat, String kodePos, String idProvinsi, String idKabupaten) async {
    String hasil = "";
    hasil = await apibiografi.BiografiUtility.apiUpdateBiografi(namaLengkap, jenisKelamin, idAgama, telpon, ponsel, alamat, kodePos, idProvinsi, idKabupaten, tanggalLahir);
    try {
      Map<String, dynamic> hasilJson = json.decode(hasil);
      print("hasilJson");
      print(hasilJson);
      print('${hasilJson['Pengguna']['hasil']}');
      if ('${hasilJson['Pengguna']['hasil']}' == 'Data Sudah Diubah') {
        globals.username = '${hasilJson['Pengguna']['namaLengkap']}';
        globals.jenisKelamin = '${hasilJson['Pengguna']['jenisKelamin']}';
        globals.idAgama = '${hasilJson['Pengguna']['idAgama']}';
        globals.agama = '${hasilJson['Pengguna']['agama']}';
        globals.telpon = '${hasilJson['Pengguna']['telpon']}';
        globals.ponsel = '${hasilJson['Pengguna']['ponsel']}';
        globals.alamat = '${hasilJson['Pengguna']['alamat']}';
        globals.kodePos = '${hasilJson['Pengguna']['kodePos']}';

        globals.idProvinsi = '${hasilJson['Pengguna']['idProvinsi']}';
        globals.provinsi = '${hasilJson['Pengguna']['provinsi']}';
        globals.logoProvinsi = '${hasilJson['Pengguna']['logoProvinsi']}';
        provinsi = globals.provinsi;
        logoProvinsi = globals.logoProvinsi;

        globals.idKabupaten = '${hasilJson['Pengguna']['idKabupaten']}';
        globals.kabupaten = '${hasilJson['Pengguna']['kabupaten']}';
        globals.logoKabupaten = '${hasilJson['Pengguna']['logoKabupaten']}';
        kabupaten = globals.kabupaten;
        logoKabupaten = globals.logoKabupaten;
        showInSnackBar('Biografi anda sudah diubah');
      } else {
        String pesanUpdateBiografi = '${hasilJson['Pengguna']['hasil']}';
        print(pesanUpdateBiografi);
      }
    } catch (e) {
      throw (e);
    }
  }

  Future uploadFotoGalleryStatus() async {
    var fotoBiografi = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      fotoBiografi = fotoBiografi;
    });
    print("Uploaded Image: $fotoBiografi");
    UploadFotoUtility.uploadFotoCameraStatus(fotoBiografi)
        .then((val) => setState(() {
              print("API result: $val");
            }));
  }

  Future pasangTanggalLahir({DateTime ttl}) async {
    String formatSqlTanggalLahir = dateSqlFormat.format(ttl);
    print(formatSqlTanggalLahir);
    apibiografi.BiografiUtility.apiUpdateTanggalLahirBiografi(formatSqlTanggalLahir);
    var splitTTL = formatSqlTanggalLahir.split('-');

    globals.tahunLahir = splitTTL[0];
    globals.bulanLahir = splitTTL[1];
    globals.tanggalLahir = splitTTL[2];
  }

  @override
  Widget build(BuildContext context) => new TampilanBiografi(this);

  @override
  userImage(fotoBiografi) {
    setState(() {
      // this.fotoBiografi = fotoBiografi;
    });
  }
}
