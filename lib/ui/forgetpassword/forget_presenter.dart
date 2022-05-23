

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutterheritageolympiad/utils/stringconstants.dart';
import 'package:http/http.dart';
import 'dart:convert' as convert;
import 'forget_viewmodal.dart';

class ForgetPasswordPresenter {
  ForgetPasswordView _view;
  ForgetPasswordPresenter(this._view);
  var snackBar;
  void forgetpassword(BuildContext context,String email) async {
    try {
      Response response = await post(
          Uri.parse(StringConstants.BASE_URL+'forgetPassword'),
          body: {
            'email':email.toString(),

          }
      );
      var jsonResponse = convert.jsonDecode(response.body);
      if (response.statusCode == 200) {
        if(jsonResponse['status'] == 200){
          // var data = jsonDecode(response.body.toString());
          // log(data['token']);
          log('Change password link has been sent to your email. Please check your email!');
          _view.forget();// for Printing the token
        }else{
          snackBar = SnackBar(
            content: Text(jsonResponse['message']),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      } else {
        log("Password link has not been sent"); // Toast
      }
    } catch (e) {
      log(e.toString());
    }
  }
}