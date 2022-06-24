import 'dart:convert';
import 'dart:developer';


import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:CultreApp/colors/colors.dart';

import 'package:CultreApp/ui/classicquiz/answerkey/answerkey.dart';
import 'package:CultreApp/ui/homepage/homepage.dart';
import 'package:getwidget/components/progress_bar/gf_progress_bar.dart';
import 'package:lottie/lottie.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../utils/StringConstants.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class DuelModeResult extends StatefulWidget {
  var quizid;
  var type;
  DuelModeResult({Key? key, required this.quizid,required this.type}) : super(key: key);

  @override
  _DuelModeResultState createState() => _DuelModeResultState();
}

const TWO_PI = 3.14 * 2;

class _DuelModeResultState extends State<DuelModeResult> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
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
  var rankdata;
  String packagename="";
  PackageInfo? packageInfo;
  //GetDuelResultResponse? duelresultr;
  var duelresultr;

  userdata() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString("username");
      country = prefs.getString("country");
      userid = prefs.getString("userid");
    });
    print("userdata");
    log("test");
    print("quizid"+widget.quizid.toString());
    log("quizid"+widget.quizid.toString());
    //calTheme();


    getDuelRank(userid.toString(), widget.quizid.toString());

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
  getDuelResult(String userid, String dualId) async {
    http.Response response = await http.post(
        Uri.parse(StringConstants.BASE_URL + "get_dual_result"),
        body: {'user_id': userid.toString(), 'dual_id': dualId.toString()});
    showLoaderDialog(context);

    print("getDuelResultapi");
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
        duelresultr = jsonResponse;
      });
      print("getdueljsonsuccess" + duelresultr.toString());
      print("getdueljsonsuccessuser" + duelresultr['user_data'].toString());
    }
  }
  getDuelRank(String userid, String dualId) async {
    http.Response response = await http.post(
        Uri.parse(StringConstants.BASE_URL + "duelrank"),
        body: {'user_id': userid.toString(), 'dual_id': dualId.toString()});
    showLoaderDialog(context);

    print("getDuelRankapi");
    var jsonResponse = convert.jsonDecode(response.body);
    if (response.statusCode == 200) {
      Navigator.pop(context);
      data = response.body;
      if(jsonResponse!=null){
        rankdata = jsonResponse;
        onrank(rankdata);
      } else {

        log(jsonResponse['message']);
      }
    } else {
      Navigator.pop(context);
      print(response.statusCode);
    }
  }

  onrank(rankdata){
    if(rankdata!=null) {
      if (rankdata['status'] == 200) {
        if (rankdata['data'] != null) {
          if (rankdata['data']['name']
              .toString()
              .isNotEmpty) {
            AlertDialog alert = AlertDialog(
              backgroundColor: Colors.white,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(32.0))),
              contentPadding: const EdgeInsets.only(top: 10.0),
              title: Container(child: Column(
                children: [
                  Text("${rankdata['data']['message']}", style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      ),
                    textAlign: TextAlign.center,),
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                        image: DecorationImage(image: rankdata['data']['rank']==1?const AssetImage("assets/images/artwork1.png"):
                        rankdata['data']['rank']==2?const AssetImage("assets/images/artwork2.png"):rankdata['data']['rank']==3?const AssetImage("assets/images/artwork3.png"):const AssetImage("assets/images/artwork1.png"))
                    ),
                    child:rankdata['data']['image'] != ""
                        ? Center(
                      child: Container(
                        alignment: Alignment.center,
                        height: 80,
                        width: 80,
                        child: CircleAvatar(
                          radius: 30.0,
                          backgroundImage: NetworkImage("${rankdata['data']['image']}"),
                          backgroundColor: Colors.transparent,
                        ),
                      ),
                    )
                        : Center(
                      child: Container(
                        alignment: Alignment.center,
                        height: 80,
                        width: 80,
                        child: const CircleAvatar(
                          radius: 30.0,
                          backgroundImage:
                          AssetImage("assets/images/placeholder.png"),
                          backgroundColor: Colors.transparent,
                        ),
                      ),
                    ),
                  ),
                  const Text("Congratulations!\nKeep it up!", style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                     ),
                    textAlign: TextAlign.center,)
                ],
              )),
              actions: [
                Container(
                  padding: const EdgeInsets.all(4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("", style: TextStyle(color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w700)),
                      const Text("", style: TextStyle(color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w700)),
                      TextButton(onPressed: () {
                        Navigator.pop(context);
                      },
                          child: const Text("CLOSE", style: TextStyle(
                              color: Colors.red,
                              fontSize: 16,
                              fontWeight: FontWeight.w700))),
                    ],
                  ),
                ),
              ],
            );
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return alert;
              },
            );
            getDuelResult(userid.toString(), widget.quizid.toString());
          }

        }else{
          getDuelResult(userid.toString(), widget.quizid.toString());
        }
      }else{
        DateTime now = DateTime.now();

        String atimenew = "${now.year.toString()}-${now.month.toString().padLeft(2,'0')}-${now.day.toString().padLeft(2,'0')} ${now.hour.toString().padLeft(2,'0')}:${now.minute.toString().padLeft(2,'0')}:${now.second.toString().padLeft(2,'0')}";

        log(atimenew);
        String atime=atimenew.substring(11);
        String ranktime=rankdata['time'].toString().substring(11);
        var newatime= (int.parse(atime.substring(0,2)) * 3600) +(int.parse(atime.substring(6,8)) * 60 )+(int.parse(atime.substring(6,8)) * 1);
        var newranktime=(int.parse(ranktime.substring(0,2)) * 3600) +(int.parse(ranktime.substring(6,8)) * 60 )+(int.parse(ranktime.substring(6,8)) * 1);

        if(newatime > newranktime){
          getDuelResult(userid.toString(), widget.quizid.toString());
        }else{
          // final stream =
          // Stream<int>.periodic(const Duration(
          //     seconds: 30), (count) => count).take(10);
          //
          // stream.forEach( getDuelRank(userid.toString(), widget.quizid.toString()));
          Future.delayed(
            const Duration(seconds: 30),
                () {
              getDuelRank(userid.toString(), widget.quizid.toString());
            },
          );
        }
      }

    }else {
      Future.delayed(
        const Duration(seconds: 30),
            () {
          getDuelRank(userid.toString(), widget.quizid.toString());
        },
      );
    }
  }

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Container(
              margin: const EdgeInsets.only(left: 7), child: const Text("Loading...")),
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
        MaterialPageRoute(builder: (BuildContext context) => HomePage()));
    // Do some stuff.
    return true;
  }
  Future<Future> _refreshdata(BuildContext context) async {
    log(widget.quizid.toString());
    return getDuelRank(userid.toString(),widget.quizid.toString());
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return Scaffold(
      key: _scaffoldKey,
      // resizeToAvoidBottomInset: false,
      // endDrawerEnableOpenDragGesture: true,
      // endDrawer: MySideMenuDrawer(),
      body: Container(
        child: RefreshIndicator(
          color: Colors.transparent,
          onRefresh: () => _refreshdata(context),
          child: Container(
            color: Colors.white.withAlpha(100),
            margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: ListView(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                      alignment: Alignment.centerLeft,

                      padding: const EdgeInsets.all(5),

                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 5.0),
                      // child: GestureDetector(
                      //   onTap: () {
                      //     _scaffoldKey.currentState!.openEndDrawer();
                      //   },
                      //   child:  Image.asset("assets/images/side_menu_2.png",height: 40,width: 40),
                      // ),
                    ),
                  ],
                ),


                duelresultr == null?Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/debackground.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: ListBody(

                    children: [
                      Container(
                        color:Colors.white.withAlpha(100),
                          alignment: Alignment.center,
                          margin: const EdgeInsets.fromLTRB(0, 80, 0, 0),
                          child: const Text(
                            "AND\n THAT'S A\nWRAP...",
                            style: TextStyle(fontSize: 22, color: Colors.black),
                            textAlign: TextAlign.center,
                          )),
                      Container(
                        height: 300,
                        width: 300,
                        margin: const EdgeInsets.only(top: 40),
                        child: Lottie.asset("assets/lottie/lottieanim.json"),
                      ),
                      Container(   color:Colors.white.withAlpha(100),
                        margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: const Text("Generating Result...",
                          style: TextStyle(fontSize: 18, color:Colors.black),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.fromLTRB(0, 80, 0, 0),
                          child: const Text(
                            "Pull to refresh",
                            style: TextStyle(fontSize: 14, color: Colors.black),
                            textAlign: TextAlign.center,
                          )),
                    ],
                  ),
                ):  ListBody(
                       children: [
                         Container(
                             alignment: Alignment.center,
                             margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                             child: const Text(
                               "YOU\nSCORED....",
                               style: TextStyle(fontSize: 24, color: ColorConstants.txt),
                               textAlign: TextAlign.center,
                             )),
                         Container(
                            decoration: const BoxDecoration(shape: BoxShape.circle),
                            margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                            alignment: Alignment.topCenter,
                            child: SizedBox(
                              height: 170,
                              width: 170,
                              child: Stack(
                                children: <Widget>[
                                  SizedBox(
                                    child: Center(
                                      child: Container(
                                        height: 170,
                                        width: 170,
                                        child: CircularProgressIndicator(
                                          value: (double.parse(duelresultr['user_data']
                                          ['percentage']
                                              .toString())/(100)),
                                          valueColor: const AlwaysStoppedAnimation<Color>(
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
                                        if(duelresultr['user_data']['xp']!=null)
                                        Center(
                                            child: Text(
                                          "${duelresultr['user_data']['xp'].toString()} XP",
                                          style: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600),
                                        )),
                                        if(duelresultr['user_data']['xp']==null)
                                          const Center(
                                              child: Text(
                                                "${"0"} XP",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w600),
                                              )),
                                        if (double.parse(duelresultr['user_data']
                                                        ['percentage']
                                                    .toString()) >=
                                                0.0 &&
                                            double.parse(duelresultr['user_data']
                                                        ['percentage']
                                                    .toString()) <
                                                10.0)
                                          const Center(child: Text("oh boy!",style: TextStyle(color: Colors.black))),
                                        if (double.parse(duelresultr['user_data']
                                                        ['percentage']
                                                    .toString()) >=
                                                10.0 &&
                                            double.parse(duelresultr['user_data']
                                                        ['percentage']
                                                    .toString()) <
                                                50.0)
                                          const Center(child: Text("Don't give up!",style: TextStyle(color: Colors.black))),
                                        if (double.parse(duelresultr['user_data']
                                                    ['percentage']
                                                .toString()) ==
                                            50.0)
                                          const Center(
                                              child: Text("Practice makes perfect!",style: TextStyle(color: Colors.black))),
                                        if (double.parse(duelresultr['user_data']
                                                        ['percentage']
                                                    .toString()) >
                                                50.0 &&
                                            double.parse(duelresultr['user_data']
                                                        ['percentage']
                                                    .toString()) <=
                                                90.0)
                                          const Center(child: Text("Almost there!",style: TextStyle(color: Colors.black))),
                                        if (double.parse(duelresultr['user_data']
                                                        ['percentage']
                                                    .toString()) >
                                                90.0 &&
                                            double.parse(duelresultr['user_data']
                                                        ['percentage']
                                                    .toString()) <=
                                                100.0)
                                          const Center(child: Text("Keep it up!",style: TextStyle(color: Colors.black))),
                                      ],
                                    ),
                                    back: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Center(
                                            child: Text(
                                                "${duelresultr['user_data']['percentage'].toString()} %",
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w600))),
                                        if (double.parse(duelresultr['user_data']
                                                        ['percentage']
                                                    .toString()) >=
                                                0.0 &&
                                            double.parse(duelresultr['user_data']
                                                        ['percentage']
                                                    .toString()) <
                                                10.0)
                                          const Center(child: Text("oh boy!",style: TextStyle(color: Colors.black))),
                                        if (double.parse(duelresultr['user_data']
                                                        ['percentage']
                                                    .toString()) >=
                                                10.0 &&
                                            double.parse(duelresultr['user_data']
                                                        ['percentage']
                                                    .toString()) <
                                                50.0)
                                          const Center(child: Text("Don't give up!",style: TextStyle(color: Colors.black))),
                                        if (double.parse(duelresultr['user_data']
                                                    ['percentage']
                                                .toString()) ==
                                            50.0)
                                          const Center(
                                              child: Text("Practice makes perfect!",style: TextStyle(color: Colors.black))),
                                        if (double.parse(duelresultr['user_data']
                                                        ['percentage']
                                                    .toString()) >
                                                50.0 &&
                                            double.parse(duelresultr['user_data']
                                                        ['percentage']
                                                    .toString()) <=
                                                90.0)
                                          const Center(child: Text("Almost there!",style: TextStyle(color: Colors.black))),
                                        if (double.parse(duelresultr['user_data']
                                                        ['percentage']
                                                    .toString()) >
                                                90.0 &&
                                            double.parse(duelresultr['user_data']
                                                        ['percentage']
                                                    .toString()) <=
                                                100.0)
                                          const Center(child: Text("Keep it up!",style: TextStyle(color: Colors.black),)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )),



                     Container(
                        margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                        decoration: const BoxDecoration(color: Colors.white),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            // if you need this

                          ),
                          child: Column(
                            children: [
                              Container(
                                margin: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                                child: const Text(
                                  "YOU SCORED...",
                                  style: TextStyle(color: ColorConstants.txt),
                                ),
                              ),
                              duelresultr == null
                                  ? Center(
                                      child: Container(),
                                    )
                                  : Container(

                                      margin:
                                          const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                      child: ListView.builder(
                                          physics: const ClampingScrollPhysics(
                                              parent: BouncingScrollPhysics()),
                                          shrinkWrap: true,
                                          itemCount: duelresultr['result'].length,
                                          itemBuilder:
                                              (BuildContext context, int index) {
                                            return Container(
                                                margin: const EdgeInsets.fromLTRB(
                                                    10, 10, 10, 10),
                                                child: GFProgressBar(

                                                  percentage: double.parse(
                                                      (int.parse(duelresultr['result']
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
                                                          child:  duelresultr['result']
                                                          [
                                                          index]
                                                          ['image']
                                                              .toString().isEmpty?CircleAvatar(
                                                            radius: 30.0,
                                                            child: Image.asset("assets/images/placeholder.png",fit: BoxFit.cover,),
                                                            backgroundColor:
                                                            Colors
                                                                .transparent,
                                                          ): CircleAvatar(
                                                            radius: 30.0,
                                                            backgroundImage: NetworkImage(
                                                                duelresultr['result']
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
                                                            duelresultr['result']
                                                                        [index]
                                                                    ['name']
                                                                .toString(),
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: const TextStyle(
                                                                fontSize: 16,
                                                                color:
                                                                    Colors.black),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  backgroundColor: ColorConstants.lightgrey200,


                                                  progressBarColor:int.parse(duelresultr['result'][index]['percentage'].toString())<10?ColorConstants.stage1color: int.parse(duelresultr['result'][index]['percentage'].toString())<49?ColorConstants.stage2color:int.parse(duelresultr['result'][index]['percentage'].toString())==50?ColorConstants.stage2color:int.parse(duelresultr['result'][index]['percentage'].toString())<50?ColorConstants.stage3color:int.parse(duelresultr['result'][index]['percentage'].toString())<90?ColorConstants.stage3color:int.parse(duelresultr['result'][index]['percentage'].toString())<=100?ColorConstants.stage4color:ColorConstants.stage5color,
                                                ));
                                          })),
                            ],
                          ),
                        ),
                      ),

               Column(
                  children: [
                    GestureDetector(
                      onTap: (){
                        Share.share("I got " +"${duelresultr['user_data']['xp'].toString()} XP"+" on Cultre App. you can play on "
                            "https://play.google.com/store/apps/details?id=$packagename", subject: 'Share link');

                      },
                      child: Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.fromLTRB(0, 20, 0, 5),
                          child: const Text(
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
                                builder: (context) => AnswerkeyPage(quizid: widget.quizid, saveddata: "", type: widget.type, sessionid: 0, tourid: 0,)));
                      },
                      child: Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.fromLTRB(0, 20, 0, 5),
                          child: const Text(
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
                        margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            onPrimary: Colors.white,
                            elevation: 3,
                            alignment: Alignment.center,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0)),
                            fixedSize:  const Size(170, 30),
                            //////// HERE
                          ),
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePage()));
                          },
                          child: const Text(
                            "BACK TO HOME",
                            style: TextStyle(color: Colors.black, fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
                       ],
                     )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
