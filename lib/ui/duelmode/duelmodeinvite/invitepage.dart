import 'dart:developer';

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:flutterheritageolympiad/colors/colors.dart';
import 'package:flutterheritageolympiad/ui/duelmode/duelmodelink/duelmodelink.dart';
import 'package:flutterheritageolympiad/ui/duelmode/duelmodemain/duelmode_main.dart';

import 'package:flutterheritageolympiad/ui/rightdrawer/right_drawer.dart';
import 'package:flutterheritageolympiad/ui/homepage/welcomeback_page.dart';

import 'package:getwidget/colors/gf_color.dart';
import 'package:getwidget/components/dropdown/gf_multiselect.dart';
import 'package:getwidget/components/progress_bar/gf_progress_bar.dart';
import 'package:getwidget/types/gf_checkbox_type.dart';

import '../../../utils/StringConstants.dart';
import '../../quiz/let_quiz.dart';
import '../duelcontactlist/duelcontactlist.dart';

class DuelModeInvite extends StatefulWidget {
  var quiztypeid;
  var quizspeedid;
  var difficultylevelid;
  var quizid;
  var type;
  var seldomain;

   DuelModeInvite({Key? key,required this.quizspeedid,required this.quiztypeid,
     required this.quizid,required this.type,required this.difficultylevelid,required seldomain}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<DuelModeInvite> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool value = false;

  @override
  void initState() {
    super.initState();
    // _locations ;
    BackButtonInterceptor.add(myInterceptor);
    // _presenter = ClassicQuizPresenter(this);

  }
  @override
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }

  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => QuizPage()));
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
            image: AssetImage("assets/images/login_bg.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(color: Colors.white.withAlpha(100),
          margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: ListView(
            children:<Widget> [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    alignment: Alignment.centerLeft,

                    padding: EdgeInsets.all(5),
                    child: Center(
                      child: Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)
                        ),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const WelcomePage()));
                          },
                          child:  Image.asset("assets/images/home_1.png",height: 40,width: 40,),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(right: 5.0),
                    child: GestureDetector(
                      onTap: () {
                        _scaffoldKey.currentState!.openEndDrawer();
                      },
                      child:  Image.asset("assets/images/side_menu_2.png",height: 40,width: 40),
                    ),
                  ),
                ],
              ),
              Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                  child: const Text("DUEL MODE",
                      style: TextStyle(
                          fontSize: 24, color: ColorConstants.txt))),
              Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: const Text(
                      "Invite someone else to Duel with",
                      style: TextStyle(
                          fontSize: 15, color: ColorConstants.txt))),
              Container(
                width: 350,
                alignment: Alignment.center,
                margin: EdgeInsets.fromLTRB(0, 30, 0, 30),
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      padding: EdgeInsets.fromLTRB(10, 40, 10, 40),
                      height: 150,
                      width: 150,
                      decoration: const BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: ColorConstants.lightgrey200
                      ),
                      child: GestureDetector(
                          onTap: () {
                            //ColorConstants.myfeed;
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>  DuelModeSelectPlayer(type: widget.type, quizid: widget.quizid, difficultylevelid: widget.difficultylevelid,
                                      quiztypeid: widget.quiztypeid, seldomain: widget.seldomain, quizspeedid: widget.quizspeedid,)));
                          },
                          child: Text("INVITE",style: TextStyle(color: Colors.black,fontSize: 20),textAlign: TextAlign.center,)),
                    ),
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      padding: EdgeInsets.fromLTRB(10, 40, 10, 40),
                      height: 150,
                      width: 150,
                      decoration: const BoxDecoration(
                        shape: BoxShape.rectangle,
                          color: ColorConstants.lightgrey200
                      ),
                      child: GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const DuelModeLink()));
                            // Navigator.pushReplacement(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => const AlmostTherePage()));
                          },
                          child: Text("GET A LINK",style: TextStyle(color: Colors.black,fontSize: 20),textAlign: TextAlign.center,)),
                    ),
                  ],
                ),
              ),
              Container(
                child: Text(
                  "QUIZ SUMMARY",
                  style: TextStyle(
                      color: ColorConstants.txt, fontSize: 15),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                decoration: const BoxDecoration(color: Colors.white),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                    // if you need this
                    side: BorderSide(
                      color: Colors.grey.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child:
                  Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                        child: Row(
                             children: [
                            Text(
                              "DIFFICULTY: ",
                              style: TextStyle(
                                  color: ColorConstants.txt,
                                  fontSize: 15,fontWeight: FontWeight.w600),
                            ),

                            Text(
                              widget.difficultylevelid,
                              style: TextStyle(
                                  color: ColorConstants.txt,
                                  fontSize: 15),
                            ),

                          ],
                        ),

                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                        child: Row(

                          children: [
                            Text(
                              "SPEED: ",
                              style: TextStyle(
                                  color: ColorConstants.txt,
                                  fontSize: 15,fontWeight: FontWeight.w600),
                            ),
                            Text(
                              widget.quizspeedid,
                              style: TextStyle(
                                  color: ColorConstants.txt,
                                  fontSize: 15),
                            ),
                          ],
                        ),

                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                        child: Column(
                            children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "DOMAINS SELECTED:",textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: ColorConstants.txt,
                                    fontSize: 15,fontWeight: FontWeight.w600),
                              ),
                            ),
                              ListView.builder(
                              physics: const BouncingScrollPhysics(),
    shrinkWrap: true,
    itemCount: widget.seldomain == null
    ? 0
        : widget.seldomain.length,
    itemBuilder: (BuildContext context, int index) {
      return
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            widget.seldomain[index]['name'].toString(), textAlign: TextAlign.left,
            style: TextStyle(
                color: ColorConstants.txt,
                fontSize: 15),
          ),
        );
    }),
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Literature and Languages",textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: ColorConstants.txt,
                                      fontSize: 15),
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Performing Arts",textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: ColorConstants.txt,
                                      fontSize: 15),
                                ),
                              ),
                          ],
                        ),

                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: ColorConstants.red,
                        onPrimary: Colors.white,
                        elevation: 3,
                        alignment: Alignment.center,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0)),
                        fixedSize: const Size(100, 40),
                        //////// HERE
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => QuizPage()));
                      },
                      child: const Text(
                        "GO BACK",
                        style: TextStyle(
                            color: ColorConstants.lightgrey200, fontSize: 14),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    // ElevatedButton(
                    //   style: ElevatedButton.styleFrom(
                    //     primary: ColorConstants.verdigris,
                    //     onPrimary: Colors.white,
                    //     elevation: 3,
                    //     alignment: Alignment.center,
                    //     shape: RoundedRectangleBorder(
                    //         borderRadius: BorderRadius.circular(30.0)),
                    //     fixedSize: const Size(100, 40),
                    //     //////// HERE
                    //   ),
                    //   onPressed: () {
                    //     Navigator.pushReplacement(
                    //         context,
                    //         MaterialPageRoute(
                    //             builder: (context) => const WelcomePage()));
                    //   },
                    //   child: const Text(
                    //     "LET'S GO!",
                    //     style: TextStyle(
                    //         color: ColorConstants.lightgrey200, fontSize: 14),
                    //     textAlign: TextAlign.center,
                    //   ),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }



}

