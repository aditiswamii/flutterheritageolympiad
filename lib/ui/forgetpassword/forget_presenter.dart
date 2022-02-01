

import 'dart:convert';

import 'package:http/http.dart';

import 'forget_viewmodal.dart';

class ForgetPasswordPresenter {
  ForgetPasswordView _view;
  ForgetPasswordPresenter(this._view);
  // void login(String email, password) async {
  //   try {
  //     Response response = await post(
  //         Uri.parse('http://3.108.183.42/api/login'),
  //         body: {
  //           'email': 'huricane@mailsac.com',
  //           'password': 'huricane123'
  //         }
  //     );
  //
  //     if (response.statusCode == 200) {
  //       var data = jsonDecode(response.body.toString());
  //       print(data['token']);
  //       print('Login successfully');
  //       _view.onLoginSuccess();// for Printing the token
  //     } else {
  //       print("Error message like email or password wrong!!!!"); // Toast
  //     }
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }
}