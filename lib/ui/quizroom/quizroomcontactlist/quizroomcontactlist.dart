import 'dart:developer';

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:CultreApp/colors/colors.dart';

import 'package:CultreApp/modal/getdueluserlist/GetDuelUserListResponse.dart';

import 'package:CultreApp/ui/rightdrawer/right_drawer.dart';
import 'package:CultreApp/ui/homepage/homepage.dart';
import 'package:CultreApp/utils/stringconstants.dart';

import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../dialog/quizroominvitesent/quizroominvitesent.dart';
import '../quizroominvite/quizroominvitepage.dart';

class QuizRoomContactList extends StatefulWidget {
  var quiztypeid;
  var quizspeedid;
  var difficultylevelid;
  var quizid;
  var type;
  var seldomain;
  var link;
  QuizRoomContactList(
      {Key? key,
      required this.quizspeedid,
      required this.quiztypeid,
      required this.quizid,
      required this.type,
      required this.difficultylevelid,
      required this.seldomain,
      required this.link})
      : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<QuizRoomContactList> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool value = false;
  var snackBar;
  var contactdata;
  var data;
  var username;
  var country;
  var userid;
  int ishide = 0;

  bool ishideb = false;
  List<Data>? contactpos;
  var cont;
  userdata() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString("username");
      country = prefs.getString("country");
      userid = prefs.getString("userid");
    });
    getUserlist(userid.toString(), widget.quizid, 0);
  }

  getUserlist(String userid, String dualid, int isHide) async {
    http.Response response = await http
        .post(Uri.parse("${StringConstants.BASE_URL}get_all_contacts"), body: {
      'user_id': userid.toString(),
      'dual_id': dualid.toString(),
      'hide_busy': isHide.toString()
    });
    showLoaderDialog(context);

    print("getUserlistapi");
    var jsonResponse = convert.jsonDecode(response.body);
    if (response.statusCode == 200) {
      Navigator.pop(context);
      data = response.body;
      if (jsonResponse['status'] == 200) {
        //final responseJson = json.decode(response.body);//store response as string
        contactdata = jsonResponse['data'];
        print("data$contactdata");
        setState(() {
          contactdata = jsonResponse['data'];
          oncontactsuccess(getDuelUserListResponseFromJson(data!));
        });
        //get all the data from json string superheros
        print("length${contactdata.length}");
        // onsuccess(jsonResponse);

      } else {
        snackBar = SnackBar(
          content: Text(
            jsonResponse['message'].toString(),
            textAlign: TextAlign.center,
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        // onsuccess(null);
        log(jsonResponse['message']);
      }
    } else {
      Navigator.pop(context);
      print(response.statusCode);
    }
  }

  oncontactsuccess(GetDuelUserListResponse duelUserListResponseFromJson) {
    if (duelUserListResponseFromJson.data != null) {
      contactpos = duelUserListResponseFromJson.data;
    }
  }

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Container(
              margin: const EdgeInsets.only(left: 7),
              child: const Text("Loading...")),
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

  var invitedata;
  var snackbar;
  void sendinvite(String fromid, String toid, String dualid) async {
    http.Response response = await http.post(
        Uri.parse("${StringConstants.BASE_URL}send_invitation_quiz_room"),
        body: {
          'from_id': fromid.toString(),
          'to_id': toid.toString(),
          'quiz_room_id': dualid.toString()
        });
    var jsonResponse = convert.jsonDecode(response.body);
    if (response.statusCode == 200) {
      if (jsonResponse['status'] == 200) {
        onsuccess();
      } else {
        snackbar = SnackBar(
            content: Text(
          jsonResponse['message'].toString(),
          textAlign: TextAlign.center,
        ));
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
      }
    } else {
      print(response.statusCode);
    }
  }

  void roomstatus(String roomid) async {
    http.Response response = await http.post(
        Uri.parse("${StringConstants.BASE_URL}room_status"),
        body: {'room_id': roomid.toString()});
    var jsonResponse = convert.jsonDecode(response.body);
    if (response.statusCode == 200) {
      if (jsonResponse['status'] == 200) {
        onroomstatus();
      } else {
        snackbar = SnackBar(
            content: Text(
          jsonResponse['message'].toString(),
          textAlign: TextAlign.center,
        ));
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
      }
    } else {
      print(response.statusCode);
    }
  }

  onroomstatus() {}
  onsuccess() {
    log(cont.toString());
    if (cont != null) {
      AlertDialog errorDialog = AlertDialog(
          insetPadding: const EdgeInsets.all(4),
          titlePadding: const EdgeInsets.all(4),
          contentPadding: const EdgeInsets.all(4),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0)), //this right here
          content: Container(
              height: 300,
              width: 250,
              alignment: Alignment.center,
              child: DialogQuizroomInviteSent(
                name: cont!.name,
                id: cont!.id,
                status: cont!.status,
                agegroup: cont!.ageGroup,
                image: cont!.image,
                flagicon: cont!.flagIcon,
                request: cont!.request,
                quizid: widget.quizid.toString(),
              )));
      showDialog(
          context: context,
          builder: (BuildContext context) {
            Future.delayed(
              const Duration(seconds: 5),
              () {
                Navigator.of(context).pop(true);
              },
            );
            return errorDialog;
          });
    }
  }

  @override
  void initState() {
    super.initState();
    BackButtonInterceptor.add(myInterceptor);
    userdata();

    // _presenter = ClassicQuizPresenter(this);
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }

  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) => QuizroomInvite(
              type: widget.type,
              quizid: widget.quizid,
              difficultylevelid: widget.difficultylevelid,
              quiztypeid: widget.quiztypeid,
              seldomain: widget.seldomain,
              quizspeedid: widget.quizspeedid,
              link: widget.link,
              typeq: 0,
            )));
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
      endDrawer: const MySideMenuDrawer(),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/login_bg.jpg"),
            fit: BoxFit.cover,
          ),
        ),
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
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                  child: const Text("QUIZ ROOM",
                      style:
                          TextStyle(fontSize: 24, color: ColorConstants.txt))),
              Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: const Text(
                      "You may choose minimum 2 other player in\nyour contact list to quiz with.",
                      style:
                          TextStyle(fontSize: 15, color: ColorConstants.txt))),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "HIDE BUSY PLAYERS",
                      style: TextStyle(color: ColorConstants.txt, fontSize: 15),
                    ),
                    Checkbox(
                      value: ishideb,
                      onChanged: (value) {
                        setState(() {
                          ishideb = value!;
                        });
                        if (ishideb == true) {
                          setState(() {
                            ishide = 1;
                          });
                        } else {
                          setState(() {
                            ishide = 0;
                          });
                          getUserlist(userid.toString(), widget.quizid, ishide);
                        }
                      },
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: const Divider(
                  color: ColorConstants.txt,
                  height: 2,
                  indent: 10,
                  endIndent: 10,
                  thickness: 2,
                ),
              ),
              contactdata == null
                  ? Container()
                  : Container(
                      margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: ListView.builder(
                          physics: const ClampingScrollPhysics(
                              parent: BouncingScrollPhysics()),
                          shrinkWrap: true,
                          itemCount: contactdata.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                              decoration:
                                  const BoxDecoration(color: Colors.white),
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
                                    Container(
                                      margin:
                                          const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          if (contactdata[index]['image'] != "")
                                            Container(
                                              padding: const EdgeInsets.all(5),
                                              height: 90,
                                              width: 90,
                                              child: CircleAvatar(
                                                radius: 30.0,
                                                backgroundImage: NetworkImage(
                                                    "${contactdata[index]['image']}"),
                                                backgroundColor:
                                                    Colors.transparent,
                                              ),
                                            ),
                                          if (contactdata[index]['image'] == "")
                                            Container(
                                              padding: const EdgeInsets.all(5),
                                              height: 90,
                                              width: 90,
                                              child: const CircleAvatar(
                                                radius: 30.0,
                                                backgroundImage: AssetImage(
                                                    "assets/images/placeholder.png"),
                                                backgroundColor:
                                                    Colors.transparent,
                                              ),
                                            ),
                                          // Image.asset("assets/profile.png",height: 100,width: 100,),
                                          Container(
                                            width: 170,
                                            margin: const EdgeInsets.fromLTRB(
                                                0, 10, 20, 10),
                                            child: Column(
                                              children: [
                                                Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    "${contactdata[index]['name']}",
                                                    style: const TextStyle(
                                                        color:
                                                            ColorConstants.txt,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                  width: 170,
                                                  child: Row(
                                                    children: [
                                                      if (contactdata[index]
                                                              ['age_group'] !=
                                                          null)
                                                        Text(
                                                          "${contactdata[index]['age_group']}",
                                                          style: const TextStyle(
                                                              color:
                                                                  ColorConstants
                                                                      .txt,
                                                              fontSize: 14),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      Container(
                                                          margin:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 5,
                                                                  right: 5),
                                                          child:
                                                              const VerticalDivider(
                                                            color: Colors.black,
                                                            thickness: 1,
                                                            width: 1,
                                                          )),
                                                      // Text("|"),
                                                      Row(
                                                        children: [
                                                          if (contactdata[index]
                                                                  [
                                                                  'flag_icon'] !=
                                                              null)
                                                            Container(
                                                                height: 20,
                                                                width: 20,
                                                                decoration: const BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle),
                                                                child:
                                                                    CircleAvatar(
                                                                  radius: 20.0,
                                                                  backgroundImage:
                                                                      NetworkImage(
                                                                          "${contactdata[index]['flag_icon']}"),
                                                                  backgroundColor:
                                                                      Colors
                                                                          .transparent,
                                                                )),
                                                          if (contactdata[index]
                                                                  ['country'] !=
                                                              null)
                                                            Container(
                                                              margin:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 5),
                                                              width: 70,
                                                              child: Text(
                                                                "${contactdata[index]['country']}",
                                                                style: const TextStyle(
                                                                    color:
                                                                        ColorConstants
                                                                            .txt,
                                                                    fontSize:
                                                                        14),
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                              ),
                                                            ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                if (contactdata[index]
                                                        ['status'] !=
                                                    null)
                                                  Container(
                                                    width: 170,
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      "${contactdata[index]['status']}",
                                                      style: const TextStyle(
                                                          color: ColorConstants
                                                              .txt),
                                                    ),
                                                  ),
                                                ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    primary: ColorConstants
                                                        .yellow200,
                                                    onPrimary: Colors.white,
                                                    elevation: 3,
                                                    alignment: Alignment.center,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        30.0)),
                                                    fixedSize:
                                                        const Size(130, 30),
                                                    //////// HERE
                                                  ),
                                                  onPressed: () {
                                                    setState(() {
                                                      if (contactpos != null) {
                                                        cont =
                                                            contactpos![index];
                                                      }
                                                      //contactpos=contactdata[index];
                                                    });
                                                    if (contactdata[index]
                                                                ['status']
                                                            .toString()
                                                            .isNotEmpty &&
                                                        contactdata[index]
                                                                ['status']
                                                            .toString()
                                                            .contains("Busy")) {
                                                    } else {
                                                      sendinvite(
                                                          userid.toString(),
                                                          contactdata[index]
                                                                  ['id']
                                                              .toString(),
                                                          widget.quizid);
                                                    }
                                                  },
                                                  child: const Text(
                                                    "SEND INVITE",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 14),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          })),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
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
                                builder: (context) => QuizroomInvite(
                                      type: widget.type,
                                      quizid: widget.quizid,
                                      difficultylevelid:
                                          widget.difficultylevelid,
                                      quiztypeid: widget.quiztypeid,
                                      seldomain: widget.seldomain,
                                      quizspeedid: widget.quizspeedid,
                                      link: widget.link,
                                      typeq: 0,
                                    )));
                      },
                      child: const Text(
                        "GO BACK",
                        style: TextStyle(
                            color: ColorConstants.lightgrey200, fontSize: 14),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    // ElevatedButton(
                    //   style: ElevatedButton.styleFrom(
                    //     primary: ColorConstants.verdigris,
                    //     onPrimary: Colors.white,
                    //     elevation: 3,
                    //     alignment: Alignment.center,
                    //     shape: RoundedRectangleBorder(
                    //         borderRadius: BorderRadius.circular(30.0)),
                    //     fixedSize: const Size(100, 40),
                    //     //////// HERE
                    //   ),
                    //   onPressed: () {
                    //     Navigator.pushReplacement(
                    //         context,
                    //         MaterialPageRoute(
                    //             builder: (context) => DuelModeResult(quizid: "",)));
                    //   },
                    //   child: const Text(
                    //     "LET'S GO!",
                    //     style: TextStyle(
                    //         color: ColorConstants.lightgrey200, fontSize: 14),
                    //     textAlign: TextAlign.center,
                    //   ),
                    // ),
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
