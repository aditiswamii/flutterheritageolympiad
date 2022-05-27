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

import '../duelmode/duelmoderesult/duelmode_result.dart';
import '../homepage/welcomeback_page.dart';
import '../quizroom/quizroomresult/quizroom_result.dart';

class Mcq extends StatefulWidget{
  var quizid;
  var type;
  Mcq({Key? key,required this.quizid,required this.type}) : super(key: key);

  @override
  _State createState() => _State();
}


class _State extends State<Mcq> {
  bool _hasBeenPressed1 = false;
  bool _hasBeenPressed2 = false;
  bool _hasBeenPressed3 = false;
  bool _hasBeenPressed4 = false;
  var resultdata;  // save result api data
  var resultres;   //save result response
  var savedata;
  var quiz;
  var results;
  var c;   //color
  var data;  //fetchques api data
  var questions; //question list
  var answer;
  var datares;
  var answerstring="";
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
  var decRes;  //fetch ques response
  var rques;
  var currentques;
  var hasTimerStopped = false;
  var queslist;
  var snackBar;
  Duration? duration;
  var secrem=30;
  var selectans="0";
  var correctanswer="0";
  int i =0;
  var _questionIndex = 0;
  var _totalScore = 0;
  Timer? countdownTimer;
  late Duration myDuration;


  @override
  void initState() {
    super.initState();
    BackButtonInterceptor.add(myInterceptor);
    getQuestions(widget.quizid);
    myDuration = Duration(seconds: 0);
    ramdomcolor = (color..shuffle()).first;
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
  reloadques() {

    secrem=questime;
    setState(() {
      secrem=questime;
      _hasBeenPressed1 = false;
        _hasBeenPressed2 = false;
        _hasBeenPressed3 = false;
       _hasBeenPressed4 = false;
      ramdomcolor = (color..shuffle()).first;
    });
    if(!(countdownTimer == null)) {
      setState(() => countdownTimer!.cancel());
    }
    setState(() => myDuration = Duration(seconds: questime));
    countdownTimer =
        Timer.periodic(Duration(seconds: 1), (_) => setCountDown());
    print(_questionIndex);
    if (_questionIndex < questions.length) {
   //   randomItem = (questions..shuffle()).first;
      randomItem = questions[_questionIndex];
      currentques = questions[_questionIndex];
      print('We have more questions!');
      setState(() {
        _questionIndex = _questionIndex + 1;
        currentques;
      });
      print("current ques"+"${currentques}");
    } else {
      showMessageDialog(context);
     // print("index"+answer[5]);
      //PassValue();

    }
  }
  PassValue(){
    answerstring = "";
    for (var i = 0; i < answer.length; i++) {
      if(answerstring.isEmpty){
        answerstring = answer[i].toString();
      } else {
        answerstring = answerstring + "," + answer[i].toString();
      }


    }

    saveresult(widget.quizid, answerstring);
    print(answerstring);
  }
  void _resetQuiz() {
    setState(() {
      _questionIndex = 0;
      _totalScore = 0;
    });
  }
  List <Color> color = <Color>[
    Color(0xFFED313B),
  //  Color(0xFF2da79e)
  ];

  void getQuestions(String quiz_id) async {
    http.Response response =
    await http.post(Uri.parse(StringConstants.BASE_URL+"questions"),
        body: {
          'quiz_id': quiz_id.toString(),
        });
    showLoaderDialog(context);
    var jsonResponse = convert.jsonDecode(response.body);
    if (response.statusCode == 200) {
      Navigator.pop(context);
      data = response.body;
      if (jsonResponse['status'] == 200) {
        decRes = jsonResponse;
        quesdata = jsonResponse['data'];
        setState(() {
          quesdata = jsonResponse['data'];
          onquestion(quesdata);

        });
        print(jsonResponse['data'].toString());


      }else{
        snackBar = SnackBar(
          content: Text(
            jsonResponse['message'].toString(),textAlign: TextAlign.center,),
        );
        ScaffoldMessenger.of(context)
            .showSnackBar(snackBar);
      }
    } else {
      Navigator.pop(context);
      print(response.statusCode);
    }
  }

  onquestion(quesdata) {
    if (quesdata != null) {
    setState(() {
      _questionIndex = 0;
      questions = quesdata['question'];
      totalques = quesdata['total_question'];
      totalquesinquiz = quesdata['total_question_in_quiz'];
      questime = quesdata['time'];
      quiztype = quesdata['quiz_type'];
      questionlistlen = questions.length;
      answer = List.filled(questions.length, 0, growable: false);
      myDuration = Duration(seconds: questime);
      print(questions.toString());
      print(decRes);
    });
    c = Colors.black;
    reloadques();
  }
  }
  void saveresult(String quiz_id,String quiz_answer) async {
    http.Response response =
    await http.post(Uri.parse("http://3.108.183.42/api/save_result"),
        body: {
          'quiz_id': quiz_id.toString(),
          'quiz_answer': quiz_answer.toString(),
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
onsuccess(savedata){
    countdownTimer!.cancel();
    if(widget.type=="1"){
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) => ResultPage(quizid: savedata['quiz_id'],savedata:savedata, type: widget.type, )));
    }else if(widget.type=="2"){
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>  DuelModeResult(quizid: widget.quizid, type: widget.type,)));
    }else if(widget.type=="3"){
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>  QuizroomResult(quizid: widget.quizid, type: widget.type,)));
    }

}
  showMessageDialog(BuildContext context) async {

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    AlertDialog alert=AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0))),
      contentPadding: EdgeInsets.only(top: 10.0),
      title: Text("Do you want to submit?",style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w700),textAlign: TextAlign.center,),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(onPressed: (){
              countdownTimer!.cancel();
              PassValue();
            },
                child: Text("Yes",style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w700))),
            TextButton(onPressed: (){
              Navigator.pop(context);
            }, child: Text("No",style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w700))),
          ],
        ),
      ],
    );
    showDialog(
      context:context,
      builder:(BuildContext context){
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
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) => WelcomePage()));
    print(BackButtonInterceptor.describe()); // Do some stuff.
    return true;
  }

  @override
  void didUpdateWidget(Mcq oldWidget) {
    // BackButtonInterceptor.remove(myInterceptor);
    super.didUpdateWidget(oldWidget);
    if(secrem==0){
      secrem=questime;
      reloadques();
    }
  }
  @override
  Widget build(BuildContext context) {
    String strDigits(int n) => n.toString().padLeft(2, '0');
   final minutes = strDigits(myDuration.inMinutes.remainder(60));
    final seconds = strDigits(myDuration.inSeconds.remainder(60));
    return  Scaffold(
      resizeToAvoidBottomInset: false,
      endDrawerEnableOpenDragGesture: true,
      endDrawer: MySideMenuDrawer(),
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: ramdomcolor,
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
      body: Container(
        decoration:  BoxDecoration(
          color: ramdomcolor,
        ),
        child: currentques==null? Container(
          height: MediaQuery.of(context).size.height,
          child: Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        ),)
            : Container(
            margin: EdgeInsets.fromLTRB(20,0,20,0),
            child: ListView(
              children: [
                Container(
                    margin: EdgeInsets.fromLTRB(0,20,0,0),
                    height: 40,
                    width: 70,

                    // margin:EdgeInsets.fromLTRB(70, 10, 70, 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: ColorConstants.lightgrey200
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(  margin: EdgeInsets.fromLTRB(0,0,5,0),
                              child: Image.asset("assets/images/clock_green.png",width: 20,height: 20,color: ramdomcolor,)),
                          Text(
                            '$minutes:$seconds',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: ramdomcolor,
                                fontSize: 24),
                          ),
                          SizedBox(height: 20),

                        ],
                      ),
                    )),
                Container(
                    margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
                    child: Text(currentques['question'].toString(),
                      style: TextStyle(color: ColorConstants.lightgrey200,fontSize: 18),)),

                if(currentques['question_media'] != "")
                  Container(
                      margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: Image.network(currentques['question_media']
                        ,height: 250,width: 250,alignment: Alignment.center,)),

                if(currentques['option1'].toString()!="")
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: RaisedButton(
                      textColor: _hasBeenPressed1 ?  ramdomcolor:ColorConstants.lightgrey200 ,
                      // 2
                      color: _hasBeenPressed1 ?  ColorConstants.lightgrey200:ramdomcolor,
                      onPressed: ()=> {
                        setState(() {
                          _hasBeenPressed1 = !_hasBeenPressed1;
                          _hasBeenPressed2=false;
                          _hasBeenPressed3=false;
                          _hasBeenPressed4=false;
                          selectans=_hasBeenPressed1 ?  "1":"0";
                          answer[_questionIndex] = 1;
                        }),

                      },
                      child: Text(currentques['option1'], style: TextStyle(fontSize: 18),),
                    ),
                  ),
                if(currentques['option2'].toString()!="")
                  Container(margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: RaisedButton(
                      textColor: _hasBeenPressed2 ?  ramdomcolor:ColorConstants.lightgrey200 ,
                      // 2
                      color: _hasBeenPressed2 ?  ColorConstants.lightgrey200:ramdomcolor ,
                      onPressed: ()=> {
                        setState(() {
                          _hasBeenPressed2 = !_hasBeenPressed2;
                          _hasBeenPressed1=false;
                          _hasBeenPressed3=false;
                          _hasBeenPressed4=false;
                          selectans=_hasBeenPressed2 ?  "2":"0";
                          answer[_questionIndex] =  _hasBeenPressed2?2:0;

                        }),

                      },
                      child: Text(currentques['option2'].toString(), style: TextStyle(fontSize: 18),),
                    ),
                  ),
                if(currentques['option3'].toString()!="")
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: RaisedButton(
                      textColor: _hasBeenPressed3 ?  ramdomcolor:ColorConstants.lightgrey200 ,
                      // 2
                      color: _hasBeenPressed3 ?  ColorConstants.lightgrey200:ramdomcolor,
                      onPressed: ()=> {
                        setState(() {
                          _hasBeenPressed3 = !_hasBeenPressed3;
                          _hasBeenPressed2=false;
                          _hasBeenPressed1=false;
                          _hasBeenPressed4=false;
                          selectans=_hasBeenPressed3 ?  "3":"0";
                          answer[_questionIndex] = 3;
                        }),

                      },
                      child: Text(currentques['option3'].toString(), style: TextStyle(fontSize: 18),),
                    ),
                  ),
                if(currentques['option4'].toString()!="")
                  Container(margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    decoration: BoxDecoration(
                      color: ramdomcolor,
                    ),
                    child: RaisedButton(
                      textColor: _hasBeenPressed4 ?  ramdomcolor:ColorConstants.lightgrey200 ,
                      // 2
                      color: _hasBeenPressed4 ?  ColorConstants.lightgrey200:ramdomcolor ,
                      onPressed: ()=> {
                        setState(() {
                          _hasBeenPressed4 = !_hasBeenPressed4;
                          _hasBeenPressed2=false;
                          _hasBeenPressed3=false;
                          _hasBeenPressed1=false;
                          selectans=_hasBeenPressed4 ?  "4":"0";
                          answer[_questionIndex] = 4;
                        }),

                      },
                      child: Text(currentques['option4'].toString(), style: TextStyle(fontSize: 18),),
                    ),
                  ),

                Container(
                  margin: EdgeInsets.fromLTRB(10, 10, 10, 20),
                  child: Row(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        child: TextButton(
                            onPressed: (){
                              // Navigator.pushReplacement(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => const QuizPage()));
                            },
                            child: Text("")
                          //Image.asset("assets/images/left_arrow.png",height: 40,width: 40),
                        ),
                      ),

                        Container(
                          alignment: Alignment.center,
                          child: GestureDetector(
                              onTap: () {
                                // if( currentques['hint'].toString().isNotEmpty && currentques['hint']!=null)
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return GestureDetector(
                                        onTap: (){
                                          Navigator.pop(context);
                                        },
                                        child: AlertDialog(
                                          backgroundColor: ramdomcolor,
                                          shape:  RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(Radius.circular(32.0))),
                                          contentPadding:
                                          EdgeInsets.fromLTRB(0, 10, 0, 10),
                                          titleTextStyle: TextStyle(
                                              fontSize: 12, color: ColorConstants.txt),
                                          title:  Image.asset(
                                            "assets/images/hint_white.png",
                                            height: 50,
                                            width: 100,
                                            alignment: Alignment.center,
                                          ),
                                          content:

                                          Text(
                                            currentques['hint'].toString().isEmpty? currentques['hint'].toString():"No Hint Available",
                                            style: TextStyle(color: ColorConstants.txt),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      );
                                    });
                                // Navigator.pushReplacement(context,
                                //     MaterialPageRoute(builder: (context) => const VjournoMain()));
                              },
                              child: Image.asset(
                                "assets/images/hint.png",
                                height: 50,
                                width: 100,
                              )),
                        ),


                      Container(

                        alignment: Alignment.centerLeft,
                        child: TextButton(
                          onPressed: (){
                          // _hasBeenPressed1 = false;
                          //   _hasBeenPressed2 = false;
                          //   _hasBeenPressed3 = false;
                          //  _hasBeenPressed4 = false;
                           // print(correctanswer);
                            print("ans:$selectans");
                            // if(selectans==randomItem['right_option'].toString()){
                            //   correctanswer="4";
                            //
                            // }
                            reloadques();
                           // initState();
                            // getQuestions(widget.quizid);
                          },
                          child: Image.asset("assets/images/rightarrow2.png",height: 40,width: 40),
                        ),
                      ),
                    ],
                  ),
                ),
                Image.asset('assets/images/mcq_pattern_3.png',height: 70,width: 70,alignment: Alignment.bottomLeft,)
              ],
            )
        ),
      ),

    );
  }
}