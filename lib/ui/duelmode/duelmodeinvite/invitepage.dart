import 'dart:developer';

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:CultreApp/colors/colors.dart';
import 'package:CultreApp/modal/dualdetailsresponse/GetDualDetailResponse.dart';
import 'package:CultreApp/ui/duelmode/duelmodelink/duelmodelink.dart';
import 'package:CultreApp/ui/duelmode/duelmodemain/duelmode_main.dart';

import 'package:CultreApp/ui/rightdrawer/right_drawer.dart';
import 'package:CultreApp/ui/homepage/homepage.dart';

import 'package:getwidget/colors/gf_color.dart';
import 'package:getwidget/components/dropdown/gf_multiselect.dart';
import 'package:getwidget/components/progress_bar/gf_progress_bar.dart';
import 'package:getwidget/types/gf_checkbox_type.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:convert' as convert;
import '../../../utils/StringConstants.dart';
import '../../quiz/let_quiz.dart';
import '../duelcontactlist/duelcontactlist.dart';

class DuelModeInvite extends StatefulWidget {
  var quiztypeid;
  var quizspeedid;
  var difficultylevelid;
  var quizid;
  var type;
  var link;
 var seldomain;
 int typeq;
   DuelModeInvite({Key? key,required this.quizspeedid,required this.quiztypeid,
     required this.quizid,required this.type,required this.difficultylevelid,required this.seldomain,required this.link,required this.typeq}) : super(key: key);

  @override
  _DuelModeInviteState createState() => _DuelModeInviteState();
}

class _DuelModeInviteState extends State<DuelModeInvite> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool value = false;
  var username;
  var email;
  var country;
  var profilepic;
  var userid;
  var data;
  var link;
  var gendata;
  var snackBar;
  var speed;
  var difficulty;
  var seldomain;
  int select=1;
  var duelid;
  userdata() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString("username");
      country =prefs.getString("country");
      userid= prefs.getString("userid");
    });
   if(widget.typeq==0){
     setState(() {
       speed=widget.quizspeedid.toString();
       difficulty=widget.difficultylevelid.toString();
       seldomain=widget.seldomain.toString();
       duelid=widget.quizid.toString();
       link=widget.link.toString();
     });
     log(speed.toString());
     log(widget.typeq.toString());
     log(widget.quizspeedid.toString());
     log(widget.difficultylevelid.toString());
     log(widget.seldomain.toString());
    generatelink(userid.toString(), widget.quizid.toString());
   }else if(widget.typeq==1){
    dualdetails(userid.toString(), widget.link.toString());
   }

  }
  void generatelink(String userid,String dualid) async {
    http.Response response =
    await http.post(Uri.parse(StringConstants.BASE_URL+"generate_link"), body: {
      'user_id': userid.toString(),
      'dual_id': dualid.toString()
    });
    showLoaderDialog(context);

    var jsonResponse = convert.jsonDecode(response.body);
    if (response.statusCode == 200) {
      Navigator.pop(context);
      data = response.body;
      if (jsonResponse['status'] == 200) {

        //store response as string
        setState(() {
          gendata = jsonResponse; //get all the data from json string superheros
          print("domiaindata: "+gendata['data']['link'].toString()); // just printed length of data
        });
        onsuccess(gendata);
      } else {

        snackBar = SnackBar(
            content: Text(
              jsonResponse['message'].toString(),
              textAlign: TextAlign.center,));
        ScaffoldMessenger.of(context)
            .showSnackBar(snackBar);
      }
    } else {
      Navigator.pop(context);
      print(response.statusCode);
    }
  }
  onsuccess(gendata){
    if(gendata['data']!=null) {
      setState(() {
        link=gendata['data']['link'].toString();
      });
    }


  }
var dualdata;
  void dualdetails(String userid,String duallink) async {
    http.Response response =
    await http.post(Uri.parse(StringConstants.BASE_URL+"dualdetails"), body: {
      'user_id': userid.toString(),
      'dual_link': duallink.toString()
    });
   showLoaderDialog(context);
    var jsonResponse = convert.jsonDecode(response.body);
    if (response.statusCode == 200) {
      Navigator.pop(context);
      data = response.body;
      if (jsonResponse['status'] == 200) {

        //store response as string
        setState(() {
          dualdata = jsonResponse; //get all the data from json string superheros
          // print("domiaindata: "+gendata['data']['link'].toString()); // just printed length of data
        });
        setduellinkdetail(getDualDetailResponseFromJson(data!));
      } else {

        snackBar = SnackBar(
            content: Text(
              jsonResponse['message'].toString(),
              textAlign: TextAlign.center,));
        ScaffoldMessenger.of(context)
            .showSnackBar(snackBar);
      }
    } else {
      Navigator.pop(context);
      print(response.statusCode);
    }
  }
  setduellinkdetail(GetDualDetailResponse? obj){
    if(obj!=null) {
      if (obj.data != null) {
        setState(() {
          seldomain = obj.data!.domain.toString().replaceAll(",", "\n");
          difficulty = obj.data!.difficulty.toString();
          speed = obj.data!.quizSpeed.toString();
          link = obj.data!.link.toString();
          duelid = obj.data!.dualId.toString();
        });
      }
    }
  }

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(
              margin: EdgeInsets.only(left: 7), child: Text("Loading...")),
        ],),
    );
    showDialog(barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  @override
  void initState() {
    super.initState();
    // _locations ;
    BackButtonInterceptor.add(myInterceptor);
    print(widget.seldomain);
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
    log(widget.typeq.toString());
    log(widget.quizspeedid.toString());
    log(widget.difficultylevelid.toString());
    log(widget.seldomain.toString());
    log(speed.toString());

   // print(widget.seldomain[0]['name'].toString());
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
        child: Container(color: Colors.white.withAlpha(100),
          margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: ListView(
            children:<Widget> [
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
                                    builder: (context) =>  HomePage()));
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
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                  child: const Text("DUEL MODE",
                      style: TextStyle(
                          fontSize: 24, color: ColorConstants.txt))),
              Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: const Text(
                      "Invite someone else to Duel with",
                      style: TextStyle(
                          fontSize: 15, color: ColorConstants.txt))),
    Container(
        margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
    child:GridView(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisSpacing: 10,crossAxisSpacing: 10),
    shrinkWrap: true,
    physics: ClampingScrollPhysics(parent: BouncingScrollPhysics()),

    children: [
    Container(
    alignment: Alignment.center,
    margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
    padding: EdgeInsets.fromLTRB(10, 40, 10, 40),
    height: 150,
    width: 150,
    decoration:  BoxDecoration(
    shape: BoxShape.rectangle,
    color: select==1?ColorConstants.yellow200:ColorConstants.lightgrey200
    ),
    child: GestureDetector(
    onTap: () {
    setState(() {
    select=1;
    });
    //ColorConstants.myfeed;
    },
    child: Text("INVITE",style: TextStyle(color: select==1?Colors.white:Colors.black,fontSize: 20),textAlign: TextAlign.center,)),
    ),
    Container(
    alignment: Alignment.center,
    margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
    padding: EdgeInsets.fromLTRB(10, 40, 10, 40),
    height: 150,
    width: 150,
    decoration:  BoxDecoration(
    shape: BoxShape.rectangle,
    color: select==2?ColorConstants.yellow200:ColorConstants.lightgrey200
    ),
    child: GestureDetector(
    onTap: () {
    setState(() {
    select=2;
    });

    },
    child: Text("GET A LINK",style: TextStyle(color: select==2?Colors.white:Colors.black,fontSize: 20),textAlign: TextAlign.center,)),
    ),
    ])),

              Container(
                child: Text(
                  "QUIZ SUMMARY",
                  style: TextStyle(
                      color: ColorConstants.txt, fontSize: 15),
                ),
              ),
              Divider(thickness: 1,height: 1,color: Colors.black,),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                decoration: const BoxDecoration(color: Colors.white),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                    // if you need this
                    side: BorderSide(
                      color: Colors.grey.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child:
                  Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                        child: Column(
                          children: [
                            Row(
                                 children: [
                                Text(
                                  "DIFFICULTY: ",
                                  style: TextStyle(
                                      color: ColorConstants.txt,
                                      fontSize: 15),
                                ),

                               Text(
                                  difficulty.toString(),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15),
                                ),

                              ],
                            ),
                            Divider(thickness: 1,height: 1,color: Colors.black,),
                          ],
                        ),

                      ),

                      Container(
                        margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                        child: Column(
                          children: [
                            Row(

                              children: [
                                Text(
                                  "SPEED: ",
                                  style: TextStyle(
                                      color: ColorConstants.txt,
                                      fontSize: 15),
                                ),
                                 Text(
                                  speed.toString(),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15),
                                ),
                              ],
                            ),
                            Divider(thickness: 1,height: 1,color: Colors.black,),
                          ],
                        ),

                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                        child: Column(
                            children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "DOMAINS SELECTED:",textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: ColorConstants.txt,
                                    fontSize: 15),
                              ),
                            ),
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  seldomain.toString(),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15),
                                ),
                              ),
    //                           if(seldomain!=null)
    //                           ListView.builder(
    //                           physics: const BouncingScrollPhysics(),
    // shrinkWrap: true,
    // itemCount: seldomain!.length,
    // itemBuilder: (BuildContext context, int index) {
    //   return
    //     Container(
    //       alignment: Alignment.centerLeft,
    //       child: Text(
    //         seldomain.toString(), textAlign: TextAlign.left,
    //         style: TextStyle(
    //             color: ColorConstants.txt,
    //             fontSize: 15),
    //       ),
    //     );
    // }),

                          ],
                        ),

                      ),
                    ],
                  ),
                ),
              ),
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
                                builder: (context) => QuizPage()));
                      },
                      child: const Text(
                        "GO BACK",
                        style: TextStyle(
                            color: Colors.white, fontSize: 14),
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
                        if(select==1){
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>  DuelModeSelectPlayer(type: widget.type, quizid: duelid, difficultylevelid: difficulty,
                                    quiztypeid: widget.quiztypeid, seldomain: seldomain, quizspeedid: speed, link: link,)));

                        }else{
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>  DuelModeLink(type: widget.type, quizid: duelid, difficultylevelid: difficulty,
                                    quiztypeid: widget.quiztypeid, seldomain: seldomain, quizspeedid: speed, link: link,)));

                        }
                        // Navigator.pushReplacement(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => const WelcomePage()));
                      },
                      child: const Text(
                        "LET'S GO!",
                        style: TextStyle(
                            color: Colors.white, fontSize: 14),
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

