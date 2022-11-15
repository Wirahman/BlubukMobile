import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';

import 'package:blubuk/globals.dart' as globals;
import 'package:blubuk/pengguna/biografi/controller/biografi.dart';
import 'package:blubuk/pengguna/biografi/model/agama.dart';
import 'package:blubuk/pengguna/biografi/model/provinsi.dart';
import 'package:blubuk/pengguna/biografi/model/kabupaten.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';

// ignore: must_be_immutable
class TampilanUbahBiografi extends StatelessWidget {
  Biografi biografi;
  BiografiState biografiState;

  TampilanUbahBiografi(this.biografiState);

  @override
  Widget build(BuildContext context) {
    return new Form(
      key: biografiState.formUbahBiografiKey,
      child: new Column(
        children: [
          new TextFormField(
            decoration:
            new InputDecoration(labelText: 'Nama Lengkap'),
            validator: (val) =>
            val.length < 1 ? 'Harap Lengkapi Nama Anda' : null,
            onSaved: (val) => biografiState.namaLengkap = val,
            obscureText: false,
            keyboardType: TextInputType.text,
            autocorrect: false,
            initialValue: globals.username,
          ),
          
          new Container(height: 10.0),
          new DropdownButton<String>(
            value: biografiState.jenisKelamin,
          //  isDense: true,
            onChanged: (String newValue) {
              // ignore: invalid_use_of_protected_member
              biografiState.setState(() {
                biografiState.jenisKelamin = newValue;
              });
            },
            items: biografiState.listJenisKelamin.map((String value) {
              return new DropdownMenuItem<String>(
                value: value,
                child: new Text(value),
              );
            }).toList(),
          ),

          new Container(height: 10.0),
          new Center(
            child:
            DateTimeField(
              format: DateFormat("yyyy-MM-dd  HH:mm"),
              initialValue: biografiState.currentTanggalLahir,
              // initialValue: DateTime.parse(globals.tahunLahir + "-" + globals.bulanLahir + "-" + globals.tanggalLahir + " 00:00"),
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
                  biografiState.currentTanggalLahir = DateTimeField.combine(date, time);
                  return DateTimeField.combine(date, time);
                } else {
                  biografiState.currentTanggalLahir = currentValue;
                  return currentValue;
                }
              },
              // onChanged: (date) => pasangTanggalLahir(date),
              onSaved: (val) => biografiState.tanggalLahir = val.toString(),
            ),
          ),

          
          // Autocomplete Agama
          new Container(height: 10.0),
          new Center(
            child: new Column(
              children: <Widget>[
                new Column(
                  children: <Widget>[
                    biografiState.loadingDaftarAgama ? CircularProgressIndicator() :
                    
                    biografiState.agamaTextField = AutoCompleteTextField<Agama>(
                      style: new TextStyle(color: Colors.black, fontSize: 16.0),
                      decoration: new InputDecoration(
                      suffixIcon: Container(
                        width: 85.0,
                        height: 60.0,
                      ),
                      contentPadding: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 20.0),
                      filled: true,
                      hintText: globals.agama,
                      hintStyle: TextStyle(color: Colors.black)), 
                      clearOnSubmit: false,
                      
                      key: biografiState.keyAgama,
                      suggestions: BiografiState.daftarAgama,

                      itemBuilder: (context, item) {
                        return Container(
                          color: Colors.blueAccent,
                          child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              item.namaAgama,
                              style: TextStyle(
                                fontSize: 16.0
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(15.0),
                            ),
                            Text(
                              item.namaAgama,
                              style: TextStyle(
                                fontWeight: FontWeight.bold
                              ),
                            )
                          ],
                        )
                        );
                      },
                      itemFilter: (suggestions, query) {
                        return suggestions.namaAgama
                            .toLowerCase()
                            .startsWith(query.toLowerCase());
                      },
                      itemSorter: (a, b) {
                        return a.namaAgama.compareTo(b.namaAgama);
                      },
                      itemSubmitted: (item) {
                        // ignore: invalid_use_of_protected_member
                        biografiState.setState(() {
                          biografiState.agamaTextField.textField.controller.text = item.namaAgama;
                          biografiState.idAgama = item.id;
                        });
                      },
                      onFocusChanged: (hasFocus) {}
                    ),
                  ],
                ),
              ],
            ),
          ),

          new Container(height: 10.0),
          new TextFormField(
            decoration:
            new InputDecoration(labelText: 'No. Telp'),
            validator: (val) =>
            val.length < 1 ? 'Harap Lengkapi Nomor Telpon Anda' : null,
            onSaved: (val) => biografiState.telpon = val,
            keyboardType: TextInputType.number,
            obscureText: false,
            autocorrect: false,
            initialValue: globals.telpon,
          ),
          
          new Container(height: 10.0),
          new TextFormField(
            decoration:
            new InputDecoration(labelText: 'Handphone'),
            validator: (val) =>
            val.length < 1 ? 'Harap Lengkapi Nomor Handphone Anda' : null,
            onSaved: (val) => biografiState.ponsel = val,
            obscureText: false,
            keyboardType: TextInputType.number,
            autocorrect: false,
            initialValue: globals.ponsel,
          ),
          
          new Container(height: 10.0),
          new TextFormField(
            decoration:
            new InputDecoration(labelText: 'Alamat'),
            validator: (val) =>
            val.length < 1 ? 'Harap Lengkapi Alamat Anda' : null,
            onSaved: (val) => biografiState.alamat = val,
            keyboardType: TextInputType.text,
            obscureText: false,
            autocorrect: false,
            initialValue: globals.alamat,
          ),
          
          new Container(height: 10.0),
          new TextFormField(
            decoration:
            new InputDecoration(labelText: 'Kode Pos'),
            onSaved: (val) => biografiState.kodePos = val,
            obscureText: false,
            keyboardType: TextInputType.number,
            autocorrect: false,
            initialValue: globals.kodePos,
          ),
                  
          // Autocomplete Provinsi
          new Container(height: 10.0),
          new Center(
            child: new Column(
              children: <Widget>[
                new Column(
                  children: <Widget>[
                    biografiState.loadingDaftarProvinsi ? CircularProgressIndicator() :
                    biografiState.provinsiTextField = AutoCompleteTextField<Provinsi>(
                      style: new TextStyle(color: Colors.black, fontSize: 16.0),
                      decoration: new InputDecoration(
                      suffixIcon: Container(
                        width: 85.0,
                        height: 60.0,
                      ),
                      contentPadding: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 20.0),
                      filled: true,
                      hintText: globals.provinsi,
                      hintStyle: TextStyle(color: Colors.black)), 
                      clearOnSubmit: false,
                      
                      key: biografiState.keyProvinsi,
                      suggestions: BiografiState.daftarProvinsi,

                      itemBuilder: (context, item) {
                        print(item);
                        return Container(
                          color: Colors.blueAccent,
                          child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              item.namaProvinsi,
                              style: TextStyle(
                                fontSize: 16.0
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(15.0),
                            ),
                            Text(
                              item.namaProvinsi,
                              style: TextStyle(
                                fontWeight: FontWeight.bold
                              ),
                            )
                          ],
                        )
                        );
                      },
                      itemFilter: (suggestions, query) {
                        return suggestions.namaProvinsi
                            .toLowerCase()
                            .startsWith(query.toLowerCase());
                      },
                      itemSorter: (a, b) {
                        return a.namaProvinsi.compareTo(b.namaProvinsi);
                      },
                      itemSubmitted: (item) {
                        // ignore: invalid_use_of_protected_member
                        biografiState.setState(() {
                          biografiState.provinsiTextField.textField.controller.text = item.namaProvinsi;
                          biografiState.idProvinsi = item.id;
                          biografiState.loadingDaftarKabupaten = true;
                          BiografiState.daftarKabupaten.clear();
                          biografiState.namaKabupaten = "Silahkan pilih kabupaten / kota";
                        });
                        biografiState.ambilDaftarKabupatenPerProvinsi();
                      },
                      onFocusChanged: (hasFocus) {
                        print("Array Daftar Provinsi");
                        print(BiografiState.daftarProvinsi);
                      }
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Tinggal buat tampilan untuk daftar kabupaten per provinsi

          // Autocomplete Kabupaten per Provinsi
          new Container(height: 10.0),
          new Center(
            child: new Column(
              children: <Widget>[
                new Column(
                  children: <Widget>[
                    biografiState.loadingDaftarKabupaten ? CircularProgressIndicator() :
                    
                    biografiState.kabupatenTextField = AutoCompleteTextField<Kabupaten>(
                      style: new TextStyle(color: Colors.black, fontSize: 16.0),
                      decoration: new InputDecoration(
                      suffixIcon: Container(
                        width: 85.0,
                        height: 60.0,
                      ),
                      contentPadding: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 20.0),
                      filled: true,
                      hintText: biografiState.namaKabupaten == "Silahkan pilih kabupaten / kota" ? "Silahkan pilih kabupaten / kota" : globals.kabupaten,
                      hintStyle: TextStyle(color: Colors.black)), 
                      clearOnSubmit: false,
                      
                      key: biografiState.keyKabupaten,
                      suggestions: BiografiState.daftarKabupaten,

                      itemBuilder: (context, item) {
                        return new Container(
                          color: Colors.blueAccent,
                          child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              item.namaKabupaten,
                              style: TextStyle(
                                fontSize: 16.0
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(15.0),
                            ),
                            Text(
                              item.namaKabupaten,
                              style: TextStyle(
                                fontWeight: FontWeight.bold
                              ),
                            )
                          ],
                        )
                        );
                      },
                      itemFilter: (suggestions, query) {
                        return suggestions.namaKabupaten
                            .toLowerCase()
                            .startsWith(query.toLowerCase());
                      },
                      itemSorter: (a, b) {
                        return a.namaKabupaten.compareTo(b.namaKabupaten);
                      },
                      itemSubmitted: (item) {
                        // ignore: invalid_use_of_protected_member
                        biografiState.setState(() {
                          biografiState.kabupatenTextField.textField.controller.text = item.namaKabupaten;
                          biografiState.idKabupaten = item.id;
                        });
                      },
                      onFocusChanged: (hasFocus) {
                        print("Array Daftar Kabupaten per Provinsi");
                        print(BiografiState.daftarKabupaten);
                      }
                    ),
                  ],
                ),
              ],
            ),
          ),
          
        ],
      ),
    );

  }
  






















}

