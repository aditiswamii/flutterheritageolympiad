
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:flutterheritageolympiad/colors/colors.dart';
import 'package:flutterheritageolympiad/dialog/duelinvitereceive/duelinvite_receivedialog.dart';
import 'package:flutterheritageolympiad/duelquiz/duel_quiz.dart';
import 'package:flutterheritageolympiad/rightdrawer/right_drawer.dart';
import 'package:flutterheritageolympiad/tournamentquiz/tournament_quiz.dart';
import 'package:flutterheritageolympiad/welcomeback/welcomeback_page.dart';
import 'package:getwidget/components/progress_bar/gf_progress_bar.dart';

void main() {

  runApp(const MaterialApp(

    debugShowCheckedModeBanner: false,
    home: QuizPage(),
  ));
}
class QuizPage extends StatefulWidget{

  const QuizPage({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}


class _State extends State<QuizPage> {

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
            image: AssetImage("assets/whitebg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child:Container(
          margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
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
                        child:  Image.asset("assets/home_1.png",height: 40,width: 40),
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
                        child:  Image.asset("assets/side_menu_2.png",height: 40,width: 40),
                      ),
                    ),
                  ],
                ),
                Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.fromLTRB(0, 60, 0, 10),
                    child: const Text("LET'S QUIZ,",style: TextStyle(fontSize: 24,color: ColorConstants.Omnes_font))),
                Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: const Text("HANA210",style: TextStyle(fontSize: 24,color: ColorConstants.Omnes_font))),
                Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: const Text("Leagues are available only in Tournament\nmode.",style: TextStyle(fontSize: 15,color: ColorConstants.Omnes_font))),

                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child:Column(

                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Container(
                              margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                              padding: EdgeInsets.fromLTRB(10, 40, 10, 40),
                              height: 150,
                              width: 150,
                              decoration: const BoxDecoration(
                                  color: ColorConstants.myaccount
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  // Navigator.pushReplacement(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) => const AlmostTherePage()));
                                },
                                child: Column(
                                  children: [
                                    Text("CLASSIC",style: TextStyle(color: Colors.white,fontSize: 22),textAlign: TextAlign.center,),
                                    Text("you are your own standard!",style: TextStyle(color: Colors.white,fontSize: 12),textAlign: TextAlign.center,),

                                  ],
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            child: Container(
                              margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                              padding: EdgeInsets.fromLTRB(10, 40, 10, 40),
                              height: 150,
                              width: 150,
                              decoration: const BoxDecoration(
                                  color: ColorConstants.myfeed
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const DuelQuizSelected()));
                                },
                                child: Column(
                                  children: [
                                    Text("DUEL",style: TextStyle(color: Colors.white,fontSize: 22),textAlign: TextAlign.center,),
                                    Text("[v],real-time match",style: TextStyle(color: Colors.white,fontSize: 12),textAlign: TextAlign.center,),

                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Container(
                              margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                              padding: EdgeInsets.fromLTRB(10, 40, 10, 40),
                              height: 150,
                              width: 150,
                              decoration: const BoxDecoration(
                                  color: ColorConstants.to_the_quizzes
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  // Dialog errorDialog = Dialog(
                                  //     shape: RoundedRectangleBorder(
                                  //         borderRadius: BorderRadius.circular(
                                  //             20.0)), //this right here
                                  //
                                  //         child: Container(
                                  //           height: 500,
                                  //             width: 350,
                                  //             margin: EdgeInsets.all(10),
                                  //             child: DialogDuelInviteReceive()));
                                  // showDialog(
                                  //     context: context,
                                  //     builder: (BuildContext context) => errorDialog);
                                  // // Navigator.pushReplacement(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) => const AlmostTherePage()));
                                },
                                child: Column(
                                  children: [
                                    Text("QUIZ ROOM",style: TextStyle(color: Colors.white,fontSize: 22),textAlign: TextAlign.center,),
                                    Text("Custom group quizzes",style: TextStyle(color: Colors.white,fontSize: 12),textAlign: TextAlign.center,),

                                  ],
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            child: Container(
                              margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
                              padding: EdgeInsets.fromLTRB(10, 40, 10, 40),
                              height: 150,
                              width: 150,
                              decoration: const BoxDecoration(
                                  color: ColorConstants.to_the_shop
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const TournamentQuizSelected()));
                                },
                                child: Column(
                                  children: [
                                    Text("TOURNAMENT",style: TextStyle(color:ColorConstants.Omnes_font,fontSize: 22),textAlign: TextAlign.center,),
                                    Text("The leagues beckon!",style: TextStyle(color:ColorConstants.Omnes_font,fontSize: 12),textAlign: TextAlign.center,),

                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
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
                            child: Text("YOUR ACTIVITY SUMMARY",style: TextStyle(color: ColorConstants.Omnes_font),),
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
                                style: TextStyle(color: ColorConstants.Omnes_font, fontSize: 16),
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