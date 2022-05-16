import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:back_button_interceptor/back_button_interceptor.dart';

import 'package:device_calendar/device_calendar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:flutter/services.dart';
import 'package:flutterheritageolympiad/colors/colors.dart';
import 'package:flutterheritageolympiad/modal/gettournament/GetTournamentResponse.dart';
import 'package:flutterheritageolympiad/ui/feed/filterpage/filterpage.dart';

import 'package:flutterheritageolympiad/ui/rightdrawer/right_drawer.dart';
import 'package:flutterheritageolympiad/ui/tournamentquiz/filtertour/filtertour.dart';
import 'package:flutterheritageolympiad/utils/countdowntimer.dart';
import 'package:intl/intl.dart';

import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../utils/StringConstants.dart';

import '../welcomeback/welcomeback_page.dart';
import 'dart:convert' as convert;
class TournamentPage extends StatefulWidget {

  TournamentPage({Key? key}) : super(key: key);

  @override
  _TournamentPageState createState() => _TournamentPageState();
}

class _TournamentPageState extends State<TournamentPage> with TickerProviderStateMixin{
  TextEditingController controller = TextEditingController();
  PageController _pageController = PageController();
  AnimationController? _controller;
  // TextEditingController controller = TextEditingController();
  // List<Data> _searchResult = [];
  // List<Data> _userDetails = [];
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  var username;
  var email;
  var country;
  var profilepic;
  var userid;
  var tourdata;
  var data;
  var snackBar;
  GetTournamentResponse? gettourR;
  Timer? countdownTimer;
  Duration myDuration = Duration(days: 1);

  userdata() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString("username");
      country = prefs.getString("country");
      userid = prefs.getString("userid");
    });
   showLoaderDialog(context);
    getTour(userid.toString(),"");
  }
  getTour(String userid,String search) async {
    Navigator.pop(context);
    if (search != "") {
      http.Response response =
      await http.get(
          Uri.parse(StringConstants.BASE_URL + "tournament?user_id=$userid"));

      if (response.statusCode == 200) {
        data = response.body;
        //final responseJson = json.decode(response.body);//store response as string
        setState(() {
          tourdata = jsonDecode(
              data!)['data']; //get all the data from json string superheros
          print(tourdata.length);
          onsuccess(getTournamentResponseFromJson(data!));
        });

        var venam = jsonDecode(data!)['data'];
        print(venam);
      } else {
        print(response.statusCode);
      }
    }else{

      http.Response response =
      await http.get(
          Uri.parse(StringConstants.BASE_URL + "tournament?user_id=$userid&search=$search"));

      if (response.statusCode == 200) {
        data = response.body;
        //final responseJson = json.decode(response.body);//store response as string
        setState(() {
          tourdata = jsonDecode(
              data!)['data']; //get all the data from json string superheros
          print(tourdata.length);
          onsuccess(getTournamentResponseFromJson(data!));
        });

        var venam = jsonDecode(data!)['data'];
        print(venam);
      } else {
        print(response.statusCode);
      }
    }
  }
 onsuccess(GetTournamentResponse tournamentResponse){
    if(tournamentResponse.data!=null){
      setState(() {
        gettourR=tournamentResponse;
      });

    }
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
      barrierDismissible: false,
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
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => WelcomePage()));
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
      endDrawer: MySideMenuDrawer(),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/login_bg.jpg"),
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
                  padding: EdgeInsets.only(left: 5.0),
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WelcomePage()));
                    },
                    child: Image.asset("assets/images/home_1.png",
                        height: 40, width: 40),
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
                    child: Image.asset("assets/images/side_menu_2.png",
                        height: 40, width: 40),
                  ),
                ),
              ],
            ),
            Container(
              color: Colors.white,
              child: ListBody(children: [
                Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: const Text("TOURNAMENT",
                        style: TextStyle(
                            fontSize: 18,
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
                Card(
                  child: ListTile(
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
               GestureDetector(
                       onTap: (){
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

                  ),
                )
                    :  Container(
                  margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: ListView.builder(
                      physics: ClampingScrollPhysics(
                          parent: BouncingScrollPhysics()),
                      shrinkWrap: true,
                      itemCount: jsonDecode(data!)['data'].length,
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
                                    height: 300,

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
                                                Container(padding: EdgeInsets.all(4),height: 30, width: 30,
                                                  child: Image.asset("assets/images/hours24.png",fit: BoxFit.fill,
                                                  ),),
                                              if(gettourR!.data![index].frequency=="Weekly")
                                                Container(padding: EdgeInsets.all(4),height: 30, width: 30,
                                                  child: Image.asset("assets/images/week7.png",fit: BoxFit.fill,
                                                  ),),
                                              if(gettourR!.data![index].frequency=="Monthly")
                                                Container(padding: EdgeInsets.all(4),height: 30, width: 30,
                                                  child: Image.asset("assets/images/month30.png",fit: BoxFit.fill,
                                                  ),),
                                              Container(padding: EdgeInsets.all(4),height: 30, width: 30,
                                                child: Image.asset("assets/images/share_feed.png",fit: BoxFit.fill,
                                                ),),
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
                                      start(gettourR!.data![index].startTime!),

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
                                                    width:60,
                                                        decoration: BoxDecoration(
                                                            image: DecorationImage(
                                                                image: NetworkImage(gettourR!.data![index].sponsorMediaId!),
                                                                fit: BoxFit.fill)),
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
                                                fontSize: 14,
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
                                          Text("DURATION",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.black54,
                                                fontFamily: "Nunito"),
                                            textAlign: TextAlign.justify,
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
                                                fontSize: 14,
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
                                        fixedSize: const Size(100, 40),
                                        //////// HERE
                                      ),
                                      onPressed: () {
                                        // updatenotify(userid.toString(), notifyid);
                                      },
                                      child: const Text(
                                        "WAITLIST",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 14),
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
    );
  }
  void startTimer() {
    countdownTimer =
        Timer.periodic(Duration(seconds: 1), (_) => setCountDown());
  }
  // Step 4
  void stopTimer() {
    setState(() => countdownTimer!.cancel());
  }
  // Step 5
  void resetTimer() {
    stopTimer();
    setState(() => myDuration = Duration(days: 1));
  }
  // Step 6
  void setCountDown() {
    final reduceSecondsBy = 1;
    setState(() {
      final seconds = myDuration.inSeconds - reduceSecondsBy;
      if (seconds < 0) {
        countdownTimer!.cancel();
      } else {
        myDuration = Duration(seconds: seconds);
      }
    });
  }
  Widget start(String s){

    var time=   getTimeFromDateAndTime(s);
   // String strDigits(int n) => n.toString().padLeft(2, '0');

    // final days = strDigits(myDuration.inDays);
    // // Step 7
    // final hours = strDigits(myDuration.inHours.remainder(24));
    // final minutes = strDigits(myDuration.inMinutes.remainder(60));
    // final seconds = strDigits(myDuration.inSeconds.remainder(60));

    return Container(
      child:
      Column(
         children: [
        //   Text(
        //     '$hours:$minutes:$seconds',
        //     style: TextStyle(
        //         fontWeight: FontWeight.bold,
        //         color: Colors.black,
        //         fontSize: 16),
        //   ),
          Text(time,
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,fontWeight: FontWeight.w600,
                  fontFamily: "Nunito")),

        ],
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
     getTour(userid.toString(), text);
    } else {

      getTour(userid.toString(), "");
    }
    print(text);
    log(text);

    setState(() {});
  }
  String getTimeFromDateAndTime(String date)  {
    DateTime dateTime;
    try {
      dateTime = DateTime.parse(date).toLocal();
     final DateFormat formatter = DateFormat('HH:mm:ss');
      final String formatted = formatter.format(dateTime);
      final int sec = dateTime.millisecond;
      _controller = AnimationController(
          vsync: this,
          duration: Duration(minutes: dateTime.minute,seconds: dateTime.second,milliseconds: dateTime.millisecond) // gameData.levelClock is a user entered number elsewhere in the applciation
      );

      _controller!.forward();

      Duration clockTimer = Duration(hours: dateTime.hour);

      String timerText = '${clockTimer.inHours.remainder(24).toString()}:${(clockTimer.inMinutes.remainder(60)).toString().padLeft(2, '0')}:${(clockTimer.inSeconds.remainder(60) ).toString().padLeft(2, '0')}';

      //return DateFormat.jm().format(dateTime).toString();
      return timerText;
      //5:08 PM
// String formattedTime = DateFormat.Hms().format(now);
// String formattedTime = DateFormat.Hm().format(now);   // //17:08  force 24 hour time
    }
    catch (e) {
      return date;
    }
  }
}
