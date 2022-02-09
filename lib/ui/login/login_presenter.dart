

import 'dart:convert';
import 'dart:developer';
import 'package:flutterheritageolympiad/ui/login/login_viewmodal.dart';
import 'package:flutterheritageolympiad/utils/stringconstants.dart';
import 'package:http/http.dart';

class LoginScreenPresenter {
  LoginViewModal _view;
  LoginScreenPresenter(this._view);
  void login(String email, password) async {
    try {
      Response response = await post(
          Uri.parse(StringConstants.BASE_URL+'login'),
          body: {
            'email': email.toString(),
            'password': password.toString()
          }
      );

      if (response.statusCode == 200) {
        // var data = jsonDecode(response.body.toString());
        // log(data['token']);
        log('Login successfully');
        _view.onLoginSuccess();// for Printing the token
      } else {
        log("Error message like email or password wrong!!!!"); // Toast
      }
    } catch (e) {
      log(e.toString());
    }
  }
}