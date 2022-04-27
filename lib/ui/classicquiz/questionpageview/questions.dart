import 'dart:convert';
import 'dart:math';
import 'dart:ui';

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:flutterheritageolympiad/colors/colors.dart';
import 'package:flutterheritageolympiad/ui/quiz/let_quiz.dart';
import 'package:flutterheritageolympiad/ui/rightdrawer/right_drawer.dart';
import 'package:flutterheritageolympiad/ui/welcomeback/welcomeback_page.dart';
import 'package:http/http.dart' as http;

import '../../../modal/classicquestion/ClassicQuestion.dart';
import '../../../modal/classicquestion/getQuestionResponse.dart';
import 'dart:convert' as convert;

class ClassicQuestion extends StatefulWidget{
  var quizid;
   ClassicQuestion({Key? key,required this.quizid}) : super(key: key);

  @override
  _State createState() => _State();
}


class _State extends State<ClassicQuestion> {
  bool _hasBeenPressed1 = false;
  bool _hasBeenPressed2 = false;
  bool _hasBeenPressed3 = false;
  bool _hasBeenPressed4 = false;
  var quiz;
  var results;
  var  c;
  var data;
  var questions;
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
  var decRes;
  @override
  void initState() {
    super.initState();
    BackButtonInterceptor.add(myInterceptor);
    getQuestions(widget.quizid);

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
  List <Color> color= <Color>[
    Color(0xFFED313B),
    Color(0xFF2da79e)
  ];
  void getQuestions(String quiz_id) async {
    http.Response response =
    await http.post(Uri.parse("http://3.108.183.42/api/questions"),
        body: {
          'quiz_id': quiz_id.toString(),
        });
    showLoaderDialog(context);
    var jsonResponse = convert.jsonDecode(response.body);
    if (response.statusCode == 200) {
      Navigator.pop(context);
      data=response.body;
      if (jsonResponse['status'] == 200) {
         decRes = jsonDecode(response.body);
        quesdata=jsonDecode(data!)['data'];
        setState(() {
         questions = jsonDecode(data!)['data']['question'];
         totalques = jsonDecode(data!)['data']['total_question'];
         totalquesinquiz = jsonDecode(data!)['data']['total_question_in_quiz'];
         questime = jsonDecode(data!)['data']['time'];
         quiztype = jsonDecode(data!)['data']['quiz_type'];
         questionlistlen=questions.length;
        });

        print(questions.toString());
        print(decRes);
        c = Colors.black;
        //quiz=getQuestionResponseFromJson(data!).data;
        // setState(() {
        //   quiz = Data.fromJson(decRes);
        // });
        randomItem = (questions..shuffle()).first;

         questionlistlen=questions.length;
         print(randomItem['question']);
        print(randomItem['question_media']);
        print(randomItem['width']);
        print(randomItem['height']);
        print(randomItem['option1']);
        print(randomItem['option1_media']);
        print(randomItem['option2']);
        print(randomItem['option2_media']);
        print(randomItem['option3']);
        print(randomItem['option3_media']);
        print(randomItem['option4']);
        print(randomItem['option4_media']);
        print(randomItem['right_option']);
        print(randomItem['hint']);
        print(randomItem['question_media_type']);
        print(randomItem['why_right']);
        print(randomItem['type']);
        print(randomItem['id']);
      }
    } else {
      Navigator.pop(context);
      print(response.statusCode);
    }
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }
  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) =>WelcomePage()));
    print(BackButtonInterceptor.describe()); // Do some stuff.
    return true;
  }


  @override
  Widget build(BuildContext context) {
    //Colors.white;
    return  Scaffold(
      resizeToAvoidBottomInset: false,
      endDrawerEnableOpenDragGesture: true,
      endDrawer: MySideMenuDrawer(),
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: decRes!=null?ramdomcolor:Colors.white,
        elevation: 0.0,
        actions: [
        Container(
          alignment: Alignment.centerRight,
          padding: EdgeInsets.only(right: 5.0),
          child: GestureDetector(
            onTap: () {
              Scaffold.of(context).openEndDrawer();
            },
            child:  Image.asset("assets/images/side_menu_3.png",height: 40,width: 40),
          ),
        ),
        ],
      ),
      body:decRes==null? Center(
        child: CircularProgressIndicator(),
      )
          :Container(
        decoration:  BoxDecoration(
         color: ramdomcolor,
        ),
        child: Container(
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
                          Image.asset("assets/images/clock_green.png",width: 20,height: 20,color: ramdomcolor,),
                          TweenAnimationBuilder<Duration>(
                              duration: Duration(seconds:30),
                              tween: Tween(begin: Duration(seconds:30), end: Duration(seconds: 0)),
                              onEnd: () {
                                Navigator.of(context).pushReplacement(MaterialPageRoute(
                                    builder: (BuildContext context) =>ClassicQuestion(quizid: widget.quizid,)));
                              },
                              builder: (BuildContext context, Duration value, Widget? child) {
                                final minutes = value.inMinutes;
                                final seconds = value.inSeconds % 60;
                                return Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 5),
                                    child: Text('${seconds}Sec',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: ramdomcolor,
                                            fontSize:15)));
                              }),
                        ],
                      ),
                    )),
                Container(
                 margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
                 child: Text(randomItem['question'].toString(),
                   style: TextStyle(color: ColorConstants.lightgrey200,fontSize: 18),)),

                 if(randomItem['question_media'] != "")
                Container(
                     margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                     child: Image.asset("assets/images/sample_image.png",
                       height: 250,width: 250,alignment: Alignment.center,)),

                if(randomItem['option1'].toString()!="")
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
                  })
                    },
                    child: Text(randomItem['option1'], style: TextStyle(fontSize: 18),),
                  ),
                ),
                if(randomItem['option2'].toString()!="")
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
                      })
                    },
                    child: Text(randomItem['option2'].toString(), style: TextStyle(fontSize: 18),),
                  ),
                ),
                if(randomItem['option3'].toString()!="")
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
                      })
                    },
                    child: Text(randomItem['option3'].toString(), style: TextStyle(fontSize: 18),),
                  ),
                ),
                if(randomItem['option4'].toString()!="")
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
                      })
                    },
                    child: Text(randomItem['option4'].toString(), style: TextStyle(fontSize: 18),),
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
                      if( randomItem['hint']!=null)
                      Container(
                        alignment: Alignment.center,
                        child: GestureDetector(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
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
                                        randomItem['hint'],
                                        style: TextStyle(color: ColorConstants.txt),
                                        textAlign: TextAlign.center,
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
                      if(randomItem['hint']==null)
                      Container(
                        alignment: Alignment.center,
                        child: GestureDetector(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
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
                                        "No Hint Available",
                                        style: TextStyle(color: ColorConstants.txt),
                                        textAlign: TextAlign.center,
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
                            getQuestions(widget.quizid);
                          },
                          child: Image.asset("assets/images/rightarrow2.png",height: 40,width: 40),
                        ),
                      ),
                    ],
                  ),
                ),
                Image.asset('assets/images/mcq_pattern_3.png',height: 70,width: 70,alignment: Alignment.bottomCenter,)
              ],
            )
        ),
      ),

    );
  }
}