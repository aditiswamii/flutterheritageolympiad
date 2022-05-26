import 'dart:convert';
import 'dart:developer';

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterheritageolympiad/ui/myaccount/invitecontact/invitecontactlink/invitecontact_link.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:flutterheritageolympiad/colors/colors.dart';


import 'package:flutterheritageolympiad/ui/duelmode/duelmodeinvite/invitepage.dart';
import 'package:flutterheritageolympiad/ui/rightdrawer/right_drawer.dart';
import 'package:flutterheritageolympiad/ui/homepage/welcomeback_page.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'dart:convert' as convert;

import '../../../modal/createquizresponse/CreateQuizResponse.dart';
import '../../../modal/domains/GetDomainsResponse.dart';
import '../../../utils/StringConstants.dart';
import '../../classicquiz/cquizrule/classicquizrule.dart';
import '../../quiz/let_quiz.dart';
class DuelModeMain extends StatefulWidget {
  var type;
 DuelModeMain({Key? key,required this.type}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<DuelModeMain> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  // late ClassicQuizPresenter _presenter;
  var data;
  var domaindata;
  var createdata;
  bool value = false;
  static int _len = 11;
  bool _expanded5 = false;
  bool _expanded6 = false;
  bool _expanded7 = false;
  bool click1 = true;
  bool click2 = false;
  bool click3 = false;

  bool click6 = true;
  bool click7 = false;
  bool click8 = false;

  bool valuefalse=false;
  bool valuetrue=true;
  var difficultylevelid="3";
  var speedid="1";
  var snackbar;
  var username;
  var email;
  var country;
  var profilepic;
  var userid;
  var domainname;
  var domainnamelist =[].toList(growable: true);
  String domain="";
  String domainid="";
  var selectedIndexes = [];

  List<bool> isChecked = List.generate(_len, (index) => false);
  // String _getTitle() =>
  //     "Checkbox Demo : Checked = ${isChecked.where((check) => check == true)}, Unchecked = ${isChecked.where((check) => check == false)}";

  String _getTitle() =>
      "Checkbox Demo : Checked = ${isChecked.where((check) => check == true)}, Unchecked = ${isChecked.where((check) => check == false)}";
  @override
  void initState() {
    super.initState();
    // _locations ;
    BackButtonInterceptor.add(myInterceptor);
    // _presenter = ClassicQuizPresenter(this);
    userdata();
    getDomains();
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
  userdata() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString("username");
      country =prefs.getString("country");
      userid= prefs.getString("userid");
    });
  }
  void getDomains() async {
    http.Response response =
    await http.get(Uri.parse(StringConstants.BASE_URL+"domains"));

    if (response.statusCode == 200) {
      data = response.body;
      var jsonResponse = convert.jsonDecode(response.body);
      if (jsonResponse['status'] == 200) {
        //store response as string
        setState(() {
          domaindata = jsonResponse;
          print(domaindata['data'].length); // just printed length of data
        });
      }else{
        snackbar = SnackBar(
            content: Text(
              jsonResponse['message'].toString(),
              textAlign: TextAlign.center,));
        ScaffoldMessenger.of(context)
            .showSnackBar(snackbar);
      }
    }else {
      print(response.statusCode);
    }
  }

  void createquiz(String userid,String  difficulty_level_id,
      String  quiz_speed_id,String  domains) async {
    showLoaderDialog(context);
    http.Response response =
    await http.post(Uri.parse(StringConstants.BASE_URL+"create_duel"), body: {
      'user_id': userid.toString(),
      'difficulty_level_id': difficulty_level_id.toString(),
      'quiz_speed_id': quiz_speed_id.toString(),
      'domains': domains.toString()
    });

    var jsonResponse = convert.jsonDecode(response.body);
    if (response.statusCode == 200) {
      Navigator.pop(context);
      data = response.body;
      if (jsonResponse['status'] == 200) {

      //store response as string
        setState(() {
          createdata = jsonResponse; //get all the data from json string superheros
          print("domiaindata: "+createdata['data'].toString()); // just printed length of data
        });
        print(createdata['data'].toString());
        onsuccess(createdata);
      } else {

        snackbar = SnackBar(
            content: Text(
              jsonResponse['message'].toString(),
              textAlign: TextAlign.center,));
        ScaffoldMessenger.of(context)
            .showSnackBar(snackbar);
      }
    } else {
      Navigator.pop(context);
      print(response.statusCode);
    }
  }
  var seldomain="";
  var  seldomainName="";
  int i=0;
  onsuccess(createdata){


    log (createdata['data'].toString());
  log(createdata['data']['dual_id'].toString());
  log(createdata['data']['user'].toString());
  log("domain: "+createdata['data']['domain'][0]['name']);
  log(createdata['data']['quiz_speed'].toString());
  log(createdata['data']['difficulty'].toString());
  log(createdata['data']['quiz_type'].toString());
  log(createdata['data']['created_date'].toString());
  List domain=List.from(createdata['data']['domain']);
   for (i ; i < domain.length; i++) {

       if(seldomain.isNotEmpty){
         seldomain = seldomain + "," + domain[i]['id'].toString();
         seldomainName = seldomainName + "\n" + domain[i]['name'].toString();
       } else {
         seldomain = seldomain + "" + domain[i]['id'].toString();
         seldomainName = seldomainName + "" + domain[i]['name'].toString();
       }


   }
  log("check");
  Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) =>  DuelModeInvite(quizspeedid:createdata['data']['quiz_speed'].toString(),
            quiztypeid: createdata['data']['quiz_type'].toString(),
            quizid:createdata['data']['dual_id'].toString(), type: widget.type.toString(),
            difficultylevelid:createdata['data']['difficulty'].toString(),
            seldomain: seldomainName, link: "", typeq: 0,)));




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
  hintdialog(BuildContext context,String text) {
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
              20.0)),
      content: Container(
          child: Text("${text}"
            ,style:TextStyle(color: ColorConstants.txt,fontSize: 18),textAlign: TextAlign.center ,)
      ),
      actions: [
        TextButton(onPressed: (){
          Navigator.pop(context);
        }, child: Text("OK"))
      ],
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
          margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: ListView(
            // physics: const BouncingScrollPhysics(
            //     parent: AlwaysScrollableScrollPhysics()),
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
                                    builder: (context) => const WelcomePage()));
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
                color: Colors.white70,
                child: ListBody(
                  children: [
                    Container(
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.fromLTRB(0, 20, 0, 5),
                        child: const Text("DUEL MODE",
                            style: TextStyle(
                                fontSize: 24, color: ColorConstants.txt))),
                    Container(
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                        child: const Text(
                            "Based on our Olympiad, this mode is for you to\nconstantly improve your performance",
                            style: TextStyle(
                                fontSize: 15, color: ColorConstants.txt))),
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "DOMAINS",
                            style: TextStyle(
                                color: Colors.black, fontSize: 16),
                          ),
                          GestureDetector(
                            onTap: (){
                              hintdialog(context, "Domain: Choose a domain or more to get quizzes on just those themes.");

                            },
                            child: Container(
                              width: 20,
                              height: 20,
                              child: Image.asset(
                                "assets/images/question.png",
                                height: 20,
                                width: 20,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    domainwidget(domaindata),

                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "DIFFICULTY",
                            style: TextStyle(
                                color: Colors.black, fontSize: 16),
                          ),
                          GestureDetector(
                            onTap: (){
                              hintdialog(context, "The difficulty level is an adjustable setting that controls how challenging the quiz is. Increasing the difficulty level makes the quiz more challenging. Decreasing the difficulty level makes the quiz easier and less challenging. Scores for each question also vary according to the difficulty level\n" +
                                  "Hard: 3 \n" +
                                  "Intermediate: 2 \n" +
                                  "Easy: 1");

                            },
                            child: Image.asset(
                              "assets/images/question.png",
                              height: 20,
                              width: 20,
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                      alignment: Alignment.centerLeft,
                      height: 30,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            ColorConstants.quiz_grad1,
                            ColorConstants.quiz_grad2,
                            ColorConstants.quiz_grad3
                          ]),
                          borderRadius: BorderRadius.circular(30)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(width:  MediaQuery.of(context).size.width/3-20,alignment: Alignment.center,
                            child: click1==false?Text(
                              "|",
                              style: TextStyle(color: Colors.white, fontSize: 24),
                            ):Image.asset("assets/images/trianglewhite.png"),
                          ),
                          Container(width:  MediaQuery.of(context).size.width/3-20,alignment: Alignment.center,
                            child: click2==false?Text(
                              "|",
                              style: TextStyle(color: Colors.white, fontSize: 24),
                            ):Image.asset("assets/images/trianglewhite.png"),
                          ),
                          Container(width:  MediaQuery.of(context).size.width/3-20,alignment: Alignment.center,
                            child: click3==false?Text(
                              "|",
                              style: TextStyle(color: Colors.white, fontSize: 24),
                            ):Image.asset("assets/images/trianglewhite.png"),
                          ),

                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(width:  MediaQuery.of(context).size.width/3-20,alignment: Alignment.center,
                          child: GestureDetector(
                              onTap: () {
                                setState(() {

                                  click1=true;
                                  click2=false;
                                  click3=false;

                                });
                              },
                              child: Text(
                                "Hard",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16,fontWeight: click1==true?FontWeight.w600:FontWeight.w500),
                              )),
                        ),
                        Container(width:  MediaQuery.of(context).size.width/3-20,alignment: Alignment.center,
                          child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  click2=true;
                                  click1=false;
                                  click3=false;
                                });
                              },
                              child: Text(
                                "Intermediate",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16,fontWeight: click2==true?FontWeight.w600:FontWeight.w500),
                              )),
                        ),
                        Container(width:  MediaQuery.of(context).size.width/3-20,alignment: Alignment.center,
                          child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  click3=true;
                                  click2=false;
                                  click1=false;
                                });
                              },
                              child: Text(
                                "Easy",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16,fontWeight: click3==true?FontWeight.w600:FontWeight.w500),
                              )),
                        ),
                      ],
                    ),
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.fromLTRB(10, 20, 10, 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "QUIZ SPEED",
                            style: TextStyle(
                                color: Colors.black, fontSize: 16),
                          ),
                          GestureDetector(
                            onTap: (){
                              hintdialog(context, "Quickfire: Each question is timed; 30 seconds; Questions: 20\n" +
                                  "Regular: Each question is timed: 60 seconds; Questions: 15\n" +
                                  "Olympiad: Over-all timer: 20 minutes; questions: 100");

                            },
                            child: Image.asset(
                              "assets/images/question.png",
                              height: 20,
                              width: 20,
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                      alignment: Alignment.centerLeft,
                      height: 30,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            ColorConstants.quiz_grad1,
                            ColorConstants.quiz_grad2,
                            ColorConstants.quiz_grad3
                          ]),
                          borderRadius: BorderRadius.circular(30)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container( width:  MediaQuery.of(context).size.width/3-20,
                            alignment: Alignment.center,
                            child: click6==false?Text(
                              "|",
                              style: TextStyle(color: Colors.white, fontSize: 24),
                            ):Image.asset("assets/images/trianglewhite.png"),
                          ),
                          Container( width:  MediaQuery.of(context).size.width/3-20,alignment: Alignment.center,
                            child: click7==false?Text(
                              "|",
                              style: TextStyle(color: Colors.white, fontSize: 24),
                            ):Image.asset("assets/images/trianglewhite.png"),
                          ),
                          Container( width:  MediaQuery.of(context).size.width/3-20,alignment: Alignment.center,
                            child: click8==false?Text(
                              "|",
                              style: TextStyle(color: Colors.white, fontSize: 24),
                            ):Image.asset("assets/images/trianglewhite.png"),
                          ),

                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width/3-20,alignment: Alignment.center,
                          child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  click6=true;
                                  click7=false;
                                  click8=false;
                                });
                              },
                              child: Text(
                                "Quickfire",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16,fontWeight: click6==true?FontWeight.w600:FontWeight.w500),
                              )),
                        ),
                        Container(  width: MediaQuery.of(context).size.width/3-20,alignment: Alignment.center,
                          child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  click7=true;
                                  click6=false;
                                  click8=false;

                                });
                              },
                              child: Text(
                                "Regular",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16,fontWeight: click7==true?FontWeight.w600:FontWeight.w500),
                              )),
                        ),
                        Container( width: MediaQuery.of(context).size.width/3-20,alignment: Alignment.center,
                          child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  click8=true;
                                  click7=false;
                                  click6=false;

                                });
                              },
                              child: Text(
                                "Olympiad",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16,fontWeight: click8==true?FontWeight.w600:FontWeight.w500),
                              )),
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
                              if(click1==true){
                                setState(() {
                                  difficultylevelid="3";
                                });
                              }else if(click2==true){
                                setState(() {
                                  difficultylevelid="2";
                                });
                              }else if(click3=true){
                                setState(() {
                                  difficultylevelid="1";
                                });
                              }
                              if(click6==true){
                                setState(() {
                                  speedid="1";
                                });
                              }else if(click7==true){
                                setState(() {
                                  speedid="2";
                                });
                              }else if(click8=true){
                                setState(() {
                                  speedid="3";
                                });
                              }
                              print(domainnamelist.toString());
                              log("hi");
                              log(difficultylevelid);
                              log("speedid"+speedid);
                              log(domainnamelist.toString());
                              log("${domainnamelist.toString().replaceAll("[", "").replaceAll("]", "")}");
                              log(_getTitle());
                              if(domainnamelist!=null){
                                if(speedid!=null){
                                  if(difficultylevelid!=null){


                                    createquiz(userid.toString(), difficultylevelid, speedid,"${domainnamelist.toString().replaceAll("[", "").replaceAll("]", "")}");
                                  }
                                }

                              }

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
                ),)
            ],
          ),
        ),
      ),
    );
  }
  Widget domainwidget(domaindata){
   // List<bool> isChecked = List<bool>.filled(domaindata.length, false);
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      // decoration:  BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(5)),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
          // if you need this
          side: BorderSide(
            color: Colors.grey.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: domaindata == null || domaindata!.isEmpty
            ? const Center(
          child: CircularProgressIndicator(),
        )
            : SingleChildScrollView(
          child: Column(
            children: [
              Card(
                  child: CheckboxListTile(
                      title: Text("Select All"),
                      onChanged: (checked) {
                        setState(
                              () {
                            _expanded7 =  checked!;

                          },
                        );
                        if(_expanded7==true) {
                          isChecked = List
                              .generate(
                              _len, (index) => true);
                        }else{
                          isChecked = List
                              .generate(
                              _len, (index) => false);
                        }
                        if(_expanded7==true) {
                          if(!domainnamelist.contains("1,2,3,4,5,6,7,8,9,10,11"))
                            domainnamelist.addAll(["1","2","3","4","5","6","7","8","9","10","11"]);

                        }
                        else {
                          // if(domainnamelist.contains(domainname))
                          domainnamelist.remove(domaindata);
                        }

                      },
                      value: _expanded7 )
              ),
              ListView.builder(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: domaindata == null
                    ? 0
                    : _expanded6==false?2:domaindata['data'].length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      Card(
                          child: CheckboxListTile(
                              title: Text(domaindata['data']
                              [index]['name']),
                              onChanged: (checked) {
                                setState(
                                      () {
                                        isChecked[index] = checked!;

                                  },
                                );
                                if(isChecked[index]==true) {
                                  domainname=domaindata['data']
                                  [index]['id'];
                                  domainid=domaindata['data'][index]['id'].toString();

                                  setState(() {
                                    domainname=domaindata['data']
                                    [index]['id'];
                                    domainid=domaindata['data'][index]['id'].toString();
                                  });
                                  if(!domainnamelist.contains(domainname))
                                    {
                                      domainnamelist.add(domainname);
                                      domainid=domainid;
                                    }else{
                                    domainid=domainid+","+domainid;
                                  }


                                }
                                else {

                                  // if(domainnamelist.contains(domainname))
                                  domainnamelist.remove(domainname);
                                }


                              },
                              value: isChecked[index])
                      ),
                      //
                    ],
                  );
                },
              ),
              _expanded6==false? Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                      // if you need this
                      side: BorderSide(
                        color: Colors.grey.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child:GestureDetector(
                      onTap: (){
                        setState(() {
                          _expanded6=true;

                        });

                      },
                      child: Container(

                        margin: EdgeInsets.all(4),
                        child: Center(
                            child:Image.asset(
                              'assets/images/down_arrow.png',
                              height: 20,width: 20,
                              color: ColorConstants.txt,
                            )
                        ),
                      ),
                    ),
                  )
              ):Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                      // if you need this
                      side: BorderSide(
                        color: Colors.grey.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child:GestureDetector(
                      onTap: (){
                        setState(() {
                          _expanded6=false;
                        });


                      },
                      child: Container(

                        margin: EdgeInsets.all(4),
                        child: Center(
                            child:Image.asset(
                              'assets/images/down_arrow_small.png',
                              height: 20,width: 20,
                              color: ColorConstants.txt,
                            )
                        ),
                      ),
                    ),
                  )
              ),


            ],
          ),
        ),
      ),
    );
  }
}
