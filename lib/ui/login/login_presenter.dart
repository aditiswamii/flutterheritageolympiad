

import 'dart:convert';
import 'dart:developer';
import 'package:flutterheritageolympiad/ui/login/login_viewmodal.dart';
import 'package:flutterheritageolympiad/utils/stringconstants.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../modal/login/LoginResponse.dart';

class LoginScreenPresenter {
  var data;
  LoginViewModal _view;
  LoginScreenPresenter(this._view);
   login(String email, password) async {
    try {
      Response response = await post(
          Uri.parse(StringConstants.BASE_URL+'login'),
          body: {
            'email': email.toString(),
            'password': password.toString()
          }
      );

      if (response.statusCode == 200) {
        data=response.body;
        final SharedPreferences prefs = await SharedPreferences.getInstance();

          prefs.setString(
              'userid', jsonDecode(data!)['data']['id'].toString());
          prefs.setString(
              'email', jsonDecode(data!)['data']['email'].toString());
          prefs.setString('lastname',
              loginResponseFromJson(data!).data.lastName.toString());
          prefs.setString(
              'name', jsonDecode(data!)['data']['name'].toString());
          prefs.setString(
              'dob', loginResponseFromJson(data!).data.dob.toString());
          prefs.setString('issocial',
              loginResponseFromJson(data!).data.isSocial.toString());
          prefs.setString('country',
              loginResponseFromJson(data!).data.country.name.toString());
          prefs.setString(
              'token', loginResponseFromJson(data!).data.token.toString());
          prefs.setString('username',
              loginResponseFromJson(data!).data.username.toString());
          prefs.setString(
              'address', loginResponseFromJson(data!).data.address.toString());
          prefs.setString('newsletter',
              loginResponseFromJson(data!).data.subscribeNewslater.toString());
          prefs.setString(
              'mobile', loginResponseFromJson(data!).data.mobile.toString());
          prefs.setString(
              'appId', loginResponseFromJson(data!).data.appId.toString());

          log('Login successfully');
          _view.onLoginSuccess(
              jsonDecode(data!)['data']); // for Printing the token

      } else {
        log("Error message like email or password wrong!!!!"); // Toast
      }
    } catch (e) {
      log(e.toString());
    }
  }
}