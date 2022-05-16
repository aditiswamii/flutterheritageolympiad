import 'dart:convert';
/// status : 200
/// user_data : {"user_id":74,"name":"neoaditi","xp":6,"percentage":"16","image":"http://3.108.183.42/storage/images/rxkhZOqdfQVdavN6DcUYHtRxWYi1ZxpL2cNAtZJV.jpg"}
/// result : [{"user_id":116,"name":"Tinkerbell","xp":6,"percentage":"22","image":"http://3.108.183.42/storage/images/IhFqlvUbMEyYLAHEu96ZCjubNjwQv64E9d7XFs5k.jpg"},{"user_id":74,"name":"neoaditi","xp":6,"percentage":"16","image":"http://3.108.183.42/storage/images/rxkhZOqdfQVdavN6DcUYHtRxWYi1ZxpL2cNAtZJV.jpg"}]
/// message : "Dual data"

GetDuelResultResponse getDuelResultResponseFromJson(String str) => GetDuelResultResponse.fromJson(json.decode(str));
String getDuelResultResponseToJson(GetDuelResultResponse data) => json.encode(data.toJson());
class GetDuelResultResponse {
  GetDuelResultResponse({
      int? status, 
      UserData? userData, 
      List<Result>? result, 
      String? message,}){
    _status = status;
    _userData = userData;
    _result = result;
    _message = message;
}

  GetDuelResultResponse.fromJson(dynamic json) {
    _status = json['status'];
    _userData = json['user_data'] != null ? UserData.fromJson(json['userData']) : null;
    if (json['result'] != null) {
      _result = [];
      json['result'].forEach((v) {
        _result?.add(Result.fromJson(v));
      });
    }
    _message = json['message'];
  }
  int? _status;
  UserData? _userData;
  List<Result>? _result;
  String? _message;

  int? get status => _status;
  UserData? get userData => _userData;
  List<Result>? get result => _result;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    if (_userData != null) {
      map['user_data'] = _userData?.toJson();
    }
    if (_result != null) {
      map['result'] = _result?.map((v) => v.toJson()).toList();
    }
    map['message'] = _message;
    return map;
  }

}

/// user_id : 116
/// name : "Tinkerbell"
/// xp : 6
/// percentage : "22"
/// image : "http://3.108.183.42/storage/images/IhFqlvUbMEyYLAHEu96ZCjubNjwQv64E9d7XFs5k.jpg"

Result resultFromJson(String str) => Result.fromJson(json.decode(str));
String resultToJson(Result data) => json.encode(data.toJson());
class Result {
  Result({
      int? userId, 
      String? name, 
      int? xp, 
      String? percentage, 
      String? image,}){
    _userId = userId;
    _name = name;
    _xp = xp;
    _percentage = percentage;
    _image = image;
}

  Result.fromJson(dynamic json) {
    _userId = json['user_id'];
    _name = json['name'];
    _xp = json['xp'];
    _percentage = json['percentage'];
    _image = json['image'];
  }
  int? _userId;
  String? _name;
  int? _xp;
  String? _percentage;
  String? _image;

  int? get userId => _userId;
  String? get name => _name;
  int? get xp => _xp;
  String? get percentage => _percentage;
  String? get image => _image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = _userId;
    map['name'] = _name;
    map['xp'] = _xp;
    map['percentage'] = _percentage;
    map['image'] = _image;
    return map;
  }

}

/// user_id : 74
/// name : "neoaditi"
/// xp : 6
/// percentage : "16"
/// image : "http://3.108.183.42/storage/images/rxkhZOqdfQVdavN6DcUYHtRxWYi1ZxpL2cNAtZJV.jpg"

UserData userDataFromJson(String str) => UserData.fromJson(json.decode(str));
String userDataToJson(UserData data) => json.encode(data.toJson());
class UserData {
  UserData({
      int? userId, 
      String? name, 
      int? xp, 
      String? percentage, 
      String? image,}){
    _userId = userId;
    _name = name;
    _xp = xp;
    _percentage = percentage;
    _image = image;
}

  UserData.fromJson(dynamic json) {
    _userId = json['user_id'];
    _name = json['name'];
    _xp = json['xp'];
    _percentage = json['percentage'];
    _image = json['image'];
  }
  int? _userId;
  String? _name;
  int? _xp;
  String? _percentage;
  String? _image;

  int? get userId => _userId;
  String? get name => _name;
  int? get xp => _xp;
  String? get percentage => _percentage;
  String? get image => _image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = _userId;
    map['name'] = _name;
    map['xp'] = _xp;
    map['percentage'] = _percentage;
    map['image'] = _image;
    return map;
  }

}