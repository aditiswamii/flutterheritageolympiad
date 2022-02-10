

import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutterheritageolympiad/modal/Product.dart';
import 'package:flutterheritageolympiad/ui/login/login_viewmodal.dart';
import 'package:flutterheritageolympiad/ui/shopproduct/product/products_viewmodal.dart';
import 'package:flutterheritageolympiad/ui/shopproduct/shopproducts_page.dart';
import 'package:flutterheritageolympiad/ui/shopproduct/shopproducts_viewmodal.dart';
import 'package:flutterheritageolympiad/utils/stringconstants.dart';
import 'package:http/http.dart';

class ProductsPresenter {
  ProductsView _view;
  ProductsPresenter(this._view);

  getproduct(String userid ,searchkey) async {
    try {
      Response response = await get(
          Uri.parse(StringConstants.BASE_URL+"get_all_products"),
      );

      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);
       jsonResponse.map((product) => Product.fromJson(product)).toList();
        log('Product list success');
        _view.onSuccess(jsonResponse);// for Printing the token
      } else {
        log("Error message!!!!"); // Toast
      }
    } catch (e) {
      log(e.toString());
    }
  }
}