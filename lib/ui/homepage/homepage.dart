
import 'dart:convert';
import 'dart:developer';
import 'dart:io';




import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:CultreApp/colors/colors.dart';
import 'package:CultreApp/modal/getuserleagueresponse/GetUserLeagueResponse.dart';

import 'package:CultreApp/ui/feed/feed.dart';
import 'package:CultreApp/ui/myaccount/myaccount_page.dart';
import 'package:CultreApp/ui/myaccount/yourpage/yourpage.dart';
import 'package:CultreApp/ui/quiz/let_quiz.dart';
import 'package:CultreApp/ui/quizroom/waitroom/waitroom.dart';
import 'package:CultreApp/ui/rightdrawer/right_drawer.dart';
import 'package:CultreApp/ui/shopproduct/shopproducts_page.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:getwidget/components/progress_bar/gf_progress_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uni_links/uni_links.dart';


import '../../dialog/duelinvitereceive/duelinvite_receivedialog.dart';
import '../../dialog/quizroominvitereceive/quizroominvite_receivedialog.dart';
import '../../fcm/messagingservice.dart';
import '../../utils/StringConstants.dart';

import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../rules/rulepage.dart';
import '../tournamentquiz/waitlist/waitlist.dart';


class HomePage extends StatefulWidget{
var link;
  HomePage({Key? key, this.link}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<HomePage> with WidgetsBindingObserver implements DialogDuelInviteView,DialogQuizRoomInviteView{

  var  title ;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
var username;
var email;
var country;
var profilepic;
var userid;
var data;
var userleagdata;
var snackBar;
var myinvdata;
  var   tournament;
  List?  contact ;
  List?  dual;
  List?  accept;
  List?   quizroom;
  List?  quizroom_start;
  var shortlink;
  var linkurl;
GetUserLeagueResponse? userLeagueR;
  String? _token;
  String? get token => _token;



 userdata() async {
  // messageHandler();
   final SharedPreferences prefs = await SharedPreferences.getInstance();

   setState(() {
     username = prefs.getString("username");
     country =prefs.getString("country");
     userid= prefs.getString("userid");
   });

   free(userid.toString());
   getuserleague(userid.toString());
   if(widget.link!=null){
     linkurl=widget.link;
   }

   if(linkurl!=null) {
     setState(() {
       shortlink = linkurl.toString().substring(18);
     });
     shortlink = linkurl.toString().substring(18);
   //            linkshort = linkurl.substring(22)!!
               log("shortlink: "+ shortlink);
               if(shortlink.toString().contains("invite")) {
                 linkdetails(userid.toString(),shortlink.toString());
               } else if(shortlink.toString().contains("quizroom")){
                   log("shortlink: "+shortlink);
                   quizroomdetail(userid.toString(), shortlink.toString());
               } else {
                  dualdetails(userid.toString(), shortlink.toString());
               }

           } else {
                 myinvitation(userid.toString());
           }
   // if(widget.link!=""){
   //
   // }

}
String link="";
  late final AsyncCallback resumeCallBack;
  late final AsyncCallback suspendingCallBack;

  @override
  void initState() {

   // log("link"+ link == null ? "" : link);
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    userdata();
  }
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
  Future<Future> _refreshdata(BuildContext context) async {
    // NotificationService(_fcm1,context).initialize();
    // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //   log("$message");
    //   NotificationService.showNotification(message.data['title'],message.data['body']);
    // });
    return myinvitation(userid.toString());
  }
  Future<String?> initUniLinks() async {

    try {
      final initialLink = await getInitialLink();

      return initialLink;
    } on PlatformException {
      return "" ;
    }

  }

  @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      endDrawerEnableOpenDragGesture: true,
      endDrawer: const MySideMenuDrawer(),
      body:Container(
        decoration: const BoxDecoration(
        image: DecorationImage(
        image: AssetImage("assets/images/debackground.jpg"),
          fit: BoxFit.cover,
    ),
    ),
        //  child:
        // RefreshIndicator(
        // onRefresh: () => _refreshdata(context),
     child:RefreshIndicator(
       color: Colors.transparent,
     onRefresh: () => _refreshdata(context),
      child: Container(
          margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: ListView(
      children: [

        Container(
          margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 5.0),
          child: GestureDetector(
            onTap: () {
              _scaffoldKey.currentState!.openEndDrawer();
            },
            child:  Image.asset("assets/images/side_menu_2.png",height: 40,width: 40),
          ),
        ),
        Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: const Text("WELCOME BACK,",style: TextStyle(fontSize: 22,color: ColorConstants.txt,fontFamily: "Nunito"))),
        Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
            child: username==null?const Text(""):Text("${username[0].toUpperCase()+username.substring(1)}",
                style: const TextStyle(fontSize: 24,color: ColorConstants.txt,fontFamily: "Nunito"))),

         Container(
           child:GridView(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisSpacing: 10,crossAxisSpacing: 10),
               shrinkWrap: true,
               physics: const ClampingScrollPhysics(parent: BouncingScrollPhysics()),

               children: [
                 GestureDetector(
                   onTap:(){
                     Navigator.pushReplacement(
                         context,
                         MaterialPageRoute(
                             builder: (context) => const MyAccountPage()));
                   },
                   child: Container(
                     height: 150,
                     width: 150,
                     color: ColorConstants.red,

                     child: Stack(
                       // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         Align(
                           alignment: Alignment.topLeft,
                           child: Container(
                             padding: const EdgeInsets.all(10),

                             child: Image.asset("assets/images/mcq_pattern2.png",
                                 height: 20,width: 20,alignment: Alignment.topRight),
                           ),
                         ),
                         Center(child: Container(child: const Text("MY\nACCOUNT",style: TextStyle(color: Colors.white,fontSize: 20,fontFamily: "Nunito"),textAlign: TextAlign.center,))),
                         Align(
                           alignment: Alignment.bottomRight,
                           child: Container(
                             padding: const EdgeInsets.all(10),

                             child: Image.asset("assets/images/mcq_pattern2.png",
                                 height: 20,width: 20,alignment: Alignment.topLeft),
                           ),
                         ),
                       ],
                     ),

                   ),
                 ),
                 GestureDetector(
                   onTap: (){
                     Navigator.pushReplacement(
                         context,
                         MaterialPageRoute(
                             builder: (context) => FeedPage(themes: '', seldomain: '',)));
                   },
                   child: Container(
                     height: 150,
                     width: 150,
                     color:ColorConstants.yellow200,

                     child:  Column(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         Container(
                           padding: const EdgeInsets.all(10),
                           alignment: Alignment.topLeft,
                           child: Image.asset("assets/images/mcq_pattern2.png",
                               height: 20,width: 20,alignment: Alignment.topLeft),
                         ),
                         Container(child: const Text("MY\nFEED",style: TextStyle(color: Colors.white,fontSize: 20,fontFamily: "Nunito"),textAlign: TextAlign.center,)),
                         Container(
                           padding: const EdgeInsets.all(10),
                           alignment: Alignment.topRight,
                           child: Image.asset("assets/images/mcq_pattern2.png",
                               height: 20,width: 20,alignment: Alignment.topRight),
                         ),
                       ],
                     ),

                   ),
                 ),
                 GestureDetector(
                   onTap: () {
                     Navigator.pushReplacement(
                         context,
                         MaterialPageRoute(
                             builder: (context) =>  const QuizPage()));
                   },
                   child: Container(
                     height: 150,
                     width: 150,
                     color: ColorConstants.blue200,

                     child: Stack(
                       // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         Container(
                           padding: const EdgeInsets.all(10),
                           alignment: Alignment.topLeft,
                           child: Image.asset("assets/images/mcq_pattern2.png",
                               height: 20,width: 20,alignment: Alignment.topRight),
                         ),
                         Center(child: Container(child: const Text("TO THE\nQUIZZES",style: TextStyle(color: Colors.white,fontSize: 20,fontFamily: "Nunito"),textAlign: TextAlign.center,))),
                         Container(
                           padding: const EdgeInsets.all(10),
                           alignment: Alignment.bottomCenter,
                           child: Image.asset("assets/images/mcq_pattern2.png",
                               height: 20,width: 20,alignment: Alignment.topLeft),
                         ),
                       ],
                     ),

                   ),
                 ),
                 GestureDetector(
                   onTap: () {
                     // Navigator.pushReplacement(
                     //     context,
                     //     MaterialPageRoute(
                     //         builder: (context) => ResultPage(quizid: "1339", savedata: null, )));
                     Navigator.pushReplacement(
                         context,
                         MaterialPageRoute(
                             builder: (context) => ShopPage()));
                   },
                   child: Container(
                     height: 150,
                     width: 150,
                     color: Colors.black26,

                     child:  Stack(
                       // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         Container(
                           padding: const EdgeInsets.all(10),
                           alignment: Alignment.topCenter,
                           child: Image.asset("assets/images/mcq_pattern2.png",
                               height: 20,width: 20,alignment: Alignment.topLeft),
                         ),
                         Center(child: Container(child: const Text("TO THE\nSHOP",style: TextStyle(color: Colors.black54,fontSize: 20,fontFamily: "Nunito"),textAlign: TextAlign.center,))),
                         Container(
                           padding: const EdgeInsets.all(10),
                           alignment: Alignment.bottomLeft,
                           child: Image.asset("assets/images/mcq_pattern2.png",
                               height: 20,width: 20,alignment: Alignment.topCenter),
                         ),
                       ],
                     ),

                   ),
                 ),
                 ]
           )


         ),




       Container(
            margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            decoration: const BoxDecoration(
                color: Colors.white),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                // if you need this

              ),
          child:  Container( margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
            child:Container(child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: const Text("Your Activity Summary",
                      style: TextStyle(color: ColorConstants.txt,fontSize: 12),textAlign: TextAlign.center,),
                  ),


                  userLeagueR==null? Container(
                      margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: GFProgressBar(
                        percentage:0.0,
                        lineHeight: 20,
                        alignment: MainAxisAlignment.spaceBetween,
                        backgroundColor: Colors.black12,
                        progressBarColor: Colors.black12,
                      )
                  ):  userLeagueR!.data!.goalsummery==null? Container(
                        margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                        child: GFProgressBar(
                          percentage:0.0,
                          lineHeight: 20,
                          alignment: MainAxisAlignment.spaceBetween,
                          backgroundColor: Colors.black12,
                          progressBarColor: Colors.black12,
                        )
                    ):((userLeagueR!.data!.goalsummery!.play!/userLeagueR!.data!.goalsummery!.total!)<1?
                  Container(
                      margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: GFProgressBar(
                        percentage:
                        (userLeagueR!.data!.goalsummery!.play!/userLeagueR!.data!.goalsummery!.total!)*(0.3).toDouble(),
                        lineHeight: 20,
                        alignment: MainAxisAlignment.spaceBetween,
                        backgroundColor: Colors.black12,
                        progressBarColor: ColorConstants.verdigris,
                        child: Text('${userLeagueR!.data!.goalsummery!.play!} out of ${userLeagueR!.data!.goalsummery!.total}', textAlign: TextAlign.left,
                          style: const TextStyle(fontSize: 14, color: Colors.white),
                        ),
                      )
                  ): Container(
                      margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: GFProgressBar(
                        percentage:1.0,
                        lineHeight: 20,
                        alignment: MainAxisAlignment.spaceBetween,
                        backgroundColor: Colors.black12,
                        progressBarColor: ColorConstants.verdigris,
                        child: Text('${userLeagueR!.data!.goalsummery!.play!} out of ${userLeagueR!.data!.goalsummery!.total}', textAlign: TextAlign.left,
                          style: const TextStyle(fontSize: 14, color: Colors.white),
                        ),
                      )
                  )
                  ),
                  Container(
                    child: const Text("Quizzes Done",
                      style: TextStyle(color: Colors.grey,fontSize: 12),textAlign: TextAlign.center,),
                  ),


                  userLeagueR==null?Container(
                    margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    height: 20,

                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: ColorConstants.red,
                       borderRadius: BorderRadius.circular(20)
                    ),
                    child: Container(
                      margin: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width/7, 0, 0, 0),
                      width: MediaQuery.of(context).size.width/5,
                      decoration: BoxDecoration(
                          color: ColorConstants.stage1color,
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: Container(
                        margin: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width/7, 0, 0, 0),
                        width: MediaQuery.of(context).size.width/5,
                        decoration: BoxDecoration(
                            color: ColorConstants.stage2color,
                             borderRadius: BorderRadius.circular(20)
                        ),
                        child: Container(
                          margin: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width/7, 0, 0, 0),
                          width: MediaQuery.of(context).size.width/5,
                          decoration: BoxDecoration(
                              color: ColorConstants.stage3color,
                               borderRadius: BorderRadius.circular(20)
                          ),
                          child: Container(
                            margin: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width/7, 0, 0, 0),
                            width: MediaQuery.of(context).size.width/5,
                            decoration: BoxDecoration(
                                color: ColorConstants.stage5color,
                                  borderRadius: BorderRadius.circular(20)
                            ),
                          ),
                        ),
                      ),
                    ),
                  ):   Container(
                    margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    height: 20,

                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: ColorConstants.red,
                         image: userLeagueR!.data!.user!.id==5?const DecorationImage(image: AssetImage("assets/images/trianglewhite.png"),
                            alignment:Alignment(-.85,0),fit: BoxFit.fitHeight,scale: 1 ):const DecorationImage(image: AssetImage("assets/images/trianglewhite.png"),
                             alignment:Alignment.centerRight,fit: BoxFit.fitHeight,scale: 1 ),
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: Container(
                      margin: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width/7, 0, 0, 0),
                      width: MediaQuery.of(context).size.width/5,
                      decoration: BoxDecoration(
                          color: ColorConstants.stage1color,
                              image:userLeagueR!.data!.user!.id==4?const DecorationImage(image: AssetImage("assets/images/trianglewhite.png"),
                                  alignment:Alignment(-.8,0),fit: BoxFit.fitHeight,scale: 1 ):const DecorationImage(image: AssetImage("assets/images/trianglewhite.png"),
                                  alignment:Alignment.centerRight,fit: BoxFit.fitHeight,scale: 1 ),
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: Container(
                        margin: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width/7, 0, 0, 0),
                        width: MediaQuery.of(context).size.width/5,
                        decoration: BoxDecoration(
                            color: ColorConstants.stage2color,
                            image:userLeagueR!.data!.user!.id==3?const DecorationImage(image: AssetImage("assets/images/trianglewhite.png"),
                          alignment:Alignment(-.75,0),fit: BoxFit.fitHeight,scale: 1 ):const DecorationImage(image: AssetImage("assets/images/trianglewhite.png"),
                       alignment:Alignment.centerRight,fit: BoxFit.fitHeight,scale: 1 ),
                            borderRadius: BorderRadius.circular(20)
                        ),
                        child: Container(
                          margin: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width/7, 0, 0, 0),
                          width: MediaQuery.of(context).size.width/5,
                          decoration: BoxDecoration(
                              color: ColorConstants.stage3color,
                              image:userLeagueR!.data!.user!.id==2?const DecorationImage(image: AssetImage("assets/images/trianglewhite.png"),
                                  alignment:Alignment(-.6,0),fit: BoxFit.fitHeight,scale: 1 ):const DecorationImage(image: AssetImage("assets/images/trianglewhite.png"),
                                  alignment:Alignment.centerRight,fit: BoxFit.fitHeight,scale: 1 ),
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: Container(
                            margin: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width/7, 0, 0, 0),
                            width: MediaQuery.of(context).size.width/5,
                            decoration: BoxDecoration(
                                color: ColorConstants.stage5color,
                                image:userLeagueR!.data!.user!.id==1?const DecorationImage(image: AssetImage("assets/images/trianglewhite.png"),
                                    alignment:Alignment.center,fit: BoxFit.fitHeight,scale: 1 ):const DecorationImage(image: AssetImage("assets/images/trianglewhite.png"),
                                    alignment:Alignment.center,fit: BoxFit.fitHeight,scale: -1, ),
                                borderRadius: BorderRadius.circular(20)
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  Container(
                    child: const Text("Leagues",
                      style: TextStyle(color: Colors.grey,fontSize: 12),textAlign: TextAlign.center,),
                  ),
                ]
            ),)

          ),
        ),
      ),

        Container(
          child: Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                onPrimary: Colors.white,
                elevation: 3,
                alignment: Alignment.center,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0)),
                fixedSize: const Size(140, 40),
                //////// HERE
              ),
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>  const YourPage()));
              },
              child: const Text(
                "TO MY PAGE",
                style: TextStyle(
                    color: Colors.black, fontSize: 14),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        ]
        ),
        ),
    ),
    ),
    );
  }

  @override
  void setDData(int type, int index,String quizid) {
    if(type == 1){
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>  RulesPage(quizspeedid:"", quiztypeid:"", quizid: quizid, type: "2", tourid: 0, sessionid: 0 ,)));

    }else {
      snackBar = const SnackBar(
        content: Text(
           "Rejected Successfully"),
      );
    }
    ScaffoldMessenger.of(context)
        .showSnackBar(snackBar);
      if(dual!=null && dual!.length>index+1){
      AlertDialog errorDialog = AlertDialog(
          insetPadding: const EdgeInsets.all(4),
          titlePadding: const EdgeInsets.all(4),
          contentPadding:const EdgeInsets.all(4),
          shape: RoundedRectangleBorder(
              borderRadius:
              BorderRadius.circular(
                  20.0)), //this right here
          content: Container(
              height:470,
              width: 250,
              alignment: Alignment.center,
              child: DialogDuelInviteReceive(id: dual![index+1]['dual_id'], image: dual![index+1]['image'], diffi: dual![index+1]['difficulty'], index: index+1,
                domainsel:  dual![index+1]['domain'], link: dual![index+1]['link'], speed: dual![index+1]['quiz_speed'], name: dual![index+1]['name'],)));
      showDialog(
          context: context,
          builder: (BuildContext context){
            // Future.delayed(
            //   Duration(seconds: 2),
            //       () {
            //     Navigator.of(context).pop(true);
            //   },
            // );
            return  errorDialog;
          }
      );

    }
  }

  @override
  void setRData(int type, int index, String quizid) {
    if(type == 1){
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>  Waitroom(quizid: quizid,)));

    }else {
      snackBar = const SnackBar(
        content: Text(
            "Rejected Successfully"),
      );
    }
    ScaffoldMessenger.of(context)
        .showSnackBar(snackBar);
    if(quizroom!=null && quizroom!.length>index+1){
      AlertDialog errorDialog = AlertDialog(
          insetPadding: const EdgeInsets.all(4),
          titlePadding: const EdgeInsets.all(4),
          contentPadding:const EdgeInsets.all(4),
          shape: RoundedRectangleBorder(
              borderRadius:
              BorderRadius.circular(
                  20.0)), //this right here
          content: Container(
              height:470,
              width: 250,
              alignment: Alignment.center,
              child: DialogQuizRoomInviteReceive(id: quizroom![index+1]['quiz_room_id'], image: quizroom![index+1]['image'], diffi: quizroom![index+1]['difficulty'], index: index+1,
                domainsel:  quizroom![index+1]['domain'], link: quizroom![index+1]['link'], speed: quizroom![index+1]['quiz_speed'], name: quizroom![index+1]['name'],)));
      showDialog(
          context: context,
          builder: (BuildContext context){
            // Future.delayed(
            //   Duration(seconds: 2),
            //       () {
            //     Navigator.of(context).pop(true);
            //   },
            // );
            return  errorDialog;
          }
      );

    }
  }
  MessagingService _msgService = MessagingService();
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {

    switch (state) {
      case AppLifecycleState.resumed:
        print("resume");
        _msgService.init();
        onResumed();
        break;
      case AppLifecycleState.inactive:
        onPaused();
        break;
      case AppLifecycleState.paused:
        onInactive();
        break;
      case AppLifecycleState.detached:
        onDetached();
        break;
    }
    super.didChangeAppLifecycleState(state);
  }

 Future<void> onResumed()  async {

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    log(prefs.getString("fcmtoken").toString());
    log(prefs.getBool("IsRegistered").toString());

    log(prefs.getString("fcmtoken")!);
      if (prefs.getBool("IsRegistered")==false && prefs.getString("fcmtoken") != null &&  prefs.getString("fcmtoken")!.isNotEmpty) {
        sendDeviceIdApi(userid.toString(),prefs.getString("fcmtoken")!,"0");

    }
    //FirebaseMessaging.onMessageOpenedApp.listen(myinvitation(userid.toString()));
    if(link.isNotEmpty) {
      setState(() {
        linkurl = link;
      });

      print(link.isEmpty ? "" : "mainlink 1: $link");
      // link="";
      initUniLinks().then((value) =>
          setState(() {
            link = value!;
          }));

      log(link.isEmpty ? "" : "mainlink 2: $link");
      print(link.isEmpty ? "" : "mainlink 3 : $link");
    }
   //myinvitation(userid.toString());
    initState();
  }
  void onPaused() {
    // TODO: implement onPaused
  }
  void onInactive() {
    // TODO: implement onInactive
  }
  void onDetached() {
    // TODO: implement onDetached
  }
  //
  // generateDeviceToken() async {
  //  _token = await _fcm!.getToken();
  //
  //  _fcm!.onTokenRefresh.listen((token) {
  //    _token = token;
  //  });
  //
  //
  //   if (token != null) {
  //
  //     final SharedPreferences prefs = await SharedPreferences.getInstance();
  //     prefs.setString("fcmtoken", "$_token");
  //   sendDeviceIdApi(userid.toString(),_token.toString(),"0");
  //   log("MYFCMTOKEN : ${prefs.getString("fcmtoken")}");
  //   }
  //
  //
  // }
  sendDeviceIdApi(String userid,String token,String devicetype) async {
    log("sendDeviceIdApi$token");
    log("sendDeviceIdApi token");
    http.Response response =
    await http.post(Uri.parse("${StringConstants.BASE_URL}updatetoken"), body: {
      'user_id': userid.toString(),
      'device_type':Platform.isIOS?"1":"0",
      'isios':  Platform.isIOS?"1":"0",
      'token':token.toString()
    });
    var jsonResponse = convert.jsonDecode(response.body);
    if (response.statusCode == 200) {

      if (jsonResponse['status'] == 200) {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
         prefs.setBool("IsRegistered", true);
       log("sendDeviceIdApi success");
      } else {
        // snackBar = SnackBar(
        //   content: Text(
        //       jsonResponse['message']),
        // );
        // ScaffoldMessenger.of(context)
        //     .showSnackBar(snackBar);
      }
    } else {
      log("${response.statusCode}");
      print(response.statusCode);
    }

  }
  free(String userid) async {

    http.Response response =
    await http.post(Uri.parse("${StringConstants.BASE_URL}free"), body: {
      'user_id': userid.toString(),
    });
    var jsonResponse = convert.jsonDecode(response.body);
    if (response.statusCode == 200) {

      if (jsonResponse['status'] == 200) {




      } else {

      }
    } else {

      print(response.statusCode);
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
  //     context: context,
  //     builder: (BuildContext context) {
  //       return alert;
  //     },
  //   );
  // }
  myinvitation(String userid) async {
    // showLoaderDialog(context);
    http.Response response =
    await http.post(Uri.parse("${StringConstants.BASE_URL}dashboard"), body: {
      'user_id': userid.toString(),
    });
    var jsonResponse = convert.jsonDecode(response.body);
    if (response.statusCode == 200) {
      // Navigator.pop(context);
      if (jsonResponse['status'] == 200) {
        data = response.body;
        //final responseJson = json.decode(response.body);//store response as string
        setState(() {
          myinvdata = jsonResponse; //get all the data from json string superheros
          print(myinvdata.length);
          print(myinvdata.toString());
        });
        onsuccess(myinvdata);
        // var venam = jsonDecode(data!)['data'];
        // print(venam);
        //last_id

      } else {
        snackBar = SnackBar(
          content: Text(
              jsonResponse['message']),
        );
        ScaffoldMessenger.of(context)
            .showSnackBar(snackBar);
      }
    } else {
      // Navigator.pop(context);
      print(response.statusCode);
    }

  }
  onsuccess(myinvdata){
    if(myinvdata!=null){
      tournament=myinvdata['data']['tournament'];
      dual=List.from(myinvdata['data']['dual']);
      quizroom=List.from(myinvdata['data']['quizroom']);
      contact=List.from(myinvdata['data']['contact']);
      accept=List.from(myinvdata['data']['accept']);
      quizroom_start=List.from(myinvdata['data']['accept']);
      setState(() {
        tournament=myinvdata['data']['tournament'];
        dual=List.from(myinvdata['data']['dual']);
        quizroom=List.from(myinvdata['data']['quizroom']);
        contact=List.from(myinvdata['data']['contact']);
        accept=List.from(myinvdata['data']['accept']);
        quizroom_start=List.from(myinvdata['data']['accept']);

      });
      if(tournament!=null && tournament['tournament_id']>0){
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>  TourRoomWaitlist(sessionid: tournament['session_id'], tourid: tournament['tournament_id'], type: '4',)));
      }
      else  if(quizroom_start!=null && quizroom_start!.isNotEmpty){
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>  RulesPage(quizspeedid:"", quiztypeid:"", quizid: accept![0]['id'], type: "3", tourid: 0, sessionid: 0 ,)));

      }else if(accept!=null && accept!.isNotEmpty){
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>  RulesPage(quizspeedid:"", quiztypeid:"", quizid: accept![0]['id'], type: "2", tourid: 0, sessionid: 0 ,)));

      }else  if(dual!=null && dual!.isNotEmpty){
        AlertDialog errorDialog = AlertDialog(
            insetPadding: const EdgeInsets.all(4),
            titlePadding: const EdgeInsets.all(4),
            contentPadding:const EdgeInsets.all(4),
            shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(
                    20.0)), //this right here
            content: Container(
                height:470,
                width: 250,
                alignment: Alignment.center,
                child: DialogDuelInviteReceive(id: dual![0]['dual_id'], image: dual![0]['image'], diffi: dual![0]['difficulty'], index: 0,
                  domainsel:  dual![0]['domain'], link: dual![0]['link'], speed: dual![0]['quiz_speed'], name: dual![0]['name'],)));
        showDialog(
            context: context,
            builder: (BuildContext context){
              // Future.delayed(
              //   Duration(seconds: 2),
              //       () {
              //     Navigator.of(context).pop(true);
              //   },
              // );
              return  errorDialog;
            }
        );

      }else if(quizroom!=null && quizroom!.isNotEmpty){
        AlertDialog errorDialog = AlertDialog(
            insetPadding: const EdgeInsets.all(4),
            titlePadding: const EdgeInsets.all(4),
            contentPadding:const EdgeInsets.all(4),
            shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(
                    20.0)), //this right here
            content: Container(
                height:470,
                width: 250,
                alignment: Alignment.center,
                child: DialogQuizRoomInviteReceive(id: quizroom![0]['quiz_room_id'], image: quizroom![0]['image'], diffi: quizroom![0]['difficulty'], index: 0,
                  domainsel:  quizroom![0]['domain'], link: quizroom![0]['link'], speed: quizroom![0]['quiz_speed'], name: quizroom![0]['name'],)));
        showDialog(
            context: context,
            builder: (BuildContext context){
              // Future.delayed(
              //   Duration(seconds: 2),
              //       () {
              //     Navigator.of(context).pop(true);
              //   },
              // );
              return  errorDialog;
            }
        );

      }else if(contact!=null && contact!.isNotEmpty){
        AlertDialog errorDialog = AlertDialog(
          insetPadding: const EdgeInsets.all(4),
          titlePadding: const EdgeInsets.all(4),
          contentPadding: const EdgeInsets.all(4),
          shape: RoundedRectangleBorder(
              borderRadius:
              BorderRadius.circular(
                  20.0)),
          //this right here
          content: Container(
              height:250,
              // width: 250,
              alignment: Alignment.center,
              margin: const EdgeInsets.fromLTRB(0,10,0,10),
              padding: const EdgeInsets.all(10),
              child:ListView(
                children: [
                  Container(
                      alignment: Alignment.center,
                      margin:const EdgeInsets.only(bottom: 10),
                      decoration: const BoxDecoration(
                          color:Colors.white
                      ),
                      child: const Text('Contact Invitation Received From',textAlign: TextAlign.center,style: TextStyle(color: ColorConstants.txt,fontSize:18 ,fontWeight: FontWeight.w600),)
                  ),
                  Container(
                      alignment: Alignment.center,
                      margin:const EdgeInsets.only(bottom: 10),
                      decoration:const  BoxDecoration(
                          color:Colors.white
                      ),
                      child: Text(contact![0]['name'].toString(),textAlign: TextAlign.center,style: const TextStyle(color: ColorConstants.txt,fontSize: 18 ),)
                  ),
                  Container(
                    padding:const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    height: 100,
                    width: 100,
                    child: Center(
                      child: SizedBox(
                        height: 100,
                        width: 100,
                        child: CircleAvatar(
                          radius: 30.0,
                          backgroundImage:
                          NetworkImage(contact![0]['image'].toString()),
                          backgroundColor: Colors.transparent,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                            rejectcontact(userid.toString(), contact![0]['link'].toString(), 0, 2);
                          },
                          child: const Text(
                            "REJECT",
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
                            acceptcontact(userid.toString(), contact![0]['link'].toString(), 0, 1);
                          },
                          child: const Text(
                            "ACCEPT",
                            style: TextStyle(
                                color: Colors.white, fontSize:14),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
          ),
        );
        showDialog(
            context: context,
            builder: (BuildContext context) {
              // Future.delayed(
              //   Duration(seconds: 2),
              //       () {
              //     Navigator.of(context).pop(true);
              //   },
              // );
              return errorDialog;
            }
        );
      }

    }
  }
  var linkdata;
  linkdetails(String userid,String link) async {
    // showLoaderDialog(context);
    http.Response response =
    await http.post(Uri.parse("${StringConstants.BASE_URL}link_details"), body: {
      'user_id': userid.toString(),
      'link':link.toString()
    });
    var jsonResponse = convert.jsonDecode(response.body);
    if (response.statusCode == 200) {
      //  Navigator.pop(context);
      if (jsonResponse['status'] == 200) {
        data = response.body;
        //final responseJson = json.decode(response.body);//store response as string
        setState(() {
          linkdata = jsonResponse; //get all the data from json string superheros
          print(linkdata.length);
          print(linkdata.toString());
        });
        onlinkdetail(linkdata);
        // var venam = jsonDecode(data!)['data'];
        // print(venam);
        //last_id

      } else {
        setState(() {
          link="";
        });

        snackBar = SnackBar(
          content: Text(
              jsonResponse['message']),
        );
        ScaffoldMessenger.of(context)
            .showSnackBar(snackBar);
      }
    } else {
      //Navigator.pop(context);
      print(response.statusCode);
    }

  }

  acceptcontact(String userid,String link,index,type) async {
    //showLoaderDialog(context);
    http.Response response =
    await http.post(Uri.parse("${StringConstants.BASE_URL}accept_link_invitation"), body: {
      'user_id': userid.toString(),
      'link':link.toString()
    });
    var jsonResponse = convert.jsonDecode(response.body);
    if (response.statusCode == 200) {
      // Navigator.pop(context);
      if (jsonResponse['status'] == 200) {
        setData(type,index);
      } else  if (jsonResponse['status'] == 201) {
        setData(type,index);
      }
      else {
        snackBar = SnackBar(
          content: Text(
              jsonResponse['message']),
        );
        ScaffoldMessenger.of(context)
            .showSnackBar(snackBar);
      }
    } else {
      // Navigator.pop(context);
      print(response.statusCode);
    }

  }
  rejectcontact(String userid,String link,index,type) async {
    //showLoaderDialog(context);
    http.Response response =
    await http.post(Uri.parse("${StringConstants.BASE_URL}reject_link_invitation"), body: {
      'user_id': userid.toString(),
      'link':link.toString()
    });
    var jsonResponse = convert.jsonDecode(response.body);
    if (response.statusCode == 200) {
      // Navigator.pop(context);
      if (jsonResponse['status'] == 200) {
        setData(type,index);
      }
      else {
        snackBar = SnackBar(
          content: Text(
              jsonResponse['message']),
        );
        ScaffoldMessenger.of(context)
            .showSnackBar(snackBar);
      }
    } else {
      //  Navigator.pop(context);
      print(response.statusCode);
    }

  }
  setData(int type,int index){
    if(type==1){
      snackBar = const SnackBar(
        content: Text(
            "Contact added"),
      );
      ScaffoldMessenger.of(context)
          .showSnackBar(snackBar);

    } else {
      snackBar = const SnackBar(
        content: Text(
            "Request rejected"),
      );
      ScaffoldMessenger.of(context)
          .showSnackBar(snackBar);
    }
    if(contact!=null && contact!.length>index+1){
      AlertDialog errorDialog = AlertDialog(
        insetPadding: const EdgeInsets.all(4),
        titlePadding: const EdgeInsets.all(4),
        contentPadding: const EdgeInsets.all(4),
        shape: RoundedRectangleBorder(
            borderRadius:
            BorderRadius.circular(
                20.0)),
        //this right here
        content: Container(
            height:250,
            // width: 250,
            alignment: Alignment.center,
            margin: const EdgeInsets.fromLTRB(0,10,0,10),
            padding: const EdgeInsets.all(10),
            child:ListView(
              children: [
                Container(
                    alignment: Alignment.center,
                    margin:const EdgeInsets.only(bottom: 10),
                    decoration: const BoxDecoration(
                        color:Colors.white
                    ),
                    child: const Text('Contact Invitation Received From',textAlign: TextAlign.center,style: TextStyle(color: ColorConstants.txt,fontSize:18 ,fontWeight: FontWeight.w600),)
                ),
                Container(
                    alignment: Alignment.center,
                    margin:const EdgeInsets.only(bottom: 10),
                    decoration:const  BoxDecoration(
                        color:Colors.white
                    ),
                    child: Text(contact![index+1]['name'].toString(),textAlign: TextAlign.center,style: const TextStyle(color: ColorConstants.txt,fontSize: 18 ),)
                ),
                Container(
                  padding:const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  height: 100,
                  width: 100,
                  child: Center(
                    child: SizedBox(
                      height: 100,
                      width: 100,
                      child: CircleAvatar(
                        radius: 30.0,
                        backgroundImage:
                        NetworkImage(contact![index+1]['image'].toString()),
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                          rejectcontact(userid.toString(), contact![index+1]['link'].toString(), index+1, 2);
                        },
                        child: const Text(
                          "REJECT",
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
                          acceptcontact(userid.toString(), contact![index+1]['link'].toString(), index+1, 1);
                        },
                        child: const Text(
                          "ACCEPT",
                          style: TextStyle(
                              color: Colors.white, fontSize:14),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
        ),
      );
      showDialog(
          context: context,
          builder: (BuildContext context) {
            // Future.delayed(
            //   Duration(seconds: 2),
            //       () {
            //     Navigator.of(context).pop(true);
            //   },
            // );
            return errorDialog;
          }
      );
    }

  }
  onlinkdetail(linkdata){

    if(linkdata!=null) {
      log(linkdata['data']['id'].toString());
      log(linkdata['data']['name']);
      log(linkdata['data']['image']);
      log(linkdata['data']['link']);
      log(linkdata['type'].toString());
      AlertDialog errorDialog = AlertDialog(
        insetPadding: const EdgeInsets.all(4),
        titlePadding: const EdgeInsets.all(4),
        contentPadding: const EdgeInsets.all(4),
        shape: RoundedRectangleBorder(
            borderRadius:
            BorderRadius.circular(
                20.0)),
        //this right here
        content: Container(
            height:250,
            // width: 250,
            alignment: Alignment.center,
            margin: const EdgeInsets.fromLTRB(0,10,0,10),
            padding: const EdgeInsets.all(10),
            child:ListView(
              children: [
                Container(
                    alignment: Alignment.center,
                    margin:const EdgeInsets.only(bottom: 10),
                    decoration: const BoxDecoration(
                        color:Colors.white
                    ),
                    child: const Text('Contact Invitation Received From',textAlign: TextAlign.center,style: TextStyle(color: ColorConstants.txt,fontSize:18 ,fontWeight: FontWeight.w600),)
                ),
                Container(
                    alignment: Alignment.center,
                    margin:const EdgeInsets.only(bottom: 10),
                    decoration:const  BoxDecoration(
                        color:Colors.white
                    ),
                    child: Text(linkdata['data']['name'].toString(),textAlign: TextAlign.center,style: const TextStyle(color: ColorConstants.txt,fontSize: 18 ),)
                ),
                Container(
                  padding:const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  height: 100,
                  width: 100,
                  child: Center(
                    child: SizedBox(
                      height: 100,
                      width: 100,
                      child: CircleAvatar(
                        radius: 30.0,
                        backgroundImage:
                        NetworkImage(linkdata['data']['image'].toString()),
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                          rejectcontact(userid.toString(), linkdata['data']['link'].toString(), 0, 2);
                        },
                        child: const Text(
                          "REJECT",
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
                          acceptcontact(userid.toString(), linkdata['data']['link'].toString(), 0, 1);
                        },
                        child: const Text(
                          "ACCEPT",
                          style: TextStyle(
                              color: Colors.white, fontSize:14),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
        ),
      );
      showDialog(
          context: context,
          builder: (BuildContext context) {
            // Future.delayed(
            //   Duration(seconds: 2),
            //       () {
            //     Navigator.of(context).pop(true);
            //   },
            // );
            return errorDialog;
          }
      );
    }else{
      myinvitation(userid.toString());
    }
  }
  var dualinkdata;
  dualdetails(String userid,String link) async {
    //showLoaderDialog(context);
    http.Response response =
    await http.post(Uri.parse("${StringConstants.BASE_URL}dualdetails"), body: {
      'user_id': userid.toString(),
      'dual_link':link.toString()
    });
    var jsonResponse = convert.jsonDecode(response.body);
    if (response.statusCode == 200) {
      // Navigator.pop(context);
      if (jsonResponse['status'] == 200) {
        data = response.body;
        //final responseJson = json.decode(response.body);//store response as string
        setState(() {
          dualinkdata = jsonResponse; //get all the data from json string superheros
          print(dualinkdata.length);
          print(dualinkdata.toString());
        });
        onduallinkdetail(dualinkdata);
        // var venam = jsonDecode(data!)['data'];
        // print(venam);
        //last_id

      } else {
        setState(() {
          link="";
        });
        snackBar = SnackBar(
          content: Text(
              jsonResponse['message']),
        );
        ScaffoldMessenger.of(context)
            .showSnackBar(snackBar);
      }
    } else {
      // Navigator.pop(context);
      print(response.statusCode);
    }

  }
  onduallinkdetail(dualinkdata){
    log(dualinkdata['data']['dual_id'].toString());
    log(dualinkdata['data']['domain']);
    log(dualinkdata['data']['quiz_speed']);
    log(dualinkdata['data']['difficulty']);
    log(dualinkdata['data']['link']);
    log(dualinkdata['data']['created_date']);
    // log(linkdata['type'].toString());
    AlertDialog errorDialog = AlertDialog(
        insetPadding: const EdgeInsets.all(4),
        titlePadding: const EdgeInsets.all(4),
        contentPadding:const EdgeInsets.all(4),
        shape: RoundedRectangleBorder(
            borderRadius:
            BorderRadius.circular(
                20.0)), //this right here
        content: Container(
            height:470,
            width: 250,
            alignment: Alignment.center,
            child: DialogDuelInviteReceive(id: dualinkdata['data']['dual_id'], image:dualinkdata['data']['image'], diffi: dualinkdata['data']['difficulty'], index: 0,
              domainsel: dualinkdata['data']['domain'], link: dualinkdata['data']['link'], speed: dualinkdata['data']['quiz_speed'], name: dualinkdata['data']['name'],)));
    showDialog(
        context: context,
        builder: (BuildContext context){
          // Future.delayed(
          //   Duration(seconds: 2),
          //       () {
          //     Navigator.of(context).pop(true);
          //   },
          // );
          return  errorDialog;
        }
    );
  }
  var quizroomdata;
  quizroomdetail(String userid,String link) async {
    //showLoaderDialog(context);
    http.Response response =
    await http.post(Uri.parse("${StringConstants.BASE_URL}dualdetails"), body: {
      'user_id': userid.toString(),
      'link':link.toString()
    });
    var jsonResponse = convert.jsonDecode(response.body);
    if (response.statusCode == 200) {
      // Navigator.pop(context);
      if (jsonResponse['status'] == 200) {
        data = response.body;
        //final responseJson = json.decode(response.body);//store response as string
        setState(() {
          quizroomdata = jsonResponse; //get all the data from json string superheros
          print(quizroomdata.length);
          print(quizroomdata.toString());
        });
        onquizroomlinkdetail(quizroomdata);
        // var venam = jsonDecode(data!)['data'];
        // print(venam);
        //last_id

      } else {
        setState(() {
          link="";
        });
        snackBar = SnackBar(
          content: Text(
              jsonResponse['message']),
        );
        ScaffoldMessenger.of(context)
            .showSnackBar(snackBar);
      }
    } else {
      //   Navigator.pop(context);
      print(response.statusCode);
    }

  }
  onquizroomlinkdetail(quizroomdata){
    log(quizroomdata['data']['dual_id'].toString());
    log(quizroomdata['data']['domain']);
    log(quizroomdata['data']['quiz_speed']);
    log(quizroomdata['data']['difficulty']);
    log(quizroomdata['data']['link']);
    log(quizroomdata['data']['created_date']);
    log(quizroomdata['type']);
    AlertDialog errorDialog = AlertDialog(
        insetPadding: const EdgeInsets.all(4),
        titlePadding: const EdgeInsets.all(4),
        contentPadding:const EdgeInsets.all(4),
        shape: RoundedRectangleBorder(
            borderRadius:
            BorderRadius.circular(
                20.0)), //this right here
        content: Container(
            height:470,
            width: 250,
            alignment: Alignment.center,
            child: DialogQuizRoomInviteReceive(id: quizroomdata['data']['dual_id'], image: quizroomdata['data']['image'], diffi:quizroomdata['data']['difficulty'], index: 0,
              domainsel:  quizroomdata['data']['domain'], link:quizroomdata['data']['link'], speed: quizroomdata['data']['quiz_speed'], name: quizroomdata['data']['name'],)));
    showDialog(
        context: context,
        builder: (BuildContext context){
          // Future.delayed(
          //   Duration(seconds: 2),
          //       () {
          //     Navigator.of(context).pop(true);
          //   },
          // );
          return  errorDialog;
        }
    );
  }
  getuserleague(String userid) async {

    //showLoaderDialog(context);
    http.Response response = await http.get(
        Uri.parse("${StringConstants.BASE_URL}userleague?user_id=$userid")
    );


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
        getuserleagueresponse(getUserLeagueResponseFromJson(data!));
        // var venam = userleagdata(data!)['data'];
        // print(venam.toString());
      } else {
        snackBar = SnackBar(
          content: Text(
              jsonResponse['message']),
        );
        ScaffoldMessenger.of(context)
            .showSnackBar(snackBar);
      }
    } else {
      // Navigator.pop(context);
      // onsuccess(null);
      print(response.statusCode);
    }

  }
  getuserleagueresponse(GetUserLeagueResponse userLeagueResponse){
    if(userLeagueResponse != null) {
      if (userLeagueResponse.data != null) {
        setState(() {
          userLeagueR = userLeagueResponse;
        });
      }
    }
  }





}
