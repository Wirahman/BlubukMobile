import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';

import 'package:blubuk/pengguna/uploadFile/imagePickerHandler.dart';
import 'package:blubuk/pengguna/biografi/tampilan/tampilanBiografiTeman.dart';
import 'package:blubuk/api/biografi/apiBiografi.dart' as apibiografi;

class BiografiTeman extends StatefulWidget {
  BiografiTeman({Key key, this.title}) : super(key: key);
  final String title;
  @override
  BiografiTemanState createState() => new BiografiTemanState();
}

class BiografiTemanState extends State<BiografiTeman> with TickerProviderStateMixin, ImagePickerListener {
  AnimationController animationcontroller;
  ImagePickerHandler imagePicker;

  File fotoBiografi;
  static String userID;
  String email;
  String namaLengkap;
  String teman;
  String jenisKelamin;
  String agama;
  String tanggalLahir;
  String telpon;
  String ponsel;
  String alamat;
  String kodePos;
  String provinsi;
  String idProvinsi;
  String logoProvinsi;
  String kabupaten;
  String idKabupaten;
  String logoKabupaten;
  String fotoProfil;

  @override
  void initState() {
    _ambilBiografiTeman();
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

  void _ambilBiografiTeman() async {
    await ambilBiografiTeman();
  }

  Future ambilBiografiTeman() async {
    print("Function ambilBiografiTeman");
    var result = await apibiografi.BiografiUtility.apiAmbilBiografiTeman(userID);
    print("User ID = " + userID.toString());
    try{
      Map<String, dynamic> hasilJSON = json.decode(result);
      print(hasilJSON);
      setState(() {
        this.email = '${hasilJSON['Teman'][0]['email']}';
        this.namaLengkap = '${hasilJSON['Teman'][0]['namaLengkap']}';
        this.jenisKelamin = '${hasilJSON['Teman'][0]['jenisKelamin']}';
        this.fotoProfil = '${hasilJSON['Teman'][0]['fotoProfil']}';
        this.agama = '${hasilJSON['Teman'][0]['agama']}';
        this.tanggalLahir = '${hasilJSON['Teman'][0]['tanggal_lahir']}';
        this.telpon = '${hasilJSON['Teman'][0]['telpon']}';
        this.ponsel = '${hasilJSON['Teman'][0]['ponsel']}';
        this.alamat = '${hasilJSON['Teman'][0]['alamat']}';
        this.kodePos = '${hasilJSON['Teman'][0]['kodePos']}';
        this.idProvinsi = '${hasilJSON['Teman'][0]['idProvinsi']}';
        this.provinsi = '${hasilJSON['Teman'][0]['provinsi']}';
        this.logoProvinsi = '${hasilJSON['Teman'][0]['logoProvinsi']}';
        this.idKabupaten = '${hasilJSON['Teman'][0]['idKabupaten']}';
        this.kabupaten = '${hasilJSON['Teman'][0]['kabupaten']}';
        this.logoKabupaten = '${hasilJSON['Teman'][0]['logoKabupaten']}';
      });

    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) => new TampilanBiografiTeman(this);

  @override
  userImage(fotoBiografi) {
    setState(() {
      // this.fotoBiografi = fotoBiografi;
    });
  }
}
