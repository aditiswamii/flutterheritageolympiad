import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:CultreApp/fcm/fcm.dart';

import 'package:CultreApp/ui/homepage/homepage.dart';
import 'package:CultreApp/uinew/loginpage.dart';
import 'package:CultreApp/widget/deeplink.dart';
import 'package:provider/provider.dart';


import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:uni_links/uni_links.dart';

import 'fcm/messagehandler.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( MaterialApp(
    theme: ThemeData(fontFamily: "Nunito"),
    debugShowCheckedModeBanner: false,
    home: MyApp(),


  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<MyApp> {
  bool isLoggedIn = false;
 
  String link = "";
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
 // final PushNotificationService _notif = PushNotificationService(_fcm);
  String title = "Notif Title";
  @override
  void initState() {

   // _notif.initialise();
    link="";
    initUniLinks().then((value) => setState(() {
      link = value!;
    }));
    super.initState();
    testFunc();
    autoLogIn();

  }
  testFunc() async {
   // await Firebase.initializeApp();
    title = await PushNotificationService(_fcm).initialise();
  }

  Future<String?> initUniLinks() async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      final initialLink = await getInitialLink();
      // Parse the link and warn the user, if it is not correct,
      // but keep in mind it could be `null`.
      return initialLink;
    } on PlatformException {
      // Handle exception by warning the user their action did not succeed
      // return?
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
    log( link == null ? "" : "mainlink: "+link);
    print(link == null ? "" : "mainlink: "+link);
    isLoggedIn==false ? Timer(
        const Duration(seconds: 3),
            () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => LoginScreen()))):
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) => HomePage(link: link,)));
  }
  @override
  void dispose() {
   // _streamSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
  // final link=Provider.of<Deeplink>(context);

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
