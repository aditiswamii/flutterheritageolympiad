import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutterheritageolympiad/modal/Domains.dart';

import 'package:http/http.dart' as http;

import '../../utils/StringConstants.dart';



class Item extends ChangeNotifier {
  List<Domain>? databean;
  Item({String? name,
    int? id,bool? issel}) {
    _name = name!;
    _id = id!;
    _issel = issel;
  }

  int? selectedIndex; // to know active index
  String? _name;
  int? _id;
  bool? _issel;




  void updateData(List<Domain> list) {
    databean!.clear();
    databean!.addAll(list);

    notifyListeners(); // To rebuild the Widget
  }
  Domain getItem(int pos) {
  return databean!.elementAt(pos);
  }


}

