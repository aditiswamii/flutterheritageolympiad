
import 'dart:convert';

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:flutter/services.dart';
import 'package:flutterheritageolympiad/colors/colors.dart';
import 'package:flutterheritageolympiad/modal/getuserleagueresponse/GetUserLeagueResponse.dart';
import 'package:flutterheritageolympiad/ui/classicquiz/questionpageview/mcq.dart';
import 'package:flutterheritageolympiad/ui/feed/feed.dart';
import 'package:flutterheritageolympiad/ui/myaccount/myaccount_page.dart';
import 'package:flutterheritageolympiad/ui/quiz/let_quiz.dart';
import 'package:flutterheritageolympiad/ui/rightdrawer/right_drawer.dart';
import 'package:flutterheritageolympiad/ui/shopproduct/shopproducts_page.dart';
import 'package:flutterheritageolympiad/utils/SharedObjects.dart';
import 'package:flutterheritageolympiad/utils/apppreference.dart';
import 'package:getwidget/components/progress_bar/gf_progress_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:webview_flutter/webview_flutter.dart';

class AboutUsPage extends StatefulWidget{

  const AboutUsPage({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<AboutUsPage> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();


  @override
  void initState() {
    super.initState();
    BackButtonInterceptor.add(myInterceptor);
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }
  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) =>MyAccountPage()));
    // Do some stuff.
    return true;
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);
    return Container(

      child: Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomInset: false,
        endDrawerEnableOpenDragGesture: true,
        endDrawer: MySideMenuDrawer(),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text("ABOUT US",style: TextStyle(color: Colors.black),),
        ),
        body:  Container(
          margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
                    child: Center(
                      child: WebView(
                        javascriptMode: JavascriptMode.unrestricted,
                        initialUrl: 'https://www.cultre.in/our-team',
                      ),
                    ),
                  )

      ),
    );
  }



}
