

import 'dart:convert';
import 'dart:developer';
import 'package:flutterheritageolympiad/modal/domains/Domains.dart';
import 'package:flutterheritageolympiad/utils/stringconstants.dart';
import 'package:http/http.dart';

import 'classicquiz_viewmodal.dart';

class ClassicQuizPresenter {
  ClassicQuizView _view;
  ClassicQuizPresenter(this._view);

  Future<List<Data>?> getdomains() async {
    try {
      Response response = await get(
          Uri.parse(StringConstants.BASE_URL+"domains"),
      );

      if (response.statusCode == 200) {
        List<Data> _model = DataFromJson(response.body);
        log(_model.join());
        return _model;

        // for Printing the tokenvar data= Domains.fromJson(json).data ;
        // _view.onSuccess(data);//
      } else {
        log("Error message!!!!"); // Toast
      }
    } catch (e) {
      log(e.toString());
    }
  }
}