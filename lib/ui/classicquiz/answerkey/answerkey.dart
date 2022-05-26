import 'dart:convert';
import 'dart:math';

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterheritageolympiad/dialog/raisedispute/Dialogdispute.dart';
import 'package:flutterheritageolympiad/modal/classicquestion/ClassicQuestion.dart';
import 'package:flutterheritageolympiad/ui/classicquiz/questionpageview/mcq.dart';
import 'package:flutterheritageolympiad/ui/classicquiz/result/result.dart';

import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:flutterheritageolympiad/colors/colors.dart';


import 'package:flutterheritageolympiad/ui/rightdrawer/right_drawer.dart';


import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/StringConstants.dart';
import '../../duelmode/duelmoderesult/duelmode_result.dart';



class AnswerkeyPage extends StatefulWidget {
  var quizid;
  var saveddata;
  var type;
  AnswerkeyPage({Key? key, required this.quizid,required this.saveddata,required this.type}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<AnswerkeyPage> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool value = false;
  String? data;
  var answerdata;
  var username;
  var email;
  var country;
  var profilepic;
  var userid;
  var quesid;
  var rightop;
  var useropt;
  var ques;
  userdata() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString("username");
      country = prefs.getString("country");
      userid = prefs.getString("userid");
    });
  }

  @override
  void initState() {
    super.initState();
    BackButtonInterceptor.add(myInterceptor);
    getData(widget.quizid);
    userdata();
  }

  void getData(String quiz_id) async {
    http.Response response = await http
        .post(Uri.parse(StringConstants.BASE_URL+"get_answerkey"), body: {
      'quiz_id': quiz_id.toString(),
    });
    if (response.statusCode == 200) {
      data = response.body; //store response as string
      setState(() {
        answerdata = jsonDecode(
            data!)['data']; //get all the data from json string superheros
        print(answerdata.length); // just printed length of data
      });

      var venam = jsonDecode(data!)['data'];
      print(venam);
    } else {
      print(response.statusCode);
    }
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }

  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    if(widget.type=="1")
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>ResultPage(quizid: widget.quizid, savedata: widget.saveddata, type: widget.type,)));
    if(widget.type=="2")
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>  DuelModeResult(quizid: widget.quizid, type: widget.type,)));
    print(BackButtonInterceptor.describe()); // Do some stuff.
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
            image: AssetImage("assets/images/debackground.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          color: Colors.white.withAlpha(100),
          margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                // color: Colors.white.withAlpha(100),
                margin: EdgeInsets.fromLTRB(0, 0, 0, 100),
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Container(
                          alignment: Alignment.topLeft,
                          margin: const EdgeInsets.fromLTRB(0, 60, 0, 10),
                          child: const Text("ANSWER KEY",
                              style: TextStyle(
                                  fontSize: 24, color: ColorConstants.txt))),
                      Container(
                        margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                        decoration: const BoxDecoration(color: Colors.white),
                        child: answerdata == null || answerdata!.isEmpty
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : SingleChildScrollView(
                                child: ListView.builder(
                                  physics: ClampingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: answerdata == null
                                      ? 0
                                      : answerdata.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Container(
                                        margin:
                                            EdgeInsets.fromLTRB(0, 10, 0, 10),
                                        child: ListBody(
                                          children: [
                                            Text("${index + 1})"
                                                "${jsonDecode(data!)['data'][index]['question']}"),
                                            Text(
                                                "Your Answer : ${jsonDecode(data!)['data'][index]['your_option']}"),
                                            Text(
                                                "Correct Answer : ${jsonDecode(data!)['data'][index]['right_option']}"),
                                          ],
                                        ));
                                  },
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 100,
                child: Container(
                  color: Colors.white.withAlpha(100),
                  alignment: Alignment.bottomCenter,
                  height: 100,
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                            alignment: Alignment.center,
                            margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                            child: Text(
                              "Did we make a mistake?",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black54,
                              ),
                              textAlign: TextAlign.center,
                            )),
                      ),
                      GestureDetector(
                        onTap: () {
                          Dialog dialog = Dialog(
                         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                            backgroundColor: Colors.white,
                            child: Container(
                              height: 250,
                                width: 250,

                                alignment: Alignment.center,
                                child: DialogDispute(quizid: widget.quizid, type: widget.type,)),
                          );
                          showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  dialog);
                        },
                        child: Container(
                            alignment: Alignment.center,
                            margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                            child: Text(
                              "Click here to raise a dispute",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black54,
                                  decoration: TextDecoration.underline),
                              textAlign: TextAlign.center,
                            )),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
