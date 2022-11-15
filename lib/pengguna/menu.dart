import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:io';

import 'package:blubuk/globals.dart' as globals;

import 'package:blubuk/pengguna/uploadFile/imagePickerHandler.dart';
import 'package:blubuk/pengguna/beranda/controller/beranda.dart';
import 'package:blubuk/pengguna/chat/controller/chat.dart';
import 'package:blubuk/pengguna/biografi/controller/biografi.dart';
import 'package:blubuk/pengguna/forum/controller/forum.dart';
import 'package:blubuk/pengguna/teman/controller/teman.dart';
import 'package:blubuk/pengguna/grup/controller/grup.dart';

class DrawerItem {
  String title;
  IconData icon;
  DrawerItem(this.title, this.icon);
}

class Menu extends StatefulWidget {
  final drawerItems = [
    new DrawerItem("Beranda", Icons.home),
    new DrawerItem("Teman", Icons.people),
    new DrawerItem("Pesan", Icons.email),
    new DrawerItem("Forum", Icons.forum),
    new DrawerItem("Group", Icons.group),
    new DrawerItem("Biografi", Icons.person_outline),
    new DrawerItem("Logout", Icons.compare),
    // new DrawerItem("Check Session", Icons.people),
    // new DrawerItem("Simple Auto Complete", Icons.event)
  ];

  @override
  State<StatefulWidget> createState() {
    return new MenuState();
  }
}

class MenuState extends State<Menu>  {
  int _selectedDrawerIndex = 0;
  ImagePickerHandler imagePicker;

  menuUtama(int pos) {
    if(imagePicker != null){
      setState(() {
        imagePicker.image = null;
        imagePicker.imageFileList = null;
      });
    }
    if (pos == 0) {
      globals.menu = "Beranda";
      return new Beranda();
    }else if (pos == 1) {
      globals.menu = "Teman";
      return new Teman();
    }else if (pos == 2) {
      globals.menu = "Pesan";
      return new Chat();
    }else if (pos == 3) {
      globals.menu = "Forum";
      return new Forum();
    }else if (pos == 4) {
      globals.menu = "Group";
      return new Grup();
    }else if (pos == 5) {
      globals.menu = "Biografi";
      return new Biografi();
    }else if (pos == 98) {
      return logout();
    }else if (pos == 99) {
      checkSession();
      checkGlobalParameter();
    }else {
      return new Text("Error");
    }
  }

  checkSession() async {
    try {
      SharedPreferences session = await SharedPreferences.getInstance();
      print("Ini Session Is Logged In = " + session.getString('isLoggedIn'));
      print("Ini Session FB Logged In = " + session.getString('fbLoggedIn'));
      print("Ini Session Oauth ID = " + session.getString('oauth_uid'));
      print("Ini Session Oauth Provider = " + session.getString('oauth_provider'));
      print("Ini Session Hasil = " + session.getString('hasil'));
      print("Ini Session User ID = " + session.getString('userid'));
      print("Ini Session Email = " + session.getString('email'));
      print("Ini Session Username = " + session.getString('username'));
      print("Ini Session Status = " + session.getString('status'));
      print("Ini Session ID Role = " + session.getString('idRole'));
      print("Ini Session Foto Profil = " + session.getString('fotoProfil'));
      print("Ini Session Token = " + session.getString('token'));
      print("Ini Session Jenis Kelamin = " + session.getString('jenisKelamin'));
      print("Ini Session Tanggal Lahir = " + session.getString('tanggalLahir'));
      print("Ini Session Bulan Lahir = " + session.getString('bulanLahir'));
      print("Ini Session Tahun Lahir = " + session.getString('tahunLahir'));
      print("Ini Session Telp = " + session.getString('telpon'));
      print("Ini Session Ponsel = " + session.getString('Ponsel'));
      print("Ini Session emote = ");
      session.getStringList('emote');
    } catch (exception) {
      print("Tidak Ada Session");
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
      print("Ini Globals Tanggal Lahir = " + globals.tanggalLahir);
      print("Ini Globals Bulan Lahir = " + globals.bulanLahir);
      print("Ini Globals Tahun Lahir = " + globals.tahunLahir);
      print("Ini Globals Telpon = " + globals.telpon);
      print("Ini Globals Ponsel = " + globals.ponsel);
      print("Ini Globals Agama = " + globals.agama);
      print("Ini Globals Provinsi = " + globals.provinsi);
      print("Ini Globals Kabupaten = " + globals.kabupaten);
      print("Ini Globals FB Logged In = " + globals.fbLoggedIn.toString());
      print("Ini Globals emote");
      print(globals.listSemuaEmote);
    } catch (exception) {
      print('Tidak Ada Nilai');
    }
  }

  logout(){
    hapusSession();
    hapusGlobal();

    Navigator.of(context).pop("/main");
    // exit(0);
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
      session.remove('token');
      session.remove('menu');
      session.remove('jenisKelamin');
      session.remove('tanggalLahir');
      session.remove('bulanLahir');
      session.remove('tahunLahir');
      session.remove('telpon');
      session.remove('ponsel');
    } catch (exception) {
      return false;
    }
    return true;
  }

  hapusGlobal(){
    globals.isLoggedIn = false;
    globals.fbLoggedIn = false;
    globals.termsChecked = false;

    globals.error = "";
    globals.hasil = "";
    globals.token = "";
    globals.domain = "";
    globals.userid = "0";
    globals.email = "Email Pengguna";
    globals.username = "Username Pengguna";
    globals.fotoProfil = "no_profil.jpg";
    globals.idRole = "ID Role Pengguna";
    globals.status = "Status Pengguna";
    globals.oauthUid = "0";
    globals.oauthProvider = "";
    globals.menu = "";
    globals.jenisKelamin = 'Jenis Kelamin';
    globals.tanggalLahir = '';
    globals.bulanLahir = '';
    globals.tahunLahir = '';
    globals.telpon = 'xxx xxxxxxx';
    globals.ponsel = 'xxxx xxxxxxx';

  }

  _onSelectItem(int index) {
    setState(() => _selectedDrawerIndex = index);
    Navigator.of(context).pop(); // close the drawer
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> drawerOptions = [];
    for (var i = 0; i < widget.drawerItems.length; i++) {
      var d = widget.drawerItems[i];
      drawerOptions.add(
          new ListTile(
            leading: new Icon(d.icon),
            title: new Text(d.title),
            selected: i == _selectedDrawerIndex,
            onTap: () => _onSelectItem(i),
          )
      );
    }

    return new Scaffold(
      appBar: new AppBar(
        // here we display the title corresponding to the fragment
        // you can instead choose to have a static title
        title: new Text(widget.drawerItems[_selectedDrawerIndex].title),
      ),
      drawer: new Drawer(
        child: new ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            new DrawerHeader(
              child: new ListView(
                children: <Widget>[
                  new Container(
                      width: 130.0,
                      height: 130.0,
                      // child: CircleAvatar(
                      //   child: Image.network(globals.fotoProfil),
                      // ),
                      decoration: new BoxDecoration(
                          shape: BoxShape.circle,
                          image: new DecorationImage(
                              fit: BoxFit.fill,
                              image: new NetworkImage(globals.fotoProfil)
                              // image: new NetworkImage("https://graph.facebook.com/2028029970626254/picture?type=large")
                          )
                      )
                ),
                ],
              ),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            new Column(children: drawerOptions)
          ],
        ),
      ),

      body: menuUtama(_selectedDrawerIndex),
    );


    
  }
}
