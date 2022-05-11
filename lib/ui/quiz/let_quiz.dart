
import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:flutterheritageolympiad/ui/classicquiz/classicquiz_main.dart';
import 'package:flutterheritageolympiad/ui/classicquiz/domainlist.dart';
import 'package:flutterheritageolympiad/ui/classicquiz/questionpageview/questions.dart';
import 'package:flutterheritageolympiad/colors/colors.dart';
import 'package:flutterheritageolympiad/dialog/duelinvitereceive/duelinvite_receivedialog.dart';
import 'package:flutterheritageolympiad/ui/duelquiz/duel_quiz.dart';
import 'package:flutterheritageolympiad/ui/rightdrawer/right_drawer.dart';
import 'package:flutterheritageolympiad/ui/tournamentquiz/tournament_quiz.dart';
import 'package:flutterheritageolympiad/ui/welcomeback/welcomeback_page.dart';
import 'package:getwidget/components/progress_bar/gf_progress_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';


class QuizPage extends StatefulWidget{

  const QuizPage({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}


class _State extends State<QuizPage> {
  var username;
  var email;
  var country;
  var profilepic;
  var userid;

  userdata() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString("username");
      country =prefs.getString("country");
      userid= prefs.getString("userid");
    });
  }
  @override
  void initState() {
    super.initState();
    BackButtonInterceptor.remove(myInterceptor);
    userdata();
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
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      endDrawerEnableOpenDragGesture: true,
      endDrawer: MySideMenuDrawer(),
      body:Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/debackground.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child:Container(
          margin: EdgeInsets.fromLTRB(20, 30, 20, 0),
          child: ListView(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 5.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const WelcomePage()));
                        },
                        child:  Image.asset("assets/images/home_1.png",height: 40,width: 40),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(right: 5.0),
                      child: GestureDetector(
                        onTap: () {
                          Scaffold.of(context).openEndDrawer();
                        },
                        child:  Image.asset("assets/images/side_menu_2.png",height: 40,width: 40),
                      ),
                    ),
                  ],
                ),
                Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                    child: const Text("LET'S QUIZ,",style: TextStyle(fontSize: 24,color: ColorConstants.txt))),
                Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: Text(username.toString(),style: TextStyle(fontSize: 24,color: ColorConstants.txt))),
                Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: const Text("Leagues are available only in Tournament\nmode.",style: TextStyle(fontSize: 15,color: ColorConstants.txt))),
                Container(
                  //height: 300,
                  width: MediaQuery.of(context).size.width,
                  //alignment: Alignment.center,
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap:(){
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                  //  Domainlist()
                                  ClassicQuizMain()
                              ));
                        },
                        child: Container(
                          height: 150,
                          width: 150,
                          color: ColorConstants.red200,

                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(child: Text("CLASSIC",style: TextStyle(color: Colors.white,fontSize: 20),textAlign: TextAlign.center,)),
                              Container(child: Text("you are your own standard!",style: TextStyle(color: Colors.white,fontSize: 12),textAlign: TextAlign.center,)),

                            ],
                          ),

                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const DuelQuizSelected()));
                        },
                        child: Container(
                          height: 150,
                          width: 150,
                          color:ColorConstants.yellow200,

                          child:  Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(child: Text("DUEL",style: TextStyle(color: Colors.white,fontSize: 20),textAlign: TextAlign.center,)),
                              Container(child: Text("[v],real-time match",style: TextStyle(color: Colors.white,fontSize: 12),textAlign: TextAlign.center,)),

                            ],
                          ),

                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  //height: 300,
                  width: MediaQuery.of(context).size.width,
                  //alignment: Alignment.center,
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>  QuizPage()));
                        },
                        child: Container(
                          height: 150,
                          width: 150,
                          color: ColorConstants.blue200,

                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(child: Text("QUIZ ROOM",style: TextStyle(color: Colors.white,fontSize: 20),textAlign: TextAlign.center,)),
                              Container(child: Text("Custom group quizzes",style: TextStyle(color: Colors.white,fontSize: 12),textAlign: TextAlign.center,)),

                            ],
                          ),

                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const TournamentQuizSelected()));
                        },
                        child: Container(
                          height: 150,
                          width: 150,
                          color: Colors.black26,

                          child:  Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(child: Text("TOURNAMENT",style: TextStyle(color:ColorConstants.txt,fontSize: 20),textAlign: TextAlign.center,)),
                              Container(child: Text("The leagues beckon!",style: TextStyle(color:ColorConstants.txt,fontSize: 12),textAlign: TextAlign.center,)),

                            ],
                          ),

                        ),
                      ),
                    ],
                  ),
                ),


                Flexible(
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                    decoration: BoxDecoration(
                        color: Colors.white),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        // if you need this
                        side: BorderSide(
                          color: Colors.grey.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
                            child: Text("YOUR ACTIVITY SUMMARY",style: TextStyle(color: ColorConstants.txt),),
                          ),
                          Container(
                              margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                              child: GFProgressBar(
                                percentage: 0.5,
                                lineHeight: 30,
                                alignment: MainAxisAlignment.spaceBetween,
                                child: const Text('10 out of 20', textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 18, color: Colors.white),
                                ),
                                backgroundColor: Colors.black12,
                                progressBarColor: Colors.blue,
                              )
                          ),
                          Container(
                              margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                              child: GFProgressBar(
                                percentage: 0.6,
                                lineHeight: 30,
                                alignment: MainAxisAlignment.spaceBetween,
                                child: const Text('12000 XP out of 20000XP', textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 18, color: Colors.white),
                                ),
                                backgroundColor: Colors.black12,
                                progressBarColor: Colors.blue,
                              )
                          ),
                          // Container(
                          //     margin: EdgeInsets.fromLTRB(10, 10, 10, 20),
                          //
                          //     child: GFProgressBar(
                          //       //   linearGradient:  LinearGradient(begin: Alignment.centerLeft,
                          //       //   end: Alignment.centerRight,colors: [ColorConstants.quiz_grad1, ColorConstants.quiz_grad2, ColorConstants.quiz_grad3].toList(growable: true)),
                          //       percentage: 0.9,
                          //       lineHeight: 30,
                          //       alignment: MainAxisAlignment.spaceBetween,
                          //       // child: const Text('70%', textAlign: TextAlign.center,
                          //       //   style: TextStyle(fontSize: 18, color: Colors.white),
                          //       // ),
                          //       backgroundColor: Colors.black12,
                          //       progressBarColor: ColorConstants.quiz_grad1,
                          //       child: Container(
                          //         decoration: BoxDecoration(
                          //           gradient: LinearGradient(
                          //             colors: [
                          //               ColorConstants.quiz_grad1,
                          //               ColorConstants.quiz_grad2,
                          //               ColorConstants.quiz_grad3
                          //             ],
                          //             stops: [
                          //               0.0,
                          //               0.5,
                          //               0.9,
                          //             ],
                          //           ),
                          //         ),
                          //       ),
                          //     )
                          // ),
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.white,
                                onPrimary: Colors.white,
                                elevation: 3,
                                alignment: Alignment.center,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0)),
                                fixedSize: const Size(190, 50),
                                //////// HERE
                              ),
                              onPressed: () {
                                // Navigator.pushReplacement(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) => const AlmostTherePage()));
                              },
                              child: const Text(
                                "SEE PERFORMANCE",
                                style: TextStyle(color: ColorConstants.txt, fontSize: 16),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ]
          ),
        ),
      ),
    );
  }
}
