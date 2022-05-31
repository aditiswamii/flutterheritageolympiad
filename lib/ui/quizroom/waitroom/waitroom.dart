import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:ffi';

import 'dart:ui';

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:flutterheritageolympiad/colors/colors.dart';
import 'package:flutterheritageolympiad/modal/waitroomuserlist/Getroomuserlist.dart';
import 'package:flutterheritageolympiad/ui/classicquiz/result/result.dart';
import 'package:flutterheritageolympiad/ui/quiz/let_quiz.dart';
import 'package:flutterheritageolympiad/ui/rightdrawer/right_drawer.dart';
import 'package:flutterheritageolympiad/utils/stringconstants.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../modal/classicquestion/ClassicQuestion.dart';
import '../../../modal/classicquestion/getQuestionResponse.dart';
import 'dart:convert' as convert;

import '../../../utils/countdowntimer.dart';

import '../../homepage/homepage.dart';
import '../../rules/rulepage.dart';

class Waitroom extends StatefulWidget {
  var quizid;

  Waitroom({Key? key, required this.quizid}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<Waitroom> {
  var username;
  var email;
  var country;
  var profilepic;
  var userid;
  var data;
  var roomdata;
  var duelresultr;
  Getroomuserlist? getroomuserlist;
  var snackBar;
  int addeduser=0;
  userdata() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString("username");
      country = prefs.getString("country");
      userid = prefs.getString("userid");
    });
    print("userdata");

   // getWaitRoom(widget.quizid.toString());
    getWaitRoom(widget.quizid.toString());
  }

  @override
  void initState() {
    super.initState();
    BackButtonInterceptor.add(myInterceptor);
    userdata();
  }
  deleteuserapi(String roomid,String id) async {
    http.Response response = await http.post(
        Uri.parse(StringConstants.BASE_URL + "delete_user_room"),
        body: {'room_id': roomid.toString(),
          'user_id': id.toString(),
        });
    showLoaderDialog(context);

    print("deleteuserapi");
    var jsonResponse = convert.jsonDecode(response.body);
    if (response.statusCode == 200) {
      Navigator.pop(context);
      data = response.body;
      if (jsonResponse['status'] == 200) {

        getWaitRoom(widget.quizid.toString());

      } else {
        snackBar = SnackBar(
          content: Text(
            jsonResponse['message'].toString(),textAlign: TextAlign.center,),
        );
        ScaffoldMessenger.of(context)
            .showSnackBar(snackBar);
      }
    } else {
      Navigator.pop(context);
      print(response.statusCode);
    }
  }

  startroom(String roomid) async {
    http.Response response = await http.post(
        Uri.parse(StringConstants.BASE_URL + "start_room"),
        body: {'room_id': roomid.toString()
        });
    showLoaderDialog(context);

    print("startroomapi");
    var jsonResponse = convert.jsonDecode(response.body);
    if (response.statusCode == 200) {
      Navigator.pop(context);
      data = response.body;
      if (jsonResponse['status'] == 200) {

       onstartr();

      } else {
        snackBar = SnackBar(
          content: Text(
            jsonResponse['message'].toString(),textAlign: TextAlign.center,),
        );
        ScaffoldMessenger.of(context)
            .showSnackBar(snackBar);
      }
    } else {
      Navigator.pop(context);
      print(response.statusCode);
    }
  }
  onstartr(){
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>  RulesPage(quizspeedid:"", quiztypeid:"", quizid: widget.quizid, type: "3", tourid: 0, sessionid: 0 ,)));

  }
  leaveapi(String roomid,String id) async {
    http.Response response = await http.post(
        Uri.parse(StringConstants.BASE_URL + "leaveroom"),
        body: {
          'room_id': roomid.toString(),
          'user_id': id.toString(),
        });
    showLoaderDialog(context);

    print("leaveroomapi");
    var jsonResponse = convert.jsonDecode(response.body);
    if (response.statusCode == 200) {
      Navigator.pop(context);
      data = response.body;
      if (jsonResponse['status'] == 200) {
            onleaveitem();
        // getWaitRoom(widget.quizid.toString());

      }else if(jsonResponse['status'] == 201) {
            onleaveitem();
      }

        else {
        snackBar = SnackBar(
          content: Text(
            jsonResponse['message'].toString(),textAlign: TextAlign.center,),
        );
        ScaffoldMessenger.of(context)
            .showSnackBar(snackBar);
      }
    } else {
      Navigator.pop(context);
      print(response.statusCode);
    }
  }
  onleaveitem(){
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>  HomePage()));
  }
  disbandapi(String roomid) async {
    http.Response response = await http.post(
        Uri.parse(StringConstants.BASE_URL + "disband_quiz"),
        body: {'quiz_room_id': roomid.toString()
        });
    showLoaderDialog(context);

    print("disband_quizapi");
    var jsonResponse = convert.jsonDecode(response.body);
    if (response.statusCode == 200) {
      Navigator.pop(context);
      data = response.body;
      if (jsonResponse['status'] == 200) {
         ondisband();
        // getWaitRoom(widget.quizid.toString());

      } else {
        snackBar = SnackBar(
          content: Text(
            jsonResponse['message'].toString(),textAlign: TextAlign.center,),
        );
        ScaffoldMessenger.of(context)
            .showSnackBar(snackBar);
      }
    } else {
      Navigator.pop(context);
      print(response.statusCode);
    }
  }
  ondisband(){
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>  HomePage()));
  }
  getroomstatus(String roomid,String userid) async {
    http.Response response = await http.post(
        Uri.parse(StringConstants.BASE_URL + "room_status"),
        body: {'room_id': roomid.toString(),
          'user_id': userid.toString(),
        });
    showLoaderDialog(context);

    print("roomstatusapi");
    var jsonResponse = convert.jsonDecode(response.body);
    if (response.statusCode == 200) {
      Navigator.pop(context);
      data = response.body;
      if (jsonResponse['status'] == 200) {
        var roomstatusata=jsonResponse['data'];
        setState(() {
          roomstatusata=jsonResponse['data'];
        });
        roomstatus(roomstatusata);

      } else {
        snackBar = SnackBar(
          content: Text(
            jsonResponse['message'].toString(),textAlign: TextAlign.center,),
        );
        ScaffoldMessenger.of(context)
            .showSnackBar(snackBar);
      }
    } else {
      Navigator.pop(context);
      print(response.statusCode);
    }
  }
  roomstatus(int roomstatusata){
    if(roomstatusata!=null){
       if(roomstatusata==2){
         Navigator.pushReplacement(
             context,
             MaterialPageRoute(
                 builder: (context) =>  HomePage()));

       }else if(roomstatusata==1){
         Navigator.pushReplacement(
             context,
             MaterialPageRoute(
                 builder: (context) =>  RulesPage(quizspeedid:"", quiztypeid:"", quizid: widget.quizid, type: "3", tourid: 0, sessionid: 0 ,)));

       }
    }
    final stream =
    Stream<int>.periodic(const Duration(
        seconds: 1), (count) => count).take(5);

    stream.forEach(getroomstatus(widget.quizid.toString(),userid.toString()));
  }
  getWaitRoom(String roomid) async {
    http.Response response = await http.post(
        Uri.parse(StringConstants.BASE_URL + "room_user"),
        body: {'room_id': roomid.toString()});
    showLoaderDialog(context);

    print("getWaitRoomapi");
    var jsonResponse = convert.jsonDecode(response.body);
    if (response.statusCode == 200) {
      Navigator.pop(context);
      data = response.body;
      if (jsonResponse['status'] == 200) {
        //final responseJson = json.decode(response.body);//store response as string
        roomdata =
            jsonResponse['data']; //get all the data from json string superheros
        print("length" + roomdata.length.toString());
        // onsuccess(jsonResponse);
        onsuccess(getroomuserlistFromJson(data!));
      } else {
        snackBar = SnackBar(
          content: Text(
            jsonResponse['message'].toString(),textAlign: TextAlign.center,),
        );
        ScaffoldMessenger.of(context)
            .showSnackBar(snackBar);
        log(jsonResponse['message']);
      }
    } else {
      Navigator.pop(context);
      print(response.statusCode);
    }
  }
var creatorid =0;
  onsuccess(Getroomuserlist? Roomlistn) {
    log(Roomlistn.toString());
    if (Roomlistn != null) {
      setState(() {
        getroomuserlist = Roomlistn;
        creatorid=Roomlistn.creatorId!;
        addeduser=Roomlistn.data!.length;
      });
      print("getroomlistjsonsuccess" + Roomlistn.toString());
    }

    final stream =
    Stream<int>.periodic(const Duration(
        seconds: 1), (count) => count).take(5);

    stream.forEach(getWaitRoom(widget.quizid.toString()));
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
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);

    super.dispose();
  }

  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => HomePage()));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.blue200,
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: ColorConstants.blue200,
        elevation: 0.0,
        leading: Container(
          padding: EdgeInsets.only(left: 5.0),
          alignment: Alignment.topLeft,
          child: Image.asset("assets/images/mcq_pattern2.png",
              height: 20, width: 20, alignment: Alignment.topLeft),
        ),
        title: Container(
          padding: EdgeInsets.only(left: 5.0),
          alignment: Alignment.centerLeft,
          child: Image.asset("assets/images/mcq_pattern2.png",
              height: 20, width: 20, alignment: Alignment.centerLeft),
        ),
      ),
      body: getroomuserlist == null?
      Container(
        height: MediaQuery.of(context).size.height,
        child: CircularProgressIndicator(color: Colors.white,),):  Container(
        child: Container(
          child: ListView(children: [
            Container(
                alignment: Alignment.topCenter,
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: const Text(
                  "PLAYER JOINED....",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                  textAlign: TextAlign.center,
                )),
            Container(
                    height: 300,
                    margin: const EdgeInsets.fromLTRB(20, 30, 20, 30),
                    child: ListView.builder(
                        physics: ClampingScrollPhysics(
                            parent: BouncingScrollPhysics()),
                        shrinkWrap: true,
                        itemCount: getroomuserlist!.data!.length,
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
                              child: Container(
                                  margin:
                                      const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                  child: ListBody(children: [
                                    Container(
                                      child: Row(
                                        children: [
                                          if (getroomuserlist!
                                                  .data![index].image !=
                                              "")
                                            Container(
                                              alignment: Alignment.centerLeft,
                                              height: 80,
                                              width: 80,
                                              child: CircleAvatar(
                                                radius: 80.0,
                                                backgroundImage: NetworkImage(
                                                    getroomuserlist!
                                                        .data![index].image
                                                        .toString()),
                                                backgroundColor:
                                                    Colors.transparent,
                                              ),
                                            ),
                                          if (getroomuserlist!
                                                  .data![index].image ==
                                              "")
                                            Container(
                                              padding: EdgeInsets.fromLTRB(
                                                  10, 10, 10, 10),
                                              height: 90,
                                              width: 90,
                                              child: CircleAvatar(
                                                radius: 30.0,
                                                backgroundImage: AssetImage(
                                                    "assets/images/placeholder.png"),
                                                backgroundColor:
                                                    Colors.transparent,
                                              ),
                                            ),
                                          Container(
                                            width: 190,
                                            margin: EdgeInsets.fromLTRB(
                                                10, 10, 0, 0),
                                            child: Column(
                                              children: [
                                                Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    "${getroomuserlist!.data![index].name}",
                                                    style: TextStyle(
                                                        color:
                                                            ColorConstants.txt,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                                Container(
                                                  //height: 20,
                                                  width: 190,
                                                  child: Row(
                                                    children: [
                                                      if (getroomuserlist!
                                                              .data![index]
                                                              .ageGroup !=
                                                          null)
                                                        Text(
                                                          "${getroomuserlist!.data![index].ageGroup}",
                                                          style: TextStyle(
                                                              color:
                                                                  ColorConstants
                                                                      .txt,
                                                              fontSize: 14),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      VerticalDivider(
                                                          color: Colors.black),
                                                      // Text("|"),
                                                      Row(
                                                        children: [
                                                          if (getroomuserlist!
                                                                  .data![index]
                                                                  .flagIcon !=
                                                              null)
                                                            Container(
                                                                height: 20,
                                                                width: 20,
                                                                decoration: BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle),
                                                                child:
                                                                    CircleAvatar(
                                                                  radius: 20.0,
                                                                  backgroundImage:
                                                                      NetworkImage(
                                                                          "${getroomuserlist!.data![index].flagIcon}"),
                                                                  backgroundColor:
                                                                      Colors
                                                                          .transparent,
                                                                )),
                                                          if (getroomuserlist!
                                                                  .data![index]
                                                                  .country !=
                                                              null)
                                                            Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      left: 5),
                                                              width: 70,
                                                              child: Text(
                                                                "${getroomuserlist!.data![index].country}",
                                                                style: TextStyle(
                                                                    color:
                                                                        ColorConstants
                                                                            .txt,
                                                                    fontSize:
                                                                        14),
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                              ),
                                                            ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                if ((creatorid.toString()==userid.toString() ))
                                                  Container(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      "Admin",
                                                      style: TextStyle(
                                                          color: ColorConstants
                                                              .txt),
                                                    ),
                                                  ),
                                                if ((creatorid.toString()!=userid.toString() ))
                                                Container(
                                                  alignment:
                                                  Alignment.centerLeft,
                                                  child: Text(
                                                    "${getroomuserlist!.data![index].status}",
                                                    style: TextStyle(
                                                        color: ColorConstants
                                                            .txt),
                                                  ),
                                                ),
                                                if ((userid!=getroomuserlist!.data![index].id && creatorid!=getroomuserlist!.data![index].id))
                                                Container(
                                                  alignment: Alignment.bottomRight,
                                                  child: Card(
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(30),
                                                      // if you need this

                                                    ),
                                                    elevation: 3,
                                                    child: Image.asset("assets/images/delete.png",height: 30,width: 30,),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ])));
                        })),
            Container(
              height: 100,
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 70,
                      width: 70,
                      alignment: Alignment.bottomRight,
                      padding: EdgeInsets.only(right: 5.0),
                      child: Center(
                        child: Image.asset(
                          "assets/images/mcq_pattern_3.png",
                          height: 50,
                          width: 50,
                          alignment: Alignment.bottomRight,
                        ),
                      ),
                    ),
                    Container(
                      height: 70,
                      width: 70,
                      alignment: Alignment.bottomLeft,
                      padding: EdgeInsets.only(right: 5.0),
                      child: Center(
                        child: Image.asset(
                          "assets/images/mcq_pattern_3.png",
                          height: 50,
                          width: 50,
                          alignment: Alignment.bottomLeft,
                        ),
                      ),
                    ),
                  ]),
            ),
            Container(
              height: 100,
              margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    Column(
                    children: [
                      if(getroomuserlist!.creatorId.toString()==userid.toString())
                     GestureDetector(
                       onTap: (){
                         disbandapi(widget.quizid.toString());
                       },
                        child: Container(
                          alignment:
                          Alignment.center,
                          child: Text(
                           "DISBAND GROUP",
                            style: TextStyle(
                                color: Colors.white,decoration: TextDecoration.underline),
                          ),
                        ),
                      ),
                      if( getroomuserlist!.creatorId.toString()!=userid.toString())
                       GestureDetector(
                         onTap: (){
                               leaveapi(widget.quizid.toString(), userid.toString());
                         },
                          child: Container(
                            alignment:
                            Alignment.center,
                            child: Text(
                              "LEAVE GROUP",
                              style: TextStyle(
                                  color: Colors.white,decoration: TextDecoration.underline),
                            ),
                          ),
                        ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: ColorConstants.verdigris,
                            onPrimary: Colors.white,
                            side: BorderSide(
                              width: 1.0,
                              color: Colors.white,
                            ),
                            shadowColor: Colors.white,
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
                            //         builder: (context) => ClassicQuizMain()));
                          },
                          child: const Text(
                            "GO BACK",
                            style: TextStyle(color: Colors.white, fontSize: 14),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        if(getroomuserlist!.creatorId.toString()==userid.toString())
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: ColorConstants.verdigris,
                            onPrimary: Colors.white,
                            elevation: 3,
                            side: BorderSide(
                              width: 1.0,
                              color: Colors.white,
                            ),
                            shadowColor: Colors.white,
                            alignment: Alignment.center,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0)),
                            fixedSize: const Size(100, 40),
                            //////// HERE
                          ),
                          onPressed: () {
                                 if(addeduser>=1){
                                   AlertDialog alert=AlertDialog(
                                     shape: RoundedRectangleBorder(
                                         borderRadius: BorderRadius.all(Radius.circular(32.0))),
                                     contentPadding: EdgeInsets.only(top: 10.0),
                                     title: Text("Are you sure you want to begin?\nIf you have invited more players, they will not be able to join this quiz.",style: TextStyle(color:ColorConstants.txt,fontSize: 16,fontWeight: FontWeight.w700),textAlign: TextAlign.center,),

                                     actions: [
                                       Row(
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
                                               // fixedSize: const Size(150, 40),
                                               //////// HERE
                                             ),
                                             onPressed: () {

                                               Navigator.pop(context);
                                             }, child: Text("GO BACK",style: TextStyle(color: Colors.white),),

                                           ),
                                           ElevatedButton(
                                             style: ElevatedButton.styleFrom(
                                               primary: ColorConstants.verdigris,
                                               onPrimary: Colors.white,
                                               elevation: 3,
                                               alignment: Alignment.center,
                                               shape: RoundedRectangleBorder(
                                                   borderRadius: BorderRadius.circular(30.0)),
                                               // fixedSize: const Size(150, 40),
                                               //////// HERE
                                             ),
                                             onPressed: () {
                                                 startroom(widget.quizid.toString());
                                             }, child: Text("LET'S GO",style: TextStyle(color:  Colors.white),),

                                           )
                                         ],
                                       ),
                                       // Container(width: 30,
                                       //     child: Text("")),
                                       //
                                     ],
                                   );
                                   showDialog(
                                     context:context,
                                     builder:(BuildContext context){
                                       return alert;
                                     },
                                   );
                                 }else{
                                   snackBar = SnackBar(
                                     content: Text(
                                       "minimum 1 users needed to start the quiz",textAlign: TextAlign.center,),
                                   );
                                   ScaffoldMessenger.of(context)
                                       .showSnackBar(snackBar);
                                 }
                          },
                          child: const Text(
                            "LET'S GO",
                            style: TextStyle(color: Colors.white, fontSize: 14),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
