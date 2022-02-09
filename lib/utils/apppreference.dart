import 'package:shared_preferences/shared_preferences.dart';

class AppPreference{
  var UserId="";
  void preference() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
     UserId = prefs.getString('username')!;
  }

  void clear()  async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('UserId');
  }
}