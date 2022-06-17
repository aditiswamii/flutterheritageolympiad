import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:back_button_interceptor/back_button_interceptor.dart';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:flutter/services.dart';
import 'package:CultreApp/colors/colors.dart';
import 'package:CultreApp/modal/gettournament/GetTournamentResponse.dart';
import 'package:CultreApp/modal/leaguerank/GetLeagueRankResponse.dart';
import 'package:CultreApp/modal/xprewards/GetXPRewardsResponse.dart';
import 'package:CultreApp/ui/feed/filterpage/filterpage.dart';

import 'package:CultreApp/ui/rightdrawer/right_drawer.dart';
import 'package:CultreApp/ui/tournamentquiz/tournament_quiz.dart';
import 'package:getwidget/components/progress_bar/gf_progress_bar.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../utils/StringConstants.dart';

import 'package:CultreApp/ui/homepage/homepage.dart';
import 'dart:convert' as convert;

import '../leaguerank/leaguerank.dart';

class SeeLeague extends StatefulWidget {
  SeeLeague({Key? key}) : super(key: key);

  @override
  _SeeLeagueState createState() => _SeeLeagueState();
}

class _SeeLeagueState extends State<SeeLeague> with TickerProviderStateMixin {
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  var username;
  var email;
  var country;
  var profilepic;
  var userid;
  var xprewarddata;
  var data;
  var snackBar;
  var _expanded = false;
  GetLeagueRankResponse? leaguerankR;

  userdata() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString("username");
      country = prefs.getString("country");
      userid = prefs.getString("userid");
    });
    //showLoaderDialog(context);
    leaguerank(userid.toString());
  }

  leaguerank(String userid) async {
    http.Response response = await http.get(
        Uri.parse(StringConstants.BASE_URL + "leaguerank?user_id=$userid"));
    var jsonResponse = convert.jsonDecode(response.body);
    if (response.statusCode == 200) {
      data = response.body;
      if (jsonResponse['status'] == 200) {
        //final responseJson = json.decode(response.body);//store response as string
        setState(() {
          xprewarddata = jsonDecode(
              data!)['data']; //get all the data from json string superheros
          print(xprewarddata.length);
          onsuccess(getLeagueRankResponseFromJson(data!));
        });

        var venam = jsonDecode(data!)['data'];
        print(venam);
      } else {
        snackBar = SnackBar(
            content: Text(
          jsonResponse['message'].toString(),
          textAlign: TextAlign.center,
        ));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } else {
      print(response.statusCode);
    }
  }

  onsuccess(GetLeagueRankResponse leaguerankResponse) {
    if (leaguerankResponse != null) {
      if (leaguerankResponse.data != null) {
        setState(() {
          leaguerankR = leaguerankResponse;
        });
      }
    }
  }

  // showLoaderDialog(BuildContext context) {
  //   AlertDialog alert = AlertDialog(
  //     content: new Row(
  //       children: [
  //         CircularProgressIndicator(),
  //         Container(
  //             margin: EdgeInsets.only(left: 7), child: Text("Loading...")),
  //       ],
  //     ),
  //   );
  //   showDialog(
  //     barrierDismissible: false,
  //     context: context,
  //     builder: (BuildContext context) {
  //       return alert;
  //     },
  //   );
  // }
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
        MaterialPageRoute(builder: (BuildContext context) => LeagueRank()));
    // Do some stuff.
    return true;
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
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
        child: Container(
          color: Colors.white.withAlpha(100),
          margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: ListView(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 5.0),
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => HomePage()));
                    },
                    child: Image.asset("assets/images/home_1.png",
                        height: 40, width: 40),
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
                    child: Image.asset("assets/images/side_menu_2.png",
                        height: 40, width: 40),
                  ),
                ),
              ],
            ),
            Container(
              color: Colors.white,
              child: ListBody(children: [
                Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: const Text("LEAGUE RANKS",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontFamily: "Nunito"))),
                Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.fromLTRB(0, 5, 0, 10),
                    child: Text(
                        "Compete with other players! Your result will be ranked in your current league. Increase your rank to reach progress through next leagues",
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                            fontFamily: "Nunito"))),
                Divider(
                  thickness: 1,
                  height: 1,
                  color: Colors.black,
                ),
                leaguerankR == null
                    ? Container()
                    : Center(
                        child: ListBody(
                          children: [
                            Container(
                                alignment: Alignment.center,
                                margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                child: const Text("Your League",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontFamily: "Nunito"))),
                            Container(
                              margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),

                              decoration: BoxDecoration(color: Colors.white),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  // if you need this
                                  side: BorderSide(
                                    color: Colors.grey.withOpacity(0.3),
                                    width: 1,
                                  ),
                                ),
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  child: ListBody(
                                    children: [
                                      Center(
                                        child: Text("${leaguerankR!.data!.yourLeage!.leagueName}", style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black,
                                            fontFamily: "Nunito")),
                                      ),
                                      Center(
                                        child: Text("Top 5 will be move to next league next week", style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.black,
                                            fontFamily: "Nunito")),

                                      ),
                                      Container(
                                          child:
                                          ListView.builder(
                                              physics: ClampingScrollPhysics(
                                                  parent: BouncingScrollPhysics()),
                                              shrinkWrap: true,
                                              itemCount: leaguerankR!.data!.yourLeage!.top!.length,
                                              itemBuilder:
                                                  (BuildContext context, int index) {
                                                return Container(
                                                    margin: EdgeInsets.fromLTRB(
                                                        10, 10, 10, 10),
                                                    child: GFProgressBar(

                                                      percentage: double.parse(
                                                          (int.parse(leaguerankR!.data!.yourLeage!.top![index].percentage.toString()) /
                                                              100).toString()),
                                                      lineHeight: 30,
                                                      // alignment: MainAxisAlignment.spaceBetween,

                                                      backgroundColor: ColorConstants.lightgrey200,
                                                      child: Container(child: Align(
                                                        alignment: Alignment.centerLeft,
                                                        child: Text("${leaguerankR!.data!.yourLeage!.top![index].rank}", style: TextStyle(
                                                            fontSize: 12,
                                                            color: Colors.white,
                                                            fontFamily: "Nunito",fontWeight: FontWeight.w600)),
                                                      )),

                                                      progressBarColor:int.parse(leaguerankR!.data!.yourLeage!.top![index].percentage.toString())<10?ColorConstants.stage1color: int.parse(leaguerankR!.data!.yourLeage!.top![index].percentage.toString())<49?ColorConstants.stage2color:int.parse(leaguerankR!.data!.yourLeage!.top![index].percentage.toString())==50?ColorConstants.stage2color:int.parse(leaguerankR!.data!.yourLeage!.top![index].percentage.toString())<50?ColorConstants.stage3color:int.parse(leaguerankR!.data!.yourLeage!.top![index].percentage.toString())<90?ColorConstants.stage3color:int.parse(leaguerankR!.data!.yourLeage!.top![index].percentage.toString())<=100?ColorConstants.stage4color:ColorConstants.stage5color,
                                                    ));
                                              })),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                              child: Divider(
                                thickness: 1,
                                height: 1,
                                color: Colors.black,
                              ),
                            ),
                            Container(
                                alignment: Alignment.center,
                                margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                child: const Text("Other League",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontFamily: "Nunito"))),
                            Container(
                              margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),

                              decoration: BoxDecoration(color: Colors.white),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  // if you need this
                                  side: BorderSide(
                                    color: Colors.grey.withOpacity(0.3),
                                    width: 1,
                                  ),
                                ),
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  child: ListBody(
                                    children: [
                                      Center(
                                        child: Text("${leaguerankR!.data!.oleague1!.leagueName}", style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black,
                                            fontFamily: "Nunito")),
                                      ),
                                      if(leaguerankR!.data!.oleague1!.data==null)
                                      Center(
                                        child: Text("Top 5 will be move to next league next week", style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.black,
                                            fontFamily: "Nunito")),

                                      ),
                                      if(leaguerankR!.data!.oleague1!.data!=null)
                                      Container(
                                          child:
                                          ListView.builder(
                                              physics: ClampingScrollPhysics(
                                                  parent: BouncingScrollPhysics()),
                                              shrinkWrap: true,
                                              itemCount: leaguerankR!.data!.oleague1!.data!.length,
                                              itemBuilder:
                                                  (BuildContext context, int index) {
                                                return Container(
                                                    margin: EdgeInsets.fromLTRB(
                                                        10, 10, 10, 10),
                                                    child: GFProgressBar(

                                                      percentage: double.parse(
                                                          (int.parse(leaguerankR!.data!.oleague1!.data![index].percentage.toString()) /
                                                              100).toString()),
                                                      lineHeight: 30,
                                                      // alignment: MainAxisAlignment.spaceBetween,

                                                      backgroundColor: ColorConstants.lightgrey200,
                                                      child: Container(child: Align(
                                                        alignment: Alignment.centerLeft,
                                                        child: Text("${leaguerankR!.data!.oleague1!.data![index].rank}", style: TextStyle(
                                                            fontSize: 12,
                                                            color: Colors.white,
                                                            fontFamily: "Nunito",fontWeight: FontWeight.w600)),
                                                      )),

                                                      progressBarColor:int.parse(leaguerankR!.data!.oleague1!.data![index].percentage.toString())<10?ColorConstants.stage1color: int.parse(leaguerankR!.data!.oleague1!.data![index].percentage.toString())<49?ColorConstants.stage2color:int.parse(leaguerankR!.data!.oleague1!.data![index].percentage.toString())==50?ColorConstants.stage2color:int.parse(leaguerankR!.data!.oleague1!.data![index].percentage.toString())<50?ColorConstants.stage3color:int.parse(leaguerankR!.data!.oleague1!.data![index].percentage.toString())<90?ColorConstants.stage3color:int.parse(leaguerankR!.data!.oleague1!.data![index].percentage.toString())<=100?ColorConstants.stage4color:ColorConstants.stage5color,
                                                    ));
                                              })),
                                    ],
                                  ),

                                ),

                              ),
                            ),

    Container(
    margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),

    decoration: BoxDecoration(color: Colors.white),
    child: Card(
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10),
    // if you need this
    side: BorderSide(
    color: Colors.grey.withOpacity(0.3),
    width: 1,
    ),
    ),
    child: Container(
    padding: EdgeInsets.all(10),
    child: ListBody(
    children: [
    Center(
    child: Text("${leaguerankR!.data!.oleague2!.leagueName}", style: TextStyle(
    fontSize: 14,
    color: Colors.black,
    fontFamily: "Nunito")),
    ),
    if(leaguerankR!.data!.oleague2!.data==null)
    Center(
    child: Text("Top 5 will be move to next league next week", style: TextStyle(
    fontSize: 12,
    color: Colors.black,
    fontFamily: "Nunito")),

    ),
    if(leaguerankR!.data!.oleague2!.data!=null)
    Container(
    child:
    ListView.builder(
    physics: ClampingScrollPhysics(
    parent: BouncingScrollPhysics()),
    shrinkWrap: true,
    itemCount: leaguerankR!.data!.oleague2!.data!.length,
    itemBuilder:
    (BuildContext context, int index) {
    return Container(
    margin: EdgeInsets.fromLTRB(
    10, 10, 10, 10),
    child: GFProgressBar(

    percentage: double.parse(
    (int.parse(leaguerankR!.data!.oleague2!.data![index].percentage.toString()) /
    100).toString()),
    lineHeight: 30,
    // alignment: MainAxisAlignment.spaceBetween,

    backgroundColor: ColorConstants.lightgrey200,
    child: Container(child: Align(
    alignment: Alignment.centerLeft,
    child: Text("${leaguerankR!.data!.oleague2!.data![index].rank}", style: TextStyle(
    fontSize: 12,
    color: Colors.white,
    fontFamily: "Nunito",fontWeight: FontWeight.w600)),
    )),

    progressBarColor:int.parse(leaguerankR!.data!.oleague2!.data![index].percentage.toString())<10?ColorConstants.stage1color: int.parse(leaguerankR!.data!.oleague2!.data![index].percentage.toString())<49?ColorConstants.stage2color:int.parse(leaguerankR!.data!.oleague2!.data![index].percentage.toString())==50?ColorConstants.stage2color:int.parse(leaguerankR!.data!.oleague2!.data![index].percentage.toString())<50?ColorConstants.stage3color:int.parse(leaguerankR!.data!.oleague2!.data![index].percentage.toString())<90?ColorConstants.stage3color:int.parse(leaguerankR!.data!.oleague2!.data![index].percentage.toString())<=100?ColorConstants.stage4color:ColorConstants.stage5color,
    ));
    })),
    ],
    ),

    ),
    ),
    ),
                            Container(
                              margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),

                              decoration: BoxDecoration(color: Colors.white),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  // if you need this
                                  side: BorderSide(
                                    color: Colors.grey.withOpacity(0.3),
                                    width: 1,
                                  ),
                                ),
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  child: ListBody(
                                    children: [
                                      Center(
                                        child: Text("${leaguerankR!.data!.oleague3!.leagueName}", style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black,
                                            fontFamily: "Nunito")),
                                      ),
                                      if(leaguerankR!.data!.oleague3!.data==null)
                                        Center(
                                          child: Text("Top 5 will be move to next league next week", style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black,
                                              fontFamily: "Nunito")),

                                        ),
                                      if(leaguerankR!.data!.oleague3!.data!=null)
                                        Container(
                                            child:
                                            ListView.builder(
                                                physics: ClampingScrollPhysics(
                                                    parent: BouncingScrollPhysics()),
                                                shrinkWrap: true,
                                                itemCount: leaguerankR!.data!.oleague3!.data!.length,
                                                itemBuilder:
                                                    (BuildContext context, int index) {
                                                  return Container(
                                                      margin: EdgeInsets.fromLTRB(
                                                          10, 10, 10, 10),
                                                      child: GFProgressBar(

                                                        percentage: double.parse(
                                                            (int.parse(leaguerankR!.data!.oleague3!.data![index].percentage.toString()) /
                                                                100).toString()),
                                                        lineHeight: 30,
                                                        // alignment: MainAxisAlignment.spaceBetween,

                                                        backgroundColor: ColorConstants.lightgrey200,
                                                        child: Container(child: Align(
                                                          alignment: Alignment.centerLeft,
                                                          child: Text("${leaguerankR!.data!.oleague3!.data![index].rank}", style: TextStyle(
                                                              fontSize: 12,
                                                              color: Colors.white,
                                                              fontFamily: "Nunito",fontWeight: FontWeight.w600)),
                                                        )),

                                                        progressBarColor:int.parse(leaguerankR!.data!.oleague3!.data![index].percentage.toString())<10?ColorConstants.stage1color: int.parse(leaguerankR!.data!.oleague3!.data![index].percentage.toString())<49?ColorConstants.stage2color:int.parse(leaguerankR!.data!.oleague3!.data![index].percentage.toString())==50?ColorConstants.stage2color:int.parse(leaguerankR!.data!.oleague3!.data![index].percentage.toString())<50?ColorConstants.stage3color:int.parse(leaguerankR!.data!.oleague3!.data![index].percentage.toString())<90?ColorConstants.stage3color:int.parse(leaguerankR!.data!.oleague3!.data![index].percentage.toString())<=100?ColorConstants.stage4color:ColorConstants.stage5color,
                                                      ));
                                                })),
                                    ],
                                  ),

                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),

                              decoration: BoxDecoration(color: Colors.white),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  // if you need this
                                  side: BorderSide(
                                    color: Colors.grey.withOpacity(0.3),
                                    width: 1,
                                  ),
                                ),
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  child: ListBody(
                                    children: [
                                      Center(
                                        child: Text("${leaguerankR!.data!.oleague4!.leagueName}", style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black,
                                            fontFamily: "Nunito")),
                                      ),
                                      if(leaguerankR!.data!.oleague4!.data==null)
                                        Center(
                                          child: Text("Top 5 will be move to next league next week", style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black,
                                              fontFamily: "Nunito")),

                                        ),
                                      if(leaguerankR!.data!.oleague4!.data!=null)
                                        Container(
                                            child:
                                            ListView.builder(
                                                physics: ClampingScrollPhysics(
                                                    parent: BouncingScrollPhysics()),
                                                shrinkWrap: true,
                                                itemCount: leaguerankR!.data!.oleague4!.data!.length,
                                                itemBuilder:
                                                    (BuildContext context, int index) {
                                                  return Container(
                                                      margin: EdgeInsets.fromLTRB(
                                                          10, 10, 10, 10),
                                                      child: GFProgressBar(

                                                        percentage: double.parse(
                                                            (int.parse(leaguerankR!.data!.oleague4!.data![index].percentage.toString()) /
                                                                100).toString()),
                                                        lineHeight: 30,
                                                        // alignment: MainAxisAlignment.spaceBetween,

                                                        backgroundColor: ColorConstants.lightgrey200,
                                                        child: Container(child: Align(
                                                          alignment: Alignment.centerLeft,
                                                          child: Text("${leaguerankR!.data!.oleague4!.data![index].rank}", style: TextStyle(
                                                              fontSize: 12,
                                                              color: Colors.white,
                                                              fontFamily: "Nunito",fontWeight: FontWeight.w600)),
                                                        )),

                                                        progressBarColor:int.parse(leaguerankR!.data!.oleague4!.data![index].percentage.toString())<10?ColorConstants.stage1color: int.parse(leaguerankR!.data!.oleague4!.data![index].percentage.toString())<49?ColorConstants.stage2color:int.parse(leaguerankR!.data!.oleague4!.data![index].percentage.toString())==50?ColorConstants.stage2color:int.parse(leaguerankR!.data!.oleague4!.data![index].percentage.toString())<50?ColorConstants.stage3color:int.parse(leaguerankR!.data!.oleague4!.data![index].percentage.toString())<90?ColorConstants.stage3color:int.parse(leaguerankR!.data!.oleague4!.data![index].percentage.toString())<=100?ColorConstants.stage4color:ColorConstants.stage5color,
                                                      ));
                                                })),
                                    ],
                                  ),

                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

              ]),
            ),
          ]),
        ),
      ),
    );
  }
}
