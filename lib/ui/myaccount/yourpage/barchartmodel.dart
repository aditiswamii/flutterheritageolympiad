import 'dart:ui';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:CultreApp/modal/xpgainchart/GetXPGainChartResponse.dart';
class Mnth1 {
  Mnth1({
    int? xp,
    String? month,}){
    _xp = xp;
    _month = month;
  }

  Mnth1.fromJson(dynamic json) {
    _xp = json['xp'];
    _month = json['month'];
  }
  int? _xp;
  String? _month;

  int? get xp => _xp;
  String? get month => _month;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['xp'] = _xp;
    map['month'] = _month;
    return map;
  }

}