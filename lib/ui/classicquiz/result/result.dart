import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:flutter/services.dart';
import 'package:flutterheritageolympiad/colors/colors.dart';
import 'package:flutterheritageolympiad/ui/classicquiz/answerkey/answerkey.dart';
import 'package:flutterheritageolympiad/ui/classicquiz/classicquiz_main.dart';

import 'package:flutterheritageolympiad/ui/myaccount/myaccount_page.dart';
import 'package:flutterheritageolympiad/ui/quiz/let_quiz.dart';
import 'package:flutterheritageolympiad/ui/rightdrawer/right_drawer.dart';
import 'package:lottie/lottie.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutterheritageolympiad/ui/homepage/homepage.dart';

class ResultPage extends StatefulWidget {
  var quizid;
  var savedata;
  String? type;
 ResultPage({Key? key,required this.quizid,required this.savedata,required this.type}) : super(key: key);

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
String packagename="";
  PackageInfo? packageInfo;
  userdata() async {
    // PackageInfo packageInfo = await PackageInfo.fromPlatform();

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString("username");
      country = prefs.getString("country");
      userid = prefs.getString("userid");
      // packagename=packageInfo.packageName.toString();
    });
  }
  void getPackage() async {
    packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      packagename = packageInfo!.packageName;
    });
    String appName = packageInfo!.appName;
    packagename = packageInfo!.packageName;
    String version = packageInfo!.version;
    String buildNumber = packageInfo!.buildNumber;
    print("App Name : ${appName}, App Package Name: ${packagename },App Version: ${version}, App build Number: ${buildNumber}");
  }
  @override
  void initState() {
    super.initState();
    getPackage();
    // setState(() {
    //   xp=widget.savedata["xp"];
    //   percentage=widget.savedata["17"];
    //
    // });
    // print(xp);
    // print(percentage);
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
        MaterialPageRoute(builder: (BuildContext context) => HomePage()));
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
      endDrawer: const MySideMenuDrawer(),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/debackground.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          color: Colors.white.withAlpha(100),
          margin: const EdgeInsets.fromLTRB(20, 40, 20, 0),
          child: ListView(children: [
          widget.savedata==null?Container(
            child: ListBody(

              children: [
                Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.fromLTRB(0, 80, 0, 0),
                    child: const Text(
                      "AND\n THAT'S A\nWRAP...",
                      style: TextStyle(fontSize: 24, color: Colors.black),
                      textAlign: TextAlign.center,
                    )),
                Container(
                  height: 300,
                  width: 300,
                  margin: const EdgeInsets.only(top: 40),
                  child: Lottie.asset("assets/lottie/lottieanim.json"),
                ),
                Container( margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: const Text("Generating Result...",
                    style: TextStyle(fontSize: 24, color:Colors.black),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          ):  Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.fromLTRB(0, 20, 0, 5),
                child: const Text(
                  "YOU\nSCORED...",
                  style: TextStyle(
                      fontSize: 24,
                      color: ColorConstants.txt,
                      fontFamily: "Nunito"),
                  textAlign: TextAlign.center,
                )),
            Container(
                decoration: const BoxDecoration(shape: BoxShape.circle),
                margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                alignment: Alignment.topCenter,
                child: SizedBox(
                  height: 170,
                  width: 170,
                  child: Stack(
                    children: <Widget>[
                      SizedBox(
                        child: Center(
                          child: Container(
                            height: 170,
                            width: 170,
                            child: CircularProgressIndicator(
                              value: (double.parse(widget.savedata["per"]
                                  .toString())/(100)),
                              valueColor: const AlwaysStoppedAnimation<Color>(
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
                        controller: FlipCardController(),
                        direction: FlipDirection.HORIZONTAL,

                        front: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(child: Text("${widget.savedata["xp"]} XP")),

                            if (double.parse(widget.savedata["per"]
                                .toString()) >=
                                0.0 &&
                                double.parse(widget.savedata["per"]
                                    .toString()) <
                                    10.0)
                              const Center(child: Text("oh boy!")),
                            if (double.parse(widget.savedata["per"]
                                .toString()) >=
                                10.0 &&
                                double.parse(widget.savedata["per"]
                                    .toString()) <
                                    50.0)
                              const Center(child: Text("Don't give up!")),
                            if (double.parse(widget.savedata["per"]
                                .toString()) ==
                                50.0)
                              const Center(
                                  child: Text("Practice makes perfect!")),
                            if (double.parse(widget.savedata["per"]
                                .toString()) >
                                50.0 &&
                                double.parse(widget.savedata["per"]
                                    .toString()) <=
                                    90.0)
                              const Center(child: Text("Almost there!")),
                            if (double.parse(widget.savedata["per"]
                                .toString()) >
                                90.0 &&
                                double.parse(widget.savedata["per"]
                                    .toString()) <=
                                    100.0)
                              const Center(child: Text("Keep it up!")),
                          ],
                        ),
                        back: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(child: Text("${widget.savedata["per"]} %")),
                            if (double.parse(widget.savedata["per"]
                                .toString()) >=
                                0.0 &&
                                double.parse(widget.savedata["per"]
                                    .toString()) <
                                    10.0)
                              const Center(child: Text("oh boy!")),
                            if (double.parse(widget.savedata["per"]
                                .toString()) >=
                                10.0 &&
                                double.parse(widget.savedata["per"]
                                    .toString()) <
                                    50.0)
                              const Center(child: Text("Don't give up!")),
                            if (double.parse(widget.savedata["per"]
                                .toString()) ==
                                50.0)
                              const Center(
                                  child: Text("Practice makes perfect!")),
                            if (double.parse(widget.savedata["per"]
                                .toString()) >
                                50.0 &&
                                double.parse(widget.savedata["per"]
                                    .toString()) <=
                                    90.0)
                              const Center(child: Text("Almost there!")),
                            if (double.parse(widget.savedata["per"]
                                .toString()) >
                                90.0 &&
                                double.parse(widget.savedata["per"]
                                    .toString()) <=
                                    100.0)
                              const Center(child: Text("Keep it up!")),
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

                    Share.share("I got " "${widget.savedata["xp"]} XP"" on Cultre App. you can play on "
                        "https://play.google.com/store/apps/details?id=$packagename", subject: 'Share link');

                  },
                  child: Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.fromLTRB(0, 40, 0, 5),
                      child: const Text(
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
                            builder: (context) => AnswerkeyPage(quizid: widget.quizid, saveddata: widget.savedata, type: widget.type, sessionid: 0, tourid: 0,)));
                  },
                  child: Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.fromLTRB(0, 20, 0, 5),
                      child: const Text(
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
                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
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
                        if(widget.type=="1") {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ClassicQuizMain()));
                        }
                        if(widget.type=="2"){
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const QuizPage()));
                        }

                      },
                      child:  Text(
                        widget.type=="1"?"START AGAIN":"BACK TO HOME",
                        style: const TextStyle(color: Colors.black, fontSize: 16),
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
