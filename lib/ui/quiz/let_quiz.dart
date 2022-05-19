
import 'dart:convert';

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:flutterheritageolympiad/ui/classicquiz/classicquiz_main.dart';
import 'package:flutterheritageolympiad/ui/classicquiz/domainlist.dart';

import 'package:flutterheritageolympiad/colors/colors.dart';
import 'package:flutterheritageolympiad/dialog/duelinvitereceive/duelinvite_receivedialog.dart';
import 'package:flutterheritageolympiad/ui/duelmode/duelmodemain/duelmode_main.dart';
import 'package:flutterheritageolympiad/ui/duelquiz/duel_quiz.dart';
import 'package:flutterheritageolympiad/ui/rightdrawer/right_drawer.dart';
import 'package:flutterheritageolympiad/ui/tournamentquiz/tournament_quiz.dart';
import 'package:flutterheritageolympiad/ui/welcomeback/welcomeback_page.dart';
import 'package:getwidget/components/progress_bar/gf_progress_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../../modal/getuserleagueresponse/GetUserLeagueResponse.dart';
import '../../utils/StringConstants.dart';
import '../duelmode/duelmoderesult/duelmode_result.dart';

class QuizPage extends StatefulWidget{

  const QuizPage({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}


class _State extends State<QuizPage> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  var username;
  var email;
  var country;
  var profilepic;
  var userid;

  var data;
  var userleagdata;
  var snackBar;
  GetUserLeagueResponse? userLeagueR;
  userdata() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString("username");
      country =prefs.getString("country");
      userid= prefs.getString("userid");
    });
    showLoaderDialog(context);
    getuserleague(userid.toString());
  }
  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: new Row(
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

  getuserleague(String userid) async {

    http.Response response = await http.get(
        Uri.parse(StringConstants.BASE_URL+"userleague?user_id=$userid")
    );
    Navigator.pop(context);
    var jsonResponse = convert.jsonDecode(response.body);
    if (response.statusCode == 200) {
      data = response.body;

      if (jsonResponse['status'] == 200) {
        setState(() {
          userleagdata = jsonDecode(
              data!)['data']; //get all the data from json string superheros
          print(userleagdata.length);
        });
        getuserleagueresponse(getUserLeagueResponseFromJson(data!));
        var venam = userleagdata(data!)['data'];
        print(venam.toString());
      } else {
        snackBar = SnackBar(
          content: Text(
              jsonResponse['message']),
        );
        ScaffoldMessenger.of(context)
            .showSnackBar(snackBar);
      }
    } else {

      // onsuccess(null);
      print(response.statusCode);
    }

  }
  getuserleagueresponse(GetUserLeagueResponse userLeagueResponse){
    if(userLeagueResponse.data!=null){
      setState(() {
        userLeagueR=userLeagueResponse;
      });
    }

  }
  @override
  void initState() {
    super.initState();
    BackButtonInterceptor.add(myInterceptor);
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
    return Scaffold(   key: _scaffoldKey,
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
          margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: ListView(
              children: [
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
                  margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
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
                          width: 160,
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
                                  builder: (context) =>  DuelModeMain()));
                        },
                        child: Container(
                          height: 150,
                          width: 160,
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
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 30),
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
                          width: 160,
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
                                  builder: (context) =>  TournamentPage()));
                        },
                        child: Container(
                          height: 150,
                          width: 160,
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


              userLeagueR!=null?  Container(
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
                    child: Container( margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                              child: Text("YOUR OVERALL PERFORMANCE",
                                style: TextStyle(color: ColorConstants.txt,fontSize: 12),textAlign: TextAlign.center,),
                            ),
                            if((userLeagueR!.data!.goalsummery!.play!/userLeagueR!.data!.goalsummery!.total!)<1)
                              Container(
                                  margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                  child: GFProgressBar(
                                    percentage:
                                    (userLeagueR!.data!.goalsummery!.play!/userLeagueR!.data!.goalsummery!.total!)*(0.3).toDouble(),
                                    lineHeight: 30,
                                    alignment: MainAxisAlignment.spaceBetween,
                                    child: Text('${userLeagueR!.data!.goalsummery!.play!} out of ${userLeagueR!.data!.goalsummery!.total}', textAlign: TextAlign.left,
                                      style: TextStyle(fontSize: 18, color: Colors.white),
                                    ),
                                    backgroundColor: Colors.black12,
                                    progressBarColor: ColorConstants.verdigris,
                                  )
                              ),
                            if((userLeagueR!.data!.goalsummery!.play!*100/userLeagueR!.data!.goalsummery!.total!)>=1)
                              Container(
                                  margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                  child: GFProgressBar(
                                    percentage:1.0,
                                    lineHeight: 20,
                                    alignment: MainAxisAlignment.spaceBetween,
                                    child: Text('${userLeagueR!.data!.goalsummery!.play!} out of ${userLeagueR!.data!.goalsummery!.total}', textAlign: TextAlign.left,
                                      style: TextStyle(fontSize: 14, color: Colors.white),
                                    ),
                                    backgroundColor: Colors.black12,
                                    progressBarColor: ColorConstants.verdigris,
                                  )
                              ),

                            Container(
                              child: Text("Quizzes Done",
                                style: TextStyle(color: Colors.grey,fontSize: 12),textAlign: TextAlign.center,),
                            ),
                          ]
                      ),
                    ),
                  ),
                ):Container(),
              ]
          ),
        ),
      ),
    );
  }
}
