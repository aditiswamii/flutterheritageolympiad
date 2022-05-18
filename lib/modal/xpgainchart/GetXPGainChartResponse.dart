import 'dart:convert';
/// status : 200
/// message : "xp"
/// data : {"mnth":[{"xp":0,"month":"Jan"},{"xp":0,"month":"Feb"},{"xp":0,"month":"Mar"},{"xp":498,"month":"Apr"},{"xp":146,"month":"May"},{"xp":0,"month":"Jun"},{"xp":0,"month":"Jul"},{"xp":0,"month":"Aug"},{"xp":0,"month":"Sep"},{"xp":0,"month":"Oct"},{"xp":0,"month":"Nov"},{"xp":0,"month":"Dec"}],"totalxp":644,"max":498,"totalquiz":50}

GetXpGainChartResponse getXpGainChartResponseFromJson(String str) => GetXpGainChartResponse.fromJson(json.decode(str));
String getXpGainChartResponseToJson(GetXpGainChartResponse data) => json.encode(data.toJson());
class GetXpGainChartResponse {
  GetXpGainChartResponse({
      int? status, 
      String? message, 
      Data? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  GetXpGainChartResponse.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  int? _status;
  String? _message;
  Data? _data;

  int? get status => _status;
  String? get message => _message;
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}

/// mnth : [{"xp":0,"month":"Jan"},{"xp":0,"month":"Feb"},{"xp":0,"month":"Mar"},{"xp":498,"month":"Apr"},{"xp":146,"month":"May"},{"xp":0,"month":"Jun"},{"xp":0,"month":"Jul"},{"xp":0,"month":"Aug"},{"xp":0,"month":"Sep"},{"xp":0,"month":"Oct"},{"xp":0,"month":"Nov"},{"xp":0,"month":"Dec"}]
/// totalxp : 644
/// max : 498
/// totalquiz : 50

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      List<Mnth>? mnth, 
      int? totalxp, 
      int? max, 
      int? totalquiz,}){
    _mnth = mnth;
    _totalxp = totalxp;
    _max = max;
    _totalquiz = totalquiz;
}

  Data.fromJson(dynamic json) {
    if (json['mnth'] != null) {
      _mnth = [];
      json['mnth'].forEach((v) {
        _mnth?.add(Mnth.fromJson(v));
      });
    }
    _totalxp = json['totalxp'];
    _max = json['max'];
    _totalquiz = json['totalquiz'];
  }
  List<Mnth>? _mnth;
  int? _totalxp;
  int? _max;
  int? _totalquiz;

  List<Mnth>? get mnth => _mnth;
  int? get totalxp => _totalxp;
  int? get max => _max;
  int? get totalquiz => _totalquiz;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_mnth != null) {
      map['mnth'] = _mnth?.map((v) => v.toJson()).toList();
    }
    map['totalxp'] = _totalxp;
    map['max'] = _max;
    map['totalquiz'] = _totalquiz;
    return map;
  }

}

/// xp : 0
/// month : "Jan"

Mnth mnthFromJson(String str) => Mnth.fromJson(json.decode(str));
String mnthToJson(Mnth data) => json.encode(data.toJson());
class Mnth {
  Mnth({
      int? xp, 
      String? month,}){
    _xp = xp;
    _month = month;
}

  Mnth.fromJson(dynamic json) {
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