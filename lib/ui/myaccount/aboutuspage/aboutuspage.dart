
import 'dart:convert';
import 'dart:io';

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:flutter/services.dart';
import 'package:CultreApp/colors/colors.dart';
import 'package:CultreApp/modal/getuserleagueresponse/GetUserLeagueResponse.dart';

import 'package:CultreApp/ui/feed/feed.dart';
import 'package:CultreApp/ui/myaccount/myaccount_page.dart';
import 'package:CultreApp/ui/quiz/let_quiz.dart';
import 'package:CultreApp/ui/rightdrawer/right_drawer.dart';
import 'package:CultreApp/ui/shopproduct/shopproducts_page.dart';
import 'package:CultreApp/utils/SharedObjects.dart';
import 'package:CultreApp/utils/apppreference.dart';
import 'package:getwidget/components/progress_bar/gf_progress_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:webview_flutter/webview_flutter.dart';

class AboutUsPage extends StatefulWidget{
String title;
String url;
   AboutUsPage({Key? key,required this.title,required this.url}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<AboutUsPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();


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
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/debackground.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomInset: false,
        endDrawerEnableOpenDragGesture: true,
        endDrawer: MySideMenuDrawer(),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,

          leading:Platform.isIOS? GestureDetector(onTap: (){
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) =>MyAccountPage()));
          },
              child: Container(child:Center(child: Image.asset("assets/images/leftarrow.png",height: 22,width: 22,)))):Container()
        ,
          title: Text(widget.title,style: TextStyle(color: Colors.black,fontSize: 22),),
        ),
        body:  Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/debackground.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(


            margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
                      child: Center(
                        child: WebView(
                          zoomEnabled: true,
                          javascriptMode: JavascriptMode.unrestricted,
                          initialUrl: widget.url,
                        ),
                      ),
                    ),
        )

      ),
    );
  }



}
