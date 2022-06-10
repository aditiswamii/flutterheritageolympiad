import 'dart:convert';
import 'dart:developer';


import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:CultreApp/colors/colors.dart';
import 'package:CultreApp/modal/getduelresult/GetDuelResultResponse.dart';
import 'package:CultreApp/modal/tourroomlist/GetTourRoomlist.dart';
import 'package:CultreApp/ui/duelmode/answerkey/answerkeyduel.dart';

import 'package:CultreApp/ui/quiz/let_quiz.dart';
import 'package:CultreApp/ui/rightdrawer/right_drawer.dart';
import 'package:CultreApp/ui/tournamentquiz/tournament_quiz.dart';

import 'package:getwidget/components/progress_bar/gf_progress_bar.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/StringConstants.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

import '../../mcq/mcq.dart';

class TourRoomWaitlist extends StatefulWidget {
  int? tourid;
  int? sessionid;
  String type="";
  TourRoomWaitlist({Key? key, required this.tourid,required this.sessionid,required this.type}) : super(key: key);

  @override
  _State createState() => _State();
}


class _State extends State<TourRoomWaitlist> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();

  var username;
  var email;
  var country;
  var profilepic;
  var userid;
  var data;
  var roomdata;
  var snackbar;
  String packagename="";
  PackageInfo? packageInfo;

  var duelresultr;
  GetTourRoomlist? getTourRoomlistt;

  userdata() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString("username");
      country = prefs.getString("country");
      userid = prefs.getString("userid");
    });
    print("userdata");
    //calTheme();

    //getTourRoom(widget.tourid, widget.sessionid);
    getTourRoom(widget.tourid!, widget.sessionid!);
    // getFeed(userid.toString(), "0", "", "", "");
  }

  getTourRoom(int tournamentId, int sessionId) async {
    http.Response response = await http.post(
        Uri.parse(StringConstants.BASE_URL + "tournamentuserlist"),
        body: {'tournament_id': tournamentId.toString(), 'session_id': sessionId.toString()});
    showLoaderDialog(context);

    print("getTourRoomapi");
    var jsonResponse = convert.jsonDecode(response.body);
    if (response.statusCode == 200) {
      Navigator.pop(context);
      data = response.body;
      if (jsonResponse['status'] == 200) {
        //final responseJson = json.decode(response.body);//store response as string
        roomdata = jsonResponse[
        'data']; //get all the data from json string superheros
        print("length" + roomdata.length.toString());

        onsuccess(getTourRoomlistFromJson(data));
      } else {
       // onsuccess(null);
        log(jsonResponse['message']);
      }
    } else {
      Navigator.pop(context);
      print(response.statusCode);
    }
  }

  onsuccess(GetTourRoomlist? tourRoomlistn) {
    log("log" + tourRoomlistn.toString());
    if (tourRoomlistn != null) {
      setState(() {
        getTourRoomlistt = tourRoomlistn;
      });
      print("getdueljsonsuccess" + getTourRoomlistt.toString());

    }
  }

  exittour(String userid,int tournamentId, int sessionId) async {
    http.Response response = await http.post(
        Uri.parse(StringConstants.BASE_URL + "exitfromtournament"),
        body: {
          'user_id': userid.toString(),
          'tournament_id': tournamentId.toString(),
          'session_id': sessionId.toString()});


    print("getTourRoomapi");
    var jsonResponse = convert.jsonDecode(response.body);
    if (response.statusCode == 200) {

      data = response.body;
      if (jsonResponse['status'] == 200) {
        snackbar = SnackBar(
            content: Text(
              jsonResponse['message'].toString(),
              textAlign: TextAlign.center,));
        ScaffoldMessenger.of(context)
            .showSnackBar(snackbar);

        onexittour();

      } else {
        snackbar = SnackBar(
            content: Text(
              jsonResponse['message'].toString(),
              textAlign: TextAlign.center,));
        ScaffoldMessenger.of(context)
            .showSnackBar(snackbar);
        log(jsonResponse['message']);
      }
    } else {

      print(response.statusCode);
    }
  }

  onexittour() {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => TournamentPage()));
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
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => TournamentPage()));
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
       color: ColorConstants.red,
        child: Container(
          margin: EdgeInsets.fromLTRB(0, 40, 0, 0),
          child: Stack(
          //  mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
         Container(
           margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
          alignment: Alignment.topRight,
         child: Image.asset("assets/images/pattern1.png",height: 30,width: 30,),
          ),
              Container(
                alignment: Alignment.topLeft,
                child: Image.asset("assets/images/pattern1.png",height: 30,width: 30,),
              ),
              Container(

                  alignment: Alignment.topCenter,
                  margin: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                  child: const Text(
                    "Tournament Start In",
                    style: TextStyle(fontSize: 18, color: Colors.white,fontStyle: FontStyle.normal),
                    textAlign: TextAlign.center,
                  )),

              getTourRoomlistt==null? Center(
    child: Container(

    ),
    )
        :  Container(
                margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Column(
            children: [
              Container(
                alignment: Alignment.topCenter,
                width: 130,
                margin: EdgeInsets.fromLTRB(0,60,0,0),
                child: Center(
                    child: Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      elevation: 2,
                      child: Container(

                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(  margin: EdgeInsets.fromLTRB(0,0,0,0),
                                child: Image.asset("assets/images/clock_green.png",width: 20,height: 20,color: ColorConstants.red,)),
                            Container(
                              child: TweenAnimationBuilder<Duration>(
                                  duration:   Duration(seconds:getTourRoomlistt!.remaningtimestamp!),
                                  tween: Tween(begin:  Duration(seconds:getTourRoomlistt!.remaningtimestamp! ),
                                      end: Duration.zero),
                                  onEnd: () {
                                    log("sessid:",error: {widget.sessionid.toString()});
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>  Mcq(quizid:"", type: widget.type, tourid: widget.tourid, sessionid: widget.sessionid,)));

                                  },
                                  builder: (BuildContext context, Duration value, Widget? child) {
                                    String strDigits(int n) => n.toString().padLeft(2, '0');
                                    final minutes =  strDigits(value.inMinutes.remainder(1000)) ;
                                    final seconds = strDigits(value.inSeconds.remainder(60));
                                    return Container(
                                      height: 40,width: 80,
                                      padding:  const EdgeInsets.all(5),
                                      alignment: Alignment.center,
                                      child: Text(
                                        '$minutes:$seconds',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: ColorConstants.red,
                                            fontSize: 18,fontStyle: FontStyle.normal),
                                      ),);
                                  }),
                            ),

                            SizedBox(height: 20),

                          ],
                        ),
                      ),
                    )),
              ),
              Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: const Text(
                    "PLAYER JOINED....",
                    style: TextStyle(fontSize: 18, color: Colors.white,fontStyle: FontStyle.normal),
                    textAlign: TextAlign.center,
                  )),
              Container(
    margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
    child: ListView.builder(
    physics: ClampingScrollPhysics(
    parent: BouncingScrollPhysics()),
    shrinkWrap: true,
    itemCount:  getTourRoomlistt!.data!.length,
    itemBuilder: (BuildContext context, int index) {
      return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                  // if you need this
                  side: BorderSide(
                    color: Colors.grey.withOpacity(0.2),
                    width: 1,
                  ),
                ),
                child: Container(margin: const EdgeInsets.fromLTRB(
                    10, 10, 10, 10),
                    child: ListBody(
                      children: [
                       Container(
                         child: Row(
                           children: [
                             Container(
                               alignment: Alignment
                                   .centerLeft,
                               height: 80,
                               width: 80,
                               child: CircleAvatar(
                                 radius: 80.0,
                                 backgroundImage: NetworkImage(
                                     getTourRoomlistt!.data![index].image.toString()),
                                 backgroundColor:
                                 Colors
                                     .transparent,
                               ),
                             ),
                  Container(
                    width: 170,
                    margin: EdgeInsets.fromLTRB(10, 10, 20, 10),
                    child: Column(
                      children: [
                        Container(alignment: Alignment.centerLeft,
                          child: Text("${ getTourRoomlistt!.data![index].name}",style: TextStyle(
                              color: ColorConstants.txt,
                              fontSize: 16,fontStyle: FontStyle.normal),
                            textAlign: TextAlign.center,),
                        ),
                        Container(
                          height: 20,
                          width: 170,
                          child: Row(
                            children: [
                              if( getTourRoomlistt!.data![index].ageGroup!.isNotEmpty)
                                Text("${getTourRoomlistt!.data![index].ageGroup}",style: TextStyle(
                                    color: ColorConstants.txt,
                                    fontSize: 14,fontStyle: FontStyle.normal),
                                  textAlign: TextAlign.center,),
                              Container(  margin: EdgeInsets.only(left:5,right: 5),
                                  child: VerticalDivider(color: Colors.black,thickness: 1,width: 1,)),
                              // Text("|"),
                              Row(

                                children: [
                                  if(getTourRoomlistt!.data![index].flagIcon!.isNotEmpty)
                                    Container(
                                        height: 20,width: 20,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle
                                        ),
                                        child:
                                        CircleAvatar(
                                          radius: 20.0,
                                          backgroundImage:
                                          NetworkImage("${getTourRoomlistt!.data![index].flagIcon}"),
                                          backgroundColor: Colors.transparent,
                                        )
                                    ),
                                  if(getTourRoomlistt!.data![index].country!.isNotEmpty)
                                    Container(
                                      margin: EdgeInsets.only(left:5),
                                      width: 70,
                                      child: Text("${getTourRoomlistt!.data![index].country}",style: TextStyle(
                                          color: ColorConstants.txt,
                                          fontSize: 14,fontStyle: FontStyle.normal),
                                        textAlign: TextAlign.left,),
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ),
                           ],
                         ),
                       )

                      ],
                    ),
      ),
      ]
                    )
                ));
    }
    )
    ),
            ],
          ),
        ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 60),
                alignment: Alignment.bottomLeft,
                child: Image.asset("assets/images/mcq_pattern_3.png",height: 60,width: 60,),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 40),
                alignment: Alignment.bottomRight,
                child: Image.asset("assets/images/mcq_pattern_3.png",height: 70,width: 70,),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                margin: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: ColorConstants.red,
                        onPrimary: Colors.white,
                        elevation: 3,
                        side: BorderSide(width: 1.0, color: Colors.white,),
                        shadowColor: Colors.white,
                        alignment: Alignment.center,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0)),
                        fixedSize: const Size(120, 30),
                        //////// HERE
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TournamentPage()));
                      },
                      child: const Text(
                        "GO BACK",
                        style: TextStyle(
                            color:  Colors.white, fontSize: 12,fontStyle: FontStyle.normal),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: ColorConstants.red,
                        onPrimary: Colors.white,
                        elevation: 3,
                        side: BorderSide(width: 1.0, color: Colors.white,),
                        shadowColor: Colors.white,
                        alignment: Alignment.center,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0)),
                        fixedSize: const Size(120, 30),
                        //////// HERE
                      ),
                      onPressed: () {
                       exittour(userid.toString(), widget.tourid!, widget.sessionid!);
                      },
                      child: const Text(
                        "EXIT WAITROOM",
                        style: TextStyle(
                            color: Colors.white, fontSize: 12,fontFamily: 'Nunito',fontStyle: FontStyle.normal),
                        textAlign: TextAlign.center,
                      ),
                    ),
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
