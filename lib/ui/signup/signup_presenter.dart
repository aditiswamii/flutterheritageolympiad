

import 'dart:convert';
import 'dart:developer';
import 'package:flutterheritageolympiad/utils/stringconstants.dart';
import 'package:http/http.dart';

import 'signup_viewmodal.dart';

class SignUpPresenter {
  SignUpView _view;
  SignUpPresenter(this._view);
  void register(
      String email, String username, String password) async {
    try {
      Response response = await post(
          Uri.parse(StringConstants.BASE_URL+'stepone'),
          body: {
            'email':email,
            'username':username,
            'password':password,
          }
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        log(data['token']);
        log(data.toString());
        log('Account Registered');
        _view.onsuccess();// for Printing the token
      } else {
        log("The email or username has already been taken."); // Toast
      }
    } catch (e) {
      log(e.toString());
    }
  }
}