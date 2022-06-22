import 'dart:developer';

import 'package:CultreApp/colors/colors.dart';
import 'package:CultreApp/main.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../modal/pushnotification/pushnotifiaction.dart';
import '../ui/mcq/mcq.dart';
import '../ui/shopactivity/shopactivity.dart';

class MessagingService{
  PushNotification? _notificationInfo;
  final _messageStreamController = BehaviorSubject<RemoteMessage>();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  String? _token;
  String? get token => _token;

  Future init() async {

    final settings = await _requestPermission();

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      log("authorized");
       _getToken();
      _registerForegroundMessageHandler();
      FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    }else{
      log("permission denied");
    }

  }

  Future _getToken() async {

    _token = await _firebaseMessaging.getToken();


    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _firebaseMessaging.onTokenRefresh.listen((token) {
      _token = token;
      prefs.setString("fcmtoken", "$_token");
      prefs.setBool("IsRegistered", false);
    });

    print("FCM: $_token");
    log("FCM: $_token");
    _firebaseMessaging.getInitialMessage();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (kDebugMode) {
        print('Handling a foreground message: ${message.messageId}');
        print('Message data: ${message.data}');
        print('Message notification: ${message.notification?.title}');
        print('Message notification: ${message.notification?.body}');
      }
      _messageStreamController.sink.add(message);
    });

    // RemoteMessage? inimessage = await _firebaseMessaging.getInitialMessage();
    //setupInteractedMessage();
    // log(inimessage.toString());
  }


  Future<NotificationSettings> _requestPermission() async {
    return await _firebaseMessaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        announcement: false);
  }
  Future _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    log(" --- background message received in service---");
    log("fcmmessage: "+message.toString());
    log("fcmtitle: "+message.data["title"].toString());
    log("fcmbody: "+message.data["body"].toString());
    _handleMessage(message);


  }
  Future _registerForegroundMessageHandler() async{
    FirebaseMessaging.onMessage.listen((remoteMessage) {
      log(" --- Foreground message received ---");
      log("fcmmessage: "+"$remoteMessage");
      _handleMessage(remoteMessage);
    });
    FirebaseMessaging.onBackgroundMessage((message) {

      return _handleMessage(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }
  Future<void> _handleMessage(RemoteMessage message) async{
    log(message.toString());
    var notificationType = message.data["type"];
    log("notificationType: $notificationType");
    if(notificationType=='tournament'){
      var title=message.data["title"];
      var body=message.data['body'];
      FirebaseMessaging.onMessageOpenedApp.listen((event) {
        Navigator.push(
            navigatorKey.currentContext!,
            MaterialPageRoute(
                builder: (context) => MyApp()));
      });
      // if( body!=null) {
      //   showSimpleNotification(  Text("${body}",style: TextStyle(color: Colors.white),),duration: Duration(minutes: 1),autoDismiss: true,slideDismiss: true,
      //       background: ColorConstants.verdigris);
      // }
      showNotification(1,title,body);
      Navigator.push(
          navigatorKey.currentContext!,
          MaterialPageRoute(
              builder: (context) => MyApp()));
    }else if(notificationType=='contact'){
      var  title=message.data["title"];
      var   body=message.data['body'];
      // if( body!=null) {
      //   showSimpleNotification(  Text("${body}",style: TextStyle(color: Colors.white),),duration: Duration(minutes: 1),autoDismiss: true,slideDismiss: true,
      //       background: ColorConstants.verdigris);
      // }
      showNotification(1,title,body);
      FirebaseMessaging.onMessageOpenedApp.listen((event) {
        Navigator.push(
            navigatorKey.currentContext!,
            MaterialPageRoute(
                builder: (context) => MyApp()));
      });
      Navigator.push(
          navigatorKey.currentContext!,
          MaterialPageRoute(
              builder: (context) => MyApp()));

    }else if(notificationType=='dual'){
      var  title=message.data["title"];
      var  body=message.data['body'];
      var  link=message.data['link'];
      // if( body!=null) {
      //   showSimpleNotification(  Text("${body}",style: TextStyle(color: Colors.white),),duration: Duration(minutes: 1),autoDismiss: true,slideDismiss: true,
      //       background: ColorConstants.verdigris);
      // }
      showNotification(2,title,body);
      FirebaseMessaging.onMessageOpenedApp.listen((event) {
        Navigator.push(
            navigatorKey.currentContext!,
            MaterialPageRoute(
                builder: (context) => MyApp()));
      });
      Navigator.push(
          navigatorKey.currentContext!,
          MaterialPageRoute(
              builder: (context) => MyApp(link: link,)));

    }else if(notificationType=='quizroom'){
      var  title=message.data["title"];
      var  body=message.data['body'];
      var  link=message.data['link'];
      // if( body!=null) {
      //   showSimpleNotification(  Text("${body}",style: TextStyle(color: Colors.white),),duration: Duration(minutes: 1),autoDismiss: true,slideDismiss: true,
      //       background: ColorConstants.verdigris);
      // }
      showNotification(2,title,body);
      FirebaseMessaging.onMessageOpenedApp.listen((event) {
        Navigator.push(
            navigatorKey.currentContext!,
            MaterialPageRoute(
                builder: (context) => MyApp()));
      });
      Navigator.push(
          navigatorKey.currentContext!,
          MaterialPageRoute(
              builder: (context) => MyApp(link: link,)));

    }else if(notificationType=='product'){
      var title=message.data["title"];
      var body=message.data['body'];
      // if( body!=null) {
      //   showSimpleNotification(  Text("${body}",style: TextStyle(color: Colors.white),),duration: Duration(minutes: 1),autoDismiss: true,slideDismiss: true,
      //       background: ColorConstants.verdigris);
      // }
      showNotification(2,title,body);
      FirebaseMessaging.onMessageOpenedApp.listen((event) {
        Navigator.push(
            navigatorKey.currentContext!,
            MaterialPageRoute(
                builder: (context) => Shopactivity(type: 1,)));
      });
      Navigator.push(
          navigatorKey.currentContext!,
          MaterialPageRoute(
              builder: (context) => Shopactivity(type: 1,)));
    }else if(notificationType=='experience'){
      var title=message.data["title"];
      var body=message.data['body'];
      // if( body!=null) {
      //   showSimpleNotification(  Text("${body}",style: TextStyle(color: Colors.white),),duration: Duration(minutes: 1),autoDismiss: true,slideDismiss: true,
      //       background: ColorConstants.verdigris);
      // }
      showNotification(2,title,body);
      FirebaseMessaging.onMessageOpenedApp.listen((event) {
        Navigator.push(
            navigatorKey.currentContext!,
            MaterialPageRoute(
                builder: (context) => Shopactivity(type: 2,)));
      });
      Navigator.push(
          navigatorKey.currentContext!,
          MaterialPageRoute(
              builder: (context) => Shopactivity(type: 2,)));
    }else if(notificationType=='post'){
      var title=message.data["title"];
      var body=message.data['body'];
      // if( body!=null) {
      //   showSimpleNotification(  Text("${body}",style: TextStyle(color: Colors.white),),duration: Duration(minutes: 1),autoDismiss: true,slideDismiss: true,
      //       background: ColorConstants.verdigris);
      // }
      showNotification(2,title,body);
      FirebaseMessaging.onMessageOpenedApp.listen((event) {
        Navigator.push(
            navigatorKey.currentContext!,
            MaterialPageRoute(
                builder: (context) => Shopactivity(type: 3,)));
      });
      Navigator.push(
          navigatorKey.currentContext!,
          MaterialPageRoute(
              builder: (context) => Shopactivity(type: 3,)));
    }else if(notificationType=='quizroomstart'){
      var title=message.data["title"];
      var body=message.data['body'];
      String roomid=message.data['room_id'];
      // if( body!=null) {
      //   showSimpleNotification(  Text("${body}",style: TextStyle(color: Colors.white),),duration: Duration(minutes: 1),autoDismiss: true,slideDismiss: true,
      //       background: ColorConstants.verdigris);
      // }
      showNotification(2,title,body);
      FirebaseMessaging.onMessageOpenedApp.listen((event) {
        Navigator.push(
            navigatorKey.currentContext!,
            MaterialPageRoute(
                builder: (context) => Mcq(quizid: roomid.toString(), type: "3", sessionid: 0, tourid: 0)));

      });
      Navigator.push(
          navigatorKey.currentContext!,
          MaterialPageRoute(
              builder: (context) => Mcq(quizid: roomid.toString(), type: "3", sessionid: 0, tourid: 0)));
    }else{
      var title=message.data["title"];
      var body=message.data['body'];
      // if( body!=null) {
      //   showSimpleNotification(  Text("${body}",style: TextStyle(color: Colors.white),),duration: Duration(minutes: 1),autoDismiss: true,slideDismiss: true,
      //       background: ColorConstants.verdigris);
      // }
      showNotification(2,title,body);
      FirebaseMessaging.onMessageOpenedApp.listen((event) {
        Navigator.push(
            navigatorKey.currentContext!,
            MaterialPageRoute(
                builder: (context) => MyApp()));
      });
      Navigator.push(
          navigatorKey.currentContext!,
          MaterialPageRoute(
              builder: (context) => MyApp()));
    }
  }

  Future showNotification(int notifyid,String? title,String? body) async {

   //  var android = const AndroidInitializationSettings('@mipmap/ic_launcher');
   //  var initiallizationSettingsIOS = const IOSInitializationSettings();
   //  var initialSetting = InitializationSettings(android: android, iOS: initiallizationSettingsIOS);
   //  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
   // await flutterLocalNotificationsPlugin.initialize(initialSetting);

    FlutterLocalNotificationsPlugin flip = FlutterLocalNotificationsPlugin();

    // app_icon needs to be a added as a drawable
    // resource to the Android head project.
    var android = AndroidInitializationSettings('@mipmap/ic_launcher');
    var IOS = IOSInitializationSettings();

    // initialise settings for both Android and iOS device.
    var settings = InitializationSettings(android: android, iOS: IOS);
    flip.initialize(settings);

    _showNotificationWithDefaultSound(flip,notifyid,title,body);


    // const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
    //     'channel-02',
    //     'Channel Names',
    //
    //     importance: Importance.max,
    //     priority: Priority.high,
    //     ticker: 'ticker',
    //     icon: "logo_rs",
    //     playSound: true,
    //     sound: RawResourceAndroidNotificationSound("notification")
    // );
    // const iOSDetails = IOSNotificationDetails();
    // const NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidDetails, iOS: iOSDetails);
    //
    // await flutterLocalNotificationsPlugin.show(0,title,body, platformChannelSpecifics);

  }
  Future _showNotificationWithDefaultSound(flip,int notifyid,String? title,String? body) async {

    // Show a notification after every 15 minute with the first
    // appearance happening a minute after invoking the method
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your channel id',
        'your channel name',
        channelDescription:'your channel description',
        importance: Importance.max,
        priority: Priority.high
    );
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();

    // initialise channel platform for both Android and iOS device.
    var platformChannelSpecifics = new NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics
    );
    await flip.show(notifyid, '$title',
        '$body',
        platformChannelSpecifics, payload: 'Default_Sound'
    );
  }

}
