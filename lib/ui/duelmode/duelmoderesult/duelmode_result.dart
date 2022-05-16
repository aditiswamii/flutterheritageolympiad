import 'dart:convert';
import 'dart:developer';
import 'dart:ffi';

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterheritageolympiad/colors/colors.dart';
import 'package:flutterheritageolympiad/modal/getduelresult/GetDuelResultResponse.dart';

import 'package:flutterheritageolympiad/ui/quiz/let_quiz.dart';
import 'package:flutterheritageolympiad/ui/rightdrawer/right_drawer.dart';
import 'package:flutterheritageolympiad/ui/welcomeback/welcomeback_page.dart';
import 'package:getwidget/components/progress_bar/gf_progress_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/StringConstants.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class DuelModeResult extends StatefulWidget {
  var duelid;
  DuelModeResult({Key? key,required this.duelid}) : super(key: key);

  @override
  _State createState() => _State();
}

const TWO_PI = 3.14 * 2;

class _State extends State<DuelModeResult> {
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
  Result? jsonres;
  UserData? jsonuser;
  GetDuelResultResponse? duelresultr;
  userdata() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString("username");
      country = prefs.getString("country");
      userid = prefs.getString("userid");
    });
    print("userdata");
    //calTheme();

    getDuelResult(userid.toString(),"1663");

    // getFeed(userid.toString(), "0", "", "", "");
  }
  getDuelResult(String userid,String dualId) async {
      http.Response response = await http.post(
          Uri.parse(StringConstants.BASE_URL + "get_dual_result"),body: {
        'user_id': userid.toString(),
        'dual_id': dualId.toString(),
      }
            );
      showLoaderDialog(context);

      print("getDuelResultapi");
    var jsonResponse = convert.jsonDecode(response.body);
      if (response.statusCode == 200) {
        Navigator.pop(context);
        data = response.body;
        if(jsonResponse['status']==200) {

        //final responseJson = json.decode(response.body);//store response as string
          resultdata = jsonResponse['result']; //get all the data from json string superheros
          print("length"+resultdata.length.toString());
          print("resdata"+ jsonResponse['result'].toString());
          setState(() {
            jsonres=jsonDecode(
                data!)['result'];
            jsonuser=jsonDecode(
                data!)['user_data'];
          });
          print(jsonuser!.name.toString());
          //print(getDuelResultResponseFromJson(data!).toString());
setState(() {
  var duelres=getDuelResultResponseFromJson(data!);
  print(duelres.toString());
});

        onsuccess(getDuelResultResponseFromJson(data!));
        print(getDuelResultResponseFromJson(data!).result.toString());
        var venam = jsonDecode(data!)['result'][0]['name'];
        print("name"+venam.toString());
        log("name"+venam.toString());
      }else{
          print(jsonResponse['message'].toString());
        }
      }
      else {
        Navigator.pop(context);
        print(response.statusCode);
      }

    }

  onsuccess(GetDuelResultResponse? duelresultresponse){
    log(duelresultresponse.toString());
    if(duelresultresponse!.userData!=null && duelresultresponse.result!=null){
      setState(() {
        duelresultr=duelresultresponse;
      });


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
        child: Container( color: Colors.white.withAlpha(100),
          margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: ListView(
            children: <Widget>[
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
                  alignment: Alignment.center,
                  margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: const Text(
                    "YOU\nSCORED....",
                    style: TextStyle(
                        fontSize: 24, color: ColorConstants.txt),
                    textAlign: TextAlign.center,
                  )),
              jsonuser!=null ?Container(
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
                              Center(child: Text("${jsonuser!.xp!} XP")),
                          if (double.parse(jsonuser!.percentage!) > 0.0 && double.parse(duelresultr!.userData!.percentage!) < 10.0)
                              Center(child: Text("oh boy!")),
                              if (double.parse(duelresultr!.userData!.percentage!) > 10.0 && double.parse(duelresultr!.userData!.percentage!) < 50.0)
                                Center(child: Text("Don't give up!")),
                              if (double.parse(duelresultr!.userData!.percentage!) == 50.0)
                                Center(child: Text("Practice makes perfect!")),
                              if (double.parse(duelresultr!.userData!.percentage!) > 50.0 && double.parse(duelresultr!.userData!.percentage!) <= 90.0)
                                Center(child: Text("Almost there!")),
                              if (double.parse(duelresultr!.userData!.percentage!)> 90.0 && double.parse(duelresultr!.userData!.percentage!) <= 100.0 )
                                Center(child: Text("Keep it up!")),

                             ],
                          ),
                          back: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(child: Text("${duelresultr!.userData!.percentage!} %")),
                              if (double.parse(duelresultr!.userData!.percentage!) > 0.0 && double.parse(duelresultr!.userData!.percentage!) < 10.0)
                                Center(child: Text("oh boy!")),
                              if (double.parse(duelresultr!.userData!.percentage!) > 10.0 && double.parse(duelresultr!.userData!.percentage!) < 50.0)
                                Center(child: Text("Don't give up!")),
                              if (double.parse(duelresultr!.userData!.percentage!) == 50.0)
                                Center(child: Text("Practice makes perfect!")),
                              if (double.parse(duelresultr!.userData!.percentage!) > 50.0 && double.parse(duelresultr!.userData!.percentage!) <= 90.0)
                                Center(child: Text("Almost there!")),
                              if (double.parse(duelresultr!.userData!.percentage!)> 90.0 && double.parse(duelresultr!.userData!.percentage!) <= 100.0 )
                                Center(child: Text("Keep it up!")),

                            ],
                          ),
                        ),
                      ],
                    ),
                  )):Container(),

              duelresultr!=null ? Container(
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
                        child: Text("YOU SCORED...",style: TextStyle(color: ColorConstants.txt),),
                      ),

                          duelresultr==null? Center(
                          child: Container(

    ),
    )
        :  Container(
    margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
    child: ListView.builder(
    physics: ClampingScrollPhysics(
    parent: BouncingScrollPhysics()),
    shrinkWrap: true,
    itemCount: duelresultr!.result!.length,
    itemBuilder: (BuildContext context, int index) {
    return Container(
                          margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                          child: GFProgressBar(
                            leading: Container(
                              // padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                              height: 30,
                              width: 30,
                              child: CircleAvatar(
                                radius: 30.0,
                                backgroundImage:
                                NetworkImage(duelresultr!.result![index].image!),
                                backgroundColor: Colors.transparent,
                              ),
                            ),
                            percentage: 0.6,
                            lineHeight: 30,
                            alignment: MainAxisAlignment.spaceBetween,
                            child:  Text(duelresultr!.result![index].name!, textAlign: TextAlign.left,
                              style: TextStyle(fontSize: 18, color: Colors.white),
                            ),
                            backgroundColor: Colors.black12,
                            progressBarColor: ColorConstants.red,
                          )
                      );
    })),

                    ],
                  ),
                ),
              ):Container(),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                builder: (context) =>  QuizPage()));
                      },
                      child: const Text(
                        "GO BACK",
                        style: TextStyle(
                            color: ColorConstants.lightgrey200, fontSize: 14),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: ColorConstants.verdigris,
                        onPrimary: Colors.white,
                        elevation: 3,
                        alignment: Alignment.center,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0)),
                        fixedSize: const Size(100, 40),
                        //////// HERE
                      ),
                      onPressed: () {
                        // Navigator.pushReplacement(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => const DuelModeResultXP()));
                      },
                      child: const Text(
                        "LET'S GO!",
                        style: TextStyle(
                            color: ColorConstants.lightgrey200, fontSize: 14),
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
