import 'dart:convert';
import 'dart:developer';
import 'dart:ffi';
import 'dart:ffi';

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterheritageolympiad/colors/colors.dart';
import 'package:flutterheritageolympiad/modal/getduelresult/GetDuelResultResponse.dart';
import 'package:flutterheritageolympiad/ui/classicquiz/answerkey/answerkey.dart';
import 'package:flutterheritageolympiad/ui/duelmode/answerkey/answerkeyduel.dart';

import 'package:flutterheritageolympiad/ui/quiz/let_quiz.dart';
import 'package:flutterheritageolympiad/ui/rightdrawer/right_drawer.dart';
import 'package:flutterheritageolympiad/ui/homepage/welcomeback_page.dart';
import 'package:getwidget/components/progress_bar/gf_progress_bar.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/StringConstants.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class QuizroomResult extends StatefulWidget {
  var quizid;
  var type;
  QuizroomResult({Key? key, required this.quizid,required this.type}) : super(key: key);

  @override
  _State createState() => _State();
}

const TWO_PI = 3.14 * 2;

class _State extends State<QuizroomResult> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool value = false;
  late double progressValue;
  final size = 200.0;
  var username;
  var email;
  var country;
  var profilepic;
  var userid;
  var data;
  var resultdata;
  var jsonres;
  var jsonuser;
  String packagename="";
  PackageInfo? packageInfo;
  //GetDuelResultResponse? duelresultr;
  var roomresultr;

  userdata() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString("username");
      country = prefs.getString("country");
      userid = prefs.getString("userid");
    });
    print("userdata");
    //calTheme();

    getDuelResult(userid.toString(), widget.quizid.toString());

    // getFeed(userid.toString(), "0", "", "", "");
  }
  void getPackage() async {
    packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      packagename = packageInfo!.packageName;
    });
    String appName = packageInfo!.appName;
    packagename = packageInfo!.packageName;
    String version = packageInfo!.version;
    String buildNumber = packageInfo!.buildNumber;
    setState(() {
      packagename = packageInfo!.packageName;
    });
    print("App Name : ${appName}, App Package Name: ${packagename },App Version: ${version}, App build Number: ${buildNumber}");
  }
  getDuelResult(String userid, String room_id) async {
    http.Response response = await http.post(
        Uri.parse(StringConstants.BASE_URL + "get_room_result"),
        body: {'user_id': userid.toString(), 'room_id': room_id.toString()});
    showLoaderDialog(context);

    print("getroomResultapi");
    var jsonResponse = convert.jsonDecode(response.body);
    if (response.statusCode == 200) {
      Navigator.pop(context);
      data = response.body;
      if (jsonResponse['status'] == 200) {
        //final responseJson = json.decode(response.body);//store response as string
        resultdata = jsonResponse[
            'result']; //get all the data from json string superheros
        print("length" + resultdata.length.toString());
        print("resdata" + jsonResponse['result'].toString());
        print("resdata" + jsonResponse['result'][0].toString());
        // print("getduelresult"+getDuelResultResponseFromJson(data!).result.toString());
        onsuccess(jsonResponse);

        // print("getduelresult"+getDuelResultResponseFromJson(data!).result.toString());
        // var venam = jsonDecode(data!)['result'][0]['name'];
        // print("name"+venam.toString());
        // log("name"+venam.toString());

      } else {
        onsuccess(null);
        log(jsonResponse['message']);
      }
    } else {
      Navigator.pop(context);
      print(response.statusCode);
    }
  }

  onsuccess(jsonResponse) {
    log("log" + jsonResponse.toString());
    if (jsonResponse != null) {
      setState(() {
        roomresultr = jsonResponse;
      });
      print("getdueljsonsuccess" + roomresultr.toString());
      print("getdueljsonsuccessuser" + roomresultr['user_data'].toString());
    }
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
    getPackage();
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
        child: Container(
          color: Colors.white.withAlpha(100),
          margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: ListView(
            children: <Widget>[
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
                  alignment: Alignment.center,
                  margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: const Text(
                    "YOU\nSCORED....",
                    style: TextStyle(fontSize: 24, color: ColorConstants.txt),
                    textAlign: TextAlign.center,
                  )),
              roomresultr != null
                  ? Container(
                      decoration: BoxDecoration(shape: BoxShape.circle),
                      margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                      alignment: Alignment.topCenter,
                      child: SizedBox(
                        height: 150,
                        width: 150,
                        child: Stack(
                          children: <Widget>[
                            SizedBox(
                              child: Center(
                                child: Container(
                                  height: 150,
                                  width: 150,
                                  child: CircularProgressIndicator(
                                    value: 0.02,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.orange,
                                    ),
                                    color: Colors.red,
                                    backgroundColor: Colors.red,
                                    strokeWidth: 20,
                                  ),
                                ),
                              ),
                            ),
                            FlipCard(
                              controller: FlipCardController(),
                              direction: FlipDirection.HORIZONTAL,
                              front: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Center(
                                      child: Text(
                                    "${roomresultr['user_data']['xp'].toString()} XP",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600),
                                  )),
                                  if (double.parse(roomresultr['user_data']
                                                  ['percentage']
                                              .toString()) >
                                          0.0 &&
                                      double.parse(roomresultr['user_data']
                                                  ['percentage']
                                              .toString()) <
                                          10.0)
                                    Center(child: Text("oh boy!")),
                                  if (double.parse(roomresultr['user_data']
                                                  ['percentage']
                                              .toString()) >
                                          10.0 &&
                                      double.parse(roomresultr['user_data']
                                                  ['percentage']
                                              .toString()) <
                                          50.0)
                                    Center(child: Text("Don't give up!")),
                                  if (double.parse(roomresultr['user_data']
                                              ['percentage']
                                          .toString()) ==
                                      50.0)
                                    Center(
                                        child: Text("Practice makes perfect!")),
                                  if (double.parse(roomresultr['user_data']
                                                  ['percentage']
                                              .toString()) >
                                          50.0 &&
                                      double.parse(roomresultr['user_data']
                                                  ['percentage']
                                              .toString()) <=
                                          90.0)
                                    Center(child: Text("Almost there!")),
                                  if (double.parse(roomresultr['user_data']
                                                  ['percentage']
                                              .toString()) >
                                          90.0 &&
                                      double.parse(roomresultr['user_data']
                                                  ['percentage']
                                              .toString()) <=
                                          100.0)
                                    Center(child: Text("Keep it up!")),
                                ],
                              ),
                              back: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Center(
                                      child: Text(
                                          "${roomresultr['user_data']['percentage'].toString()} %",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600))),
                                  if (double.parse(roomresultr['user_data']
                                                  ['percentage']
                                              .toString()) >
                                          0.0 &&
                                      double.parse(roomresultr['user_data']
                                                  ['percentage']
                                              .toString()) <
                                          10.0)
                                    Center(child: Text("oh boy!")),
                                  if (double.parse(roomresultr['user_data']
                                                  ['percentage']
                                              .toString()) >
                                          10.0 &&
                                      double.parse(roomresultr['user_data']
                                                  ['percentage']
                                              .toString()) <
                                          50.0)
                                    Center(child: Text("Don't give up!")),
                                  if (double.parse(roomresultr['user_data']
                                              ['percentage']
                                          .toString()) ==
                                      50.0)
                                    Center(
                                        child: Text("Practice makes perfect!")),
                                  if (double.parse(roomresultr['user_data']
                                                  ['percentage']
                                              .toString()) >
                                          50.0 &&
                                      double.parse(roomresultr['user_data']
                                                  ['percentage']
                                              .toString()) <=
                                          90.0)
                                    Center(child: Text("Almost there!")),
                                  if (double.parse(roomresultr['user_data']
                                                  ['percentage']
                                              .toString()) >
                                          90.0 &&
                                      double.parse(roomresultr['user_data']
                                                  ['percentage']
                                              .toString()) <=
                                          100.0)
                                    Center(child: Text("Keep it up!")),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ))
                  : Container(),
              roomresultr != null
                  ? Container(
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
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
                              child: Text(
                                "YOU SCORED...",
                                style: TextStyle(color: ColorConstants.txt),
                              ),
                            ),
                            roomresultr == null
                                ? Center(
                                    child: Container(),
                                  )
                                : Container(

                                    margin:
                                        const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                    child: ListView.builder(
                                        physics: ClampingScrollPhysics(
                                            parent: BouncingScrollPhysics()),
                                        shrinkWrap: true,
                                        itemCount: roomresultr['result'].length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Container(
                                              margin: EdgeInsets.fromLTRB(
                                                  10, 10, 10, 10),
                                              child: GFProgressBar(
                                                // leading: Container(
                                                //   // padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                                //   height: 30,
                                                //   width: 30,
                                                //   child: CircleAvatar(
                                                //     radius: 30.0,
                                                //     backgroundImage:
                                                //     NetworkImage(duelresultr['result'][index]['image'].toString()),
                                                //     backgroundColor: Colors.transparent,
                                                //   ),
                                                // ),
                                                percentage: double.parse(
                                                    (int.parse(roomresultr['result']
                                                                        [index][
                                                                    'percentage']
                                                                .toString()) /
                                                            100)
                                                        .toString()),
                                                lineHeight: 30,
                                                // alignment: MainAxisAlignment.spaceBetween,
                                                child: Container(
                                                  child: Stack(
                                                    children: <Widget>[
                                                      Container(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        height: 30,
                                                        width: 30,
                                                        child: CircleAvatar(
                                                          radius: 30.0,
                                                          backgroundImage: NetworkImage(
                                                              roomresultr['result']
                                                                          [
                                                                          index]
                                                                      ['image']
                                                                  .toString()),
                                                          backgroundColor:
                                                              Colors
                                                                  .transparent,
                                                        ),
                                                      ),
                                                      Center(
                                                        child: Text(
                                                          roomresultr['result']
                                                                      [index]
                                                                  ['name']
                                                              .toString(),
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                backgroundColor: ColorConstants.lightgrey200,


                                                progressBarColor:int.parse(roomresultr['result'][index]['percentage'].toString())<10?ColorConstants.stage1color: int.parse(roomresultr['result'][index]['percentage'].toString())<49?ColorConstants.stage2color:int.parse(roomresultr['result'][index]['percentage'].toString())==50?ColorConstants.stage2color:int.parse(roomresultr['result'][index]['percentage'].toString())<50?ColorConstants.stage3color:int.parse(roomresultr['result'][index]['percentage'].toString())<90?ColorConstants.stage3color:int.parse(roomresultr['result'][index]['percentage'].toString())<=100?ColorConstants.stage4color:ColorConstants.stage5color,
                                              ));
                                        })),
                          ],
                        ),
                      ),
                    )
                  : Container(),
              roomresultr!=null?Column(
                children: [
                  GestureDetector(
                    onTap: (){
                      Share.share("I got " +"${roomresultr['user_data']['xp'].toString()} XP"+" on Cultre App. you can play on "
                          "https://play.google.com/store/apps/details?id=$packagename", subject: 'Share link');

                    },
                    child: Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.fromLTRB(0, 20, 0, 5),
                        child: Text(
                          "SHARE PERFORMANCE",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              decoration: TextDecoration.underline),
                          textAlign: TextAlign.center,
                        )),
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AnswerkeyPage(quizid: widget.quizid, saveddata: "", type: widget.type,)));
                    },
                    child: Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.fromLTRB(0, 20, 0, 5),
                        child: Text(
                          "ANSWER KEY",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              decoration: TextDecoration.underline),
                          textAlign: TextAlign.center,
                        )),
                  ),

                  Center(
                    child: Container(
                      margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          onPrimary: Colors.white,
                          elevation: 3,
                          alignment: Alignment.center,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0)),
                          fixedSize: const Size(170, 30),
                          //////// HERE
                        ),
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => QuizPage()));
                        },
                        child: const Text(
                          "BACK TO QUIZ",
                          style: TextStyle(color: Colors.black, fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ):Container(),
              // Container(
              //   margin: const EdgeInsets.fromLTRB(0, 20, 0, 10),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       ElevatedButton(
              //         style: ElevatedButton.styleFrom(
              //           primary: ColorConstants.red,
              //           onPrimary: Colors.white,
              //           elevation: 3,
              //           alignment: Alignment.center,
              //           shape: RoundedRectangleBorder(
              //               borderRadius: BorderRadius.circular(30.0)),
              //           fixedSize: const Size(100, 40),
              //           //////// HERE
              //         ),
              //         onPressed: () {
              //           Navigator.pushReplacement(
              //               context,
              //               MaterialPageRoute(
              //                   builder: (context) => QuizPage()));
              //         },
              //         child: const Text(
              //           "GO BACK",
              //           style: TextStyle(
              //               color: ColorConstants.lightgrey200, fontSize: 14),
              //           textAlign: TextAlign.center,
              //         ),
              //       ),
              //       ElevatedButton(
              //         style: ElevatedButton.styleFrom(
              //           primary: ColorConstants.verdigris,
              //           onPrimary: Colors.white,
              //           elevation: 3,
              //           alignment: Alignment.center,
              //           shape: RoundedRectangleBorder(
              //               borderRadius: BorderRadius.circular(30.0)),
              //           fixedSize: const Size(100, 40),
              //           //////// HERE
              //         ),
              //         onPressed: () {
              //           // Navigator.pushReplacement(
              //           //     context,
              //           //     MaterialPageRoute(
              //           //         builder: (context) => const DuelModeResultXP()));
              //         },
              //         child: const Text(
              //           "LET'S GO!",
              //           style: TextStyle(
              //               color: ColorConstants.lightgrey200, fontSize: 14),
              //           textAlign: TextAlign.center,
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
