

import 'dart:convert';
import 'dart:developer';
import 'package:flutterheritageolympiad/ui/myaccount/privacy/privacy_viewmodal.dart';
import 'package:flutterheritageolympiad/utils/stringconstants.dart';
import 'package:http/http.dart';

class PrivacyPresenter {
  PrivacyModal _view;
  PrivacyPresenter(this._view);
  void updateprivacy(String email, password) async {
    try {
      Response response = await post(
          Uri.parse(StringConstants.BASE_URL+'privacy'),
          body: {
            'email': email.toString(),
            'password': password.toString()
          }
      );

      if (response.statusCode == 200) {
        // var data = jsonDecode(response.body.toString());
        // log(data['token']);
        log('Login successfully');
        _view.onupdateprivacy();// for Printing the token
      } else {
        log("Error message like email or password wrong!!!!"); // Toast
      }
    } catch (e) {
      log(e.toString());
    }
  }
}