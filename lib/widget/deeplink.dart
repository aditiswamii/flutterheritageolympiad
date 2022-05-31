//
//
// import 'package:flutter/foundation.dart';
// import 'package:flutter/services.dart';
// import 'package:uni_links/uni_links.dart';
//
// class Deeplink with ChangeNotifier{
//   String link="";
//
//   Future<String?> initUniLinks() async {
//
//     try {
//       final initialLink = await getInitialLink();
//       notifyListeners();
//       return initialLink;
//     } on PlatformException {
//
//     }
//   }
//
// }