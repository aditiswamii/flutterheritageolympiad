import 'dart:convert';

import 'package:back_button_interceptor/back_button_interceptor.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterheritageolympiad/colors/colors.dart';
import 'package:flutterheritageolympiad/modal/badgeresponse/GetBadgeResponse.dart';
import 'package:flutterheritageolympiad/modal/xpgainchart/GetXPGainChartResponse.dart';

import 'package:flutterheritageolympiad/ui/myaccount/myaccount_page.dart';
import 'package:flutterheritageolympiad/ui/rightdrawer/right_drawer.dart';
import 'package:flutterheritageolympiad/ui/homepage/welcomeback_page.dart';
import 'package:getwidget/components/progress_bar/gf_progress_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'dart:convert' as convert;

import '../../../modal/userprofile/GetUserProfileResponse.dart';
import '../../../utils/StringConstants.dart';

class YourPage extends StatefulWidget {
  const YourPage({Key? key}) : super(key: key);

  @override
  _YourPageState createState() => _YourPageState();
}

class _YourPageState extends State<YourPage> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController numquizcontroller = TextEditingController();
  var username;
  var email;
  var country;
  var profilepic;
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
  List<num>? xplist;
  GetBadgeResponse? badgeResponse;
  final List<String> goallist = <String>[
    'Monthly',
    'Weekly',
    'Daily'
  ]; //for goal list
  var goalname; // selected goal
  userdata() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString("username");
      country = prefs.getString("country");
      userid = prefs.getString("userid");
    });

    getUserProfile(userid.toString());
  }

  getUserProfile(String userid) async {
    showLoaderDialog(context);
    http.Response response = await http.post(
        Uri.parse(StringConstants.BASE_URL + "user_profile"),
        body: {'user_id': userid.toString()});

    if (response.statusCode == 200) {
      Navigator.pop(context);
      data = response.body;
      //final responseJson = json.decode(response.body);//store response as string
      setState(() {
        prodata = jsonDecode(
            data!)['data']; //get all the data from json string superheros
        print(prodata.length);
        print(prodata.toString());
        print("profileuserdata" + prodata['user'].toString());
        onsuccess(prodata['user']);
      });

      var venam = jsonDecode(data!)['data'];
      print(venam);
    } else {
      Navigator.pop(context);
      print(response.statusCode);
    }
  }

  onsuccess(jsonDecode) {
    if (jsonDecode != null) {
      setState(() {
        // userprofileresdata=jsonDecode;
        username =
            "${jsonDecode['name'][0].toUpperCase() + jsonDecode['name'].substring(1)}";
        country = "${jsonDecode['country']}";
        profilepic = jsonDecode['image'].toString();
        agegroup = jsonDecode['age_group'].toString();
        flagicon = jsonDecode['flag_icon'].toString();
      });
      print("flagicon" + flagicon);
      xpgainchart(userid.toString(), "");
      getbadges(userid.toString(), "");
      goalsummary(userid.toString());
    }
  }

  xpgainchart(String userid, String contactid) async {
    showLoaderDialog(context);
    http.Response response = await http
        .post(Uri.parse(StringConstants.BASE_URL + "xpgainchart"), body: {
      'user_id': userid.toString(),
      'contact_id': contactid.toString()
    });

    if (response.statusCode == 200) {
      Navigator.pop(context);
      data = response.body;
      var jsonResponse = convert.jsonDecode(response.body);
      if (jsonResponse['status'] == 200) {
        setState(() {
          xpdata = jsonResponse; //get all the data from json string superheros
          print(xpdata.length);
          print(xpdata.toString());
          print("mnth : " + jsonResponse['data']['mnth'].toString());
          print("totalxp" + jsonResponse['data']['totalxp'].toString());
          print("max" + jsonResponse['data']['max'].toString());
          print("totalquiz" + jsonResponse['data']['totalquiz'].toString());

          onxpsuccess(xpdata);
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
      Navigator.pop(context);
      print(response.statusCode);
    }
  }

  onxpsuccess(xpdata) {
    //  xplist=List.from(xpdata['data']['mnth']);
    print("mnth : " + xpdata['data']['mnth'].toString());
    print("userdata" + xpdata['data']['totalxp'].toString());
    print("userdata" + xpdata['data']['max'].toString());
    print("userdata" + xpdata['data']['totalquiz'].toString());
  }

  leaderboardranking(String userid, String month, String contactid) async {
    showLoaderDialog(context);
    http.Response response = await http.post(
        Uri.parse(StringConstants.BASE_URL + "leaderboardranking"),
        body: {
          'user_id': userid.toString(),
          'contact_id': contactid.toString(),
          'month': month.toString()
        });

    if (response.statusCode == 200) {
      Navigator.pop(context);
      data = response.body;
      var jsonResponse = convert.jsonDecode(response.body);
      if (jsonResponse['status'] == 200) {
        setState(() {
          leaderdata =
              jsonResponse; //get all the data from json string superheros
          print(leaderdata.length);
          print(leaderdata.toString());
          print("rank : " + jsonResponse['data']['rank'].toString());

          onleadersuccess(leaderdata);
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
      Navigator.pop(context);
      print(response.statusCode);
    }
  }

  onleadersuccess(leaderdata) {
    print("rank : " + leaderdata['rank'].toString());
  }

  getbadges(String userid, String contactid) async {
    showLoaderDialog(context);
    http.Response response = await http
        .post(Uri.parse(StringConstants.BASE_URL + "badges"), body: {
      'user_id': userid.toString(),
      'contact_id': contactid.toString()
    });

    if (response.statusCode == 200) {
      Navigator.pop(context);
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
      Navigator.pop(context);
      print(response.statusCode);
    }
  }

  onbadgesuccess(badgedata) {
    //  xplist=List.from(xpdata['data']['mnth']);
    if (badgedata != null) print("badgedata : " + badgedata['data'].toString());
    print("badgedata : " + badgedata['data'][0]['image'].toString());
    print("badgedata : " + badgedata['data'][0]['title'].toString());
    print("badgedata : " + badgedata['data'][0]['description'].toString());
  }

  setgoals(String userid, String number, String type) async {
    showLoaderDialog(context);
    http.Response response =
        await http.post(Uri.parse(StringConstants.BASE_URL + "goals"), body: {
      'user_id': userid.toString(),
      'no': number.toString(),
      'type': type.toLowerCase().toString()
    });

    if (response.statusCode == 200) {
      Navigator.pop(context);
      data = response.body;
      var jsonResponse = convert.jsonDecode(response.body);
      if (jsonResponse['status'] == 200) {
        setState(() {
          goaldata =
              jsonResponse; //get all the data from json string superheros
          print(goaldata.length);
          print(goaldata.toString());
          print("data : " + jsonResponse['data'].toString());

          ongoalsuccess(goaldata);
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
      Navigator.pop(context);
      print(response.statusCode);
    }
  }

  ongoalsuccess(goaldata) {
    print("data : " + goaldata['data'].toString());
  }

  goalsummary(String userid) async {
    showLoaderDialog(context);
    http.Response response = await http.post(
        Uri.parse(StringConstants.BASE_URL + "goalsummary"),
        body: {'user_id': userid.toString()});

    if (response.statusCode == 200) {
      Navigator.pop(context);
      data = response.body;
      var jsonResponse = convert.jsonDecode(response.body);
      if (jsonResponse['status'] == 200) {
        setState(() {
          goalsummarydata =
              jsonResponse; //get all the data from json string superheros
          print(goalsummarydata.length);
          print(goalsummarydata.toString());
          print("data : " + jsonResponse['data'].toString());

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
      Navigator.pop(context);
      print(response.statusCode);
    }
  }

  goalsummarysuccess(goalsummarydata) {
    print("data : " + goalsummarydata['data'].toString());
    print("total : " + goalsummarydata['data']['total'].toString());
    print("play : " + goalsummarydata['data']['play'].toString());
    print("type : " + goalsummarydata['data']['type'].toString());
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
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => MyAccountPage()));
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
          margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: ListView(children: [
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
                      margin: const EdgeInsets.fromLTRB(0, 40, 0, 10),
                      child: const Text("YOUR PAGE",
                          style: TextStyle(fontSize: 24, color: Colors.black))),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Text(
                        "You can find about your performanc, your goals, and your achievements here.",
                        style:
                            TextStyle(fontSize: 15, color: ColorConstants.txt)),
                  ),
                  xpdata == null
                      ? Container()
                      : ListBody(
                          children: [
                            Card(
                              child: Column(
                                children: [
                                  Container(
                                      margin: const EdgeInsets.fromLTRB(
                                          0, 10, 0, 10),
                                      height: 200,
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                      ),
                                      child: Column(
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            alignment: Alignment.topRight,
                                            child: Container(
                                              margin: const EdgeInsets.fromLTRB(
                                                  0, 10, 10, 10),
                                              height: 20,
                                              width: 20,
                                              alignment: Alignment.topRight,
                                              padding: EdgeInsets.all(4),
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  shape: BoxShape.circle),
                                              child: Image.asset(
                                                "assets/images/editpen.png",
                                                height: 20,
                                                width: 20,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.center,
                                            child: Container(
                                              height: 100,
                                              width: 100,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(4),
                                              decoration: BoxDecoration(
                                                  color: Colors.red,
                                                  shape: BoxShape.circle),
                                              child: Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: 100,
                                                child: CircleAvatar(
                                                    backgroundColor: Colors.red,
                                                    child: ClipOval(
                                                        child: Image.network(
                                                      profilepic,
                                                      height: 100,
                                                      width: 100,
                                                      fit: BoxFit.cover,
                                                    ))),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    alignment: Alignment.center,
                                    child: Text(
                                      "${username}",
                                      style: TextStyle(
                                          color: ColorConstants.txt,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  username == null
                                      ? Container()
                                      : Container(
                                          margin:
                                              EdgeInsets.fromLTRB(0, 10, 0, 10),
                                          width:
                                              MediaQuery.of(context).size.width,
                                          alignment: Alignment.center,
                                          height: 20,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "${agegroup}",
                                                style: TextStyle(
                                                    color: ColorConstants.txt,
                                                    fontSize: 14),
                                                textAlign: TextAlign.center,
                                              ),
                                              VerticalDivider(
                                                  color: Colors.black),
                                              // Text("|"),
                                              Row(
                                                children: [
                                                  Container(
                                                      height: 20,
                                                      width: 20,
                                                      decoration: BoxDecoration(
                                                          shape:
                                                              BoxShape.circle),
                                                      child: CircleAvatar(
                                                        radius: 20.0,
                                                        backgroundImage:
                                                            NetworkImage(
                                                                "${flagicon}"),
                                                        backgroundColor:
                                                            Colors.transparent,
                                                      )),
                                                  Text(
                                                    "${country}",
                                                    style: TextStyle(
                                                        color:
                                                            ColorConstants.txt,
                                                        fontSize: 14),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                ],
                              ),
                            ),
                            badgedata['data'] == null
                                ? Container()
                                : Card(
                                    child: Container(
                                      padding: EdgeInsets.all(5),
                                      margin: const EdgeInsets.fromLTRB(
                                          0, 10, 0, 10),
                                      child: Column(
                                        children: [
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text("YOUR BADGES",
                                                style: TextStyle(
                                                    color: ColorConstants.txt,
                                                    fontSize: 16)),
                                          ),
                                          GridView.builder(
                                              physics: ClampingScrollPhysics(
                                                  parent:
                                                      BouncingScrollPhysics()),
                                              itemCount:
                                                  badgedata['data'].length,
                                              shrinkWrap: true,
                                              gridDelegate:
                                                  SliverGridDelegateWithFixedCrossAxisCount(
                                                      crossAxisCount: 3),
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return Padding(
                                                  padding: EdgeInsets.all(5),
                                                  child: Container(
                                                         height: 50,
                                                    width: MediaQuery.of(context).size.width,
                                                    child: Image.network(
                                                        "${badgedata['data'][index]['image'].toString()}", height: 50,width: 50,),
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
                                      padding: EdgeInsets.all(5),
                                      margin: const EdgeInsets.fromLTRB(
                                          0, 10, 0, 10),
                                      child: Column(
                                        children: [
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text("XP GAIN OVER TIME",
                                                style: TextStyle(
                                                    color: ColorConstants.txt,
                                                    fontSize: 16)),
                                          ),
                                          // xplist==null?Container():  Container(
                                          //     child: SfSparkLineChart(data:xplist,color: Colors.black,))
                                          //
                                        ],
                                      ),
                                    ),
                                  ),
                            leaderdata == null
                                ? Container()
                                : Card(
                                    child: Container(
                                      padding: EdgeInsets.all(5),
                                      margin: const EdgeInsets.fromLTRB(
                                          0, 10, 0, 10),
                                      child: Column(
                                        children: [
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text("LEADERSHIP RANKING",
                                                style: TextStyle(
                                                    color: ColorConstants.txt,
                                                    fontSize: 16)),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                            goalsummarydata == null
                                ? Container()
                                : Card(
                                    child: Container(
                                      padding: EdgeInsets.all(5),
                                      margin: const EdgeInsets.fromLTRB(
                                          0, 10, 0, 10),
                                      child: Column(
                                        children: [
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text("YOUR GOALS",
                                                style: TextStyle(
                                                    color: ColorConstants.txt,
                                                    fontSize: 16)),
                                          ),
                                          // if((userLeagueR!.data!.goalsummery!.play!/userLeagueR!.data!.goalsummery!.total!)<1)
                                          //   Container(
                                          //       margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                          //       child: GFProgressBar(
                                          //         percentage:
                                          //         (userLeagueR!.data!.goalsummery!.play!/userLeagueR!.data!.goalsummery!.total!)*(0.3).toDouble(),
                                          //         lineHeight: 30,
                                          //         alignment: MainAxisAlignment.spaceBetween,
                                          //         child: Text('${userLeagueR!.data!.goalsummery!.play!} out of ${userLeagueR!.data!.goalsummery!.total}', textAlign: TextAlign.left,
                                          //           style: TextStyle(fontSize: 18, color: Colors.white),
                                          //         ),
                                          //         backgroundColor: Colors.black12,
                                          //         progressBarColor: ColorConstants.verdigris,
                                          //       )
                                          //   ),

                                          if (((goalsummarydata['data']
                                                          ['play'] *
                                                      100) /
                                                  (goalsummarydata['data']
                                                      ['total'])) >=
                                              1)
                                            Container(
                                                margin: EdgeInsets.fromLTRB(
                                                    10, 10, 10, 10),
                                                child: GFProgressBar(
                                                  percentage: 1.0,
                                                  lineHeight: 20,
                                                  alignment: MainAxisAlignment
                                                      .spaceBetween,
                                                  child: Text(
                                                    '${goalsummarydata['data']['play']} out of ${goalsummarydata['data']['total']}',
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.white),
                                                  ),
                                                  backgroundColor:
                                                      Colors.black12,
                                                  progressBarColor:
                                                      ColorConstants.verdigris,
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
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: GestureDetector(
                                  onTap: () {
                                    AlertDialog errorDialog = AlertDialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              20.0)), //this right here
                                      title: Container(
                                        height: 100,
                                        width: 100,
                                        padding: EdgeInsets.all(8),
                                        alignment: Alignment.center,
                                        child: ListView.builder(
                                            physics: ClampingScrollPhysics(
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
                                                    padding: EdgeInsets.all(4),
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          goalname =
                                                              '${goallist[index]}';
                                                          Navigator.pop(
                                                              context);
                                                        });
                                                      },
                                                      child: Text(
                                                        '${goallist[index]}',
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            color:
                                                                ColorConstants
                                                                    .txt),
                                                      ),
                                                    ),
                                                  ),
                                                  Divider(
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
                                    margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: goalname == null
                                              ? Text(
                                                  "Monthly, Weekly or Daily?",
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 14))
                                              : Text("${goalname}",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14)),
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

                              //color: Colors.white,
                              // decoration: BoxDecoration(
                              //   color: Colors.white,
                              //   border: Border.all(color: Colors.black),
                              // ),
                              margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),

                              child: TextFormField(
                                controller: numquizcontroller,
                                obscureText: false,
                                maxLength: 5,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
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
                                    hintStyle: TextStyle(color: Colors.grey)),
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter
                                      .singleLineFormatter
                                ],
                              ),
                            ),
                            Center(
                              child: Container(
                                margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
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
                                  onPressed: () {},
                                  child: const Text(
                                    "SAVE CHANGES",
                                    style: TextStyle(
                                        color: ColorConstants.txt,
                                        fontSize: 16),
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
