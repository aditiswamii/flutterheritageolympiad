import 'dart:developer';
import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:CultreApp/colors/colors.dart';
import 'package:CultreApp/ui/rightdrawer/right_drawer.dart';
import 'package:CultreApp/ui/homepage/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;
import '../../../modal/Domains.dart';
import '../../../utils/StringConstants.dart';
import '../../quiz/let_quiz.dart';
import '../quizroominvite/quizroominvitepage.dart';

class QuizRoomMain extends StatefulWidget {
  var type;
  QuizRoomMain({Key? key, required this.type}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<QuizRoomMain> with ChangeNotifier {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  // late ClassicQuizPresenter _presenter;
  var data;
  var domaindata;
  var createdata;
  bool value = false;
  static const int _len = 11;
  bool click1 = true;
  bool click2 = false;
  bool click3 = false;

  bool click6 = true;
  bool click7 = false;
  bool click8 = false;

  bool valuefalse = false;
  bool valuetrue = true;
  var difficultylevelid = "3";
  var speedid = "1";
  var snackbar;
  var username;
  var email;
  var country;
  var profilepic;
  var userid;
  var domainname;
  var domainnamelist = [].toList(growable: true);
  String domain = "";
  String domainid = "";
  var selectedIndexes = [];
  var click = false;
  List<Domain>? databean = [].cast<Domain>().toList(growable: true);

  String seldomain = "";
  List<Domain>? clist = [].cast<Domain>().toList(growable: true);
  List<bool> isChecked = List.generate(_len, (index) => false);
  // String _getTitle() =>
  //     "Checkbox Demo : Checked = ${isChecked.where((check) => check == true)}, Unchecked = ${isChecked.where((check) => check == false)}";

  String _getTitle() =>
      "Checkbox Demo : Checked = ${isChecked.where((check) => check == true)}, Unchecked = ${isChecked.where((check) => check == false)}";
  @override
  void initState() {
    super.initState();
    BackButtonInterceptor.add(myInterceptor);
    userdata();
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
    ChangeNotifier().dispose();
    super.dispose();
  }

  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => const QuizPage()));
    // Do some stuff.
    return true;
  }

  void showInSnackBar(String value) {
    ScaffoldMessenger.of(_scaffoldKey.currentContext!)
        .showSnackBar(SnackBar(content: Text(value)));
  }

  userdata() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString("username");
      country = prefs.getString("country");
      userid = prefs.getString("userid");
    });
    getDomains();
  }

  void getDomains() async {
    http.Response response =
        await http.get(Uri.parse("${StringConstants.BASE_URL}domains"));
    var jsonResponse = convert.jsonDecode(response.body);
    if (response.statusCode == 200) {
      data = response.body;
      if (jsonResponse['status'] == 200) {
        //store response as string
        setState(() {
          domaindata = jsonResponse;
          if (kDebugMode) {
            print(domaindata['data'].length);
          } // just printed length of data
        });
        List? jsarray = List.from(domaindata['data']);
        setState(() {
          jsarray;
        });
        if (jsarray.isNotEmpty) {
          var sobj = Domain(0, "Select All", true);

          //clist!.add(sobj);
          setState(() {
            clist!.add(sobj);
          });
          for (int i = 0; i < jsarray.length; i++) {
            var jobj = jsarray[i];
            var sobj = Domain(jobj['id'], jobj['name'], true);

            // clist!.add(sobj);
            setState(() {
              clist!.add(sobj);
            });
          }
          setDomain(clist);
        } else {
          snackbar = const SnackBar(
              content: Text(
            "domain data is not available",
            textAlign: TextAlign.center,
          ));
          ScaffoldMessenger.of(context).showSnackBar(snackbar);
        }
      } else {
        snackbar = SnackBar(
            content: Text(
          jsonResponse['message'].toString(),
          textAlign: TextAlign.center,
        ));
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
      }
    } else {
      if (kDebugMode) {
        print(response.statusCode);
      }
    }
  }

  setDomain(List<Domain>? clist) {
    if (clist != null) {
      setState(() {
        databean = clist;
      });
    }
  }

  void createquiz(String userid, String difficultyLevelId, String quizSpeedId,
      String domains) async {
    //showLoaderDialog(context);
    http.Response response = await http
        .post(Uri.parse("${StringConstants.BASE_URL}create_quiz_room"), body: {
      'user_id': userid.toString(),
      'difficulty_level_id': difficultyLevelId.toString(),
      'quiz_speed_id': quizSpeedId.toString(),
      'domains': domains.toString()
    });

    var jsonResponse = convert.jsonDecode(response.body);
    if (response.statusCode == 200) {
      //Navigator.pop(context);
      data = response.body;
      if (jsonResponse['status'] == 200) {
        //store response as string
        setState(() {
          createdata =
              jsonResponse; //get all the data from json string superheros
          if (kDebugMode) {
            print("domiaindata: ${createdata['data']}");
          } // just printed length of data
        });
        if (kDebugMode) {
          print(createdata['data'].toString());
        }
        onsuccess(createdata);
      } else {
        snackbar = SnackBar(
            content: Text(
          jsonResponse['message'].toString(),
          textAlign: TextAlign.center,
        ));
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
      }
    } else {
      // Navigator.pop(context);
      if (kDebugMode) {
        print(response.statusCode);
      }
    }
  }

  var seldomainName = "";
  int i = 0;

  onsuccess(createdata) {
    log(createdata['data'].toString());
    log(createdata['data']['quiz_room'].toString());
    log(createdata['data']['user'].toString());
    log("domain: " + createdata['data']['domain'][0]['name']);
    log(createdata['data']['quiz_speed'].toString());
    log(createdata['data']['difficulty'].toString());
    log(createdata['data']['quiz_type'].toString());
    log(createdata['data']['created_date'].toString());
    List domain = List.from(createdata['data']['domain']);
    for (i; i < domain.length; i++) {
      if (seldomain.isNotEmpty) {
        seldomain = "$seldomain,${domain[i]['id']}";
        seldomainName = "$seldomainName\n${domain[i]['name']}";
      } else {
        seldomain = "$seldomain${domain[i]['id']}";
        seldomainName = "$seldomainName${domain[i]['name']}";
      }
    }
    log("check");
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => QuizroomInvite(
                  quizspeedid: createdata['data']['quiz_speed'].toString(),
                  quiztypeid: createdata['data']['quiz_type'].toString(),
                  quizid: createdata['data']['quiz_room'].toString(),
                  type: widget.type.toString(),
                  difficultylevelid:
                      createdata['data']['difficulty'].toString(),
                  seldomain: seldomainName,
                  link: "",
                  typeq: 0,
                )));
  }

  hintdialog(BuildContext context, String text) {
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      content: Text(
        text,
        style: const TextStyle(color: ColorConstants.txt, fontSize: 18),
        textAlign: TextAlign.center,
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("OK"))
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
      endDrawer: const MySideMenuDrawer(),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/debackground.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: ListView(
            // physics: const BouncingScrollPhysics(
            //     parent: AlwaysScrollableScrollPhysics()),
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.all(5),
                    child: Center(
                      child: Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePage()));
                          },
                          child: Image.asset(
                            "assets/images/home_1.png",
                            height: 40,
                            width: 40,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 5.0),
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
                color: Colors.white70,
                child: ListBody(
                  children: [
                    Container(
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.fromLTRB(0, 20, 0, 5),
                        child: const Text("QUIZ ROOM",
                            style: TextStyle(
                                fontSize: 24, color: ColorConstants.txt))),
                    Container(
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                        child: const Text(
                            "Step1: Choose the domain,difficulty and the\nspeed of the quiz.",
                            style: TextStyle(
                                fontSize: 15, color: ColorConstants.txt))),
                    Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "DOMAINS",
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          ),
                          GestureDetector(
                            onTap: () {
                              hintdialog(context,
                                  "Domain: Choose a domain or more to get quizzes on just those themes.");
                            },
                            child: SizedBox(
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
                      margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "DIFFICULTY",
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          ),
                          GestureDetector(
                            onTap: () {
                              hintdialog(context,
                                  "The difficulty level is an adjustable setting that controls how challenging the quiz is. Increasing the difficulty level makes the quiz more challenging. Decreasing the difficulty level makes the quiz easier and less challenging. Scores for each question also vary according to the difficulty level\nHard: 3 \nIntermediate: 2 \nEasy: 1");
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
                          gradient: const LinearGradient(colors: [
                            ColorConstants.quiz_grad1,
                            ColorConstants.quiz_grad2,
                            ColorConstants.quiz_grad3
                          ]),
                          borderRadius: BorderRadius.circular(30)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 3 - 20,
                            alignment: Alignment.center,
                            child: click1 == false
                                ? const VerticalDivider(
                                    thickness: 1,
                                    width: 1,
                                    color: Colors.white,
                                  )
                                : Image.asset(
                                    "assets/images/trianglewhite.png"),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 3 - 20,
                            alignment: Alignment.center,
                            child: click2 == false
                                ? const VerticalDivider(
                                    thickness: 1,
                                    width: 1,
                                    color: Colors.white,
                                  )
                                : Image.asset(
                                    "assets/images/trianglewhite.png"),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 3 - 20,
                            alignment: Alignment.center,
                            child: click3 == false
                                ? const VerticalDivider(
                                    thickness: 1,
                                    width: 1,
                                    color: Colors.white,
                                  )
                                : Image.asset(
                                    "assets/images/trianglewhite.png"),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 3 - 20,
                          alignment: Alignment.center,
                          child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  click1 = true;
                                  click2 = false;
                                  click3 = false;
                                });
                              },
                              child: Text(
                                "Hard",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: click1 == true
                                        ? FontWeight.w600
                                        : FontWeight.w500),
                              )),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 3 - 20,
                          alignment: Alignment.center,
                          child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  click2 = true;
                                  click1 = false;
                                  click3 = false;
                                });
                              },
                              child: Text(
                                "Intermediate",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: click2 == true
                                        ? FontWeight.w600
                                        : FontWeight.w500),
                              )),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 3 - 20,
                          alignment: Alignment.center,
                          child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  click3 = true;
                                  click2 = false;
                                  click1 = false;
                                });
                              },
                              child: Text(
                                "Easy",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: click3 == true
                                        ? FontWeight.w600
                                        : FontWeight.w500),
                              )),
                        ),
                      ],
                    ),
                    Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "QUIZ SPEED",
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          ),
                          GestureDetector(
                            onTap: () {
                              hintdialog(context,
                                  "Quickfire: Each question is timed; 30 seconds; Questions: 20\nRegular: Each question is timed: 60 seconds; Questions: 15\nOlympiad: Over-all timer: 20 minutes; questions: 100");
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
                          gradient: const LinearGradient(colors: [
                            ColorConstants.quiz_grad1,
                            ColorConstants.quiz_grad2,
                            ColorConstants.quiz_grad3
                          ]),
                          borderRadius: BorderRadius.circular(30)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 3 - 20,
                            alignment: Alignment.center,
                            child: click6 == false
                                ? const VerticalDivider(
                                    thickness: 1,
                                    width: 1,
                                    color: Colors.white,
                                  )
                                : Image.asset(
                                    "assets/images/trianglewhite.png"),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 3 - 20,
                            alignment: Alignment.center,
                            child: click7 == false
                                ? const VerticalDivider(
                                    thickness: 1,
                                    width: 1,
                                    color: Colors.white,
                                  )
                                : Image.asset(
                                    "assets/images/trianglewhite.png"),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 3 - 20,
                            alignment: Alignment.center,
                            child: click8 == false
                                ? const VerticalDivider(
                                    thickness: 1,
                                    width: 1,
                                    color: Colors.white,
                                  )
                                : Image.asset(
                                    "assets/images/trianglewhite.png"),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 3 - 20,
                          alignment: Alignment.center,
                          child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  click6 = true;
                                  click7 = false;
                                  click8 = false;
                                });
                              },
                              child: Text(
                                "Quickfire",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: click6 == true
                                        ? FontWeight.w600
                                        : FontWeight.w500),
                              )),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 3 - 20,
                          alignment: Alignment.center,
                          child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  click7 = true;
                                  click6 = false;
                                  click8 = false;
                                });
                              },
                              child: Text(
                                "Regular",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: click7 == true
                                        ? FontWeight.w600
                                        : FontWeight.w500),
                              )),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 3 - 20,
                          alignment: Alignment.center,
                          child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  click8 = true;
                                  click7 = false;
                                  click6 = false;
                                });
                              },
                              child: Text(
                                "Olympiad",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: click8 == true
                                        ? FontWeight.w600
                                        : FontWeight.w500),
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
                                      builder: (context) => const QuizPage()));
                            },
                            child: const Text(
                              "GO BACK",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14),
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
                              if (click1 == true) {
                                setState(() {
                                  difficultylevelid = "3";
                                });
                              } else if (click2 == true) {
                                setState(() {
                                  difficultylevelid = "2";
                                });
                              } else if (click3 = true) {
                                setState(() {
                                  difficultylevelid = "1";
                                });
                              }
                              if (click6 == true) {
                                setState(() {
                                  speedid = "1";
                                });
                              } else if (click7 == true) {
                                setState(() {
                                  speedid = "2";
                                });
                              } else if (click8 = true) {
                                setState(() {
                                  speedid = "3";
                                });
                              }
                              if (kDebugMode) {
                                print(domainnamelist.toString());
                              }
                              log("hi");
                              log(difficultylevelid);
                              log("speedid$speedid");
                              log(domainnamelist.toString());
                              log(domainnamelist
                                  .toString()
                                  .replaceAll("[", "")
                                  .replaceAll("]", ""));
                              log(_getTitle());
                              seldomain = "";
                              for (int i = 0; i < databean!.length; i++) {
                                if (!databean![i].issel!) {
                                  if (databean![i].id != 0) {
                                    if (seldomain.isNotEmpty) {
                                      setState(() {
                                        seldomain =
                                            "$seldomain,${databean![i].id}";
                                      });
                                    } else {
                                      setState(() {
                                        seldomain =
                                            "$seldomain${databean![i].id}";
                                      });
                                    }
                                  }
                                }
                              }
                              if (kDebugMode) {
                                print(seldomain);
                              }
                              if (seldomain.isNotEmpty) {
                                createquiz(userid.toString(), difficultylevelid,
                                    speedid, seldomain);
                              } else {
                                showInSnackBar("Please select domain");
                              }
                            },
                            child: const Text(
                              "LET'S GO!",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget domainwidget(domaindata) {
    // List<bool> isChecked = List<bool>.filled(domaindata.length, false);
    return databean == null
        ? Container()
        : Container(
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
              child: Column(
                children: [
                  SizedBox(
                    height: click == false
                        ? MediaQuery.of(context).size.height / 6
                        : MediaQuery.of(context).size.height / 2,
                    child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: databean!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                              child:
                                  domainrow(context, index, databean!.length));
                        }),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        click = !click;
                      });
                    },
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: click == false
                            ? Image.asset(
                                'assets/images/down_arrow.png',
                                height: 20,
                                width: 20,
                                color: ColorConstants.txt,
                              )
                            : Image.asset(
                                'assets/images/down_arrow_small.png',
                                height: 20,
                                width: 20,
                                color: ColorConstants.txt,
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }

  Widget domainrow(BuildContext context, int index, int length) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                databean![index].name!,
                style: const TextStyle(fontSize: 18),
              ),
              GestureDetector(
                onTap: () {
                  accept(index);
                },
                child: databean![index].issel == false
                    ? SizedBox(
                        width: 20,
                        height: 20,
                        child: Image.asset(
                          "assets/images/check_box_with_tick.png",
                          height: 20,
                          width: 20,
                        ),
                      )
                    : SizedBox(
                        width: 20,
                        height: 20,
                        child: Image.asset(
                          "assets/images/check_box.png",
                          height: 20,
                          width: 20,
                        ),
                      ),
              )
            ],
          ),
        ),
      ],
    );
  }

  void accept(int index) {
    Domain? domain;
    if (index == 0) {
      bool? issel = !databean![0].issel!;
      for (int i = 0; i < databean!.length; i++) {
        domain = databean![i];
        domain.issel = issel;
        databean![i] = domain;
      }
      updateData(databean!.toList());
    } else {
      Domain domain = getItem(index);
      domain.issel = !domain.issel!;
      databean![index] = domain;
      updateData(databean!.toList());
    }
  }

  void updateData(List<Domain> list) {
    setState(() {
      databean!.clear();
      databean!.addAll(list);
    });

    notifyListeners(); // To rebuild the Widget
  }

  Domain getItem(int pos) {
    return databean!.elementAt(pos);
  }
}
