import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:CultreApp/ui/quiz/let_quiz.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:flutter/services.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_echarts/flutter_echarts.dart';
import 'package:CultreApp/colors/colors.dart';
import 'package:CultreApp/modal/gettournament/GetTournamentResponse.dart' as TournamentResponse;
import 'package:CultreApp/ui/feed/filterpage/filterpage.dart';

import 'package:CultreApp/ui/rightdrawer/right_drawer.dart';
import 'package:CultreApp/ui/tournamentquiz/filtertour/filtertour.dart';
import 'package:CultreApp/ui/tournamentquiz/waitlist/waitlist.dart';
import 'package:CultreApp/utils/countdowntimer.dart';
import 'package:getwidget/components/progress_bar/gf_progress_bar.dart';
import 'package:intl/intl.dart';

import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../utils/StringConstants.dart';

import 'package:CultreApp/ui/homepage/homepage.dart';
import 'dart:convert' as convert;

import '../../modal/leaderboardrank/GetLeaderboardRank.dart';
import 'leaguerank/leaguerank.dart';
class TournamentPage extends StatefulWidget {
  var contents;
  var themes;
  var seldomain;
  TournamentPage({Key? key,required this.seldomain,required this.contents,required this.themes}) : super(key: key);

  @override
  _TournamentPageState createState() => _TournamentPageState();
}

class _TournamentPageState extends State<TournamentPage> with TickerProviderStateMixin{
  TextEditingController controller = TextEditingController();
  PageController _pageController = PageController();
 // AnimationController? _controller;
  // TextEditingController controller = TextEditingController();
  // List<Data> _searchResult = [];
  // List<Data> _userDetails = [];
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  var username;
  var email;
  var country;
  var profilepic;
  var userid;
  var tourdata;
  var data;
  var snackBar;
  var _expanded=false;
  TournamentResponse.GetTournamentResponse? gettourR;
  GetLeaderboardRank? getleaderboardR;
  Duration myDuration = Duration(days: 1);
  var leaderdata;
  userdata() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString("username");
      country = prefs.getString("country");
      userid = prefs.getString("userid");
    });
   // log(widget.contents!);
   //  log(widget.seldomain!);
   //  log(widget.themes!);
    getTour(userid.toString(),"",widget.contents!.isNotEmpty ?widget.contents!:"",widget.seldomain!.isNotEmpty ?widget.seldomain!:"",widget.themes!.isNotEmpty ?widget.themes!:"",);
  }
  getTour(String userid,String search,String tournamentType,String domainid,String themeid) async {

    if (search != "") {
      http.Response response =
      await http.get(
          Uri.parse("${StringConstants.BASE_URL}tournament?user_id=$userid&tournament_type=$tournamentType&domain_id=$domainid&theme_id=$themeid"));

      if (response.statusCode == 200) {
        data = response.body;
        //final responseJson = json.decode(response.body);//store response as string
        setState(() {
          tourdata = jsonDecode(
              data!)['data']; //get all the data from json string superheros
          print(tourdata.length);
          onsuccess(TournamentResponse.getTournamentResponseFromJson(data!));
        });

        var venam = jsonDecode(data!)['data'];
        print(venam);
      } else {
        print(response.statusCode);
      }
    }else{

      http.Response response =
      await http.get(
          Uri.parse("${StringConstants.BASE_URL}tournament?user_id=$userid&search=$search"));

      if (response.statusCode == 200) {
        data = response.body;
        //final responseJson = json.decode(response.body);//store response as string
        setState(() {
          tourdata = jsonDecode(
              data!)['data']; //get all the data from json string superheros
          print(tourdata.length);
          onsuccess(TournamentResponse.getTournamentResponseFromJson(data!));
        });

        var venam = jsonDecode(data!)['data'];
        print(venam);
      } else {
        print(response.statusCode);
      }
    }
  }
 onsuccess(TournamentResponse.GetTournamentResponse tournamentResponse){

    if(tournamentResponse.data!=null){
      setState(() {
        gettourR=tournamentResponse;
      });
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
  joinroom(String userid,int tournamentId, int sessionId ,int pos) async {
  http.Response response = await http.post(
  Uri.parse(StringConstants.BASE_URL + "join_tournament"),
  body: {
    'user_id':userid.toString(),
    'tournament_id': tournamentId.toString(),
    'session_id': sessionId.toString()});


  print("getTourRoomapi");
  var jsonResponse = convert.jsonDecode(response.body);
  if (response.statusCode == 200) {

  data = response.body;
  if (jsonResponse['status'] == 200) {
  //final responseJson = json.decode(response.body);//store response as string
    setJoined(pos);
  } else {
    snackBar = SnackBar(
        content: Text(
          jsonResponse['message'].toString(),
          textAlign: TextAlign.center,));
    ScaffoldMessenger.of(context)
        .showSnackBar(snackBar);
  log(jsonResponse['message']);
  }
  } else {

  print(response.statusCode);
  }
}

  setJoined(int pos) {
    getTour(userid.toString(),"",widget.contents!.isNotEmpty ?widget.contents!:"",widget.seldomain!.isNotEmpty ?widget.seldomain!:"",widget.themes!.isNotEmpty ?widget.themes!:"",);
   }
  leaderboardranking(String userid, String month, String contactid) async {
    http.Response response = await http.post(
        Uri.parse(StringConstants.BASE_URL + "leaderboardranking"),
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

      log("rank : " + leaderdata['rank'].toString());
      log("rank : " + leaderdata.toString());
    }
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
  //     barrierDismissible: false,
  //     context: context,
  //     builder: (BuildContext context) {
  //       return alert;
  //     },
  //   );
  // }
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
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => QuizPage()));
    // Do some stuff.
    return true;
  }
  Future<Future> _refreshdata(BuildContext context) async {
    return getTour(userid.toString(),"",widget.contents!.isNotEmpty ?widget.contents!:"",widget.seldomain!.isNotEmpty ?widget.seldomain!:"",widget.themes!.isNotEmpty ?widget.themes!:"",);
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
        child: RefreshIndicator(
          color: Colors.transparent,
          onRefresh: () => _refreshdata(context),
          child: Container(

            margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: Stack(children: [
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  color: Colors.white,
                  margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
                  height: 80,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(20, 10, 0, 10),
                        alignment: Alignment.centerLeft,

                        padding: EdgeInsets.all(5),
                        child: Center(
                          child: Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)
                            ),
                            child: Center(
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
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 10, 20, 10),
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.only(right: 5.0),
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
                alignment: Alignment(0,100),
                // height: MediaQuery.of(context).size.height-120,
                margin: const EdgeInsets.fromLTRB(20, 90, 20, 10),
                child: ListView(
                    children: [
                  Container(
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: const Text("TOURNAMENT",
                          style: TextStyle(
                              fontSize: 22,
                              color: Colors.black,
                              fontFamily: "Nunito"))),
                  Container(
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                      child: Text("Compete with other players! Your result will be ranked in your current league. Increase your rank to reach progress through next leagues",
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                              fontFamily: "Nunito"))),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                    decoration: BoxDecoration(
                        color: Colors.white),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        // if you need this
                        side: BorderSide(
                          color: Colors.grey.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Container( margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                        child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                height: 20,

                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    color: ColorConstants.red,
                                    // image: DecorationImage(image: AssetImage("assets/images/trianglewhite.png"),
                                    //     alignment:Alignment.centerLeft,fit: BoxFit.fitHeight,scale: 1 ),
                                    borderRadius: BorderRadius.circular(20)
                                ),
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width/7, 0, 0, 0),
                                  width: MediaQuery.of(context).size.width-30,
                                  decoration: BoxDecoration(
                                      color: ColorConstants.stage1color,
                                      // image: DecorationImage(image: AssetImage("assets/images/trianglewhite.png"),
                                      //     alignment:Alignment.centerLeft,fit: BoxFit.fitHeight,scale: 1 ),
                                      borderRadius: BorderRadius.circular(20)
                                  ),
                                  child: Container(
                                    margin: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width/7, 0, 0, 0),
                                    width: MediaQuery.of(context).size.width-30,
                                    decoration: BoxDecoration(
                                        color: ColorConstants.stage2color,
                                        // image: DecorationImage(image: AssetImage("assets/images/trianglewhite.png"),
                                        //     alignment:Alignment.centerLeft,fit: BoxFit.fitHeight,scale: 1 ),
                                        borderRadius: BorderRadius.circular(20)
                                    ),
                                    child: Container(
                                      margin: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width/7, 0, 0, 0),
                                      width: MediaQuery.of(context).size.width-30,
                                      decoration: BoxDecoration(
                                          color: ColorConstants.stage3color,
                                          // image: DecorationImage(image: AssetImage("assets/images/trianglewhite.png"),
                                          //     alignment:Alignment.centerLeft,fit: BoxFit.fitHeight,scale: 1 ),
                                          borderRadius: BorderRadius.circular(20)
                                      ),
                                      child: Container(
                                        margin: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width/7, 0, 0, 0),
                                        width: MediaQuery.of(context).size.width-30,
                                        decoration: BoxDecoration(
                                            color: ColorConstants.stage5color,
                                            // image: DecorationImage(image: AssetImage("assets/images/trianglewhite.png"),
                                            //     alignment:Alignment.centerLeft,fit: BoxFit.fitHeight,scale: 1 ),
                                            borderRadius: BorderRadius.circular(20)
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              _expanded==false? GestureDetector(
                                onTap: (){
                                  setState(() {
                                    _expanded=true;

                                  });

                                },
                                child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 30,
                                    child: Center(
                                        child:Image.asset(
                                          'assets/images/down_arrow.png',
                                          height: 10,width: 10,
                                          color: ColorConstants.txt,
                                        )
                                    )
                                ),
                              ):Container(
                                  width: MediaQuery.of(context).size.width,
                                //  height: 40,
                                  child: Container(

                                    margin: EdgeInsets.all(4),
                                    child: ListView(
                                      shrinkWrap: true,
                                      children: [

                                        getleaderboardR == null
                                            ? Container()
                                            : Container(
                                          child: Echarts(
                                            option: '''
                                                  {
                                                    xAxis: {
                                                      type: 'category',
                                                     
                                                    },
                                                    yAxis: {
                                                      type: 'value'
                                                    },
                                                    series: [{
                                                      data:${getleaderboardR!.data!.rank},
                                                      type: 'line',
                                                      color: '#F73F0C'
                                                    }]
                                                  }
                                                ''',
                                          ),
                                          width: 300,
                                          height: 250,
                                        ),
                                        Center(
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              primary: Colors.white,
                                              onPrimary: Colors.white,
                                              elevation: 3,
                                              alignment: Alignment.center,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(30.0)),
                                              fixedSize: const Size(120, 30),
                                              //////// HERE
                                            ),
                                            onPressed: () {
                                              // _controller!.dispose();
                                              Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>  LeagueRank()));
                                            },
                                            child: const Text(
                                              "SEE LEAGUE",
                                              style: TextStyle(
                                                  color: ColorConstants.txt, fontSize: 14),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: (){
                                            setState(() {
                                              _expanded=false;
                                            });


                                          },
                                          child: Container(
                                            width: MediaQuery.of(context).size.width,
                                            margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                            child: Center(
                                                child:Image.asset(
                                                  'assets/images/down_arrow_small.png',
                                                  height: 10,width: 10,
                                                  color: ColorConstants.txt,
                                                )
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                              ),


                              // Container(
                              //   child: Text("Quizzes Done",
                              //     style: TextStyle(color: Colors.grey,fontSize: 12),textAlign: TextAlign.center,),
                              // ),
                            ]
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 50,
                    child: Card(
                      child: ListTile(
                        visualDensity: VisualDensity(vertical: -4,horizontal: -4),
                        tileColor: Colors.black12.withAlpha(30),
                        leading: Icon(Icons.search),
                        title: TextFormField(
                          controller: controller,
                          textInputAction: TextInputAction.search,
                          onFieldSubmitted: onSearchTextChanged,
                          decoration: InputDecoration(

                              hintText: 'Search', border: InputBorder.none),
                        ),
                        trailing: controller.text.isNotEmpty
                            ? IconButton(
                          icon: Icon(Icons.cancel),
                          onPressed: () {
                            controller.clear();
                            onSearchTextChanged('');
                          },
                        )
                            : IconButton(
                          icon: Icon(Icons.cancel,color: Colors.white,),
                          onPressed: () {
                            controller.clear();
                            onSearchTextChanged('');
                          },
                        ),
                      ),
                    ),
                  ),
                 GestureDetector(
                         onTap: (){
                           // _controller!.dispose();
                           Navigator.pushReplacement(
                               context,
                               MaterialPageRoute(
                                   builder: (context) => FilterTour()));
                         },
                    child: Card(

                      child: Container(margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        child: ListTile(
                          tileColor:  Colors.black12.withAlpha(30),
                          trailing:
                                      Image.asset("assets/images/right_arrow.png",
                                          height: 20, width: 20),
                          title:
                                      Text("SET FILTER",
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black,
                                              fontFamily: "Nunito")),
                        )
                      ),
                    ),
                  ),

                  gettourR==null? Center(
                    child: Container(
                        child: Center(child: CircularProgressIndicator()),
                    ),
                  )
                      :  Container(
                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: ListView.builder(
                        physics: ClampingScrollPhysics(
                            parent: BouncingScrollPhysics()),
                        shrinkWrap: true,
                        itemCount: gettourR!.data!.length,
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
                            child: Container(margin: const EdgeInsets.fromLTRB(
                                10, 10, 10, 10),
                              child: ListBody(
                                children: [
                                  Container(
                                      height: 200,

                                      child:  Container(
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: NetworkImage(gettourR!.data![index].imageUrl!),
                                                  fit: BoxFit.fill)),
                                          child: Container(
                                            alignment: Alignment.topLeft,
                                            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                if(gettourR!.data![index].frequency=="Daily")
                                                  Container(padding:  EdgeInsets.all(8),height: 45, width: 45,
                                                    child: Image.asset("assets/images/hours24.png",fit: BoxFit.fill,
                                                    ),),
                                                if(gettourR!.data![index].frequency=="Weekly")
                                                  Container(padding: EdgeInsets.all(8),height: 45, width: 45,
                                                    child: Image.asset("assets/images/week7.png",fit: BoxFit.fill,
                                                    ),),
                                                if(gettourR!.data![index].frequency=="Monthly")
                                                  Container(padding:  EdgeInsets.all(8),height: 45, width: 45,
                                                    child: Image.asset("assets/images/month30.png",fit: BoxFit.fill,
                                                    ),),
                                                GestureDetector(
                                                  onTap:(){
                                                    Share.share("Tournament: "+"${gettourR!.data![index].title}" +"\n"+"Interval: "
                                                        + "${gettourR!.data![index].intervalSession}" +"\n"+"Duration: "
                                                        + "${gettourR!.data![index].duration}"  +"\n"+"you can play tournament on http://cultre.app/"+"${gettourR!.data![index].link}", subject: 'share');
                                                  },
                                                  child: Container(padding: EdgeInsets.all(8),height: 45, width: 45,
                                                    child: Image.asset("assets/images/share_feed.png",fit: BoxFit.fill,
                                                    ),),
                                                ),
                                              ],
                                            )


                                          ),
                                      ),
                                  ),
                              Container(
                                  margin: const EdgeInsets.fromLTRB(
                                      0, 10, 0, 10),
                                child: Text(
                                    gettourR!.data![index].title!,
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black,
                                        fontFamily: "Nunito"))),
                                  Container(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        starttimer(gettourR!.time!,gettourR!.data![index].id!,
                                            gettourR!.data![index].sessions![index].id!,gettourR!.data![index],gettourR!.date!,gettourR!.data![index].startTime!),

                                        // Text(
                                        //     gettourR!.data![index].startTime!,
                                        //     style: TextStyle(
                                        //         fontSize: 12,
                                        //         color: Colors.black,
                                        //         fontFamily: "Nunito")),

                                        Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                               Container(margin: const EdgeInsets.fromLTRB(
                                                   0, 0, 10, 0),
                                                   height: 50,
                                                   child: Center(child:
                                                   VerticalDivider(color: Colors.black,)
                                                   )),
                                            Container(
                                              height: 70,
                                              width:60,
                                              child:  Column(
                                                children: [
                                                  Container(  height: 20,
                                                    width:60,
                                                    child: Center(
                                                      child: Text("Sponsor",
                                                          style: TextStyle(
                                                              fontSize: 10,
                                                              color: Colors.black,
                                                              fontFamily: "Nunito")),
                                                    ),
                                                  ),
                                                  Container(  height: 50,
                                                      width:50,
                                                          decoration: BoxDecoration(
                                                              image: DecorationImage(
                                                                  image: NetworkImage(gettourR!.data![index].sponsorMediaId!),
                                                                  fit: BoxFit.cover)),
                                                          child: Container(


                                                          )
                                                  ),
                                                ],
                                              )
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),

                                  Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(

                                        margin: const EdgeInsets.fromLTRB(
                                            0, 10, 0, 10),
                                        child: Column(
                                          children: [
                                            Text("INTERVAL",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black54,
                                                  fontFamily: "Nunito"),
                                              textAlign: TextAlign.justify,
                                            ),
                                            Container(height: 30, width: 30,padding: EdgeInsets.all(4),
                                              child: Text(gettourR!.data![index].intervalSession!.toString(),
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.black,
                                                    fontFamily: "Nunito"),
                                                textAlign: TextAlign.justify,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.fromLTRB(
                                            0, 10, 0, 10),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Container(  margin: EdgeInsets.fromLTRB(0,0,5,0),
                                                    child: Image.asset("assets/images/clock_green.png",width: 10,height: 10,color: Colors.grey,)),

                                                Text("DURATION",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.black54,
                                                      fontFamily: "Nunito"),
                                                  textAlign: TextAlign.justify,
                                                ),
                                              ],
                                            ),
                                            Container(height: 30, width: 30,padding: EdgeInsets.all(4),
                                              child: Text(gettourR!.data![index].duration!.toString(),
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.black,
                                                    fontFamily: "Nunito"),
                                                textAlign: TextAlign.justify,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.fromLTRB(
                                            0, 10, 0, 10),
                                        child: Column(
                                          children: [
                                            Text("DIFFICULTY",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black54,
                                                  fontFamily: "Nunito"),
                                              textAlign: TextAlign.justify,
                                            ),
                                        if(gettourR!.data![index].difficulty=="advance")
                                        Container(padding: EdgeInsets.all(4),height: 30, width: 30,
                                          child: Image.asset("assets/images/emoji3.png",fit: BoxFit.fill,
                                              ),),
                                            if(gettourR!.data![index].difficulty=="intermediate")
                                              Container(padding: EdgeInsets.all(4),height: 30, width: 30,
                                                child: Image.asset("assets/images/emoji2.png",
                                                  fit: BoxFit.fill,),),
                                            if(gettourR!.data![index].difficulty=="beginner")
                                              Container(padding: EdgeInsets.all(4),height: 30, width: 30,
                                                child: Image.asset("assets/images/emoji1.png",
                                                  fit: BoxFit.fill,),),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  // if(gettourR!.data![index].waitlist_joined==1){
                                  //   itemView.joinroom.visibility = View.VISIBLE
                                  //   itemView.letsgo.visibility = View.GONE
                                  // } else {
                                  //   itemView.joinroom.visibility = View.GONE
                                  //   itemView.letsgo.visibility = View.VISIBLE
                                  // }
                                   if(gettourR!.data![index].waitlistJoined!=1)
                                  Container(
                                    child: Center(
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: ColorConstants.verdigris,
                                          onPrimary: Colors.white,
                                          elevation: 3,
                                          alignment: Alignment.center,
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(30.0)),
                                          fixedSize: const Size(130, 30),
                                          //////// HERE
                                        ),
                                        onPressed: () {
                                          joinroom(userid.toString(), gettourR!.data![index].id!, gettourR!.data![index].sessions![index].id!, index);
                                       },
                                        child: const Text(
                                          "JOIN WAITLIST",
                                          style: TextStyle(
                                              color: Colors.white, fontSize: 14,fontStyle: FontStyle.normal),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                  if(gettourR!.data![index].waitlistJoined==1)
                                  Container(
                                    child: Center(
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: ColorConstants.verdigris,
                                          onPrimary: Colors.white,
                                          elevation: 3,
                                          alignment: Alignment.center,
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(30.0)),
                                          fixedSize: const Size(130, 30),
                                          //////// HERE
                                        ),
                                        onPressed: () {

                                        Navigator.of(context).pushReplacement(
                                               MaterialPageRoute(builder: (BuildContext context) =>
                                                   TourRoomWaitlist( tourid: gettourR!.data![index].id!, sessionid: gettourR!.data![index].sessions![index].id!, type: '4',)));

                                        },
                                        child: const Text(
                                          "WAITLIST",
                                          style: TextStyle(
                                              color: Colors.white, fontSize: 14,fontStyle: FontStyle.normal),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
    ]
    ),
                            )
                                              );
                                            }),
                                      ),

                ]),
              ),
            ]),
          ),
        ),
      ),
    );
  }
  int expiryTime=0;
  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 30;
  DateTime? convertStringToDate( String? dateStr,String? format )  {
    final DateFormat formatter = DateFormat(format);
    DateTime? date;
    date = formatter.parse(dateStr!);
    log(date.toString());
  return date;
}




  Widget starttimer(String time,int tourid,int sessionid, TournamentResponse.Data? data,String date, String stime){
   //  log(time);
   //  log(date);
   //  log("${data!.startTime}");
   //  final DateFormat formatter = DateFormat('hh:mm:ss');
   //
   //    if (data.frequency == "Daily") {
   //      String ttime = data.startTime!.substring(11);
   //      if (data.startTime!.compareTo(
   //          "$date $time") > 0) {
   //        int currentTime = convertStringToDate(
   //            "$date $time", "yyyy-mm-dd hh:mm:ss")!.millisecond;
   //        var newatime= (DateTime.parse(
   //            "$date $time").hour * 3600) +(DateTime.parse(
   //            "$date $time").minute * 60 )+(DateTime.parse(
   //            "$date $time").second * 1);
   //          // expiryTime =
   //          //     convertStringToDate(data.startTime, "yyyy-mm-dd hh:mm:ss")!
   //          //         .millisecond - currentTime;
   //        var exatime= (DateTime.parse(
   //            data.startTime!).hour * 3600) +(DateTime.parse(
   //            data.startTime!).minute * 60 )+(DateTime.parse(
   //            data.startTime!).second * 1);
   //        expiryTime =   exatime- newatime ;
   //        log("currentTime1:$currentTime");
   // log("expiryTime1:$expiryTime");
   //      } else {if (data.isPlayed == 0) {
   //          if (data.sessions != null && data.sessions!.isNotEmpty) {
   //            int selindex = -1;
   //            TournamentResponse.Sessions? sess;
   //            for (sess in data.sessions!) {
   //              selindex++;
   //              String sval = "";
   //              if (sess.startTime!.length == 4) {
   //
   //                  sval = "0${sess.startTime!}:00";
   //
   //
   //              } else {
   //
   //                  sval = "${sess.startTime!}:00";
   //
   //
   //              }
   //
   //              if (time.compareTo(sval) > 0) {
   //                break;
   //              }
   //            }
   //            if (selindex == -1 || selindex == data.sessions!.length - 1) {
   //              int currentTime =  DateTime.parse(
   //                  "$date $time").millisecond;
   //              var newatime= (DateTime.parse(
   //                  "$date $time").hour * 3600) +(DateTime.parse(
   //                  "$date $time").minute * 60 )+(DateTime.parse(
   //                  "$date $time").second * 1);
   //                // expiryTime =
   //                //     DateTime.parse("$date $ttime")
   //                //         .millisecond + 86400000 - currentTime;
   //              var exatime= (DateTime.parse(
   //                  "$date $ttime").hour * 3600) +(DateTime.parse(
   //                  "$date $ttime").minute * 60 )+(DateTime.parse(
   //                  "$date $ttime").second * 1);
   //              expiryTime =exatime + 86400000-newatime;
   //              log("expiryTime2:$expiryTime");
   //            } else {
   //              String sstime = "${data.sessions![selindex].startTime}:00";
   //              if (sstime.length == 7)
   //                sstime = "0$sstime";
   //
   //
   //              log("start: $sstime");
   //              log("datetime3:$date $time");
   //              int currentTime = DateTime.parse(
   //                  "$date $time").toLocal().millisecondsSinceEpoch;
   //              var newatime= (DateTime.parse(
   //                  "$date $time").toLocal().hour * 3600) +(DateTime.parse(
   //                  "$date $time").toLocal().minute * 60 )+(DateTime.parse(
   //                  "$date $time").toLocal().second * 1);
   //
   //              log("currentTime3:$currentTime");
   //           //   log("newatime3:$newatime");
   //             var expiryTimee =
   //                  DateTime.parse("$date $sstime")
   //                      .millisecondsSinceEpoch + 86400000 - currentTime;
   //              var exatime= (DateTime.parse(
   //                  "$date $sstime").toLocal().hour * 3600) +(DateTime.parse(
   //                  "$date $sstime").toLocal().minute * 60 )+(DateTime.parse(
   //                  "$date $sstime").toLocal().second * 1);
   //           //   log("exatime3:$exatime");
   //              log("exatimee3:$expiryTimee");
   //              expiryTime =
   //                  exatime  -newatime ;
   //             // log("value${exatime-newatime}");
   //              log("expiryTime3:$expiryTime");
   //            }
   //          }
   //        } else {
   //          int currentTime = convertStringToDate(
   //              "$date $time", "yyyy-mm-dd hh:mm:ss")!.millisecond;
   //
   //          var newatime= (DateTime.parse(
   //              "$date $time").hour * 3600) +(DateTime.parse(
   //              "$date $time").minute * 60 )+(DateTime.parse(
   //              "$date $time").second * 1);
   //            // expiryTime =
   //            //     convertStringToDate("$date $ttime", "yyyy-mm-dd hh:mm:ss")!
   //            //         .millisecond + 864 - currentTime;
   //          var exatime= (DateTime.parse(
   //              "$date $ttime").hour * 3600) +(DateTime.parse(
   //              "$date $ttime").minute * 60 )+(DateTime.parse(
   //              "$date $ttime").second * 1);
   //          expiryTime =exatime + 86400000-newatime;
   //          log("expiryTime4:$expiryTime");
   //        }
   //      }
   //    } else if (data.frequency == "Weekly") {
   //      String ttime = data.startTime!.substring(data.startTime!.length - 8);
   //      if (data.startTime!.compareTo("$date $time") > 0) {
   //        int currentTime = convertStringToDate(
   //            "$date $time", "yyyy-mm-dd hh:mm:ss")!.millisecond;
   //        var newatime= (DateTime.parse(
   //            "$date $time").hour * 3600) +(DateTime.parse(
   //            "$date $time").minute * 60 )+(DateTime.parse(
   //            "$date $time").second * 1);
   //          // expiryTime =
   //          //     convertStringToDate(data.startTime, "yyyy-mm-dd hh:mm:ss")!
   //          //         .millisecond - currentTime;
   //        var exatime= (DateTime.parse(
   //            data.startTime!).hour * 3600) +(DateTime.parse(
   //            data.startTime!).minute * 60 )+(DateTime.parse(
   //            data.startTime!).second * 1);
   //        expiryTime =exatime -newatime;
   //        log("expiryTime5:$expiryTime");
   //      } else {
   //        if ("$date $time".compareTo("$date $ttime") > 0) {
   //          int currentTime = convertStringToDate(
   //              "$date $time", "yyyy-mm-dd hh:mm:ss")!.millisecond;
   //          var newatime= (DateTime.parse(
   //              "$date $time").hour * 3600) +(DateTime.parse(
   //              "$date $time").minute * 60 )+(DateTime.parse(
   //              "$date $time").second * 1);
   //            // expiryTime =
   //            //     convertStringToDate("$date $ttime", "yyyy-mm-dd hh:mm:ss")!
   //            //         .millisecond + 864 - currentTime;
   //          var exatime= (DateTime.parse(
   //              "$date $ttime").hour * 3600) +(DateTime.parse(
   //              "$date $ttime").minute * 60 )+(DateTime.parse(
   //              "$date $ttime").second * 1);
   //          expiryTime =exatime + 86400000-newatime;
   //          log("expiryTime6:$expiryTime");
   //        } else {
   //          int currentTime = convertStringToDate(
   //              "$date $time", "yyyy-mm-dd hh:mm:ss")!.millisecond;
   //          var newatime= (DateTime.parse(
   //              "$date $time").hour * 3600) +(DateTime.parse(
   //              "$date $time").minute * 60 )+(DateTime.parse(
   //              "$date $time").second * 1);
   //            // expiryTime =
   //            //     convertStringToDate("$date $ttime", "yyyy-mm-dd hh:mm:ss")!
   //            //         .millisecond - currentTime;
   //          var exatime= (DateTime.parse(
   //              "$date $ttime").hour * 3600) +(DateTime.parse(
   //              "$date $ttime").minute * 60 )+(DateTime.parse(
   //              "$date $ttime").second * 1);
   //          expiryTime =   exatime- newatime ;
   //          log("expiryTime7:$expiryTime");
   //        }
   //      }
   //    } else if (data.frequency == "Monthly") {
   //      String ttime = data.startTime!.substring(data.startTime!.length - 8);
   //      if (data.startTime!.compareTo("$date $time") > 0) {
   //        int currentTime = convertStringToDate(
   //            "$date $time", "yyyy-mm-dd hh:mm:ss")!.millisecond;
   //        var newatime= (DateTime.parse(
   //            "$date $time").hour * 3600) +(DateTime.parse(
   //            "$date $time").minute * 60 )+(DateTime.parse(
   //            "$date $time").second * 1);
   //          // expiryTime =
   //          //     convertStringToDate(data.startTime, "yyyy-mm-dd hh:mm:ss")!
   //          //         .millisecond - currentTime;
   //        var exatime= (DateTime.parse(
   //            data.startTime!).hour * 3600) +(DateTime.parse(
   //            data.startTime!).minute * 60 )+(DateTime.parse(
   //            data.startTime!).second * 1);
   //        expiryTime =   exatime- newatime ;
   //        log("expiryTime8:$expiryTime");
   //      } else {
   //        if ("$date $time".compareTo("$date $ttime") > 0) {
   //          int currentTime = convertStringToDate(
   //              "$date $time", "yyyy-mm-dd hh:mm:ss")!.millisecond;
   //          var newatime= (DateTime.parse(
   //              "$date $time").hour * 3600) +(DateTime.parse(
   //              "$date $time").minute * 60 )+(DateTime.parse(
   //              "$date $time").second * 1);
   //
   //            // expiryTime =
   //            //     convertStringToDate("$date $ttime", "yyyy-mm-dd hh:mm:ss")!
   //            //         .millisecond + 864 - currentTime;
   //          var exatime= (DateTime.parse(
   //              "$date $ttime").hour * 3600) +(DateTime.parse(
   //              "$date $ttime").minute * 60 )+(DateTime.parse(
   //              "$date $ttime").second * 1);
   //          expiryTime =exatime + 86400000-newatime;
   //          log("expiryTime9:$expiryTime");
   //        } else {
   //          int currentTime = convertStringToDate(
   //              "$date $time", "yyyy-mm-dd hh:mm:ss")!.millisecond;
   //          var newatime= (DateTime.parse(
   //              "$date $time").hour * 3600) +(DateTime.parse(
   //              "$date $time").minute * 60 )+(DateTime.parse(
   //              "$date $time").second * 1);
   //            // expiryTime =
   //            //     convertStringToDate("$date $ttime", "yyyy-mm-dd hh:mm:ss")!
   //            //         .millisecond - currentTime;
   //          var exatime= (DateTime.parse(
   //              "$date $ttime").hour * 3600) +(DateTime.parse(
   //              "$date $ttime").minute * 60 )+(DateTime.parse(
   //              "$date $ttime").second * 1);
   //          expiryTime = exatime- newatime ;
   //          log("expiryTime10:$expiryTime");
   //        }
   //      }
   //
   //    }
   //
   //
   //  log("ex"+expiryTime.toString());
    DateTime dateTime;
    dateTime = DateTime.parse(stime);
    final DateFormat formatterr = DateFormat('HH:mm:ss');
    final String formatted = formatterr.format(dateTime);
    final int sec = dateTime.millisecond;
    Duration clockTimer = Duration(hours: dateTime.hour);
     String starttime="";
    log(starttime.toString());
   //log(expiryTime.toString());
    return Container(
      child:
      Column(
         children: [
           Container(
             child: TweenAnimationBuilder<Duration>(
                 duration:  Duration(hours: dateTime.hour,minutes: dateTime.minute,seconds: dateTime.second),
                 tween: Tween(begin: Duration(hours: dateTime.hour,minutes: dateTime.minute,seconds: dateTime.second),
                     end: Duration.zero),
                 onEnd: () {
                   starttime="JOIN NOW";
                 },
                 builder: (BuildContext context, Duration value, Widget? child) {
                   // log("value"+value.toString());
                   String strDigits(int n) => n.toString().padLeft(2, '0');
                   final hours = strDigits(value.inHours.remainder(12));
                   final minutes =  strDigits(value.inMinutes.remainder(60)) ;
                   final seconds = strDigits(value.inSeconds.remainder(60));
                   starttime='$hours:$minutes:$seconds';
                   return Center(
                       child: Container(
                         height: 40,width: 100,
                         padding:  const EdgeInsets.all(5),
                         alignment: Alignment.center,
                         child: Text(starttime,
                             textAlign: TextAlign.center,
                             style: TextStyle(
                                 fontSize: 18,
                                 color: Colors.black,fontWeight: FontWeight.w600,
                                 fontFamily: "Nunito")),
                       )
                   );
                 }),
           ),
           // Container(
           //   child: TweenAnimationBuilder<Duration>(
           //       duration:  Duration(seconds: expiryTime<0?-expiryTime:expiryTime),
           //       tween: Tween(begin: Duration(seconds: expiryTime<0?-expiryTime:expiryTime),
           //           end: Duration.zero),
           //       onEnd: () {
           //         starttime="JOIN NOW";
           //       },
           //       builder: (BuildContext context, Duration value, Widget? child) {
           //         String strDigits(int n) => n.toString().padLeft(2, '0');
           //         final hours = strDigits(value.inHours.remainder(12));
           //         final minutes =  strDigits(value.inMinutes.remainder(60)) ;
           //         final seconds = strDigits(value.inSeconds.remainder(60));
           //         starttime='$hours:$minutes:$seconds';
           //         return Center(
           //           child: Container(
           //               height: 40,width: 120,
           //               padding:  const EdgeInsets.all(5),
           //               alignment: Alignment.center,
           //               child: Text(starttime,
           //                   textAlign: TextAlign.center,
           //         style: TextStyle(
           //         fontSize: 18,
           //         color: Colors.black,fontWeight: FontWeight.w600,
           //         fontFamily: "Nunito")),
           //           )
           //         );
           //       }),
           // ),


         ]
      ),
    );
  }

  List<Widget> indicators(imagesLength, currentIndex) {
    return List<Widget>.generate(imagesLength, (index) {
      return Container(
        margin: EdgeInsets.all(3),
        width: 10,
        height: 10,
        decoration: BoxDecoration(
            color: currentIndex == index ? Colors.white : Colors.grey,
            shape: BoxShape.circle),
      );
    });
  }

  onSearchTextChanged(String text) {
    tourdata=null;

    if (text.isNotEmpty) {


      // showLoaderDialog(context);
     getTour(userid.toString(), text,widget.contents!.isNotEmpty ?widget.contents!:"",widget.seldomain!.isNotEmpty ?widget.seldomain!:"",widget.themes!.isNotEmpty ?widget.themes!:"",);
    } else {

      getTour(userid.toString(),"",widget.contents!.isNotEmpty ?widget.contents!:"",widget.seldomain!.isNotEmpty ?widget.seldomain!:"",widget.themes!.isNotEmpty ?widget.themes!:"",);
      ;
    }
    print(text);
    log(text);

    setState(() {});
  }

}
