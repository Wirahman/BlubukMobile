import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';

import 'package:Blubuk/globals.dart' as globals;
import 'package:Blubuk/pengguna/biografi/controller/biografi.dart';
import 'package:Blubuk/pengguna/biografi/model/agama.dart';
import 'package:Blubuk/pengguna/biografi/model/provinsi.dart';
import 'package:Blubuk/pengguna/biografi/model/kabupaten.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';

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
            child: DateTimePickerFormField(
              dateOnly: true,
              format: biografiState.dateFormat,
              validator: (val) {
                if (val != null) {
                  return null;
                } else {
                  return 'Tanggal Lahir tidak boleh kosong';
                }
              },
              decoration: InputDecoration(labelText: 'Tanggal Lahir'),
              initialValue: new DateTime(int.parse(globals.tahunLahir), int.parse(globals.bulanLahir), int.parse(globals.tanggalLahir)),
              
              // onSaved: (value) {
              //   debugPrint(value.toString());
              // },
              
              onChanged: (value) => biografiState.pasangTanggalLahir(ttl: value),
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
                        biografiState.setState(() => biografiState.agamaTextField.textField.controller.text = item.namaAgama);
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
                        biografiState.setState(() {
                          biografiState.provinsiTextField.textField.controller.text = item.namaProvinsi;
                          biografiState.idProvinsi = item.id;
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
                      hintText: globals.kabupaten,
                      hintStyle: TextStyle(color: Colors.black)), 
                      clearOnSubmit: false,
                      
                      key: biografiState.keyKabupaten,
                      suggestions: BiografiState.daftarKabupaten,

                      itemBuilder: (context, item) {
                        return Container(
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

