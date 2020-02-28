import 'package:flutter/material.dart';
import 'package:uni_grade/welcome.dart';
import 'LoginScreen.dart';
import 'Gecmis.dart';
import 'GecmisLogin.dart';

void main() {
  runApp(MaterialApp(
    title: 'Uni-Grade',
    theme: ThemeData(
      primarySwatch: MaterialColor(Colors.grey.shade200.value, {
        50: Colors.grey.shade50,
        100: Colors.grey.shade100,
        200: Colors.grey.shade200,
        300: Colors.grey.shade300,
        400: Colors.grey.shade400,
        500: Colors.grey.shade500,
        600: Colors.grey.shade600,
        700: Colors.grey.shade700,
        800: Colors.grey.shade800,
        900: Colors.grey.shade900
      }),
    ),
    darkTheme: ThemeData.dark(),
    initialRoute: "/",
    routes: {
      "/": (context) => LoginScreenPage(),
      "/GecmisLogin": (context) => GecmisLogin(),
      "/Gecmis": (context) => GecmisDersler(),
      "/Welcome": (context) => welcome(),
    },
  ));
}

class Initialize extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Uni-Grade',
      theme: ThemeData(
        primarySwatch: MaterialColor(Colors.grey.shade200.value, {
          50: Colors.grey.shade50,
          100: Colors.grey.shade100,
          200: Colors.grey.shade200,
          300: Colors.grey.shade300,
          400: Colors.grey.shade400,
          500: Colors.grey.shade500,
          600: Colors.grey.shade600,
          700: Colors.grey.shade700,
          800: Colors.grey.shade800,
          900: Colors.grey.shade900
        }),
      ),
      home: LoginScreenPage(),
      //TODO Change this widget for change main screen
    );
  }
}
