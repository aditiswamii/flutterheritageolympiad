

import 'dart:convert';
import 'dart:developer';
import 'package:flutterheritageolympiad/modal/SignUpModal.dart';
import 'package:flutterheritageolympiad/utils/stringconstants.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'almostthere_viewmodal.dart';

class AlmostTherePresenter {
  AlmostThereView _view;
  AlmostTherePresenter(this._view);
  void register(
      String firstname, String dob, String mobile,
      String lastname, String stateid, String cityid,
      String gender, String newsletter, String userid) async {
    try {
      Response response = await post(
          Uri.parse(StringConstants.BASE_URL+'register'),
          body: {
            'first_name':firstname,
            'dob':dob,
            'mobile':mobile,
            'last_name':lastname,
            'state_id':stateid,
            'city_id':cityid,
            'gender':gender,
            'newsletter':newsletter,
            'user_id':userid,

          }

      );
      if (response.statusCode == 200) {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('email', Data.fromJson(json).email);
        prefs.setString('lastname', Data.fromJson(json).lastName);
        prefs.setString('name', Data.fromJson(json).name);
        prefs.setString('dob', Data.fromJson(json).dob);
        prefs.setString('issocial', Data.fromJson(json).isSocial);
        prefs.setString('country', Data.fromJson(json).country.toString());
        prefs.setString('token', Data.fromJson(json).token);
        prefs.setString('username', Data.fromJson(json).username);
        prefs.setString('address', Data.fromJson(json).address);
        prefs.setString('newsletter', Data.fromJson(json).subscribeNewslater);
        prefs.setString('mobile', Data.fromJson(json).mobile);
        prefs.setString('id', Data.fromJson(json).id.toString());
        prefs.setString('appId', Data.fromJson(json).appId);
         // var data = jsonDecode(response.body.toString());
         // List jsonResponse = json.decode(response.body);
         // jsonResponse.map((data) => Data.fromJson(data)).toList();
         //jsonResponse.map((signup) => SignUpModal.fromJson(jsonDecode(response.body))).toList();
        // log(data['token']);
        // log(data.toString());
        log('User updated successfully');
        _view.onsuccess();// for Printing the token
      } else {
        log("The email or username has already been taken."); // Toast
      }
    } catch (e) {
      log(e.toString());
    }
  }
}