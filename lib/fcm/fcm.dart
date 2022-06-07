import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FCM extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Application();
}

class _Application extends State<FCM> {
  String? _token;
  String? get token => _token;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

    Future _getToken() async {
    _token = await _firebaseMessaging.getToken();

    print("FCM: $_token");
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("fcmtoken", "$_token");


    _firebaseMessaging.onTokenRefresh.listen((token) {
      _token = token;
    });
  }


  Future<void> setupInteractedMessage() async {

    RemoteMessage? initialMessage =
    await FirebaseMessaging.instance.getInitialMessage();
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );
    //Set all values back to false to revert to the default functionality


    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }


    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'channel-02', // id
      'Channel Names', // title
      description:'This channel is used for important notifications.',// description
      importance: Importance.max,
    );
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      // If `onMessage` is triggered with a notification, construct our own
      // local notification to show to users using the created channel.
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channelDescription:  channel.description,
                icon: android.smallIcon,
                // other properties...
              ),
            ));
      }
    });
  }

  void _handleMessage(RemoteMessage message) {
    var notificationType = message.data["type"];
     if(notificationType=='tournament'){

    }
  }

  @override
  void initState() {
    super.initState();
    _getToken();
    // Run code required to handle interacted messages in an async function
    // as initState() must not be async
    setupInteractedMessage();
  }

  @override
  Widget build(BuildContext context) {
    return Text("...");
  }
}





// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class FCM {
//   final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
//
//   String? _token;
//   String? get token => _token;
//
//   Future init() async {
//     final settings = await _requestPermission();
//
//     if (settings.authorizationStatus == AuthorizationStatus.authorized) {
//       await _getToken();
//       _registerForegroundMessageHandler();
//     }
//   }
//
//   Future _getToken() async {
//     _token = await _firebaseMessaging.getToken();
//
//     print("FCM: $_token");
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.setString("fcmtoken", "$_token");
//
//
//     _firebaseMessaging.onTokenRefresh.listen((token) {
//       _token = token;
//     });
//   }
//
//   Future<NotificationSettings> _requestPermission() async {
//     return await _firebaseMessaging.requestPermission(
//         alert: true,
//         badge: true,
//         sound: true,
//         carPlay: false,
//         criticalAlert: false,
//         provisional: false,
//         announcement: false);
//   }
//
//   void _registerForegroundMessageHandler() {
//     FirebaseMessaging.onMessage.listen((remoteMessage) {
//       print(" --- foreground message received ---");
//       print(remoteMessage.notification!.title);
//       print(remoteMessage.notification!.body);
//     });
//   }
// }
