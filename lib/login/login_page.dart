import 'dart:math';

import 'package:flutter/material.dart';


void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: LoginPage(),
  ));
}
class LoginPage extends StatefulWidget{
  const LoginPage({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}


class _State extends State<LoginPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(

    );
  }
}