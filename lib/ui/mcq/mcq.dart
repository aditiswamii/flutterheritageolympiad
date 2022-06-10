import 'dart:async';
import 'dart:convert';

import 'dart:math';
import 'dart:ui';

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';

import 'package:CultreApp/colors/colors.dart';
import 'package:CultreApp/modal/question/GetQuestionResponse.dart';
import 'package:CultreApp/ui/classicquiz/result/result.dart';

import 'package:CultreApp/ui/rightdrawer/right_drawer.dart';
import 'package:CultreApp/utils/stringconstants.dart';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:convert' as convert;



import '../duelmode/duelmoderesult/duelmode_result.dart';
import '../homepage/homepage.dart';
import '../quizroom/quizroomresult/quizroom_result.dart';
import '../tournamentquiz/result/tourresult.dart';

class Mcq extends StatefulWidget {
  var quizid;
  var type;
  var tourid;
  var sessionid;
  Mcq(
      {Key? key,
      required this.quizid,
      required this.type,
      required this.sessionid,
      required this.tourid})
      : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<Mcq> {
  bool _hasBeenPressed1 = false;
  bool _hasBeenPressed2 = false;
  bool _hasBeenPressed3 = false;
  bool _hasBeenPressed4 = false;
  var resultdata; // save result api data
  var resultres; //save result response
  var savedata;
  var quiz;
  var results;
  var c; //color
  var data; //fetchques api data
  List<Question>? questions =
      [].cast<Question>().toList(growable: true); //question list
  var answer;
  var datares;
  var answerstring = "";
  var randomItem;
  var questionlistlen;
  Random random = Random();
  var selectedquestion;
  var domains_length;
  var totalques;
  var totalquesinquiz;
  var questime;
  var quiztype;
  var ramdomcolor;
  var quesdata;
  var decRes; //fetch ques response
  var rques;
  Question? currentques;
  var hasTimerStopped = false;
  var queslist;
  var snackBar;
  Duration? duration;
  var secrem = 30;
  var selectans = "0";
  var correctanswer = "0";
  int i = 0;
  int _questionindex = 0;
  var _totalScore = 0;
  Timer? countdownTimer;
  late Duration myDuration;
  bool visibilityanimation = false;
  bool prevarrow = false;
  GetQuestionResponse? questionR;
  int wholequiztime = 0;
  bool lltype1=true;
  @override
  void initState() {
    super.initState();
    BackButtonInterceptor.add(myInterceptor);
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        visibilityanimation = true;
      });
    });

    if (widget.type == "1" || widget.type == "2" || widget.type == "3") {
      getQuestions(widget.quizid.toString());
    } else {
      getTourQuestions(widget.tourid, widget.sessionid);
    }

    myDuration = Duration(seconds: 0);
   // ramdomcolor = (color..shuffle()).first;
    ramdomcolor = ColorConstants.red_ques;
  }

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          CircularProgressIndicator(),
          Container(
              margin: EdgeInsets.only(left: 7), child: Text("Loading...")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void setCountDown() {
    final reduceSecondsBy = 1;
    setState(() {
      final seconds = myDuration.inSeconds - reduceSecondsBy;
      if (seconds < 0) {
        countdownTimer!.cancel();
        reloadques();
      } else {
        myDuration = Duration(seconds: seconds);
      }
    });
  }
   nextByTime(){
    if(_questionindex == questions!.length-1){
      PassValue();
    } else {
      setState(() {
        _questionindex+1;
      });

      reloadques();
    }
  }
  reloadques() {
    print("wholequiztime: "+wholequiztime.toString());
    print("_questionindex: "+_questionindex.toString());

    if(wholequiztime == 1) {
      _questionindex==0?prevarrow=false:prevarrow=true;
      setState(() {
        prevarrow;
      });
    }else{
      setState(() {
        prevarrow == false;
      });

    }
    print("prevarrow: "+prevarrow.toString());
    secrem = questime;
    setState(() {
      secrem = questime;
      _hasBeenPressed1 = false;
      _hasBeenPressed2 = false;
      _hasBeenPressed3 = false;
      _hasBeenPressed4 = false;
      //ramdomcolor = (color..shuffle()).first;
      ramdomcolor = ColorConstants.red_ques;
    });
    if (!(countdownTimer == null)) {
      setState(() => countdownTimer!.cancel());
    }
    setState(() => myDuration = Duration(seconds: questime));
    countdownTimer =
        Timer.periodic(Duration(seconds: 1), (_) => setCountDown());
    print(_questionindex);
    if (_questionindex < questions!.length) {
      //   randomItem = (questions..shuffle()).first;
      randomItem = questions![_questionindex];
      currentques = questions![_questionindex];
      print('We have more questions!');
      setState(() {
        _questionindex = _questionindex + 1;
        currentques;
      });
      print("current ques: " + "${currentques!.question}");
    } else {
      showMessageDialog(context);
      // print("index"+answer[5]);
      //PassValue();

    }
    if(currentques!.quesType==2){
      setState(() {
        ramdomcolor = ColorConstants.yellow_ques;
        lltype1=false;
      });

    }else if(currentques!.quesType==3){
      setState(() {
        ramdomcolor = ColorConstants.blue_ques;
        lltype1=true;
      });

    }else{
      setState(() {
        ramdomcolor = ColorConstants.red_ques;
        lltype1=true;
      });

    }
  }

  PassValue() {
    answerstring = "";
    for (int i = 0; i < answer.length; i++) {
      if (answerstring.isEmpty) {
        answerstring = answer[i].toString();
      } else {
        answerstring = answerstring + "," + answer[i].toString();
      }
    }
    if (widget.type == "1" || widget.type == "2") {
      submitquiz(widget.quizid.toString(), answerstring);
    } else if (widget.type == "3") {
      submitquizroomquiz(widget.quizid.toString(), answerstring);
    } else if (widget.type == "4") {
      submittourquiz(widget.tourid, widget.sessionid, answerstring);
    }

    print(answerstring);
  }

  void _resetQuiz() {
    setState(() {
      _questionindex = 0;
      _totalScore = 0;
    });
  }

  // List<Color> color = <Color>[
  //   Color(0xFFED313B),
  //   //  Color(0xFF2da79e)
  // ];

  void getQuestions(String quizId) async {
    http.Response response = await http
        .post(Uri.parse(StringConstants.BASE_URL + "questions"), body: {
      'quiz_id': quizId.toString(),
    });

    var jsonResponse = convert.jsonDecode(response.body);
    data = response.body;
    if (response.statusCode == 200) {


      if (jsonResponse['status'] == 200) {

        onquestion(getQuestionResponseFromJson(data));

        print(jsonResponse['data'].toString());
      } else {
        snackBar = SnackBar(
          content: Text(
            jsonResponse['message'].toString(),
            textAlign: TextAlign.center,
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } else {

      print(response.statusCode);
    }
  }

  void getTourQuestions(int tournamentId, int sessionId) async {
    http.Response response = await http.post(
        Uri.parse(StringConstants.BASE_URL + "tournament_questions"),
        body: {
          'tournament_id': tournamentId.toString(),
          'session_id': sessionId.toString(),
        });

    var jsonResponse = convert.jsonDecode(response.body);
    if (response.statusCode == 200) {

      data = response.body;
      if (jsonResponse['status'] == 200) {
        onquestion(getQuestionResponseFromJson(data));
        print(jsonResponse['data'].toString());
      } else {
        snackBar = SnackBar(
          content: Text(
            jsonResponse['message'].toString(),
            textAlign: TextAlign.center,
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } else {

      print(response.statusCode);
    }
  }

  onquestion(GetQuestionResponse? questionResponse) {
    print(questionResponse);
    if (questionResponse != null) {
      if (questionResponse.data != null) {
        setState(() {
          questionR = questionResponse;
          _questionindex = 0;
          questions = List.from(questionR!.data!.question!);
          totalques = questionR!.data!.totalQuestion;
          totalquesinquiz = questionR!.data!.totalQuestionInQuiz;
          questime = questionR!.data!.time!;
          quiztype = questionR!.data!.quizType!.toString();
          questionlistlen = questions!.length;
          wholequiztime = int.parse(questionR!.data!.wholeQuizTime!);

          answer = List.filled(questions!.length, 0, growable: false);
          myDuration = Duration(seconds: questime);
          print(questions.toString());
          print(decRes);
        });
        c = Colors.black;
        reloadques();
      }
    }
  }

  void submitquiz(String quizId, String quizAnswer) async {
    http.Response response = await http
        .post(Uri.parse(StringConstants.BASE_URL + "save_result"), body: {
      'quiz_id': quizId.toString(),
      'quiz_answer': quizAnswer.toString(),
    });
    showLoaderDialog(context);
    var jsonResponse = convert.jsonDecode(response.body);
    if (response.statusCode == 200) {
      Navigator.pop(context);
      resultdata = response.body;
      if (jsonResponse['status'] == 200) {
        resultres = jsonDecode(response.body);
        savedata = jsonDecode(resultdata!)['data'];
        setState(() {
          savedata = jsonDecode(resultdata!)['data'];
        });
        onsuccess(savedata);
        print(savedata);
        print(savedata['quiz_id']);
        print(jsonDecode(resultdata!)['data']);
        print(jsonDecode(resultdata!)['data']['quiz_id']);
        print(jsonDecode(resultdata!)['data']['xp']);
        print(jsonDecode(resultdata!)['data']['per']);
      }
    } else {
      Navigator.pop(context);
      print(response.statusCode);
    }
  }

  int quizroomcheck = 0;
  void submitquizroomquiz(String quizId, String quizAnswer) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (quizroomcheck == 0) {
      quizroomcheck = 1;
      http.Response response = await http.post(
          Uri.parse(StringConstants.BASE_URL + "save_room_result"),
          body: {
            'quiz_id': quizId.toString(),
            'quiz_answer': quizAnswer.toString(),
            'user_id': prefs.getString("userid").toString()
          });
      showLoaderDialog(context);
      var jsonResponse = convert.jsonDecode(response.body);
      if (response.statusCode == 200) {
        Navigator.pop(context);
        resultdata = response.body;
        if (jsonResponse['status'] == 200) {
          resultres = jsonDecode(response.body);
          savedata = jsonDecode(resultdata!)['data'];
          setState(() {
            savedata = jsonDecode(resultdata!)['data'];
          });
          onsuccess(savedata);
          print(savedata);
          print(savedata['quiz_id']);
          print(jsonDecode(resultdata!)['data']);
          print(jsonDecode(resultdata!)['data']['quiz_id']);
          print(jsonDecode(resultdata!)['data']['xp']);
          print(jsonDecode(resultdata!)['data']['per']);
        }
      } else {
        Navigator.pop(context);
        print(response.statusCode);
      }
    }
  }

  void submittourquiz(
      int tournamentId, int sessionId, String quizAnswer) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    http.Response response = await http
        .post(Uri.parse(StringConstants.BASE_URL + "save_room_result"), body: {
      'tournament_id': tournamentId.toString(),
      'session_id': sessionId.toString(),
      'quiz_answer': quizAnswer.toString(),
      'user_id': prefs.getString("userid").toString()
    });
    showLoaderDialog(context);
    var jsonResponse = convert.jsonDecode(response.body);
    if (response.statusCode == 200) {
      Navigator.pop(context);
      resultdata = response.body;
      if (jsonResponse['status'] == 200) {
        resultres = jsonDecode(response.body);
        savedata = jsonDecode(resultdata!)['data'];
        setState(() {
          savedata = jsonDecode(resultdata!)['data'];
        });
        onsuccess(savedata);
        print(savedata);
        print(savedata['quiz_id']);
        print(jsonDecode(resultdata!)['data']);
        print(jsonDecode(resultdata!)['data']['quiz_id']);
        print(jsonDecode(resultdata!)['data']['xp']);
        print(jsonDecode(resultdata!)['data']['per']);
      }
    } else {
      Navigator.pop(context);
      print(response.statusCode);
    }
  }

  onsuccess(savedata) {
    countdownTimer!.cancel();
    if (widget.type == "1") {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => ResultPage(
                    quizid: savedata['quiz_id'],
                    savedata: savedata,
                    type: widget.type,
                  )));
    } else if (widget.type == "2") {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => DuelModeResult(
                    quizid: widget.quizid,
                    type: widget.type,
                  )));
    } else if (widget.type == "3") {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => QuizroomResult(
                    quizid: widget.quizid,
                    type: widget.type,
                  )));
    } else if (widget.type == "4") {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => TournamentResult(
                    type: widget.type,
                    sessionid: widget.sessionid,
                    tourid: widget.tourid,
                  )));
    }
  }

  showMessageDialog(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0))),
      contentPadding: EdgeInsets.only(top: 10.0),
      title: Text(
        "Do you want to submit?",
        style: TextStyle(
            color: Colors.black, fontSize: 16, fontWeight: FontWeight.w700),
        textAlign: TextAlign.center,
      ),
      actions: [
        Container(
          padding: EdgeInsets.all(4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("No",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w700))),
              TextButton(
                  onPressed: () {
                    countdownTimer!.cancel();
                    PassValue();
                  },
                  child: Text("Yes",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w700))),
            ],
          ),
        ),
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
    countdownTimer!.cancel();
    super.dispose();
  }

  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => HomePage()));
    print(BackButtonInterceptor.describe()); // Do some stuff.
    return true;
  }

  @override
  void didUpdateWidget(Mcq oldWidget) {
    // BackButtonInterceptor.remove(myInterceptor);
    super.didUpdateWidget(oldWidget);
    if (secrem == 0) {
      secrem = questime;
      reloadques();
    }
  }

  @override
  Widget build(BuildContext context) {
    String strDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = strDigits(myDuration.inMinutes.remainder(60));
    final seconds = strDigits(myDuration.inSeconds.remainder(60));
    return Visibility(
      visible: visibilityanimation,
      replacement: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/login_bg.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: ListBody(
                  children: [
                    Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.fromLTRB(0, 80, 0, 0),
                        child: const Text(
                          "Done! Preparing quiz...",
                          style: TextStyle(fontSize: 24, color: Colors.black),
                          textAlign: TextAlign.center,
                        )),
                    Container(
                      height: 300,
                      width: 300,
                      margin: EdgeInsets.only(top: 40),
                      child: Lottie.asset("assets/lottie/lottieanim.json"),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Text(
                        "LOADING...",
                        style: TextStyle(fontSize: 24, color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        endDrawerEnableOpenDragGesture: true,
        endDrawer: MySideMenuDrawer(),
        extendBodyBehindAppBar: false,
        appBar: AppBar(
          toolbarHeight: 70,
          backgroundColor: ramdomcolor,
          elevation: 0.0,
          leading: Container(
            alignment: Alignment.topRight,
            child: Image.asset(
              "assets/images/pattern1.png",
              height: 30,
              width: 30,
            ),
          ),
          title: Container(
            margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
            alignment: Alignment.topRight,
            child: Image.asset(
              "assets/images/pattern1.png",
              height: 30,
              width: 30,
            ),
          ),
          actions: [
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.only(right: 5.0),
              child: GestureDetector(
                onTap: () {
                  // Scaffold.of(context).openEndDrawer();
                },
                child: Image.asset("assets/images/mcq_pattern_3.png",
                    height: 40, width: 40),
              ),
            ),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            color: ramdomcolor,
          ),
          child: currentques == null
              ? Container()
              : Container(
                  margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: ListView(
                    children: [
                      // queno.setText(""+(currentPos+1)+"/"+questionList!!.size)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                              width: 130,
                              height: 50,
                              child: Center(
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  elevation: 2,
                                  child: Container(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                            margin:
                                                EdgeInsets.fromLTRB(0, 0, 5, 0),
                                            child: Image.asset(
                                              "assets/images/clock_green.png",
                                              width: 20,
                                              height: 20,
                                              color: ramdomcolor,
                                            )),
                                        if (wholequiztime == 0)
                                          Container(
                                            height: 35,
                                            width: 70,
                                            padding: const EdgeInsets.all(5),
                                            child: Text(
                                              '$seconds Sec',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: ramdomcolor,
                                                  fontSize: 18),
                                            ),
                                          ),
                                        if (wholequiztime != 0)
                                          Container(
                                            height: 35,
                                            width: 70,
                                            padding: const EdgeInsets.all(5),
                                            child: Text(
                                              '$minutes:$seconds',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: ramdomcolor,
                                                  fontSize: 18),
                                            ),
                                          ),
                                        SizedBox(height: 20),
                                      ],
                                    ),
                                  ),
                                ),
                              )),
                          Container(
                              margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                              width: 130,
                              height: 50,
                              child: Center(
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  elevation: 2,
                                  child: Container(
                                    // queno.setText(""+(currentPos+1)+"/"+questionList!!.size)
                                    child: Container(
                                      height: 35,
                                      width: 130,
                                      padding: const EdgeInsets.all(5),
                                      alignment: Alignment.center,
                                      child: Text(
                                        "" +
                                            "${_questionindex}" +
                                            "/" +
                                            questions!.length.toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: ramdomcolor,
                                            fontSize: 18),
                                      ),
                                    ),
                                  ),
                                ),
                              )),
                        ],
                      ),

                      Container(
                          margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
                          child:
                          Text( Bidi.stripHtmlIfNeeded(currentques!.question!),
                              style: TextStyle(
                                  color: ColorConstants.lightgrey200,
                                  fontSize: 18),
                              textAlign: TextAlign.center,
                            ),
                          ),

                      if (currentques!.questionMedia!.isNotEmpty)
                        Container(
                            margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                            child: Image.network(
                              currentques!.questionMedia!,
                              height: 250,
                              width: 250,
                              alignment: Alignment.center,
                            )),


                        Visibility(
                          visible: lltype1,
                          replacement: ListBody(
                           children: [
                             Container(
                               child:GridView(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisSpacing: 10,crossAxisSpacing: 10),
                                   shrinkWrap: true,
                                   physics: ClampingScrollPhysics(parent: BouncingScrollPhysics()),

                                   children: [

                                     if (currentques!.option1!.isNotEmpty)
                                     Container(
                                       margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                       child: ElevatedButton(
                                         style: ElevatedButton.styleFrom(
                                           primary: _hasBeenPressed1
                                               ? ColorConstants.lightgrey200
                                               : ramdomcolor,
                                           onPrimary: Colors.white,
                                           elevation: 3,
                                           side: BorderSide(
                                             width: 1.0,
                                             color: Colors.white,
                                           ),
                                           alignment: Alignment.center,
                                           shape: RoundedRectangleBorder(
                                               borderRadius: BorderRadius.circular(0.0)),
                                            fixedSize:  Size(150, 150),
                                           //////// HERE
                                         ),
                                         onPressed: () {
                                           setState(() {
                                             _hasBeenPressed1 = !_hasBeenPressed1;
                                             _hasBeenPressed2 = false;
                                             _hasBeenPressed3 = false;
                                             _hasBeenPressed4 = false;
                                             selectans = _hasBeenPressed1 ? "1" : "0";
                                             answer[_questionindex-1] = _hasBeenPressed1 ? 1 : 0;
                                           });
                                         },
                                         child: Text(
                                           currentques!.option1!,
                                           style: TextStyle(
                                             fontSize: 18,
                                             color: _hasBeenPressed1
                                                 ? ramdomcolor
                                                 : ColorConstants.lightgrey200,
                                           ),
                                         ),
                                       ),
                                     ),

                                     if (currentques!.option2!.isNotEmpty)
                                       Container(
                                         margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                         child: ElevatedButton(
                                           style: ElevatedButton.styleFrom(
                                             primary: _hasBeenPressed2
                                                 ? ColorConstants.lightgrey200
                                                 : ramdomcolor,
                                             onPrimary: Colors.white,
                                             elevation: 3,
                                             alignment: Alignment.center,
                                             side: BorderSide(
                                               width: 1.0,
                                               color: Colors.white,
                                             ),

                                             shape: RoundedRectangleBorder(
                                                 borderRadius: BorderRadius.circular(0.0)),
                                             fixedSize:  Size(150, 150),
                                             //////// HERE
                                           ),
                                           onPressed: () {
                                             setState(() {
                                               _hasBeenPressed2 = !_hasBeenPressed2;
                                               _hasBeenPressed1 = false;
                                               _hasBeenPressed3 = false;
                                               _hasBeenPressed4 = false;
                                               selectans = _hasBeenPressed2 ? "2" : "0";
                                               answer[_questionindex-1] = _hasBeenPressed2 ? 2 : 0;
                                             });
                                           },
                                           child: Text(
                                             currentques!.option2.toString(),
                                             style: TextStyle(
                                               fontSize: 18,
                                               color: _hasBeenPressed2
                                                   ? ramdomcolor
                                                   : ColorConstants.lightgrey200,
                                             ),
                                           ),
                                         ),
                                       ),
                                     ]
                        ),
                             )
                            ]
                          ),
                          child: ListBody(
                            children: [
                              if (currentques!.option1!.isNotEmpty)
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: _hasBeenPressed1
                                        ? ColorConstants.lightgrey200
                                        : ramdomcolor,
                                    onPrimary: Colors.white,
                                    elevation: 3,
                                    alignment: Alignment.center,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(0.0)),
                                    // fixedSize: const Size(100, 40),
                                    //////// HERE
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _hasBeenPressed1 = !_hasBeenPressed1;
                                      _hasBeenPressed2 = false;
                                      _hasBeenPressed3 = false;
                                      _hasBeenPressed4 = false;
                                      selectans = _hasBeenPressed1 ? "1" : "0";
                                      answer[_questionindex-1] =  _hasBeenPressed1 ? 1 : 0;
                                    });
                                  },
                                  child: Text(
                                    currentques!.option1!,
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: _hasBeenPressed1
                                          ? ramdomcolor
                                          : ColorConstants.lightgrey200,
                                    ),
                                  ),
                                ),
                              ),

                      if (currentques!.option2!.isNotEmpty)
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: _hasBeenPressed2
                                    ? ColorConstants.lightgrey200
                                    : ramdomcolor,
                                onPrimary: Colors.white,
                                elevation: 3,
                                alignment: Alignment.center,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0.0)),
                                //  fixedSize: const Size(100, 40),
                                //////// HERE
                              ),
                              onPressed: () {
                                setState(() {
                                  _hasBeenPressed2 = !_hasBeenPressed2;
                                  _hasBeenPressed1 = false;
                                  _hasBeenPressed3 = false;
                                  _hasBeenPressed4 = false;
                                  selectans = _hasBeenPressed2 ? "2" : "0";
                                  answer[_questionindex-1] = _hasBeenPressed2 ? 2 : 0;
                                });
                              },
                              child: Text(
                                currentques!.option2.toString(),
                                style: TextStyle(
                                  fontSize: 18,
                                  color: _hasBeenPressed2
                                      ? ramdomcolor
                                      : ColorConstants.lightgrey200,
                                ),
                              ),
                            ),
                          ),
                      if (currentques!.option3!.isNotEmpty)
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: _hasBeenPressed3
                                    ? ColorConstants.lightgrey200
                                    : ramdomcolor,
                                onPrimary: Colors.white,
                                elevation: 3,
                                alignment: Alignment.center,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0.0)),
                                //  fixedSize: const Size(100, 40),
                                //////// HERE
                              ),
                              onPressed: () {
                                setState(() {
                                  _hasBeenPressed3 = !_hasBeenPressed3;
                                  _hasBeenPressed2 = false;
                                  _hasBeenPressed1 = false;
                                  _hasBeenPressed4 = false;
                                  selectans = _hasBeenPressed3 ? "3" : "0";
                                  answer[_questionindex-1] = _hasBeenPressed3 ? 3 : 0;
                                });
                              },
                              child: Text(
                                currentques!.option3.toString(),
                                style: TextStyle(
                                  fontSize: 18,
                                  color: _hasBeenPressed3
                                      ? ramdomcolor
                                      : ColorConstants.lightgrey200,
                                ),
                              ),
                            ),
                          ),
                      if (currentques!.option4!.isNotEmpty)
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                            decoration: BoxDecoration(
                              color: ramdomcolor,
                            ),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: _hasBeenPressed4
                                    ? ColorConstants.lightgrey200
                                    : ramdomcolor,
                                onPrimary: Colors.white,
                                elevation: 3,
                                alignment: Alignment.center,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0.0)),
                                // fixedSize: const Size(100, 40),
                                //////// HERE
                              ),
                              onPressed: () {
                                setState(() {
                                  _hasBeenPressed4 = !_hasBeenPressed4;
                                  _hasBeenPressed2 = false;
                                  _hasBeenPressed3 = false;
                                  _hasBeenPressed1 = false;
                                  selectans = _hasBeenPressed4 ? "4" : "0";
                                  answer[_questionindex-1] = _hasBeenPressed4 ? 4 : 0;
                                });
                              },
                              child: Text(
                                currentques!.option4!.toString(),
                                style: TextStyle(
                                  fontSize: 18,
                                  color: _hasBeenPressed4
                                      ? ramdomcolor
                                      : ColorConstants.lightgrey200,
                                ),
                              ),
                            ),
                          ),
                            ],
                          ),
                        ),
                      Container(
                        margin: EdgeInsets.fromLTRB(10, 10, 10, 20),
                        child: Row(
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Visibility(
                              visible: prevarrow,
                              replacement: Container(child: Text(""),),
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: TextButton(
                                  onPressed: () {
                                    setState(() {
                                      _questionindex = _questionindex-2;
                                    });
                                    reloadques();
                                  },
                                  child: Image.asset(
                                      "assets/images/left_arrow.png",
                                      height: 40,
                                      width: 40),
                                ),
                              ),
                            ),
                            if(currentques!.hint!=null)
                            Container(
                              alignment: Alignment.center,
                              child: GestureDetector(
                                  onTap: () {

                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return GestureDetector(
                                            onTap: () {
                                              Navigator.pop(context);
                                            },
                                            child: AlertDialog(
                                              backgroundColor: ramdomcolor,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              32.0))),
                                              contentPadding:
                                                  EdgeInsets.fromLTRB(
                                                      0, 10, 0, 10),
                                              titleTextStyle: TextStyle(
                                                  fontSize: 12,
                                                  color: ColorConstants.txt),
                                              title: Image.asset(
                                                "assets/images/hint_white.png",
                                                height: 50,
                                                width: 100,
                                                alignment: Alignment.center,
                                              ),
                                              content: Text(
                                              currentques!.hint!
                                                    ,
                                                style: TextStyle(
                                                    color: ColorConstants.txt),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          );
                                        });
                                  },
                                  child: Image.asset(
                                    "assets/images/hint_white.png",
                                    height: 50,
                                    width: 100,
                                  )),
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: TextButton(
                                onPressed: () {
                                  print("ans:$selectans");

                                  reloadques();
                                },
                                child: Image.asset(
                                    "assets/images/rightarrow2.png",
                                    height: 40,
                                    width: 40),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Image.asset(
                        'assets/images/mcq_pattern_3.png',
                        height: 70,
                        width: 70,
                        alignment: Alignment.bottomLeft,
                      )
                    ],
                  )),
        ),
      ),
    );
  }
}
