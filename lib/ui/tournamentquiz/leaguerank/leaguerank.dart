import 'dart:convert';

import 'package:back_button_interceptor/back_button_interceptor.dart';

import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:CultreApp/colors/colors.dart';
import 'package:CultreApp/modal/xprewards/GetXPRewardsResponse.dart';

import 'package:CultreApp/ui/rightdrawer/right_drawer.dart';
import 'package:CultreApp/ui/tournamentquiz/seeleague/seeleague.dart';
import 'package:CultreApp/ui/tournamentquiz/tournament_quiz.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../utils/StringConstants.dart';

import 'package:CultreApp/ui/homepage/homepage.dart';
import 'dart:convert' as convert;

class LeagueRank extends StatefulWidget {
  LeagueRank({Key? key}) : super(key: key);

  @override
  LeagueRankState createState() => LeagueRankState();
}

class LeagueRankState extends State<LeagueRank> with TickerProviderStateMixin {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  var username;
  var email;
  var country;
  var profilepic;
  var userid;
  var xprewarddata;
  var data;
  var snackBar;
  GetXpRewardsResponse? xprewardsR;

  userdata() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString("username");
      country = prefs.getString("country");
      userid = prefs.getString("userid");
    });
    //showLoaderDialog(context);
    xprewards(userid.toString());
  }

  xprewards(String userid) async {
    http.Response response = await http
        .get(Uri.parse("${StringConstants.BASE_URL}xprewards?user_id=$userid"));
    var jsonResponse = convert.jsonDecode(response.body);
    if (response.statusCode == 200) {
      data = response.body;
      if (jsonResponse['status'] == 200) {
        //final responseJson = json.decode(response.body);//store response as string
        setState(() {
          xprewarddata = jsonDecode(
              data!)['data']; //get all the data from json string superheros
          print(xprewarddata.length);
          onsuccess(getXpRewardsResponseFromJson(data!));
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

  onsuccess(GetXpRewardsResponse? xpRewardsResponse) {
    if (xpRewardsResponse != null) {
      if (xpRewardsResponse.data != null) {
        setState(() {
          xprewardsR = xpRewardsResponse;
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
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) => TournamentPage(
              contents: "",
              themes: "",
              seldomain: "",
            )));
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
      endDrawer: const MySideMenuDrawer(),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/login_bg.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          color: Colors.white.withAlpha(100),
          margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: Stack(children: [
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                color: Colors.white,
                margin: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                height: 80,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(20, 10, 0, 10),
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.all(5),
                      child: Center(
                        child: Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: Center(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomePage()));
                              },
                              child: Image.asset(
                                "assets/images/home_1.png",
                                height: 40,
                                width: 40,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 10, 20, 10),
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 5.0),
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
              ),
            ),
            Container(
              alignment: const Alignment(0, 100),
              // height: MediaQuery.of(context).size.height-120,
              margin: const EdgeInsets.fromLTRB(20, 90, 20, 10),
              child: ListView(children: [
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
                    child: const Text(
                        "Compete with other players! Your result will be ranked in your current league. Increase your rank to reach progress through next leagues",
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                            fontFamily: "Nunito"))),
                const Divider(
                  thickness: 1,
                  height: 1,
                  color: Colors.black,
                ),
                xprewardsR == null
                    ? Container()
                    : Center(
                        child: ListBody(
                          children: [
                            Container(
                                alignment: Alignment.center,
                                margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                child: const Text("Your League",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontFamily: "Nunito"))),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            SeeLeague()));
                              },
                              child: Container(
                                margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: ColorConstants.red,
                                    borderRadius: BorderRadius.circular(20)),
                                width: width,
                                height: width - 70,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                        "${xprewardsR!.data!.yourLeage!.league}",
                                        style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.white,
                                            fontFamily: "Nunito")),
                                    Text(
                                        "${xprewardsR!.data!.yourLeage!.xp}XP REWARD",
                                        style: const TextStyle(
                                            fontSize: 22,
                                            color: Colors.white,
                                            fontFamily: "Nunito")),
                                    const Text("",
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.white,
                                            fontFamily: "Nunito")),
                                  ],
                                ),
                              ),
                            ),
                            const Divider(
                              thickness: 1,
                              height: 1,
                              color: Colors.black,
                            ),
                            Container(
                                alignment: Alignment.center,
                                margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                child: const Text("Other League",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontFamily: "Nunito"))),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            SeeLeague()));
                              },
                              child: Container(
                                margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: ColorConstants.stage5color,
                                    borderRadius: BorderRadius.circular(20)),
                                width: width,
                                height: width - 70,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                        "${xprewardsR!.data!.oleague1!.league}",
                                        style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.white,
                                            fontFamily: "Nunito")),
                                    Text(
                                        "${xprewardsR!.data!.oleague1!.xp}XP REWARD",
                                        style: const TextStyle(
                                            fontSize: 22,
                                            color: Colors.white,
                                            fontFamily: "Nunito")),
                                    const Text("",
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.white,
                                            fontFamily: "Nunito")),
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            SeeLeague()));
                              },
                              child: Container(
                                margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: ColorConstants.stage4color,
                                    borderRadius: BorderRadius.circular(20)),
                                width: width,
                                height: width - 70,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                        "${xprewardsR!.data!.oleague2!.league}",
                                        style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.white,
                                            fontFamily: "Nunito")),
                                    Text(
                                        "${xprewardsR!.data!.oleague2!.xp}XP REWARD",
                                        style: const TextStyle(
                                            fontSize: 22,
                                            color: Colors.white,
                                            fontFamily: "Nunito")),
                                    const Text("",
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.white,
                                            fontFamily: "Nunito")),
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            SeeLeague()));
                              },
                              child: Container(
                                margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Colors.orange,
                                    borderRadius: BorderRadius.circular(20)),
                                width: width,
                                height: width - 70,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                        "${xprewardsR!.data!.oleague3!.league}",
                                        style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.white,
                                            fontFamily: "Nunito")),
                                    Text(
                                        "${xprewardsR!.data!.oleague3!.xp}XP REWARD",
                                        style: const TextStyle(
                                            fontSize: 22,
                                            color: Colors.white,
                                            fontFamily: "Nunito")),
                                    const Text("",
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.white,
                                            fontFamily: "Nunito")),
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            SeeLeague()));
                              },
                              child: Container(
                                margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Colors.deepOrange,
                                    borderRadius: BorderRadius.circular(20)),
                                width: width,
                                height: width - 70,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                        "${xprewardsR!.data!.oleague4!.league}",
                                        style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.white,
                                            fontFamily: "Nunito")),
                                    Text(
                                        "${xprewardsR!.data!.oleague4!.xp}XP REWARD",
                                        style: const TextStyle(
                                            fontSize: 22,
                                            color: Colors.white,
                                            fontFamily: "Nunito")),
                                    const Text("",
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.white,
                                            fontFamily: "Nunito")),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                Container(
                  alignment: FractionalOffset.bottomCenter,
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
                                  builder: (context) => TournamentPage(
                                        seldomain: "",
                                        themes: "",
                                        contents: "",
                                      )));
                        },
                        child: const Text(
                          "GO BACK",
                          style: TextStyle(
                              color: ColorConstants.lightgrey200, fontSize: 14),
                          textAlign: TextAlign.center,
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
