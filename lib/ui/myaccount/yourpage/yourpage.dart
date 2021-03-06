import 'dart:convert';
import 'dart:developer';

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_echarts/flutter_echarts.dart';
import 'package:CultreApp/colors/colors.dart';
import 'package:CultreApp/modal/badgeresponse/GetBadgeResponse.dart';
import 'package:CultreApp/modal/leaderboardrank/GetLeaderboardRank.dart';
import 'package:CultreApp/modal/xpgainchart/GetXPGainChartResponse.dart';
import 'package:CultreApp/ui/myaccount/myaccount_page.dart';
import 'package:CultreApp/ui/rightdrawer/right_drawer.dart';
import 'package:CultreApp/ui/homepage/homepage.dart';
import 'package:getwidget/components/progress_bar/gf_progress_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import '../../../modal/getuserleagueresponse/GetUserLeagueResponse.dart'
    as GetUserLeagueResponse;
import '../../../modal/userprofile/GetUserProfileResponse.dart';
import '../../../utils/StringConstants.dart';
import '../personalinfo/personalinfo.dart';

class YourPage extends StatefulWidget {
  const YourPage({Key? key}) : super(key: key);

  @override
  _YourPageState createState() => _YourPageState();
}

class _YourPageState extends State<YourPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController numquizcontroller = TextEditingController();
  var username;
  var email;
  var country;
  String? profilepic;
  var userid;
  var agegroup;
  var flagicon;
  var prodata;
  var data;
  var datab;
  var xpdata;
  var leaderdata;
  var goaldata;
  var goalsummarydata;
  var badgedata;
  User? userprofileresdata;
  var snackBar;
  var userleagdata;
  List<num>? xplist;
  GetBadgeResponse? badgeResponse;
  GetXpGainChartResponse? getXpGainChartResponse;
  GetLeaderboardRank? getleaderboardR;
  GetUserLeagueResponse.GetUserLeagueResponse? userLeagueR;
  final List<String> goallist = <String>[
    'Monthly',
    'Weekly',
    'Daily'
  ]; //for goal list
  var goalname;
  //TooltipBehavior _tooltipBehavior=TooltipBehavior(enable: true);
// selected goal
  userdata() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString("username");
      country = prefs.getString("country");
      userid = prefs.getString("userid");
    });

    getUserProfile(userid.toString());
  }

  getuserleague(String userid) async {
    //showLoaderDialog(context);
    http.Response response = await http.get(
        Uri.parse("${StringConstants.BASE_URL}userleague?user_id=$userid"));

    var jsonResponse = convert.jsonDecode(response.body);
    if (response.statusCode == 200) {
      // Navigator.pop(context);
      data = response.body;

      if (jsonResponse['status'] == 200) {
        setState(() {
          userleagdata = jsonDecode(
              data!)['data']; //get all the data from json string superheros
          print(userleagdata.length);
        });
        getuserleagueresponse(
            GetUserLeagueResponse.getUserLeagueResponseFromJson(data!));
        // var venam = userleagdata(data!)['data'];
        // print(venam.toString());
      } else {
        snackBar = SnackBar(
          content: Text(jsonResponse['message']),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } else {
      // Navigator.pop(context);
      // onsuccess(null);
      print(response.statusCode);
    }
  }

  getuserleagueresponse(
      GetUserLeagueResponse.GetUserLeagueResponse userLeagueResponse) {
    if (userLeagueResponse.data != null) {
      setState(() {
        userLeagueR = userLeagueResponse;
      });
    }
  }

  getUserProfile(String userid) async {
    http.Response response = await http.post(
        Uri.parse("${StringConstants.BASE_URL}user_profile"),
        body: {'user_id': userid.toString()});
    var jsonResponse = convert.jsonDecode(response.body);
    if (response.statusCode == 200) {
      data = response.body;
      if (jsonResponse['status'] == 200) {
        //final responseJson = json.decode(response.body);//store response as string
        setState(() {
          prodata = jsonDecode(
              data!)['data']; //get all the data from json string superheros
          print(prodata.length);
          print(prodata.toString());
          print("profileuserdata${prodata['user']}");
          onsuccess(prodata['user']);
        });

        var venam = jsonDecode(data!)['data'];
        print(venam);
      } else {
        snackBar = SnackBar(
          content: Text(jsonResponse['message']),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } else {
      print(response.statusCode);
    }
  }

  onsuccess(prodataa) {
    if (prodataa != null) {
      setState(() {
        // userprofileresdata=jsonDecode;
        username =
            "${prodataa['name'][0].toUpperCase() + prodataa['name'].substring(1)}";
        country = "${prodataa['country']}";
        profilepic = prodataa['image'].toString();
        agegroup = prodataa['age_group'].toString();
        flagicon = prodataa['flag_icon'].toString();
      });
      print("flagicon" + flagicon);
      xpgainchart(userid.toString(), "");
      getbadges(userid.toString(), "");
      goalsummary(userid.toString());
      getuserleague(userid.toString());
      var date = DateTime.now();
      var month;
      if (date.month == 1) {
        month = "jan";
      } else if (date.month == 2) {
        month = "feb";
      } else if (date.month == 3) {
        month = "mar";
      } else if (date.month == 4) {
        month = "apr";
      } else if (date.month == 5) {
        month = "may";
      } else if (date.month == 6) {
        month = "jun";
      } else if (date.month == 7) {
        month = "jul";
      } else if (date.month == 8) {
        month = "aug";
      } else if (date.month == 9) {
        month = "sep";
      } else if (date.month == 10) {
        month = "oct";
      } else if (date.month == 11) {
        month = "nov";
      } else if (date.month == 12) {
        month = "dec";
      }
      log(date.month.toString());
      leaderboardranking(userid.toString(), month.toString(), "");
    }
  }

  xpgainchart(String userid, String contactid) async {
    http.Response response = await http
        .post(Uri.parse("${StringConstants.BASE_URL}xpgainchart"), body: {
      'user_id': userid.toString(),
      'contact_id': contactid.toString()
    });

    if (response.statusCode == 200) {
      data = response.body;
      var jsonResponse = convert.jsonDecode(response.body);
      if (jsonResponse['status'] == 200) {
        setState(() {
          xpdata = jsonResponse; //get all the data from json string superheros
          print(xpdata.length);
          print(xpdata.toString());
          print("mnth : ${jsonResponse['data']['mnth']}");
          print("totalxp${jsonResponse['data']['totalxp']}");
          print("max${jsonResponse['data']['max']}");
          print("totalquiz${jsonResponse['data']['totalquiz']}");

          onxpsuccess(xpdata, getXpGainChartResponseFromJson(data!));
        });

        var venam = jsonDecode(data!)['data'];
        print(venam);
      } else {
        snackBar = SnackBar(
          content: Text(jsonResponse['message']),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } else {
      print(response.statusCode);
    }
  }

  onxpsuccess(xpdata, GetXpGainChartResponse? getXpGainChartR) {
    //  xplist=List.from(xpdata['data']['mnth']);
    print("mnth : ${xpdata['data']['mnth']}");
    print("userdata${xpdata['data']['totalxp']}");
    print("userdata${xpdata['data']['max']}");
    print("userdata${xpdata['data']['totalquiz']}");
    if (getXpGainChartR != null) {
      if (getXpGainChartR.data != null) {
        setState(() {
          getXpGainChartResponse = getXpGainChartR;
        });
      }
    }
  }

  leaderboardranking(String userid, String month, String contactid) async {
    http.Response response = await http.post(
        Uri.parse("${StringConstants.BASE_URL}leaderboardranking"),
        body: {
          'user_id': userid.toString(),
          'contact_id': contactid.toString(),
          'month': month.toString()
        });

    if (response.statusCode == 200) {
      data = response.body;
      var jsonResponse = convert.jsonDecode(response.body);
      if (jsonResponse['status'] == 200) {
        setState(() {
          leaderdata = jsonResponse[
              'data']; //get all the data from json string superheros
          print(leaderdata.length);
          print(leaderdata.toString());

          onleadersuccess(getLeaderboardRankFromJson(data));
        });
      } else {
        snackBar = SnackBar(
          content: Text(jsonResponse['message']),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } else {
      print(response.statusCode);
    }
  }

  var color_bar = [];

  int index = 0;
  onleadersuccess(GetLeaderboardRank? leaderboardRank) {
    if (leaderboardRank != null) {
      if (leaderboardRank.data != null) {
        setState(() {
          getleaderboardR = leaderboardRank;
        });
      }

      for (int i = 0; i < getleaderboardR!.data!.rank!.length; i++) {
        setState(() {
          index = i;
        });
      }

      log("rank : ${leaderdata['rank']}");
      log("rank : $leaderdata");
    }
  }

  getbadges(String userid, String contactid) async {
    http.Response response = await http
        .post(Uri.parse("${StringConstants.BASE_URL}badges"), body: {
      'user_id': userid.toString(),
      'contact_id': contactid.toString()
    });

    if (response.statusCode == 200) {
      datab = response.body;
      var jsonResponse = convert.jsonDecode(response.body);
      if (jsonResponse['status'] == 200) {
        setState(() {
          badgedata =
              jsonResponse; //get all the data from json string superheros
          print(badgedata.length);
          print(badgedata.toString());
          print(badgedata['data'].toString());

          // onbadgesuccess(badgedata);
          onbadgesuccess(badgedata);
        });

        var venam = jsonDecode(data!)['data'];
        print(venam);
      } else {
        snackBar = SnackBar(
          content: Text(jsonResponse['message']),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } else {
      print(response.statusCode);
    }
  }

  onbadgesuccess(badgedata) {
    //  xplist=List.from(xpdata['data']['mnth']);
    if (badgedata != null) {
      print("badgedata : ${badgedata['data']}");
      print("badgedata : ${badgedata['data'][0]['image']}");
      print("badgedata : ${badgedata['data'][0]['title']}");
      print("badgedata : ${badgedata['data'][0]['description']}");
    }
  }

  setgoals(String userid, String number, String type) async {
    http.Response response =
        await http.post(Uri.parse("${StringConstants.BASE_URL}goals"), body: {
      'user_id': userid.toString(),
      'no': number.toString(),
      'type': type.toLowerCase().toString()
    });

    if (response.statusCode == 200) {
      data = response.body;
      var jsonResponse = convert.jsonDecode(response.body);
      if (jsonResponse['status'] == 200) {
        setState(() {
          goaldata =
              jsonResponse; //get all the data from json string superheros
          print(goaldata.length);
          print(goaldata.toString());
          print("data : ${jsonResponse['data']}");

          ongoalsuccess(goaldata);
          // numquizcontroller.text="";
          // goalname=null;
        });

        var venam = jsonDecode(data!)['data'];
        print(venam);
      } else {
        snackBar = SnackBar(
          content: Text(jsonResponse['message']),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        // setState(() {
        //   numquizcontroller.text="";
        //   goalname=null;
        // });

      }
    } else {
      print(response.statusCode);
    }
  }

  ongoalsuccess(goaldata) {
    print("data : ${goaldata['data']}");
  }

  goalsummary(String userid) async {
    // showLoaderDialog(context);
    http.Response response = await http.post(
        Uri.parse("${StringConstants.BASE_URL}goalsummary"),
        body: {'user_id': userid.toString()});

    if (response.statusCode == 200) {
      data = response.body;
      var jsonResponse = convert.jsonDecode(response.body);
      if (jsonResponse['status'] == 200) {
        setState(() {
          goalsummarydata =
              jsonResponse; //get all the data from json string superheros
          print(goalsummarydata.length);
          print(goalsummarydata.toString());
          print("data : ${jsonResponse['data']}");

          goalsummarysuccess(goalsummarydata);
        });

        var venam = jsonDecode(data!)['data'];
        print(venam);
      } else {
        snackBar = SnackBar(
          content: Text(jsonResponse['message']),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } else {
      // Navigator.pop(context);
      print(response.statusCode);
    }
  }

  goalsummarysuccess(goalsummarydata) {
    print("data : ${goalsummarydata['data']}");
    print("total : ${goalsummarydata['data']['total']}");
    print("play : ${goalsummarydata['data']['play']}");
    print("type : ${goalsummarydata['data']['type']}");
  }

  // showLoaderDialog(BuildContext context) {
  //   AlertDialog alert = AlertDialog(
  //     content: new Row(
  //       children: [
  //         CircularProgressIndicator(),
  //         Container(
  //             margin: EdgeInsets.only(left: 7), child: Text("Loading...")),
  //       ],
  //     ),
  //   );
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return alert;
  //     },
  //   );
  // }
  var badgedetaildata;
  getbadgedetails(String userid, String badgesId) async {
    http.Response response = await http.post(
        Uri.parse("${StringConstants.BASE_URL}badges_details"),
        body: {'user_id': userid.toString(), 'badges_id': badgesId.toString()});

    if (response.statusCode == 200) {
      datab = response.body;
      var jsonResponse = convert.jsonDecode(response.body);
      if (jsonResponse['status'] == 200) {
        setState(() {
          badgedetaildata =
              jsonResponse; //get all the data from json string superheros
          print(badgedetaildata.length);
          print(badgedetaildata.toString());
          print(badgedetaildata['data'].toString());

          // onbadgesuccess(badgedata);
          onbadgedetails(badgedetaildata);
        });

        var venam = jsonDecode(data!)['data'];
        print(venam);
      } else {
        snackBar = SnackBar(
          content: Text(jsonResponse['message']),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } else {
      print(response.statusCode);
    }
  }

  onbadgedetails(badgedetaildata) {
    //  xplist=List.from(xpdata['data']['mnth']);
    if (badgedata != null) {
      print("badgedata : ${badgedetaildata['data']}");
    }
    print("badgedata : ${badgedetaildata['data']['image']}");
    print("badgedata : ${badgedetaildata['data']['title']}");
    print("badgedata : ${badgedetaildata['data']['description']}");
    if (badgedetaildata != null) {
      AlertDialog alert = AlertDialog(
        insetPadding: const EdgeInsets.all(4),
        titlePadding: const EdgeInsets.all(4),
        contentPadding: const EdgeInsets.all(4),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        content: Container(
          height: 180,
          width: 250,
          alignment: Alignment.center,
          child: Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            height: 180,
            width: 250,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  height: 80,
                  width: 80,
                  child: CircleAvatar(
                    radius: 30.0,
                    backgroundImage: NetworkImage(
                        badgedetaildata['data']['image'].toString()),
                    backgroundColor: Colors.transparent,
                  ),
                ),
                Text(badgedetaildata['data']['title'].toString(),
                    style: const TextStyle(
                        fontSize: 18,
                        color: ColorConstants.txt,
                        fontWeight: FontWeight.w600)),
                Text(
                  badgedetaildata['data']['message'].toString(),
                  style: const TextStyle(
                    fontSize: 18,
                    color: ColorConstants.txt,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      );
      showDialog(
          context: context,
          builder: (BuildContext context) {
            Future.delayed(
              const Duration(seconds: 3),
              () {
                Navigator.of(context).pop(true);
              },
            );
            return alert;
          });
    }
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
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => const MyAccountPage()));
    // Do some stuff.
    return true;
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return Scaffold(
      key: _scaffoldKey,
      //resizeToAvoidBottomInset: false,
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
          child: Stack(children: [
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                color: Colors.white,
                margin: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                height: 80,
                child: Row(
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
              ),
            ),
            Container(
              alignment: const Alignment(0, 100),
              // height: MediaQuery.of(context).size.height-120,
              margin: const EdgeInsets.fromLTRB(0, 90, 0, 10),
              child: ListView(
                children: [
                  Container(
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.fromLTRB(0, 30, 0, 10),
                      child: const Text("YOUR PAGE",
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.black,
                            fontFamily: 'Nunito',
                            fontStyle: FontStyle.normal,
                          ))),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: const Text(
                        "You can find about your performance, your goals, and your achievements here.",
                        style: TextStyle(
                            fontSize: 15,
                            color: ColorConstants.txt,
                            fontFamily: 'Nunito',
                            fontStyle: FontStyle.normal)),
                  ),
                  (prodata == null &&
                          xpdata == null &&
                          goalsummarydata == null &&
                          goaldata == null)
                      ? Container(
                          color: Colors.transparent,
                          height: MediaQuery.of(context).size.height,
                          child: const Center(
                              child: CircularProgressIndicator(
                            color: Colors.blueAccent,
                          )),
                        )
                      : ListBody(
                          children: [
                            Card(
                              child: Column(
                                children: [
                                  Container(
                                      margin: const EdgeInsets.fromLTRB(
                                          0, 10, 0, 10),
                                      height: 200,
                                      decoration: const BoxDecoration(
                                        color: Colors.red,
                                      ),
                                      child: Column(
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            alignment: Alignment.topRight,
                                            child: GestureDetector(
                                              onTap: () {
                                                Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const PersonalInfoScreen()));
                                              },
                                              child: Container(
                                                margin:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 10, 10, 10),
                                                height: 30,
                                                width: 30,
                                                alignment: Alignment.topRight,
                                                padding:
                                                    const EdgeInsets.all(4),
                                                decoration: const BoxDecoration(
                                                    color: Colors.white,
                                                    shape: BoxShape.circle),
                                                child: Image.asset(
                                                  "assets/images/editpen.png",
                                                  height: 30,
                                                  width: 30,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.center,
                                            child: Container(
                                              height: 100,
                                              width: 100,
                                              alignment: Alignment.center,
                                              padding: const EdgeInsets.all(4),
                                              decoration: const BoxDecoration(
                                                  color: Colors.red,
                                                  shape: BoxShape.circle),
                                              child: SizedBox(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: 100,
                                                child: profilepic!.isEmpty
                                                    ? const CircleAvatar(
                                                        radius: 30.0,
                                                        backgroundImage: AssetImage(
                                                            "assets/images/placeholder.png"),
                                                        backgroundColor:
                                                            Colors.transparent,
                                                      )
                                                    : CircleAvatar(
                                                        backgroundColor:
                                                            Colors.red,
                                                        child: ClipOval(
                                                            child:
                                                                Image.network(
                                                          profilepic!,
                                                          height: 100,
                                                          width: 100,
                                                          fit: BoxFit.cover,
                                                        ))),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )),
                                  username == null
                                      ? Container()
                                      : Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          alignment: Alignment.center,
                                          child: Text(
                                            "$username",
                                            style: const TextStyle(
                                                color: ColorConstants.txt,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: 'Nunito',
                                                fontStyle: FontStyle.normal),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                  agegroup == null &&
                                          country == null &&
                                          flagicon == null
                                      ? Container()
                                      : Container(
                                          margin: const EdgeInsets.fromLTRB(
                                              0, 10, 0, 10),
                                          width:
                                              MediaQuery.of(context).size.width,
                                          alignment: Alignment.center,
                                          height: 20,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "$agegroup",
                                                style: const TextStyle(
                                                    color: ColorConstants.txt,
                                                    fontSize: 14,
                                                    fontFamily: 'Nunito',
                                                    fontStyle:
                                                        FontStyle.normal),
                                                textAlign: TextAlign.center,
                                              ),
                                              const VerticalDivider(
                                                  color: Colors.black),
                                              // Text("|"),
                                              Row(
                                                children: [
                                                  Container(
                                                      height: 20,
                                                      width: 20,
                                                      decoration:
                                                          const BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle),
                                                      child: CircleAvatar(
                                                        radius: 20.0,
                                                        backgroundImage:
                                                            NetworkImage(
                                                                "$flagicon"),
                                                        backgroundColor:
                                                            Colors.transparent,
                                                      )),
                                                  Text(
                                                    "$country",
                                                    style: const TextStyle(
                                                        color:
                                                            ColorConstants.txt,
                                                        fontSize: 14,
                                                        fontFamily: 'Nunito',
                                                        fontStyle:
                                                            FontStyle.normal),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                  userLeagueR == null
                                      ? Container(
                                          margin: const EdgeInsets.fromLTRB(
                                              0, 10, 10, 20),
                                          height: 20,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                              color: ColorConstants.red,
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: Container(
                                            margin: EdgeInsets.fromLTRB(
                                                MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    7,
                                                0,
                                                0,
                                                0),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                5,
                                            decoration: BoxDecoration(
                                                color:
                                                    ColorConstants.stage1color,
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: Container(
                                              margin: EdgeInsets.fromLTRB(
                                                  MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      7,
                                                  0,
                                                  0,
                                                  0),
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  5,
                                              decoration: BoxDecoration(
                                                  color: ColorConstants
                                                      .stage2color,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              child: Container(
                                                margin: EdgeInsets.fromLTRB(
                                                    MediaQuery.of(context)
                                                            .size
                                                            .width /
                                                        7,
                                                    0,
                                                    0,
                                                    0),
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    5,
                                                decoration: BoxDecoration(
                                                    color: ColorConstants
                                                        .stage3color,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                child: Container(
                                                  margin: EdgeInsets.fromLTRB(
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width /
                                                          7,
                                                      0,
                                                      0,
                                                      0),
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      5,
                                                  decoration: BoxDecoration(
                                                      color: ColorConstants
                                                          .stage5color,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20)),
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      : Container(
                                          margin: const EdgeInsets.fromLTRB(
                                              10, 0, 10, 20),
                                          height: 20,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                              color: ColorConstants.red,
                                              image: userLeagueR!
                                                          .data!.user!.id ==
                                                      5
                                                  ? const DecorationImage(
                                                      image: AssetImage(
                                                          "assets/images/trianglewhite.png"),
                                                      alignment:
                                                          Alignment(-.85, 0),
                                                      fit: BoxFit.fitHeight,
                                                      scale: 1)
                                                  : const DecorationImage(
                                                      image: AssetImage(
                                                          "assets/images/trianglewhite.png"),
                                                      alignment:
                                                          Alignment.centerRight,
                                                      fit: BoxFit.fitHeight,
                                                      scale: 1),
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: Container(
                                            margin: EdgeInsets.fromLTRB(
                                                MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    7,
                                                0,
                                                0,
                                                0),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                5,
                                            decoration: BoxDecoration(
                                                color:
                                                    ColorConstants.stage1color,
                                                image: userLeagueR!
                                                            .data!.user!.id ==
                                                        4
                                                    ? const DecorationImage(
                                                        image: AssetImage(
                                                            "assets/images/trianglewhite.png"),
                                                        alignment:
                                                            Alignment(-.8, 0),
                                                        fit: BoxFit.fitHeight,
                                                        scale: 1)
                                                    : const DecorationImage(
                                                        image: AssetImage(
                                                            "assets/images/trianglewhite.png"),
                                                        alignment: Alignment
                                                            .centerRight,
                                                        fit: BoxFit.fitHeight,
                                                        scale: 1),
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: Container(
                                              margin: EdgeInsets.fromLTRB(
                                                  MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      7,
                                                  0,
                                                  0,
                                                  0),
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  5,
                                              decoration: BoxDecoration(
                                                  color: ColorConstants
                                                      .stage2color,
                                                  image: userLeagueR!
                                                              .data!.user!.id ==
                                                          3
                                                      ? const DecorationImage(
                                                          image: AssetImage(
                                                              "assets/images/trianglewhite.png"),
                                                          alignment: Alignment(
                                                              -.75, 0),
                                                          fit: BoxFit.fitHeight,
                                                          scale: 1)
                                                      : const DecorationImage(
                                                          image: AssetImage(
                                                              "assets/images/trianglewhite.png"),
                                                          alignment: Alignment
                                                              .centerRight,
                                                          fit: BoxFit.fitHeight,
                                                          scale: 1),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              child: Container(
                                                margin: EdgeInsets.fromLTRB(
                                                    MediaQuery.of(context)
                                                            .size
                                                            .width /
                                                        7,
                                                    0,
                                                    0,
                                                    0),
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    5,
                                                decoration: BoxDecoration(
                                                    color: ColorConstants
                                                        .stage3color,
                                                    image: userLeagueR!.data!
                                                                .user!.id ==
                                                            2
                                                        ? const DecorationImage(
                                                            image: AssetImage(
                                                                "assets/images/trianglewhite.png"),
                                                            alignment: Alignment(
                                                                -.6, 0),
                                                            fit: BoxFit
                                                                .fitHeight,
                                                            scale: 1)
                                                        : const DecorationImage(
                                                            image: AssetImage(
                                                                "assets/images/trianglewhite.png"),
                                                            alignment: Alignment
                                                                .centerRight,
                                                            fit: BoxFit
                                                                .fitHeight,
                                                            scale: 1),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                child: Container(
                                                  margin: EdgeInsets.fromLTRB(
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width /
                                                          7,
                                                      0,
                                                      0,
                                                      0),
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      5,
                                                  decoration: BoxDecoration(
                                                      color: ColorConstants
                                                          .stage5color,
                                                      image: userLeagueR!.data!
                                                                  .user!.id ==
                                                              1
                                                          ? const DecorationImage(
                                                              image: AssetImage(
                                                                  "assets/images/trianglewhite.png"),
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              fit: BoxFit
                                                                  .fitHeight,
                                                              scale: 1)
                                                          : const DecorationImage(
                                                              image: AssetImage(
                                                                  "assets/images/trianglewhite.png"),
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              fit: BoxFit
                                                                  .fitHeight,
                                                              scale: -1,
                                                            ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20)),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                ],
                              ),
                            ),
                            badgedata == null
                                ? Container()
                                : Card(
                                    child: Container(
                                      padding: const EdgeInsets.all(5),
                                      margin: const EdgeInsets.fromLTRB(
                                          0, 10, 0, 10),
                                      child: Column(
                                        children: [
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            child: const Text("YOUR BADGES",
                                                style: TextStyle(
                                                    color: ColorConstants.txt,
                                                    fontSize: 16,
                                                    fontFamily: 'Nunito',
                                                    fontStyle:
                                                        FontStyle.normal)),
                                          ),
                                          GridView.builder(
                                              physics: const ClampingScrollPhysics(
                                                  parent:
                                                      BouncingScrollPhysics()),
                                              itemCount:
                                                  badgedata['data'].length,
                                              shrinkWrap: true,
                                              gridDelegate:
                                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                                      crossAxisCount: 3),
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return GestureDetector(
                                                  onTap: () {
                                                    getbadgedetails(
                                                        userid.toString(),
                                                        badgedata['data'][index]
                                                                ['id']
                                                            .toString());
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(5),
                                                    child: SizedBox(
                                                      height: 50,
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      child: Image.network(
                                                        badgedata['data'][index]
                                                                ['image']
                                                            .toString(),
                                                        height: 50,
                                                        width: 50,
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              }),
                                          // Container(
                                          //   child: Image.network("${badgedata['data']['image'].toString()}"),
                                          // )
                                        ],
                                      ),
                                    ),
                                  ),
                            xpdata == null
                                ? Container()
                                : Card(
                                    child: Container(
                                      padding: const EdgeInsets.all(5),
                                      margin: const EdgeInsets.fromLTRB(
                                          0, 10, 0, 10),
                                      child: Column(
                                        children: [
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            child: const Text(
                                                "XP GAIN OVER TIME",
                                                style: TextStyle(
                                                    color: ColorConstants.txt,
                                                    fontSize: 16,
                                                    fontFamily: 'Nunito',
                                                    fontStyle:
                                                        FontStyle.normal)),
                                          ),
                                          getXpGainChartResponse == null
                                              ? Container()
                                              : SizedBox(
                                                  width: 300,
                                                  height: 250,
                                                  child: Echarts(
                                                    option: '''
                                                  {
                                                    xAxis: {
                                                      type: 'category',
                                                      data: ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
                                                    },
                                                    yAxis: {
                                                      type: 'value'
                                                    },
                                                    series: [{
                                                      data: [${getXpGainChartResponse!.data!.mnth![0].xp},
                                                       ${getXpGainChartResponse!.data!.mnth![1].xp},
                                                        ${getXpGainChartResponse!.data!.mnth![2].xp},
                                                         ${getXpGainChartResponse!.data!.mnth![3].xp},
                                                          ${getXpGainChartResponse!.data!.mnth![4].xp},
                                                           ${getXpGainChartResponse!.data!.mnth![5].xp},
                                                            ${getXpGainChartResponse!.data!.mnth![6].xp},
                                                            ${getXpGainChartResponse!.data!.mnth![7].xp},
                                                            ${getXpGainChartResponse!.data!.mnth![8].xp},
                                                            ${getXpGainChartResponse!.data!.mnth![9].xp},
                                                            ${getXpGainChartResponse!.data!.mnth![10].xp},
                                                            ${getXpGainChartResponse!.data!.mnth![11].xp}
                                                            ],
                                                      type: 'bar',
                                                      color: '#F73F0C',
                                                     
                                                   
                                                    }]
                                                  }
                                                ''',
                                                    //       extraScript: '''
                                                    //   chart.on('mouseover', { dataType: 'node' }, (params) => {
                                                    //   if(params.componentType === 'series') {
                                                    //     Messager.postMessage('anything');
                                                    //   }
                                                    //   });
                                                    // ''',
                                                  ),
                                                ),
                                          Container(
                                            alignment: Alignment.center,
                                            child: const Text("2022",
                                                style: TextStyle(
                                                    color: ColorConstants.txt,
                                                    fontSize: 16,
                                                    fontFamily: 'Nunito',
                                                    fontStyle:
                                                        FontStyle.normal)),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.fromLTRB(
                                                20, 10, 20, 10),
                                            alignment: Alignment.center,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  children: [
                                                    Text(
                                                        xpdata['data']
                                                                ['totalxp']
                                                            .toString(),
                                                        style: const TextStyle(
                                                            color:
                                                                ColorConstants
                                                                    .txt,
                                                            fontSize: 14,
                                                            fontFamily:
                                                                'Nunito',
                                                            fontStyle: FontStyle
                                                                .normal)),
                                                    const Text("Total XP",
                                                        style: TextStyle(
                                                            color:
                                                                ColorConstants
                                                                    .txt,
                                                            fontSize: 14,
                                                            fontFamily:
                                                                'Nunito',
                                                            fontStyle: FontStyle
                                                                .normal)),
                                                  ],
                                                ),
                                                Column(
                                                  children: [
                                                    Text(
                                                        xpdata['data']
                                                                ['totalquiz']
                                                            .toString(),
                                                        style: const TextStyle(
                                                            color:
                                                                ColorConstants
                                                                    .txt,
                                                            fontSize: 14,
                                                            fontFamily:
                                                                'Nunito',
                                                            fontStyle: FontStyle
                                                                .normal)),
                                                    const Text("Quizzes Done",
                                                        style: TextStyle(
                                                            color:
                                                                ColorConstants
                                                                    .txt,
                                                            fontSize: 14,
                                                            fontFamily:
                                                                'Nunito',
                                                            fontStyle: FontStyle
                                                                .normal)),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                            getleaderboardR == null
                                ? Container()
                                : Card(
                                    child: Container(
                                      padding: const EdgeInsets.all(5),
                                      margin: const EdgeInsets.fromLTRB(
                                          0, 10, 0, 10),
                                      child: Column(
                                        children: [
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            child: const Text(
                                                "LEADERSHIP RANKING",
                                                style: TextStyle(
                                                    color: ColorConstants.txt,
                                                    fontSize: 16,
                                                    fontFamily: 'Nunito',
                                                    fontStyle:
                                                        FontStyle.normal)),
                                          ),
                                          SizedBox(
                                            width: 300,
                                            height: 250,
                                            child: Echarts(
                                              option: '''
                                                      {
                                                        xAxis: {
                                                          type: 'category',
                                                        
                                                    
                                                        },
                                                        yAxis: {
                                                          type: 'value',
                                                        },
                                                        series: [{
                                                          data:${getleaderboardR!.data!.rank},
                                                          type: 'line',
                                                          color: '#F73F0C',
                                                           nodes: ${getleaderboardR!.data!.rank}
                                                        
                                                        }],
                                                   
                                                      }
                                                    ''',
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.center,
                                            child: const Text("2022",
                                                style: TextStyle(
                                                    color: ColorConstants.txt,
                                                    fontSize: 16,
                                                    fontFamily: 'Nunito',
                                                    fontStyle:
                                                        FontStyle.normal)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                            goalsummarydata == null
                                ? Container()
                                : Card(
                                    child: Container(
                                      padding: const EdgeInsets.all(5),
                                      margin: const EdgeInsets.fromLTRB(
                                          0, 10, 0, 10),
                                      child: Column(
                                        children: [
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            child: const Text("YOUR GOALS",
                                                style: TextStyle(
                                                    color: ColorConstants.txt,
                                                    fontSize: 16,
                                                    fontFamily: 'Nunito',
                                                    fontStyle:
                                                        FontStyle.normal)),
                                          ),
                                          if ((goalsummarydata['data']['play'] /
                                                  (goalsummarydata['data']
                                                      ['total'])) >=
                                              1)
                                            Container(
                                                margin:
                                                    const EdgeInsets.fromLTRB(
                                                        10, 10, 10, 10),
                                                child: GFProgressBar(
                                                  percentage: 1.0,
                                                  lineHeight: 20,
                                                  alignment: MainAxisAlignment
                                                      .spaceBetween,
                                                  backgroundColor:
                                                      Colors.black12,
                                                  progressBarColor:
                                                      ColorConstants.verdigris,
                                                  child: Text(
                                                    '${goalsummarydata['data']['play']} out of ${goalsummarydata['data']['total']}',
                                                    textAlign: TextAlign.left,
                                                    style: const TextStyle(
                                                        fontSize: 14,
                                                        fontFamily: 'Nunito',
                                                        fontStyle:
                                                            FontStyle.normal,
                                                        color: Colors.white),
                                                  ),
                                                )),
                                          if (((goalsummarydata['data']
                                                      ['play']) /
                                                  (goalsummarydata['data']
                                                      ['total'])) <
                                              1)
                                            Container(
                                                margin:
                                                    const EdgeInsets.fromLTRB(
                                                        10, 10, 10, 10),
                                                child: GFProgressBar(
                                                  percentage:
                                                      (goalsummarydata['data']
                                                                  ['play']! /
                                                              goalsummarydata[
                                                                      'data']
                                                                  ['total']!) *
                                                          (0.3).toDouble(),
                                                  lineHeight: 20,
                                                  alignment: MainAxisAlignment
                                                      .spaceBetween,
                                                  backgroundColor:
                                                      Colors.black12,
                                                  progressBarColor:
                                                      ColorConstants.verdigris,
                                                  child: Text(
                                                    '${goalsummarydata['data']['play']} out of ${goalsummarydata['data']['total']}',
                                                    textAlign: TextAlign.left,
                                                    style: const TextStyle(
                                                        fontSize: 14,
                                                        fontFamily: 'Nunito',
                                                        fontStyle:
                                                            FontStyle.normal,
                                                        color: Colors.white),
                                                  ),
                                                )),
                                        ],
                                      ),
                                    ),
                                  ),
                            Container(
                                height: 40,
                                alignment: Alignment.centerLeft,
                                //color: Colors.white,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Colors.black),
                                ),
                                margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: GestureDetector(
                                  onTap: () {
                                    AlertDialog errorDialog = AlertDialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              20.0)), //this right here
                                      title: Container(
                                        height: 150,
                                        width: 100,
                                        padding: const EdgeInsets.all(8),
                                        alignment: Alignment.center,
                                        child: ListView.builder(
                                            physics: const ClampingScrollPhysics(
                                                parent:
                                                    BouncingScrollPhysics()),
                                            shrinkWrap: true,
                                            itemCount: goallist.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return Column(
                                                children: [
                                                  Container(
                                                    //height: 50,
                                                    padding:
                                                        const EdgeInsets.all(4),
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          goalname =
                                                              goallist[index];
                                                          Navigator.pop(
                                                              context);
                                                        });
                                                      },
                                                      child: Text(
                                                        goallist[index],
                                                        style: const TextStyle(
                                                            fontSize: 18,
                                                            color:
                                                                ColorConstants
                                                                    .txt,
                                                            fontFamily:
                                                                'Nunito',
                                                            fontStyle: FontStyle
                                                                .normal),
                                                      ),
                                                    ),
                                                  ),
                                                  const Divider(
                                                    color: Colors.black12,
                                                  )
                                                ],
                                              );
                                            }),
                                      ),
                                    );
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            errorDialog);
                                  },
                                  child: Container(
                                    margin:
                                        const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: goalname == null
                                              ? const Text(
                                                  "Monthly, Weekly or Daily?",
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 14))
                                              : Text("$goalname",
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14,
                                                      fontFamily: 'Nunito',
                                                      fontStyle:
                                                          FontStyle.normal)),
                                        ),
                                        Image.asset(
                                          "assets/images/dropdown.png",
                                          height: 18,
                                          width: 18,
                                        )
                                      ],
                                    ),
                                  ),
                                )),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 60,
                              margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                              child: TextFormField(
                                controller: numquizcontroller,
                                obscureText: false,
                                maxLength: 5,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.zero,
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 1.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.zero,
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 1.0),
                                    ),
                                    hintText: 'Number of Quizzes',
                                    hintStyle: TextStyle(
                                      color: Colors.grey,
                                      fontFamily: 'Nunito',
                                      fontStyle: FontStyle.normal,
                                    )),
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter
                                      .singleLineFormatter
                                ],
                              ),
                            ),
                            Center(
                              child: Container(
                                margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.white,
                                    onPrimary: Colors.white,
                                    elevation: 3,
                                    alignment: Alignment.center,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0)),
                                    fixedSize: const Size(160, 30),
                                    //////// HERE
                                  ),
                                  onPressed: () {
                                    if (numquizcontroller.text.isNotEmpty) {
                                      if (goalname != null) {
                                        setgoals(
                                            userid.toString(),
                                            numquizcontroller.text.toString(),
                                            goalname);
                                      } else {
                                        snackBar = const SnackBar(
                                          content:
                                              Text("please select goal period"),
                                        );
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBar);
                                      }
                                    } else {
                                      snackBar = const SnackBar(
                                        content:
                                            Text("please fill no. of quizzes"),
                                      );
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                    }
                                  },
                                  child: const Text(
                                    "SAVE CHANGES",
                                    style: TextStyle(
                                        color: ColorConstants.txt,
                                        fontSize: 16,
                                        fontFamily: 'Nunito',
                                        fontStyle: FontStyle.normal),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
