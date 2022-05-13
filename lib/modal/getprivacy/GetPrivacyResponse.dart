import 'dart:convert';
/// status : 200
/// message : "Privacy data"
/// data : [{"id":1,"title":"My Profile is visible to","hint":"No hint","data":[{"id":1,"title":"Anyone","is_checked":0},{"id":2,"title":"Only user i have added","is_checked":0},{"id":3,"title":"Only me","is_checked":1}]}]

GetPrivacyResponse getPrivacyResponseFromJson(String str) => GetPrivacyResponse.fromJson(json.decode(str));
String getPrivacyResponseToJson(GetPrivacyResponse data) => json.encode(data.toJson());
class GetPrivacyResponse {
  GetPrivacyResponse({
      int? status, 
      String? message, 
      List<Data>? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  GetPrivacyResponse.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  int? _status;
  String? _message;
  List<Data>? _data;

  int? get status => _status;
  String? get message => _message;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 1
/// title : "My Profile is visible to"
/// hint : "No hint"
/// data : [{"id":1,"title":"Anyone","is_checked":0},{"id":2,"title":"Only user i have added","is_checked":0},{"id":3,"title":"Only me","is_checked":1}]

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      int? id, 
      String? title, 
      String? hint, 
      List<Data1>? data1,}){
    _id = id;
    _title = title;
    _hint = hint;
    _data1 = data1;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _hint = json['hint'];
    if (json['data'] != null) {
      _data1 = [];
      json['data'].forEach((v) {
        _data1?.add(Data1.fromJson(v));
      });
    }
  }
  int? _id;
  String? _title;
  String? _hint;
  List<Data1>? _data1;

  int? get id => _id;
  String? get title => _title;
  String? get hint => _hint;
  List<Data1>? get data1 => _data1;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['hint'] = _hint;
    if (_data1 != null) {
      map['data'] = _data1?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 1
/// title : "Anyone"
/// is_checked : 0

Data1 data1FromJson(String str) => Data1.fromJson(json.decode(str));
String data1ToJson(Data data) => json.encode(data.toJson());
class Data1 {
  Data1({
      int? id, 
      String? title, 
      int? isChecked,}){
    _id = id;
    _title = title;
    _isChecked = isChecked;
}

  Data1.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _isChecked = json['is_checked'];
  }
  int? _id;
  String? _title;
  int? _isChecked;

  int? get id => _id;
  String? get title => _title;
  int? get isChecked => _isChecked;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['is_checked'] = _isChecked;
    return map;
  }

}