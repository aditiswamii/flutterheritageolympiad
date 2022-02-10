

import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutterheritageolympiad/modal/Product.dart';
import 'package:flutterheritageolympiad/modal/SignUpModal.dart';
import 'package:flutterheritageolympiad/ui/login/login_viewmodal.dart';
import 'package:flutterheritageolympiad/ui/shopproduct/product/products_viewmodal.dart';
import 'package:flutterheritageolympiad/ui/shopproduct/shopproducts_page.dart';
import 'package:flutterheritageolympiad/ui/shopproduct/shopproducts_viewmodal.dart';
import 'package:flutterheritageolympiad/utils/stringconstants.dart';
import 'package:http/http.dart';

import 'classicquizrule_viewmodal.dart';

class ClassicQuizRulePresenter {
  ClassicQuizRuleView _view;
  ClassicQuizRulePresenter(this._view);

  getquizrule(String quiz_type ,quiz_speed) async {
    try {
      Response response = await get(
          Uri.parse(StringConstants.BASE_URL+"quiz_rules"),
      );

      if (response.statusCode == 200) {
       // // Data.fromJson(json)
       //  List jsonResponse = json.decode(response.body);
       // jsonResponse.map((product) => Product.fromJson(product)).toList();
       //  log('Product list success');
       //  _view.onSuccess(jsonResponse);// for Printing the token
      } else {
        log("Error message!!!!"); // Toast
      }
    } catch (e) {
      log(e.toString());
    }
  }
}