import 'dart:convert';
import 'dart:developer';


import 'package:CultreApp/ui/homepage/homepage.dart';
import 'package:CultreApp/ui/quiz/let_quiz.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:CultreApp/dialog/raisedispute/Dialogdispute.dart';


import 'package:CultreApp/ui/classicquiz/result/result.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:CultreApp/colors/colors.dart';


import 'package:CultreApp/ui/rightdrawer/right_drawer.dart';


import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/StringConstants.dart';
import '../../duelmode/duelmoderesult/duelmode_result.dart';
import '../../quizroom/quizroomresult/quizroom_result.dart';
import '../../tournamentquiz/result/tourresult.dart';



class AnswerkeyPage extends StatefulWidget {
  var quizid;
  var saveddata;
  var type;
  var tourid;
  var sessionid;
  AnswerkeyPage({Key? key, required this.quizid,required this.saveddata,
    required this.type,required this.sessionid,required this.tourid}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<AnswerkeyPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
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
  var snackBar;
  TextEditingController descripcontroller= TextEditingController();
  var data1;
  var raisedata;
  userdata() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString("username");
      country = prefs.getString("country");
      userid = prefs.getString("userid");
    });
    if(widget.type=="1"|| widget.type=="2"|| widget.type=="3"){
      getAnswer(widget.quizid);
    }else if(widget.type=="4"){
      getTourAnswer(widget.tourid, widget.sessionid);
    }

  }

  @override
  void initState() {
    super.initState();
    BackButtonInterceptor.add(myInterceptor);
    userdata();
  }

  void getAnswer(String quizId) async {
    http.Response response = await http
        .post(Uri.parse(StringConstants.BASE_URL+"get_answerkey"), body: {
      'quiz_id': quizId.toString(),
    });
    var jsonResponse = convert.jsonDecode(response.body);
    if (response.statusCode == 200) {
      if(jsonResponse['status']==200) {
        data = response.body; //store response as string
        setState(() {
          answerdata = jsonDecode(
              data!)['data']; //get all the data from json string superheros
          print(answerdata.length); // just printed length of data
        });

        var venam = jsonDecode(data!)['data'];
        print(venam);
      }else{
        snackBar = SnackBar(
          content: Text(
              jsonResponse['message']),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } else {
      print(response.statusCode);
    }
  }
  void getTourAnswer(int tourid,int sessionid) async {
    http.Response response = await http
        .post(Uri.parse(StringConstants.BASE_URL+"get_tournament_answer"), body: {
      'tournament_id': tourid.toString(),
      'session_id': sessionid.toString(),
      'user_id':userid.toString()
    });
    var jsonResponse = convert.jsonDecode(response.body);
    if (response.statusCode == 200) {
      if(jsonResponse['status']==200) {
        data = response.body; //store response as string
        setState(() {
          answerdata = jsonDecode(
              data!)['data']; //get all the data from json string superheros
          print(answerdata.length); // just printed length of data
        });

        var venam = jsonDecode(data!)['data'];
        print(venam);
      }else{
        snackBar = SnackBar(
          content: Text(
              jsonResponse['message']),
        );
        ScaffoldMessenger.of(context)
            .showSnackBar(snackBar);
      }
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
      widget.type=='1'? Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (BuildContext context) =>
              ResultPage(quizid: widget.quizid, savedata: widget.saveddata, type: widget.type,)))
          :widget.type=='2'? Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (BuildContext context) =>
              DuelModeResult(quizid: widget.quizid, type: widget.type,)))
          :widget.type=='3'?Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (BuildContext context) =>
              QuizroomResult(quizid: widget.quizid, type: widget.type,))):
          Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (BuildContext context) =>
              TournamentResult( type: widget.type, sessionid: widget.sessionid, tourid: widget.tourid,)));
    log(info.currentRoute(context).toString());
    log("answerkey${BackButtonInterceptor.describe()}");
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
                                            Text("${index + 1}) ${jsonDecode(data!)['data'][index]['question']}"),
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
                                child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,

                                    ),
                                    // height:250,
                                    // width: 250,
                                    alignment: Alignment.center,
                                    //margin: EdgeInsets.fromLTRB(0,10,0,10),

                                    child:Column(
                                      children: [
                                        Text('Raise a dispute',textAlign: TextAlign.center,style: TextStyle(color: ColorConstants.txt,fontSize:18 ),),
                                        Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Container(
                                            height: 150,
                                            width: MediaQuery.of(context).size.width,
                                            child: TextFormField(
                                                textInputAction: TextInputAction.done,
                                                decoration: InputDecoration(
                                                  enabledBorder: OutlineInputBorder(
                                                      borderRadius:
                                                      BorderRadius.all(Radius.circular(5.0)),
                                                      borderSide: BorderSide(color: Colors.black54)),
                                                  focusedBorder: OutlineInputBorder(
                                                      borderRadius:
                                                      BorderRadius.all(Radius.circular(5.0)),
                                                      borderSide: BorderSide(color: Colors.black54)),
                                                  border: InputBorder.none,
                                                ),
                                                controller: descripcontroller //this is your text
                                            ),
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
                                            if(descripcontroller.text.isNotEmpty){
                                              raisedispute(userid.toString(), widget.type!, descripcontroller.text.toString(), widget.tourid, widget.sessionid,
                                                  widget.quizid);

                                            }else{
                                              var snackbar = SnackBar(
                                                  content: Text(
                                                    "Please submit your dispute",
                                                    textAlign: TextAlign.center,));
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(snackbar);
                                            }
                                          },
                                          child: const Text(
                                            "SUBMIT",
                                            style: TextStyle(
                                                color: ColorConstants.lightgrey200, fontSize: 14),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ],
                                    )
                                ),
                                // child: DialogDispute(quizid: widget.quizid, type: widget.type,)
                            ),
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

  void raisedispute(String user_id,String type,String dispute,int tourid,int seesionid,String quizid) async {
    descripcontroller.text="";
    http.Response response = await http
        .post(Uri.parse(StringConstants.BASE_URL+"raise_dispute"), body: {
      'user_id': user_id.toString(),
      'type': type.toString(),
      if(widget.type=="4")
        "tournament_id" : tourid.toString(),
      "session_id": seesionid.toString(),
      if(widget.type == "1")
        "quiz_id": quizid.toString(),
      'dispute':dispute.toString()
    });
    var jsonResponse = convert.jsonDecode(response.body);
    if (response.statusCode == 200) {
      Navigator.pop(context);//store response as string

      data1 = response.body;
      if (jsonResponse['status'] == 200) {
      setState(() {
        raisedata = jsonDecode(
            data1!)['data']; //get all the data from json string superheros
        print(raisedata.length); // just printed length of data
      });
      snackBar = SnackBar(
          content: Text(
            "thanks for feedback",
            textAlign: TextAlign.center,
          ));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      var venam = jsonDecode(data1!)['data'];
      print(venam);
    }else{
        snackBar = SnackBar(
            content: Text(
              "please submit again",
              textAlign: TextAlign.center,
            ));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
      else {
      Navigator.pop(context);//store response as string

      snackBar = SnackBar(
          content: Text(
            "please submit again",
            textAlign: TextAlign.center,
          ));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      print(response.statusCode);
    }
  }

}
