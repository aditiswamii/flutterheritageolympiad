import 'dart:developer';


// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:CultreApp/colors/colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart' show kIsWeb;


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:CultreApp/fcm/fcm.dart';

import 'package:CultreApp/ui/homepage/homepage.dart';
import 'package:CultreApp/uinew/loginpage.dart';
import 'package:CultreApp/widget/deeplink.dart';
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
// MessagingService _msgService = MessagingService();
//
// Future _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   log(" --- background message received ---");
//   log(message.notification!.title.toString());
//   log(message.notification!.body.toString());
// }
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.white, // navigation bar color
    statusBarColor:  ColorConstants.verdigris,  // status bar color
    statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
    statusBarBrightness: Brightness.light,
  ));
  // if (Firebase.apps.isEmpty) {
  //   await Firebase.initializeApp(
  //       options: const FirebaseOptions(
  //           apiKey: "AIzaSyCA45SEP0RVCkh0m-ZAKE6CgUi49MfPfmw",
  //           appId: "1:996536312413:android:10e948f7dea194aa6f63b4",
  //           messagingSenderId: "996536312413-l4uljrnuhq8ci89rec4g4fn5iic9nm4a.apps.googleusercontent.com",
  //           projectId: "cultre-mobile-app"));
  // }
  // if (kIsWeb) {
  //   // initialiaze the facebook javascript SDK
  //   await FacebookAuth.i.webInitialize(
  //     appId: "1401599550295984",
  //     cookie: true,
  //     xfbml: true,
  //     version: "v13.0",
  //   );
  // }
  // FirebaseMessaging.instance.getToken().then((value) {
  //   String? token = value;
  //   log(token!);
  // });
  // _msgService.init();
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  // initUniLinks().then((value) => link;
  runApp( OverlaySupport(
    child: MaterialApp(
      navigatorKey: navigatorKey,
      theme: ThemeData(fontFamily: "Nunito"),
      debugShowCheckedModeBanner: false,
      home: MyApp(),


    ),
  ));
}
Future<String?> initUniLinks() async {

  try {
    final initialLink = await getInitialLink();

    return initialLink;
  } on PlatformException {
    return "" ;
  }

}
class MyApp extends StatefulWidget {

  var link;
   MyApp({Key? key,this.link,}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<MyApp> {
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
    checkForInitialMessage();
    super.initState();

    autoLogIn();

  }
  Future _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    print("Handling a background message: ${message.messageId}");
  }
  checkForInitialMessage() async {
    await Firebase.initializeApp();
    RemoteMessage? initialMessage =
    await FirebaseMessaging.instance.getInitialMessage();
    FirebaseMessaging.instance.getToken().then((token){
      log(token!);
      print(token);
    });
    if (initialMessage != null) {
      PushNotification notification = PushNotification(
        title: initialMessage.notification?.title,
        body: initialMessage.notification?.body,
        dataTitle: initialMessage.data['title'],
        dataBody: initialMessage.data['body'],
      );
      setState(() {
        _notificationInfo = notification;
        _totalNotifications++;
      });
      log('TITLE: ${_notificationInfo!.dataTitle ?? _notificationInfo!.title}');
      log('BODY: ${_notificationInfo!.dataBody ?? _notificationInfo!.body}');
    }
  }
  void registerNotification() async {
    // 1. Initialize the Firebase app
    await Firebase.initializeApp();

    // 2. Instantiate Firebase Messaging
    _messaging = FirebaseMessaging.instance;

    // 3. On iOS, this helps to take the user permissions
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
      FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

      // For handling the received notifications
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        // Parse the message received
        PushNotification notification = PushNotification(
          title: message.notification?.title,
          body: message.notification?.body,
        );

        setState(() {
          _notificationInfo = notification;
          _totalNotifications++;
        });
      });
      if(_notificationInfo != null){
        log("title:"+_notificationInfo!.title.toString());
        log("body"+_notificationInfo!.body.toString());
      }

    } else {
      print('User declined or has not accepted permission');
    }
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

    super.dispose();
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
