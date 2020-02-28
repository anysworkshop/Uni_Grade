import 'package:flutter/material.dart';



  class LoginScreenPage extends StatelessWidget{

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            
            //GoogleButton
            Container(
              margin: EdgeInsets.all(5),
              width:250,
              height:50,
              child: FloatingActionButton(
                heroTag: 'btn1',
                onPressed: () {(Navigator.pushNamed(context, "/DRP"));},
                child: Text('Google ile Devam Edin',style: TextStyle(color:Colors.white ),),
                tooltip: 'Google Girişi',
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16.0))),
              ),
            ),

            //FacebookButton
            Container(
              margin: EdgeInsets.all(5),
              width:250,
              height:50,
              child: FloatingActionButton(
                heroTag: 'btn2',
                onPressed: () {(Navigator.pushNamed(context, "/Gecmis"));},
                child: Text('Facebook ile Devam Edin',style: TextStyle(color:Colors.white ),),
                tooltip: 'Facebook Girişi',
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16.0))),
              ),
            ),

            //MisafirButton
            new GestureDetector(
               child: Container(
              margin: EdgeInsets.all(5),
              width:250,
              height:50,
              child: FloatingActionButton(
                heroTag: 'btn3',
                onPressed: () {(Navigator.pushNamed(context, "/GecmisLogin"));},
                child: Text('Misafir Olarak Devam Edin',style: TextStyle(color:Colors.white ),),
                tooltip: 'Misafir Girişi',
                backgroundColor: Colors.brown,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16.0))),
              ),  
            ), 
            )
            
          ],
        )
      ),
    );
  }

  }