

import 'dart:convert';
import 'dart:developer';
import 'package:flutterheritageolympiad/utils/stringconstants.dart';
import 'package:http/http.dart';

import 'alldone_viewmodal.dart';

class AllDonePresenter {
  AllDoneView _view;
  AllDonePresenter(this._view);
  void verifyemail(
      String email, String otp, String is_social) async {
    try {
      Response response = await post(
          Uri.parse(StringConstants.BASE_URL+'email_verify'),
          body: {
            'email':email,
            'otp':otp,
            'is_social':is_social,
          }
      );
      if (response.statusCode == 200) {
        // var data = jsonDecode(response.body.toString());
        // log(data['token']);
        // log(data.toString());
        log('OTP verified successfully');
        _view.onsuccess();// for Printing the token
      } else {
        log("OTP not verified."); // Toast
      }
    } catch (e) {
      log(e.toString());
    }
  }
}