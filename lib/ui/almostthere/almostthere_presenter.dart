

import 'dart:convert';
import 'dart:developer';
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

         var data = jsonDecode(response.body.toString());
        // log(data['token']);
        // log(data.toString());
        log('User updated successfully');
        _view.onsuccess(data);// for Printing the token
      } else {
        log("The email or username has already been taken."); // Toast
      }
    } catch (e) {
      log(e.toString());
    }
  }
}