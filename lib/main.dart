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

Future _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  log('Handling a background message ${message.messageId}');
  log('Notification Message: ${message.data}');
  NotificationService.showNotification(message.data['title'],message.data['body']);
}
Future<String?> initUniLinks() async {

  try {
    final initialLink = await getInitialLink();

    return initialLink;
  } on PlatformException {
    return "";
  }
}
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var link;
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  initUniLinks().then((value) => link);
  runApp( MaterialApp(
    theme: ThemeData(fontFamily: "Nunito"),
    debugShowCheckedModeBanner: false,
    home: MyApp(link:link),


  ));
}

class MyApp extends StatefulWidget {
  var link;
   MyApp({Key? key,this.link,}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<MyApp> {
  bool isLoggedIn = false;
 
  // String? link = "";
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
 // final PushNotificationService _notif = PushNotificationService(_fcm);
  var title ;
  @override
  void initState() {

    NotificationService(_fcm,context).initialize();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log("$message");
      NotificationService.showNotification(message.data['title'],message.data['body']);
    });
   // link="";
    widget.link="";
    // initUniLinks().then((value) => setState(() {
    //   link = value;
    // }));
    super.initState();
   // testFunc();
    autoLogIn();

  }
  // testFunc() async {
  //  // await Firebase.initializeApp();
  //   title = await NotificationService(_fcm).onMessage();
  // }

  Future<String?> initUniLinks() async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      final initialLink = await getInitialLink();
      // Parse the link and warn the user, if it is not correct,
      // but keep in mind it could be `null`.
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
    log(  widget.link == null ? "" : "mainlink: "+ widget.link!);
    print( widget.link == null ? "" : "mainlink: "+ widget.link!);
    isLoggedIn==false ? Timer(
        const Duration(seconds: 3),
            () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => LoginScreen()))):
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) => HomePage(link:  widget.link,)));
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
