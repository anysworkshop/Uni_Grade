import 'package:flutter/material.dart';
import 'main.dart';
import 'LoginScreen.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class welcome extends StatelessWidget {
  final UserDetails detailsUser;
  GoogleSignInAccount googleUser;
  final GoogleSignIn _googlSignIn = new GoogleSignIn();

  welcome({Key key, @required this.detailsUser, @required this.googleUser})
      : super(key: key);

  Widget build(BuildContext context) {
    final GoogleSignIn _gSignIn = GoogleSignIn();
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text(detailsUser.userName),
          automaticallyImplyLeading: false,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                FontAwesomeIcons.signOutAlt,
                size: 20.0,
                color: Colors.white,
              ),
              onPressed: () {
                _gSignIn.signOut();
                print('Signed out');
                Navigator.pop(context);
              },
            ),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                backgroundImage: NetworkImage(detailsUser.photoUrl),
                radius: 50.0,
              ),
              SizedBox(height: 10.0),
              Text(
                "Name : " + detailsUser.userName,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 20.0),
              ),
              SizedBox(height: 10.0),
              Text(
                "Email : " + detailsUser.userEmail,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 20.0),
              ),
              SizedBox(height: 10.0),
              Text(
                "Provider : " + detailsUser.providerDetails,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 20.0),
              ),
            ],
          ),
        ));
  }
}
