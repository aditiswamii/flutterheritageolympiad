
import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'dart:math';
import 'dart:ui';

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:flutterheritageolympiad/colors/colors.dart';
import 'package:flutterheritageolympiad/ui/classicquiz/result/result.dart';
import 'package:flutterheritageolympiad/ui/quiz/let_quiz.dart';
import 'package:flutterheritageolympiad/ui/rightdrawer/right_drawer.dart';
import 'package:flutterheritageolympiad/utils/stringconstants.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../modal/classicquestion/ClassicQuestion.dart';
import '../../../modal/classicquestion/getQuestionResponse.dart';
import 'dart:convert' as convert;

import '../../../utils/countdowntimer.dart';

import '../../homepage/welcomeback_page.dart';


class Waitroom extends StatefulWidget{

  Waitroom({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}


class _State extends State<Waitroom> {

  @override
  void initState() {
    super.initState();
    BackButtonInterceptor.add(myInterceptor);
  }

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(
              margin: EdgeInsets.only(left: 7), child: Text("Loading...")),
        ],),
    );
    showDialog(barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);

    super.dispose();

  }

  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) => WelcomePage()));
    return true;
  }


  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      resizeToAvoidBottomInset: false,
      endDrawerEnableOpenDragGesture: true,
      endDrawer: MySideMenuDrawer(),
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: ColorConstants.blue200,
        elevation: 0.0,
        actions: [
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(right: 5.0),
            child: GestureDetector(
              onTap: () {
                // Scaffold.of(context).openEndDrawer();
              },
              child:  Image.asset("assets/images/mcq_pattern_3.png",height: 40,width: 40),
            ),
          ),
        ],
      ),


    );
  }
}