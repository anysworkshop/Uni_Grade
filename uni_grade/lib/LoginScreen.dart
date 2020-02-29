import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:uni_grade/Gecmis.dart';
import 'package:uni_grade/GecmisLogin.dart';

class LoginScreenPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginScreenPage();
}

class _LoginScreenPage extends State<LoginScreenPage>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _backgroundAnimation;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googlSignIn = new GoogleSignIn();

  Future<FirebaseUser> _signIn(BuildContext context) async {
    GoogleSignInAccount googleUser =
        await _googlSignIn.signIn().catchError((onError) {
      print("Error $onError");
    });

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    AuthResult result = await _firebaseAuth.signInWithCredential(credential);
    FirebaseUser userDetails = result.user;
    ProviderDetails providerInfo = new ProviderDetails(userDetails.providerId);

    List<ProviderDetails> providerData = new List<ProviderDetails>();
    providerData.add(providerInfo);

    UserDetails details = new UserDetails(
      userDetails.providerId,
      userDetails.displayName,
      userDetails.photoUrl,
      userDetails.email,
      providerData,
    );
    setState(() {
      Navigator.pushReplacement(
        context,
        new MaterialPageRoute(
          builder: (context) => new GecmisDersler(
            detailsUser: details,
            gSignIn: _googlSignIn,
          ),
        ),
      );
    });

    return userDetails;
  }

  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 20));

    _backgroundAnimation =
        CurvedAnimation(parent: _animationController, curve: Curves.linear)
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener((animationStatus) {
            if (animationStatus == AnimationStatus.completed) {
              _animationController.reset();
              _animationController.forward();
            }
          });

    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        Image.asset(
          'lib/resources/images/background.jpg',
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
          alignment: FractionalOffset(_backgroundAnimation.value, 0),
        ),
        Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //GoogleButton
            Container(
              margin: EdgeInsets.all(5),
              width: 250,
              height: 50,
              child: FloatingActionButton(
                heroTag: 'btn1',
                onPressed: () {
                  setState(() {
                    Navigator.pushNamed(context, "/DRP");
                  });
                },
                child: Row(
                  children: <Widget>[
                    SizedBox(width: 10),
                    Icon(FontAwesomeIcons.google, color: Colors.red),
                    SizedBox(
                      width: 15,
                    ),
                    Text('Google ile giriş yapın',
                        style: TextStyle(fontSize: 15))
                  ],
                ),
                tooltip: 'Google Girişi',
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16.0))),
              ),
            ),

            //FacebookButton
            Container(
              margin: EdgeInsets.all(5),
              width: 250,
              height: 50,
              child: FloatingActionButton(
                heroTag: 'btn2',
                onPressed: () {
                  _signIn(context)
                      .then((FirebaseUser user) => print(user))
                      .catchError((e) => print(e));
                },
                child: Row(
                  children: <Widget>[
                    SizedBox(width: 10),
                    Icon(FontAwesomeIcons.facebook, color: Colors.white),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      'Facebook ile giriş yapın',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ],
                ),
                tooltip: 'Facebook Girişi',
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16.0))),
              ),
            ),

            //MisafirButton
            new GestureDetector(
              child: Container(
                margin: EdgeInsets.all(5),
                width: 250,
                height: 50,
                child: FloatingActionButton(
                  heroTag: 'btn3',
                  onPressed: () {
                    setState(() {
                      Navigator.pushNamed(context, "/GecmisLogin");
                    });
                  },
                  child: Text(
                    'Misafir Olarak Devam Edin',
                    style: TextStyle(color: Colors.white),
                  ),
                  tooltip: 'Misafir Girişi',
                  backgroundColor: Colors.brown,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16.0))),
                ),
              ),
            )
          ],
        )),
      ],
    ));
  }
}

class UserDetails {
  final String providerDetails;
  final String userName;
  final String photoUrl;
  final String userEmail;
  final List<ProviderDetails> providerData;

  UserDetails(this.providerDetails, this.userName, this.photoUrl,
      this.userEmail, this.providerData);
}

class ProviderDetails {
  ProviderDetails(this.providerDetails);
  final String providerDetails;
}
