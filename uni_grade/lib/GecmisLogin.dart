import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'LoginScreen.dart';

class GecmisLogin extends StatefulWidget {

  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _GecmisLogin();
  }
}

class _GecmisLogin extends State<GecmisLogin> {
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Gecmis Login')),
        body: Center(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 5, top: 120),
                alignment: Alignment.centerLeft,
                child: SizedBox(
                  width: 300,
                  child: TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'İsim - Soyisim'),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 5, top: 10),
                alignment: Alignment.centerLeft,
                child: SizedBox(
                  width: 300,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Sınıfınız'),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 5, top: 10),
                alignment: Alignment.centerLeft,
                child: SizedBox(
                  width: 300,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Hesaplamak İstediğiniz Dönem Sayısı'),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
