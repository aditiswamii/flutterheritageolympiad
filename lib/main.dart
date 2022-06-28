import 'dart:developer';

import 'package:CultreApp/colors/colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:CultreApp/ui/homepage/homepage.dart';
import 'package:CultreApp/ui/authentication/loginpage.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:overlay_support/overlay_support.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:uni_links/uni_links.dart';

import 'fcm/messagingservice.dart';
import 'modal/pushnotification/pushnotifiaction.dart';

//
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

MessagingService _msgService = MessagingService();

Future _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  log(" --- background message received in main---");
  _firebaseMessaging.getInitialMessage();
  showNotification(0, message.data['title'], message.data['body']);
  // _msgService.init();
  //_handleMessage(message);
}

Future _registerForegroundMessageHandler(RemoteMessage message) async {
  log(" --- Foreground message received in main1---");
  showNotification(0, message.notification!.title.toString(),
      message.notification!.body.toString());
  _handleMessage(message);
  FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
}

Future<void> _handleMessage(RemoteMessage message) async {
  log(message.toString());
  var notificationType = message.data["type"];
  log("notificationType: $notificationType");
  if (notificationType == "tournament") {
    var title = message.data["title"];
    var body = message.data["body"];
    showNotification(1, title, body);
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      Navigator.push(navigatorKey.currentContext!,
          MaterialPageRoute(builder: (context) => MyApp()));
    });

    Navigator.push(navigatorKey.currentContext!,
        MaterialPageRoute(builder: (context) => MyApp()));
  } else if (notificationType == "contact") {
    var title = message.data["title"];
    var body = message.data["body"];

    showNotification(1, title, body);
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      Navigator.push(navigatorKey.currentContext!,
          MaterialPageRoute(builder: (context) => MyApp()));
    });
    Navigator.push(navigatorKey.currentContext!,
        MaterialPageRoute(builder: (context) => MyApp()));
  } else if (notificationType == 'dual') {
    var title = message.data["title"];
    var body = message.data['body'];
    var link = message.data['link'];

    showNotification(2, title, body);
    // FirebaseMessaging.onMessageOpenedApp.listen((event) {
    //   Navigator.push(navigatorKey.currentContext!,
    //       MaterialPageRoute(builder: (context) => MyApp()));
    // });
    // Navigator.push(
    //     navigatorKey.currentContext!,
    //     MaterialPageRoute(
    //         builder: (context) => MyApp(
    //               link: link,
    //             )));
  } else if (notificationType == 'quizroom') {
    var title = message.data["title"];
    var body = message.data['body'];
    var link = message.data['link'];

    showNotification(2, title, body);

  } else if (notificationType == 'product') {
    var title = message.data["title"];
    var body = message.data['body'];

    showNotification(2, title, body);

  } else if (notificationType == 'experience') {
    var title = message.data["title"];
    var body = message.data['body'];

    showNotification(2, title, body);

  } else if (notificationType == 'post') {
    var title = message.data["title"];
    var body = message.data['body'];

    showNotification(2, title, body);

  } else if (notificationType == 'quizroomstart') {
    var title = message.data["title"];
    var body = message.data['body'];
    String roomid = message.data['room_id'];

    showNotification(2, title, body);

  } else {
    var title = message.data["title"];
    var body = message.data['body'];

    showNotification(2, title, body);

  }
}

Future showNotification(int notifyid, String? title, String? body) async {
  FlutterLocalNotificationsPlugin flip = FlutterLocalNotificationsPlugin();

  // app_icon needs to be a added as a drawable
  // resource to the Android head project.
  var android = const AndroidInitializationSettings('@mipmap/ic_launcher');
  var IOS = const IOSInitializationSettings();

  // initialise settings for both Android and iOS device.
  var settings = InitializationSettings(android: android, iOS: IOS);
  flip.initialize(settings);

  _showNotificationWithDefaultSound(flip, notifyid, title, body);

}

Future _showNotificationWithDefaultSound(
    flip, int notifyid, String? title, String? body) async {
  // Show a notification after every 15 minute with the first
  // appearance happening a minute after invoking the method
  var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'your channel id', 'your channel name',
      channelDescription: 'your channel description',
      importance: Importance.max,
      priority: Priority.high);
  var iOSPlatformChannelSpecifics = const IOSNotificationDetails();

  // initialise channel platform for both Android and iOS device.
  var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics);
  await flip.show(notifyid, '$title', '$body', platformChannelSpecifics,
      payload: 'Default_Sound');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    // systemNavigationBarColor: Colors.white, // navigation bar color
    statusBarColor: ColorConstants.verdigris, // status bar color
    statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
    statusBarBrightness: Brightness.light,
  ));
  await Firebase.initializeApp();

  _msgService.init();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseMessaging.onMessage.listen(_registerForegroundMessageHandler);
  FirebaseMessaging.instance.getInitialMessage();
  // if (kIsWeb) {
  //   // initialiaze the facebook javascript SDK
  //   await FacebookAuth.i.webInitialize(
  //     appId: "1401599550295984",
  //     cookie: true,
  //     xfbml: true,
  //     version: "v13.0",
  //   );
  // }

  runApp(OverlaySupport(
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
  MyApp({
    Key? key,
    this.link,
  }) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<MyApp> {
  late int _totalNotifications;
  late final FirebaseMessaging _messaging;
  PushNotification? _notificationInfo;
  bool isLoggedIn = false;

  String? link = "";

  var title;
  @override
  void initState() {
    _totalNotifications = 0;

    link = "";
    initUniLinks().then((value) => setState(() {
          link = value;
        }));

    //  WidgetsBinding.instance.addObserver(this);
    super.initState();

    autoLogIn();
  }

  Future<String?> initUniLinks() async {
    try {
      final initialLink = await getInitialLink();

      return initialLink;
    } on PlatformException {
      return "";
    }
  }

  void autoLogIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("IsRegistered", false);
    final bool? loggedin = prefs.getBool('loggedin');
    // print(loggedin.toString());
    if (loggedin != true) {
      setState(() {
        isLoggedIn = false;
      });
    } else {
      setState(() {
        isLoggedIn = true;
      });
    }
    log(link == null ? "" : "mainlink: ${link!}");
    print(link == null ? "" : "mainlink: ${link!}");

    isLoggedIn == false
        ? Timer(
            const Duration(seconds: 3),
            () => Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => LoginScreen())))
        : Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => HomePage(
                  link: link,
                )));
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
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

  Future<void> setupInteractedMessage() async {
    //Terminated State
    //Comes in from terminated app's notification
    FirebaseMessaging.instance.getInitialMessage().then((value) => {
          if (value != null)
            {print("ContentAvailable : ${value.contentAvailable}")}
        });

    //Foreground state

    //Opened from background notification trigger and handler
    //It does not work if the app is detached only works in paused state
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      _msgService.init();
      print("Received in background while the app is paused and not detached");
    });
  }
}
