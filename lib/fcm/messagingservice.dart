import 'dart:developer';

import 'package:CultreApp/main.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../ui/mcq/mcq.dart';

class MessagingService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  String? _token;
  String? get token => _token;

  Future init() async {
    final settings = await _requestPermission();
    _getToken();
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
       _getToken();
      _registerForegroundMessageHandler();
    }
  }

  Future _getToken() async {
    _token = await _firebaseMessaging.getToken();

    print("FCM: $_token");
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("fcmtoken", "$_token");


    _firebaseMessaging.onTokenRefresh.listen((token) {
      _token = token;
    });
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

  void _registerForegroundMessageHandler() {
    FirebaseMessaging.onMessage.listen((remoteMessage) {
      _handleMessage(remoteMessage);
    });
  }
  void _handleMessage(RemoteMessage message) {
    var notificationType = message.data["type"];
    log("notificationType: $notificationType");
    if(notificationType=='tournament'){
      var title=message.data["title"];
      var body=message.data['body'];
      showNotification(title,body);
      Navigator.push(
          navigatorKey.currentContext!,
          MaterialPageRoute(
              builder: (context) => MyApp()));
    }else if(notificationType=='contact'){
      var  title=message.data["title"];
      var   body=message.data['body'];
      showNotification(title,body);
    }else if(notificationType=='dual'){
      var  title=message.data["title"];
      var  body=message.data['body'];
      var  link=message.data['link'];
      Navigator.push(
          navigatorKey.currentContext!,
          MaterialPageRoute(
              builder: (context) => MyApp(link: link,)));
      showNotification(title,body);
    }else if(notificationType=='quizroom'){
      var  title=message.data["title"];
      var  body=message.data['body'];
      var  link=message.data['link'];
      Navigator.push(
          navigatorKey.currentContext!,
          MaterialPageRoute(
              builder: (context) => MyApp(link: link,)));
      showNotification(title,body);
    }else if(notificationType=='product'){
      var title=message.data["title"];
      var body=message.data['body'];
      showNotification(title,body);
      Navigator.push(
          navigatorKey.currentContext!,
          MaterialPageRoute(
              builder: (context) => MyApp()));
    }else if(notificationType=='experience'){
      var title=message.data["title"];
      var body=message.data['body'];
      showNotification(title,body);
      Navigator.push(
          navigatorKey.currentContext!,
          MaterialPageRoute(
              builder: (context) => MyApp()));
    }else if(notificationType=='post'){
      var title=message.data["title"];
      var body=message.data['body'];
      showNotification(title,body);
      Navigator.push(
          navigatorKey.currentContext!,
          MaterialPageRoute(
              builder: (context) => MyApp()));
    }else if(notificationType=='quizroomstart'){
      var title=message.data["title"];
      var body=message.data['body'];
      String roomid=message.data['room_id'];
      showNotification(title,body);
      Navigator.push(
          navigatorKey.currentContext!,
          MaterialPageRoute(
              builder: (context) => Mcq(quizid: roomid.toString(), type: "3", sessionid: 0, tourid: 0)));
    }else{
      var title=message.data["title"];
      var body=message.data['body'];
      showNotification(title,body);
      Navigator.push(
          navigatorKey.currentContext!,
          MaterialPageRoute(
              builder: (context) => MyApp()));
    }
  }
  static Future<void> showNotification(String title,String body) async {

    var android = AndroidInitializationSettings('@mipmap/ic_launcher');
    var initiallizationSettingsIOS = IOSInitializationSettings();
    var initialSetting = new InitializationSettings(android: android, iOS: initiallizationSettingsIOS);
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initialSetting);



    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
        'channel-02',
        'Channel Names',

        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
        icon: "logo_rs",
        playSound: true,
        sound: RawResourceAndroidNotificationSound("notification")
    );
    const iOSDetails = IOSNotificationDetails();
    const NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidDetails, iOS: iOSDetails);

    await flutterLocalNotificationsPlugin.show(0,title,body, platformChannelSpecifics);
  }

}
