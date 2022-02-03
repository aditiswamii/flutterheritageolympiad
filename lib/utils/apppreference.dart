import 'package:shared_preferences/shared_preferences.dart';

class AppPreference{
  void preference() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
   // final String? userId = prefs.getString('username');
  }
}