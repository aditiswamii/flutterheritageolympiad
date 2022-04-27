
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:flutterheritageolympiad/colors/colors.dart';
import 'package:flutterheritageolympiad/ui/duelmode/duelmodemain/duelmode_main.dart';
import 'package:flutterheritageolympiad/ui/rightdrawer/right_drawer.dart';
import 'package:flutterheritageolympiad/ui/welcomeback/welcomeback_page.dart';
import 'package:getwidget/components/progress_bar/gf_progress_bar.dart';

void main() {

  runApp(const MaterialApp(

    debugShowCheckedModeBanner: false,
    home: DuelQuizSelected(),
  ));
}
class DuelQuizSelected extends StatefulWidget{

  const DuelQuizSelected({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}


class _State extends State<DuelQuizSelected> {

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
                    child: const Text("LET'S QUIZ,",style: TextStyle(fontSize: 24,color: ColorConstants.txt))),
                Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: const Text("HANA210",style: TextStyle(fontSize: 24,color: ColorConstants.txt))),
                Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: const Text("Leagues are available only in Tournament\nmode.",style: TextStyle(fontSize: 15,color: ColorConstants.txt))),

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
                                  color: ColorConstants.red200
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
                                  color: ColorConstants.yellow200
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
                                  color: ColorConstants.blue200
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
                                  color: ColorConstants.lightgrey200
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
                                    Text("TOURNAMENT",style: TextStyle(color:ColorConstants.txt,fontSize: 22),textAlign: TextAlign.center,),
                                    Text("The leagues beckon!",style: TextStyle(color:ColorConstants.txt,fontSize: 12),textAlign: TextAlign.center,),

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
                Container(
                  margin: EdgeInsets.fromLTRB(90, 10, 90, 10),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      onPrimary: Colors.white,
                      elevation: 3,
                      alignment: Alignment.center,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                      fixedSize: const Size(150, 50),
                      //////// HERE
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const DuelModeMain()));
                    },
                    child: const Text(
                      "NEXT",
                      style: TextStyle(color: ColorConstants.txt, fontSize: 16),
                      textAlign: TextAlign.center,
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
