import 'package:flutter/material.dart';


class Profil extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Profil();
  }

}

class _Profil extends State<Profil>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
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
      ),
    );
  }

}