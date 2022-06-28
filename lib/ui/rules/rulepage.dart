import 'dart:convert';
import 'dart:developer';

import 'package:back_button_interceptor/back_button_interceptor.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:CultreApp/colors/colors.dart';
import 'package:CultreApp/ui/classicquiz/classicquiz_main.dart';
import 'package:CultreApp/ui/quiz/let_quiz.dart';
import 'package:CultreApp/ui/rightdrawer/right_drawer.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../utils/StringConstants.dart';
import '../mcq/mcq.dart';

// ignore: must_be_immutable
class RulesPage extends StatefulWidget {
  var quiztypeid;
  var quizspeedid;
  var quizid;
  var type;
  int? tourid;
  int? sessionid;
  RulesPage(
      {Key? key,
      required this.quizspeedid,
      required this.quiztypeid,
      required this.quizid,
      required this.type,
      required this.sessionid,
      required this.tourid})
      : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<RulesPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool value = false;
  String? data;
  var ruledata;
  var username;
  var email;
  var country;
  var profilepic;
  var userid;
  var title;
  bool visiblility = true;
  userdata() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString("username");
      country = prefs.getString("country");
      userid = prefs.getString("userid");
    });
    log("test");
    print("quizid${widget.quizid}");
    log("quizid${widget.quizid}");
    if (widget.type == "1") {
      getClassicRule(
          widget.quiztypeid.toString(), widget.quizspeedid.toString());
    } else if (widget.type == "2") {
      getDualRule(widget.quizid.toString());
    } else if (widget.type == "3") {
      getQuizroomRule(widget.quizid.toString());
    } else if (widget.type == "4") {
      log(widget.tourid.toString());
      log(widget.sessionid.toString());
      getTourRule(widget.tourid!, widget.sessionid!);
    }
  }

  @override
  void initState() {
    super.initState();
    BackButtonInterceptor.add(myInterceptor);
    if (widget.type == "1") {
      title = "CLASSIC QUIZ";
    } else if (widget.type == "2") {
      title = 'DUEL QUIZ';
    } else if (widget.type == "3") {
      title = 'QUIZ ROOM';
    } else if (widget.type == "4") {
      title = 'TOURNAMENT';
    }
    userdata();
  }

  void getClassicRule(String quizTypeId, String quizSpeedId) async {
    http.Response response = await http
        .post(Uri.parse("${StringConstants.BASE_URL}quiz_rules"), body: {
      'quiz_type_id': quizTypeId.toString(),
      'quiz_speed_id': quizSpeedId.toString()
    });
    if (response.statusCode == 200) {
      data = response.body; //store response as string
      setState(() {
        ruledata = jsonDecode(
            data!)['data']; //get all the data from json string superheros
        print(ruledata.length); // just printed length of data
      });
      var venam = jsonDecode(data!)['data'];
      print(venam);
    } else {
      print(response.statusCode);
    }
  }

  void getDualRule(String quizId) async {
    http.Response response = await http
        .post(Uri.parse("${StringConstants.BASE_URL}duel_rules"), body: {
      'user_id': userid.toString(),
      'id': quizId.toString(),
    });
    if (response.statusCode == 200) {
      data = response.body; //store response as string
      setState(() {
        ruledata = jsonDecode(
            data!)['data']; //get all the data from json string superheros
        print(ruledata.length); // just printed length of data
      });
      var venam = jsonDecode(data!)['data'];
      print(venam);
    } else {
      print(response.statusCode);
    }
  }

  void getQuizroomRule(String quizid) async {
    http.Response response = await http
        .post(Uri.parse("${StringConstants.BASE_URL}quiz_room_rule"), body: {
      'user_id': userid.toString(),
      'quiz_room_id': quizid.toString(),
    });
    if (response.statusCode == 200) {
      data = response.body; //store response as string
      setState(() {
        ruledata = jsonDecode(
            data!)['data']; //get all the data from json string superheros
        print(ruledata.length); // just printed length of data
      });
      var venam = jsonDecode(data!)['data'];
      print(venam);
    } else {
      print(response.statusCode);
    }
  }

  void getTourRule(int tournamentId, int sessionId) async {
    http.Response response = await http
        .post(Uri.parse("${StringConstants.BASE_URL}tournament_rule"), body: {
      'user_id': userid.toString(),
      'tournament_id': tournamentId.toString(),
      'session_id': sessionId.toString(),
    });
    if (response.statusCode == 200) {
      data = response.body; //store response as string
      setState(() {
        ruledata = jsonDecode(
            data!)['data']; //get all the data from json string superheros
        print(ruledata.length); // just printed length of data
      });
      var venam = jsonDecode(data!)['data'];
      print(venam);
    } else {
      print(response.statusCode);
    }
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }

  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => const QuizPage()));
    print(BackButtonInterceptor.describe()); // Do some stuff.
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
          margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: ListView(
            children: <Widget>[
              ruledata != null
                  ? Visibility(
                      visible: visiblility,
                      replacement: ListBody(
                        children: [
                          Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.fromLTRB(0, 80, 0, 0),
                              child: const Text(
                                "Waiting for the other players\nto accept rules...",
                                style: TextStyle(
                                    fontSize: 24, color: Colors.black),
                                textAlign: TextAlign.center,
                              )),
                          Container(
                            height: 300,
                            width: 300,
                            margin: const EdgeInsets.only(top: 40),
                            child:
                                Lottie.asset("assets/lottie/lottieanim.json"),
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                            child: const Text(
                              "LOADING...",
                              style:
                                  TextStyle(fontSize: 24, color: Colors.black),
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
                      ),
                      child: ListBody(
                        children: [
                          if (title != null)
                            Container(
                                alignment: Alignment.centerLeft,
                                margin: const EdgeInsets.fromLTRB(0, 60, 0, 10),
                                child: Text("$title",
                                    style: const TextStyle(
                                        fontSize: 24,
                                        color: ColorConstants.txt))),
                          Container(
                              alignment: Alignment.centerLeft,
                              margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                              child: const Text("RULES",
                                  style: TextStyle(
                                      fontSize: 24,
                                      color: ColorConstants.txt))),
                          TweenAnimationBuilder<Duration>(
                              duration:
                                  const Duration(seconds: kDebugMode ? 5 : 30),
                              tween: Tween(
                                  begin: const Duration(
                                      seconds: kDebugMode ? 5 : 30),
                                  end: Duration.zero),
                              onEnd: () {
                                if (widget.type != "1") {
                                  setState(() {
                                    visiblility = false;
                                  });
                                  Future.delayed(const Duration(seconds: 3),
                                      () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Mcq(
                                                  quizid: widget.quizid,
                                                  type: widget.type,
                                                  tourid: widget.tourid,
                                                  sessionid: widget.sessionid,
                                                )));
                                  });
                                } else {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Mcq(
                                                quizid: widget.quizid,
                                                type: widget.type,
                                                tourid: widget.tourid,
                                                sessionid: widget.sessionid,
                                              )));
                                }
                              },
                              builder: (BuildContext context, Duration value,
                                  Widget? child) {
                                String strDigits(int n) =>
                                    n.toString().padLeft(2, '0');
                                final minutes =
                                    strDigits(value.inMinutes.remainder(60));
                                final seconds =
                                    strDigits(value.inSeconds.remainder(60));
                                return Container(
                                  height: 50,
                                  width: 150,
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                            margin: const EdgeInsets.fromLTRB(
                                                0, 0, 5, 0),
                                            child: Image.asset(
                                              "assets/images/clock_green.png",
                                              width: 20,
                                              height: 20,
                                              color: ColorConstants.red,
                                            )),
                                        Container(
                                            height: 35,
                                            width: 100,
                                            padding: const EdgeInsets.all(5),
                                            alignment: Alignment.center,
                                            child: Text('$minutes:$seconds',
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                    color: ColorConstants.txt,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14))),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                          ListBody(
                            children: [
                              Container(
                                margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                decoration:
                                    const BoxDecoration(color: Colors.white),
                                child: ruledata == null || ruledata!.isEmpty
                                    ? const Center(
                                        child: CircularProgressIndicator(),
                                      )
                                    : SingleChildScrollView(
                                        child: ListView.builder(
                                          physics:
                                              const BouncingScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: ruledata == null
                                              ? 0
                                              : ruledata.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return Container(
                                                margin:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 10, 0, 10),
                                                child: Text("${index + 1}) "
                                                    "${jsonDecode(data!)['data'][index]}"));
                                          },
                                        ),
                                      ),
                              ),
                            ],
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: ColorConstants.red,
                                    onPrimary: Colors.white,
                                    elevation: 3,
                                    alignment: Alignment.center,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0)),
                                    fixedSize: const Size(100, 40),
                                    //////// HERE
                                  ),
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const QuizPage()));
                                  },
                                  child: const Text(
                                    "GO BACK",
                                    style: TextStyle(
                                        color: ColorConstants.lightgrey200,
                                        fontSize: 14),
                                    textAlign: TextAlign.center,
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container()
            ],
          ),
        ),
      ),
    );
  }
}
