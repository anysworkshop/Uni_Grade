import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'LoginScreen.dart';

class GecmisLogin extends StatefulWidget {
  final UserDetails detailsUser;
  GoogleSignInAccount googleUser;
  GoogleSignIn gSignIn;

  GecmisLogin({Key key, @required this.detailsUser, @required this.gSignIn})
      : super(key: key);

  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _GecmisLogin();
  }
}

class _GecmisLogin extends State<GecmisLogin> {
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Gecmis Login')),
        drawer: new Drawer(
          child: new ListView(
            children: <Widget>[
              new UserAccountsDrawerHeader(
                accountName: new Text(widget.detailsUser.userName),
                accountEmail: new Text(widget.detailsUser.userEmail),
                currentAccountPicture: new CircleAvatar(
                  backgroundImage: NetworkImage(widget.detailsUser.photoUrl),
                ),
              ),
              new ListTile(
                title: new Text("Hesap"),
                trailing: new Icon(Icons.account_circle),
              ),
              new ListTile(
                title: new Text("Çıkış Yap"),
                trailing: new Icon(Icons.exit_to_app),
                onTap: () {
                  widget.gSignIn.signOut();
                  print('Signed out');
                  Navigator.pushReplacement(
                    context,
                    new MaterialPageRoute(
                      builder: (context) => new LoginScreenPage(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
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
