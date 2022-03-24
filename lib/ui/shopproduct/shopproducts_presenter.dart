//
//
// import 'dart:convert';
// import 'dart:developer';
// import 'package:flutter/foundation.dart';
// import 'package:flutterheritageolympiad/ui/login/login_viewmodal.dart';
// import 'package:flutterheritageolympiad/ui/shopproduct/shopproducts_page.dart';
// import 'package:flutterheritageolympiad/ui/shopproduct/shopproducts_viewmodal.dart';
// import 'package:flutterheritageolympiad/utils/stringconstants.dart';
// import 'package:http/http.dart';
//
// class ShopProductsPresenter {
//   ShopProductsView _view;
//   ShopProductsPresenter(this._view);
//   // void getproduct(String userid ,searchkey) async {
//   //   try {
//   //     Response response = await get(
//   //         Uri.parse(StringConstants.BASE_URL+"get_all_products"),
//   //     );
//   //
//   //     if (response.statusCode == 200) {
//   //       var data = jsonDecode(response.body.toString());
//   //       log(data['token']);
//   //       log('Product list success');
//   //       _view.onSuccess();// for Printing the token
//   //     } else {
//   //       log("Error message!!!!"); // Toast
//   //     }
//   //   } catch (e) {
//   //     print(e.toString());
//   //   }
//   // }
// }