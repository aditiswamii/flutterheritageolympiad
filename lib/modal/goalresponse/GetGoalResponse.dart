import 'dart:convert';
/// status : 200
/// message : "Goal set succesfully"
/// data : {"user_id":"73","type":"daily","no":"10","updated_at":"2022-05-19T06:20:08.000000Z","created_at":"2022-05-19T06:20:08.000000Z","id":23}

GetGoalResponse getGoalResponseFromJson(String str) => GetGoalResponse.fromJson(json.decode(str));
String getGoalResponseToJson(GetGoalResponse data) => json.encode(data.toJson());
class GetGoalResponse {
  GetGoalResponse({
      int? status, 
      String? message, 
      Data? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  GetGoalResponse.fromJson(dynamic json) {
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

/// user_id : "73"
/// type : "daily"
/// no : "10"
/// updated_at : "2022-05-19T06:20:08.000000Z"
/// created_at : "2022-05-19T06:20:08.000000Z"
/// id : 23

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? userId, 
      String? type, 
      String? no, 
      String? updatedAt, 
      String? createdAt, 
      int? id,}){
    _userId = userId;
    _type = type;
    _no = no;
    _updatedAt = updatedAt;
    _createdAt = createdAt;
    _id = id;
}

  Data.fromJson(dynamic json) {
    _userId = json['user_id'];
    _type = json['type'];
    _no = json['no'];
    _updatedAt = json['updated_at'];
    _createdAt = json['created_at'];
    _id = json['id'];
  }
  String? _userId;
  String? _type;
  String? _no;
  String? _updatedAt;
  String? _createdAt;
  int? _id;

  String? get userId => _userId;
  String? get type => _type;
  String? get no => _no;
  String? get updatedAt => _updatedAt;
  String? get createdAt => _createdAt;
  int? get id => _id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = _userId;
    map['type'] = _type;
    map['no'] = _no;
    map['updated_at'] = _updatedAt;
    map['created_at'] = _createdAt;
    map['id'] = _id;
    return map;
  }

}