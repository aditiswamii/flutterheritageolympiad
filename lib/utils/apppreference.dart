import 'dart:convert';

import 'package:flutterheritageolympiad/modal/SignUpModal.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppPreference {
 late String email;
 late String lastname;
 late String name;
 late String userid;
 late String subscribenewslater;
 late String dob;
 late String country;
 late String issocial;
 late String auth_token;
 late String username;
 late String mobiles;
 late String appid;
 late String address;
 late String mobile;
  Preference(){}
    getInstance(context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
     email=prefs.setString('email', Data.fromJson(json).email) as String;
    lastname=prefs.setString('lastname', Data.fromJson(json).lastName) as String;
     name=prefs.setString('name', Data.fromJson(json).name) as String;
     dob=prefs.setString('dob', Data.fromJson(json).dob) as String;
     issocial=prefs.setString('issocial', Data.fromJson(json).isSocial) as String;
     country=prefs.setString('country', Data.fromJson(json).country.toString()) as String;
     auth_token=prefs.setString('token', Data.fromJson(json).token) as String;
     username= prefs.setString('username', Data.fromJson(json).username) as String;
     address=prefs.setString('address', Data.fromJson(json).address) as String;
     subscribenewslater=prefs.setString('newsletter', Data.fromJson(json).subscribeNewslater) as String;
     mobile=prefs.setString('mobile', Data.fromJson(json).mobile) as String;
     userid=prefs.setString('id', Data.fromJson(json).id.toString()) as String;
     appid=prefs.setString('appId', Data.fromJson(json).appId) as String;

  }

  //  clear()  async {
  //  // final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.remove('UserId');
  // }
}