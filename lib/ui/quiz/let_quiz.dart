
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
import 'package:flutterheritageolympiad/ui/quizroom/quizroominvite/quizroominvitepage.dart';
import 'package:flutterheritageolympiad/ui/quizroom/quizroommain/quizroom_main.dart';

import 'package:flutterheritageolympiad/ui/rightdrawer/right_drawer.dart';
import 'package:flutterheritageolympiad/ui/tournamentquiz/tournament_quiz.dart';
import 'package:flutterheritageolympiad/ui/homepage/welcomeback_page.dart';
import 'package:getwidget/components/progress_bar/gf_progress_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../../modal/getuserleagueresponse/GetUserLeagueResponse.dart';
import '../../utils/StringConstants.dart';
import '../duelmode/duelmodeinvite/invitepage.dart';
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
    showLoaderDialog(context);
    http.Response response = await http.get(
        Uri.parse(StringConstants.BASE_URL+"userleague?user_id=$userid")
    );

    var jsonResponse = convert.jsonDecode(response.body);
    if (response.statusCode == 200) {
      Navigator.pop(context);
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
      Navigator.pop(context);
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

var datalink;
  checkquiz(String userid,String type) async {
   showLoaderDialog(context);
    http.Response response = await http.post(
        Uri.parse(StringConstants.BASE_URL+"checkquiz"),body: {
          'user_id':userid.toString(),
          'type':type.toString()
    }
    );

    var jsonResponse = convert.jsonDecode(response.body);
    if (response.statusCode == 200) {
      Navigator.pop(context);
      data = response.body;

      if (jsonResponse['status'] == 200) {
        setState(() {
          datalink = jsonDecode(
              data!)['data']; //get all the data from json string superheros
          print(datalink.length);
        });
        linkshare(datalink.toString());
      } else if(jsonResponse['status'] == 201 || jsonResponse['status'] == 204){
       createnew();
      }
        else {
        snackBar = SnackBar(
          content: Text(
              jsonResponse['message']),
        );
        ScaffoldMessenger.of(context)
            .showSnackBar(snackBar);
      }
    } else {
      Navigator.pop(context);
      // onsuccess(null);
      print(response.statusCode);
    }

  }
  linkshare(String link){
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) =>DuelModeInvite(seldomain: [], quizspeedid: "", type: "", quiztypeid: "", quizid: "", difficultylevelid: "", link: link, typeq: 1,)));
  }
  createnew(){
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>  DuelModeMain(type: "2",)));
  }
  checkquizoom(String userid,String type) async {
    showLoaderDialog(context);
    http.Response response = await http.post(
        Uri.parse(StringConstants.BASE_URL+"checkquiz"),body: {
      'user_id':userid.toString(),
      'type':type.toString()
    }
    );

    var jsonResponse = convert.jsonDecode(response.body);
    if (response.statusCode == 200) {
      Navigator.pop(context);
      data = response.body;

      if (jsonResponse['status'] == 200) {
        setState(() {
          datalink = jsonDecode(
              data!)['data']; //get all the data from json string superheros
          print(datalink.length);
        });
        linkshare(datalink.toString());
      } else if(jsonResponse['status'] == 201 || jsonResponse['status'] == 204){
        createnew();
      }
      else {
        snackBar = SnackBar(
          content: Text(
              jsonResponse['message']),
        );
        ScaffoldMessenger.of(context)
            .showSnackBar(snackBar);
      }
    } else {
      Navigator.pop(context);
      // onsuccess(null);
      print(response.statusCode);
    }

  }
  roomlinkshare(String link){
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) =>QuizroomInvite(seldomain: [], quizspeedid: "", type: "", quiztypeid: "", quizid: "", difficultylevelid: "", link: link, typeq: 1,)));
  }
  createnewroom(){
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>  QuizRoomMain(type: "3",)));
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
                                      builder: (context) =>  WelcomePage()));
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
                    child: username==null?Text(""):Text("${username[0].toUpperCase()+username.substring(1)}",style: TextStyle(fontSize: 24,color: ColorConstants.txt))),
                Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: const Text("Leagues are available only in Tournament\nmode.",style: TextStyle(fontSize: 15,color: ColorConstants.txt))),
                Container(
                  //height: 300,
                  width: MediaQuery.of(context).size.width,
                  //alignment: Alignment.center,
                  margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
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
                           checkquiz(userid.toString(), "2");
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
                         checkquizoom(userid.toString(), "3");
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
                                  builder: (context) =>  TournamentPage()));
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
