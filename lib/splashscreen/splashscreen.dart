// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
//
//
//
//
// import 'dart:async';
//
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../ui/homepage/welcomeback_page.dart';
// import '../uinew/loginpage.dart';
//
//
// void main() {
//   runApp(const MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: SplashScreen(),
//   ));
// }
//
// class SplashScreen extends StatefulWidget {
//   const SplashScreen({Key? key}) : super(key: key);
//
//   @override
//   _State createState() => _State();
// }
//
// class _State extends State<SplashScreen> {
//   bool isLoggedIn = false;
//   String emailadd = '';
//
//   @override
//   void initState() {
//     super.initState();
//     autoLogIn();
//     !isLoggedIn ? Timer(
//         const Duration(seconds: 3),
//             () => Navigator.of(context).pushReplacement(MaterialPageRoute(
//             builder: (BuildContext context) => LoginScreen()))):
//     Navigator.of(context).pushReplacement(MaterialPageRoute(
//         builder: (BuildContext context) => WelcomePage()));
//   }
//   void autoLogIn() async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     final String? emailaddress = prefs.getString('email');
//     print(emailaddress);
//     if (emailaddress != null) {
//       setState(() {
//         isLoggedIn = true;
//         emailadd = emailaddress;
//       });
//       Navigator.of(context).pushReplacement(MaterialPageRoute(
//           builder: (BuildContext context) =>WelcomePage()));
//       return;
//     }
//   }
//   @override
//   Widget build(BuildContext context) {
//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.portraitUp,
//       DeviceOrientation.portraitDown
//     ]);
//     return Scaffold(
//       body: Container(
//         decoration: const BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage("assets/images/splash_heritage.jpg"),
//             fit: BoxFit.cover,
//           ),
//         ),
//
//       ),
//     );
//   }
// }
