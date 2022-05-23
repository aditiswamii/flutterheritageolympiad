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

import '../../modal/createquizresponse/CreateQuizResponse.dart';
import '../../modal/domains/GetDomainsResponse.dart';
import '../../utils/StringConstants.dart';
import '../quiz/let_quiz.dart';
import 'cquizrule/classicquizrule.dart';
import 'dart:convert' as convert;
class ClassicQuizMain extends StatefulWidget {
  const ClassicQuizMain({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<ClassicQuizMain> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
 // late ClassicQuizPresenter _presenter;
  var data;
  var domains_length;
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
  var difficultylevelid;
  var speedid;
  var snackbar;
  var username;
  var email;
  var country;
  var profilepic;
  var userid;
  var domainname;
  var domainnamelist =[].toList(growable: true);
  String domain="";
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
      data = response.body; //store response as string
      setState(() {
        domains_length = jsonDecode(
            data!)['data'];
        //get all the data from json string superheros
        print(domains_length.length); // just printed length of data
      });
      var jsondata=getDomainsResponseFromJson(data!).data;
      var jsondataa=datadomainFromJson(data!).id.toString();
      log(jsondata.toString());
      var venam = jsonDecode(data!)['data'][4]['name'];
      log(venam);
    } else {
      print(response.statusCode);
    }
  }

  void createquiz(String userid, String quiz_type_id,String  difficulty_level_id,
      String  quiz_speed_id,String  domains) async {
    http.Response response =
        await http.post(Uri.parse(StringConstants.BASE_URL+"createquiz"), body: {
      'user_id': userid.toString(),
      'quiz_type_id': quiz_type_id.toString(),
      'difficulty_level_id': difficulty_level_id.toString(),
      'quiz_speed_id': quiz_speed_id.toString(),
      'domains': domains.toString()
    });
    var jsonResponse = convert.jsonDecode(response.body);
    if (response.statusCode == 200) {
      if (jsonResponse['status'] == 200) {
        Navigator.pop(context);
      data = response.body; //store response as string
      setState(() {
        domains_length = jsonDecode(
            data!)['data']; //get all the data from json string superheros
        print(domains_length.length); // just printed length of data
      });
        var userid = jsonDecode(data!)['data']['user_id'];
        var quiz_type_id = jsonDecode(data!)['data']['quiz_type_id'];
        var difficulty_level_id =
        jsonDecode(data!)['data']['difficulty_level_id'];
        var quiz_speed_id = jsonDecode(data!)['data']['quiz_speed_id'];
        var quizid=createQuizResponseFromJson(data!).data!.id.toString();
      onsuccess(quiz_type_id,quiz_speed_id,quizid);
      
     // var id = jsonDecode(data!)['data']['id'];
        log(userid);
        log(quiz_type_id);
        log(difficulty_level_id);
        log(quiz_speed_id);
      print(userid);
    } else {
        Navigator.pop(context);
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
  onsuccess(quiz_type_id, quiz_speed_id, String quizid){
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>  RulesPage(quizspeedid:quiz_speed_id, quiztypeid: quiz_type_id, quizid: quizid, type: "1" ,)));
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
  //final String text;
  //   SecondScreen({Key key, @required this.text}) : super(key: key);
//Navigator.push(
//     context,
//     MaterialPageRoute(
//       builder: (context) => SecondScreen(text: 'Hello',),
//     ));
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
                  child: const Text("CLASSIC QUIZ",
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
                    Container(
                      width: 20,
                      height: 20,
                      child: Image.asset(
                        "assets/images/about.png",
                        height: 20,
                        width: 20,
                      ),
                    )
                  ],
                ),
              ),
              Container(
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
                  child: domains_length == null || domains_length!.isEmpty
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : SingleChildScrollView(
                          child: Column(
                            children: [
                              // Card(
                              //     child: CheckboxListTile(
                              //         title: Text("Select All"),
                              //         onChanged: (checked) {
                              //           setState(
                              //                 () {
                              //               _expanded7 =  checked!;
                              //
                              //             },
                              //           );
                              //           if(_expanded7==true) {
                              //           isChecked = List
                              //                 .generate(
                              //                 _len, (index) => true);
                              //           }else{
                              //             isChecked = List
                              //                 .generate(
                              //                 _len, (index) => false);
                              //           }
                              //           if(_expanded7==true) {
                              //             if(!domainnamelist.contains(domains_length))
                              //               domainnamelist.addAll(domains_length);
                              //
                              //           }
                              //           else {
                              //             // if(domainnamelist.contains(domainname))
                              //             domainnamelist.remove(domains_length);
                              //           }
                              //
                              //         },
                              //         value: _expanded7 )
                              // ),
                              ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: domains_length == null
                                    ? 0
                                    : _expanded6==false?2:domains_length.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Column(
                                    children: [
                                      Card(
                                          child: CheckboxListTile(
                                            visualDensity: VisualDensity(vertical: -4,horizontal: 4),
                                              title: Text(jsonDecode(data!)['data']
                                                  [index]['name']),
                                              onChanged: (checked) {
                                                setState(
                                                  () {
                                                    isChecked[index] = checked!;

                                                  },
                                                );
                                                if(isChecked[index]==true) {
                                                  domainname=jsonDecode(data!)['data']
                                                  [index]['id'];

                                                  setState(() {
                                                    domainname=jsonDecode(data!)['data']
                                                    [index]['id'];
                                                  });
                                                    if(!domainnamelist.contains(domainname))
                                                      domainnamelist.add(domainname);

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
                               child: GestureDetector(
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
                               )
                              ):Container(
                                 width: MediaQuery.of(context).size.width,
                                 height: 50,
                                 child: GestureDetector(
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
                                 )
                             ),


                            ],
                          ),
                        ),
                ),
              ),

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
                    Image.asset(
                      "assets/images/about.png",
                      height: 20,
                      width: 20,
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

                      },
                      child: Image.asset(
                        "assets/images/about.png",
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
                        log(speedid);
                        log(domainnamelist.toString());
                        log("${domainnamelist.toString()}");
                        log(_getTitle());
                        if(domainnamelist!=null){
                          if(speedid!=null){
                            if(difficultylevelid!=null){
                              showLoaderDialog(context);

                              createquiz(userid,"1", difficultylevelid, speedid,"${domainnamelist.toString().replaceAll("[", "").replaceAll("]", "")}");
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
}
