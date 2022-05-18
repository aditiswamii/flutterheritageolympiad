
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:flutter/services.dart';
import 'package:flutterheritageolympiad/colors/colors.dart';
import 'package:flutterheritageolympiad/modal/getuserleagueresponse/GetUserLeagueResponse.dart';
import 'package:flutterheritageolympiad/ui/classicquiz/questionpageview/mcq.dart';
import 'package:flutterheritageolympiad/ui/feed/feed.dart';
import 'package:flutterheritageolympiad/ui/myaccount/myaccount_page.dart';
import 'package:flutterheritageolympiad/ui/quiz/let_quiz.dart';
import 'package:flutterheritageolympiad/ui/rightdrawer/right_drawer.dart';
import 'package:flutterheritageolympiad/ui/shopproduct/shopproducts_page.dart';
import 'package:flutterheritageolympiad/utils/SharedObjects.dart';
import 'package:flutterheritageolympiad/utils/apppreference.dart';
import 'package:getwidget/components/progress_bar/gf_progress_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../../utils/StringConstants.dart';
import '../classicquiz/result/result.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class WelcomePage extends StatefulWidget{

  const WelcomePage({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<WelcomePage> {
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
  @override
  void initState() {
    super.initState();
    userdata();
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);
    return Scaffold(
      key: _scaffoldKey,
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
        margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
    child: ListView(
    children: [

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
      Container(
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.fromLTRB(0, 20, 0, 5),
          child: const Text("WELCOME BACK,",style: TextStyle(fontSize: 24,color: ColorConstants.txt,fontFamily: "Nunito"))),
      Container(
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.fromLTRB(0, 5, 0, 10),
          child: Text(username.toString(),style: TextStyle(fontSize: 24,color: ColorConstants.txt,fontFamily: "Nunito"))),
        Container(
          //height: 300,
            width: MediaQuery.of(context).size.width,
            //alignment: Alignment.center,
            margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
           children: [
           GestureDetector(
             onTap:(){
               Navigator.pushReplacement(
                   context,
                   MaterialPageRoute(
                       builder: (context) => MyAccountPage()));
        },
               child: Container(
                 height: 150,
          width: 150,
            color: ColorConstants.red200,

                 child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     Container(
                       padding: EdgeInsets.all(10),
                       alignment: Alignment.topRight,
                       child: Image.asset("assets/images/mcq_pattern2.png",
                           height: 20,width: 20,alignment: Alignment.topRight),
                     ),
                     Container(child: Text("MY ACCOUNT",style: TextStyle(color: Colors.white,fontSize: 20,fontFamily: "Nunito"),textAlign: TextAlign.center,)),
                     Container(
                       padding: EdgeInsets.all(10),
                       alignment: Alignment.topLeft,
                       child: Image.asset("assets/images/mcq_pattern2.png",
                           height: 20,width: 20,alignment: Alignment.topLeft),
                     ),
                   ],
                 ),

               ),
             ),
             GestureDetector(
               onTap: (){
                 Navigator.pushReplacement(
                     context,
                     MaterialPageRoute(
                         builder: (context) => FeedPage(contents: "", seldomain: "", themes: "",)));
               },
               child: Container(
                 height: 150,
                   width: 150,
                   color:ColorConstants.yellow200,

                 child:  Column(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     Container(
                       padding: EdgeInsets.all(10),
                       alignment: Alignment.topLeft,
                       child: Image.asset("assets/images/mcq_pattern2.png",
                           height: 20,width: 20,alignment: Alignment.topLeft),
                     ),
                     Container(child: Text("MY FEED",style: TextStyle(color: Colors.white,fontSize: 20,fontFamily: "Nunito"),textAlign: TextAlign.center,)),
                     Container(
                       padding: EdgeInsets.all(10),
                       alignment: Alignment.topRight,
                       child: Image.asset("assets/images/mcq_pattern2.png",
                           height: 20,width: 20,alignment: Alignment.topRight),
                     ),
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
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>  QuizPage()));
              },
              child: Container(
                height: 150,
                width: 150,
                color: ColorConstants.blue200,

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      alignment: Alignment.topRight,
                      child: Image.asset("assets/images/mcq_pattern2.png",
                          height: 20,width: 20,alignment: Alignment.topRight),
                    ),
                    Container(child: Text("TO THE QUIZZES",style: TextStyle(color: Colors.white,fontSize: 20,fontFamily: "Nunito"),textAlign: TextAlign.center,)),
                    Container(
                      padding: EdgeInsets.all(10),
                      alignment: Alignment.topLeft,
                      child: Image.asset("assets/images/mcq_pattern2.png",
                          height: 20,width: 20,alignment: Alignment.topLeft),
                    ),
                  ],
                ),

              ),
            ),
            GestureDetector(
              onTap: () {
                // Navigator.pushReplacement(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => ResultPage(quizid: "1339", savedata: null, )));
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ShopPage()));
              },
              child: Container(
                height: 150,
                width: 150,
                color: Colors.black26,

                child:  Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      alignment: Alignment.topLeft,
                      child: Image.asset("assets/images/mcq_pattern2.png",
                          height: 20,width: 20,alignment: Alignment.topLeft),
                    ),
                    Container(child: Text("TO THE SHOP",style: TextStyle(color: Colors.black54,fontSize: 20,fontFamily: "Nunito"),textAlign: TextAlign.center,)),
                    Container(
                      padding: EdgeInsets.all(10),
                      alignment: Alignment.topCenter,
                      child: Image.asset("assets/images/mcq_pattern2.png",
                          height: 20,width: 20,alignment: Alignment.topCenter),
                    ),
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
                child: Text("Your Activity Summary",
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
