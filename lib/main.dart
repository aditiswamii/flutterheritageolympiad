import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterheritageolympiad/ui/login/login_page.dart';
import 'package:flutterheritageolympiad/ui/welcomeback/welcomeback_page.dart';


import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';


void main() {
  runApp( MaterialApp(
    theme: ThemeData(fontFamily: "Nunito"),
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<MyApp> {
  bool isLoggedIn = false;
  String name = '';

  @override
  void initState() {
    super.initState();
    autoLogIn();
    !isLoggedIn ? Timer(
    const Duration(seconds: 3),
        () => Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) =>const LoginPage()))):
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) =>const WelcomePage()));
  }
  void autoLogIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userId = prefs.getString('email');
    print(userId);
    if (userId != null) {
      setState(() {
        isLoggedIn = true;
        name = userId;
      });
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) =>const WelcomePage()));
      return;
    }
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/splash_heritage.jpg"),
            fit: BoxFit.cover,
          ),
        ),

      ),
    );
  }
}
