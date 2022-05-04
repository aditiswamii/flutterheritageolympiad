import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:flutter/services.dart';
import 'package:flutterheritageolympiad/colors/colors.dart';
import 'package:flutterheritageolympiad/ui/classicquiz/answerkey/answerkey.dart';
import 'package:flutterheritageolympiad/ui/classicquiz/classicquiz_main.dart';
import 'package:flutterheritageolympiad/ui/classicquiz/questionpageview/mcq.dart';
import 'package:flutterheritageolympiad/ui/myaccount/myaccount_page.dart';
import 'package:flutterheritageolympiad/ui/quiz/let_quiz.dart';
import 'package:flutterheritageolympiad/ui/rightdrawer/right_drawer.dart';
import 'package:flutterheritageolympiad/ui/shopproduct/shopproducts_page.dart';
import 'package:flutterheritageolympiad/utils/SharedObjects.dart';
import 'package:flutterheritageolympiad/utils/apppreference.dart';
import 'package:getwidget/components/progress_bar/gf_progress_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../welcomeback/welcomeback_page.dart';

class ResultPage extends StatefulWidget {
  var quizid;
  var savedata;
 ResultPage({Key? key,required this.quizid,required this.savedata}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<ResultPage> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  var username;
  var email;
  var country;
  var profilepic;
  var userid;
var xp;
var percentage;
  userdata() async {

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString("username");
      country = prefs.getString("country");
      userid = prefs.getString("userid");
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      xp=widget.savedata["xp"];
      percentage=widget.savedata["17"];

    });
    print(xp);
    print(percentage);
    userdata();
    BackButtonInterceptor.add(myInterceptor);
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }

  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => WelcomePage()));
    // Do some stuff.
    return true;
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      endDrawerEnableOpenDragGesture: true,
      endDrawer: MySideMenuDrawer(),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/debackground.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          color: Colors.white.withAlpha(100),
          margin: EdgeInsets.fromLTRB(20, 40, 20, 0),
          child: ListView(children: [
            Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.fromLTRB(0, 20, 0, 5),
                child: Text(
                  "YOU\nSCORED...",
                  style: TextStyle(
                      fontSize: 24,
                      color: ColorConstants.txt,
                      fontFamily: "Nunito"),
                  textAlign: TextAlign.center,
                )),
            Container(
                decoration: BoxDecoration(shape: BoxShape.circle),
                margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                alignment: Alignment.topCenter,
                child: SizedBox(
                  height: 150,
                  width: 150,
                  child: Stack(
                    children: <Widget>[
                      SizedBox(
                        child: Center(
                          child: Container(
                            height: 150,
                            width: 150,
                            child: CircularProgressIndicator(
                              value: 0.02,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.orange,
                              ),
                              color: Colors.red,
                              backgroundColor: Colors.red,
                              strokeWidth: 20,
                            ),
                          ),
                        ),
                      ),
                      FlipCard(
                        direction: FlipDirection.HORIZONTAL,

                        front: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(child: Text("${widget.savedata["xp"]} XP")),

                            Center(child: Text("oh boy!")),
                          ],
                        ),
                        back: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(child: Text("${widget.savedata["per"]}")),
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
            Column(
              children: [
                GestureDetector(
                  onTap: (){

                  },
                  child: Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.fromLTRB(0, 20, 0, 5),
                      child: Text(
                        "SHARE PERFORMANCE",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            decoration: TextDecoration.underline),
                        textAlign: TextAlign.center,
                      )),
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AnswerkeyPage(quizid: widget.quizid, saveddata: widget.savedata,)));
                  },
                  child: Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.fromLTRB(0, 20, 0, 5),
                      child: Text(
                        "ANSWER KEY",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            decoration: TextDecoration.underline),
                        textAlign: TextAlign.center,
                      )),
                ),

                Center(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        onPrimary: Colors.white,
                        elevation: 3,
                        alignment: Alignment.center,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0)),
                        fixedSize: const Size(140, 30),
                        //////// HERE
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ClassicQuizMain()));
                      },
                      child: const Text(
                        "START AGAIN",
                        style: TextStyle(color: Colors.black, fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
