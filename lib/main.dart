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
import 'fcm/messagingservice.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
MessagingService _msgService = MessagingService();
// Future _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp();
//   log('Handling a background message ${message.messageId}');
//   log('Notification Message: ${message.data}');
//   NotificationService.showNotification(message.data['title'],message.data['body']);
// }
Future _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  log(" --- background message received ---");
  log(message.notification!.title.toString());
  log(message.notification!.body.toString());
}
void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyCA45SEP0RVCkh0m-ZAKE6CgUi49MfPfmw",
            appId: "1:996536312413:android:10e948f7dea194aa6f63b4",
            messagingSenderId: "996536312413-l4uljrnuhq8ci89rec4g4fn5iic9nm4a.apps.googleusercontent.com",
            projectId: "cultre-mobile-app"));
  }
  FirebaseMessaging.instance.getToken().then((value) {
    String? token = value;
    log(token!);
  });
  _msgService.init();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);


  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();

  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp( MaterialApp(
    navigatorKey: navigatorKey,
    theme: ThemeData(fontFamily: "Nunito"),
    debugShowCheckedModeBanner: false,
    home: MyApp(),


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
 
  String? link = "";
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
 // final PushNotificationService _notif = PushNotificationService(_fcm);
  var title ;
  @override
  void initState() {

    // NotificationService(_fcm,context).initialize();
    // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //   log("$message");
    //   NotificationService.showNotification(message.data['title'],message.data['body']);
    // });
   // link="";
    link="";
    initUniLinks().then((value) => setState(() {
      link = value;
    }));
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
