import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutterheritageolympiad/ui/homepage/welcomeback_page.dart';
import 'package:flutterheritageolympiad/uinew/loginpage.dart';


import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:uni_links/uni_links.dart';


void main() {

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
  // String name = '';
  // bool _initialURILinkHandled = false;
  // Uri? _initialURI;
  // Uri? _currentURI;
  // Object? _err;
  String link = "";
  StreamSubscription? _streamSubscription;

  // Future<void> _initURIHandler() async {
  //   // 1
  //   if (!_initialURILinkHandled) {
  //     _initialURILinkHandled = true;
  //     // 2
  //    var snackBar = SnackBar(
  //       content: Text("Invoked _initURIHandler"),
  //     );
  //     ScaffoldMessenger.of(context).showSnackBar(snackBar);
  //     try {
  //       // 3
  //       final initialURI = await getInitialUri();
  //       // 4
  //       if (initialURI != null) {
  //         debugPrint("Initial URI received $initialURI");
  //         if (!mounted) {
  //           return;
  //         }
  //         setState(() {
  //           _initialURI = initialURI;
  //         });
  //       } else {
  //         debugPrint("Null Initial URI received");
  //       }
  //     } on PlatformException { // 5
  //       debugPrint("Failed to receive initial uri");
  //     } on FormatException catch (err) { // 6
  //       if (!mounted) {
  //         return;
  //       }
  //       debugPrint('Malformed Initial URI received');
  //       setState(() => _err = err);
  //     }
  //   }
  //   log(_initialURI.toString());
  // }
  // void _incomingLinkHandler() {
  //   // 1
  //   // if (!kIsWeb) {
  //     // 2
  //     _streamSubscription = uriLinkStream.listen((Uri? uri) {
  //       if (!mounted) {
  //         return;
  //       }
  //       debugPrint('Received URI: $uri');
  //       setState(() {
  //         _currentURI = uri;
  //         _err = null;
  //       });
  //       // 3
  //     }, onError: (Object err) {
  //       if (!mounted) {
  //         return;
  //       }
  //       debugPrint('Error occurred: $err');
  //       setState(() {
  //         _currentURI = null;
  //         if (err is FormatException) {
  //           _err = err;
  //         } else {
  //           _err = null;
  //         }
  //       });
  //     });
  //   //}
  //   log(_currentURI.toString());
  // }
  @override
  void initState() {
    link="";
    initUniLinks().then((value) => setState(() {
      link = value!;
    }));
    super.initState();
    autoLogIn();


    // _initURIHandler();
    // _incomingLinkHandler();
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

  @override
  void dispose() {
   // _streamSubscription?.cancel();
    super.dispose();
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
        builder: (BuildContext context) => WelcomePage(link: link,)));
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
