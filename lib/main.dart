import 'dart:developer';


// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:CultreApp/colors/colors.dart';
import 'package:CultreApp/ui/mcq/mcq.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart' show kIsWeb;


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:CultreApp/fcm/fcm.dart';

import 'package:CultreApp/ui/homepage/homepage.dart';
import 'package:CultreApp/uinew/loginpage.dart';
import 'package:CultreApp/widget/deeplink.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:overlay_support/overlay_support.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:provider/provider.dart';


import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:uni_links/uni_links.dart';

import 'fcm/messagehandler.dart';
import 'fcm/messagingservice.dart';
import 'modal/pushnotification/pushnotifiaction.dart';
//
 final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();


Future _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  log(" --- background message received ---");
  log(message.notification!.title.toString());
  log(message.notification!.body.toString());
}
MessagingService _msgService = MessagingService();
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
   // systemNavigationBarColor: Colors.white, // navigation bar color
    statusBarColor:  ColorConstants.verdigris,  // status bar color
    statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
    statusBarBrightness: Brightness.light,
  ));
  await Firebase.initializeApp();
  _msgService.init();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // if (kIsWeb) {
  //   // initialiaze the facebook javascript SDK
  //   await FacebookAuth.i.webInitialize(
  //     appId: "1401599550295984",
  //     cookie: true,
  //     xfbml: true,
  //     version: "v13.0",
  //   );
  // }

  runApp( OverlaySupport(
    child: MaterialApp(
      navigatorKey: navigatorKey,
      theme: ThemeData(fontFamily: "Nunito"),
      debugShowCheckedModeBanner: false,
      home: MyApp(),


    ),
  ));
}

class MyApp extends StatefulWidget {

  var link;
   MyApp({Key? key,this.link,}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<MyApp> with WidgetsBindingObserver{
  late int _totalNotifications;
  late final FirebaseMessaging _messaging;
  PushNotification? _notificationInfo;
  bool isLoggedIn = false;
 
  String? link = "";

  var title ;
  @override
  void initState() {
    _totalNotifications = 0;

    link="";
    initUniLinks().then((value) => setState(() {
      link = value;
    }));

    WidgetsBinding.instance.addObserver(this);
    super.initState();

    autoLogIn();

  }

  Future<String?> initUniLinks() async {

    try {
      final initialLink = await getInitialLink();

      return initialLink;
    } on PlatformException {
      return "" ;
    }

  }
  void autoLogIn() async {

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool? loggedin = prefs.getBool('loggedin');
    // print(loggedin.toString());
    if (loggedin != true) {
      setState(() {
        isLoggedIn=false;
      });
    }else{
      setState(() {
        isLoggedIn=true;
      });
    }
    log(  link == null ? "" : "mainlink: "+link!);
    print(link == null ? "" : "mainlink: "+ link!);

    isLoggedIn==false ? Timer(
        const Duration(seconds: 3),
            () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => LoginScreen()))):
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) => HomePage(link:  link,)));
  }
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
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
    print(link == null ? "" : "mainlink 1: $link");
    // link="";
    initUniLinks().then((value) => setState(() {
      link = value!;
    }));
    log(  link == null ? "" : "mainlink 2: "+link!);
    print(link == null ? "" : "mainlink 3 : "+ link!);

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

  @override
  Widget build(BuildContext context) {


    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/splash_heritage.jpg"),
            fit: BoxFit.cover,
          ),
        ),

      ),
    );
  }
}
