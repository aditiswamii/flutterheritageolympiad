

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
        var sobj=_model[0].name;

        log(_model.toList(growable: true).toString());
        _view.onSuccess(_model);
        return _model;
      } else {
        log("Error message!!!!"); // Toast
      }
    } catch (e) {
      log(e.toString());
    }
  }
}