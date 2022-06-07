import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PushNotificationService {
  final FirebaseMessaging _fcm;
  String? _token;
  String? get token => _token;
  PushNotificationService(this._fcm);
  Future initialise() async {
    String initMessage = "default";
    if (Platform.isIOS) {
      // Request permission if on IOS
      _fcm.requestPermission();
    }
      _token = await _fcm.getToken();

      print("FCM: $_token");
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("fcmtoken", "$_token");

    _fcm.onTokenRefresh.listen((token) {
        _token = token;
      });

      RemoteMessage? initialMessage =
      await FirebaseMessaging.instance.getInitialMessage();
      await _fcm.setForegroundNotificationPresentationOptions(
        alert: true, // Required to display a heads up notification
        badge: true,
        sound: true,
      );
      //Set all values back to false to revert to the default functionality
      //   _handleMessage(initialMessage!);
    var notificationType = initialMessage!.data["type"];
    if(notificationType=='tournament'){

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
    return initMessage;
  }

void _handleMessage(RemoteMessage message) {
  var notificationType = message.data["type"];
  if(notificationType=='tournament'){

  }
}
}