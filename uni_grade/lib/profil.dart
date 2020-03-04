import 'package:flutter/material.dart';
import 'LoginScreen.dart';
import 'Gecmis.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Profil extends StatefulWidget {
  @override
  final UserDetails detailsUser;
  GoogleSignInAccount googleUser;
  GoogleSignIn gSignIn;

  Profil({Key key, @required this.detailsUser, @required this.gSignIn})
      : super(key: key);
  State<StatefulWidget> createState() => _Profil();
}

class _Profil extends State<Profil> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(),
      body: Column(children: <Widget>[
        UserAccountsDrawerHeader(
          accountName: new Text(widget.detailsUser.userName),
          accountEmail: new Text(widget.detailsUser.userEmail),
          currentAccountPicture: new CircleAvatar(
            backgroundImage: NetworkImage(widget.detailsUser.photoUrl),
          ),
          decoration: BoxDecoration(),
        ),
      ]),
    );
  }
}
