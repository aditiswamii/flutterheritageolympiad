import 'dart:convert';
/// status : 200
/// message : "Email verified succesfully"
/// data : {"name":"","email":"tinkerbell@mailsac.com","username":"Heritage","dob":"2022-04-15","email_verified_at":"2022-04-15T06:07:52.000000Z","updated_at":"2022-04-15T06:07:52.000000Z","created_at":"2022-04-15T06:07:52.000000Z","id":126}

GetEmailVerifyResponse getEmailVerifyResponseFromJson(String str) => GetEmailVerifyResponse.fromJson(json.decode(str));
String getEmailVerifyResponseToJson(GetEmailVerifyResponse data) => json.encode(data.toJson());
class GetEmailVerifyResponse {
  GetEmailVerifyResponse({
      int? status, 
      String? message, 
      Data? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  GetEmailVerifyResponse.fromJson(dynamic json) {
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

/// name : ""
/// email : "tinkerbell@mailsac.com"
/// username : "Heritage"
/// dob : "2022-04-15"
/// email_verified_at : "2022-04-15T06:07:52.000000Z"
/// updated_at : "2022-04-15T06:07:52.000000Z"
/// created_at : "2022-04-15T06:07:52.000000Z"
/// id : 126

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? name, 
      String? email, 
      String? username, 
      String? dob, 
      String? emailVerifiedAt, 
      String? updatedAt, 
      String? createdAt, 
      int? id,}){
    _name = name;
    _email = email;
    _username = username;
    _dob = dob;
    _emailVerifiedAt = emailVerifiedAt;
    _updatedAt = updatedAt;
    _createdAt = createdAt;
    _id = id;
}

  Data.fromJson(dynamic json) {
    _name = json['name'];
    _email = json['email'];
    _username = json['username'];
    _dob = json['dob'];
    _emailVerifiedAt = json['email_verified_at'];
    _updatedAt = json['updated_at'];
    _createdAt = json['created_at'];
    _id = json['id'];
  }
  String? _name;
  String? _email;
  String? _username;
  String? _dob;
  String? _emailVerifiedAt;
  String? _updatedAt;
  String? _createdAt;
  int? _id;

  String? get name => _name;
  String? get email => _email;
  String? get username => _username;
  String? get dob => _dob;
  String? get emailVerifiedAt => _emailVerifiedAt;
  String? get updatedAt => _updatedAt;
  String? get createdAt => _createdAt;
  int? get id => _id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['email'] = _email;
    map['username'] = _username;
    map['dob'] = _dob;
    map['email_verified_at'] = _emailVerifiedAt;
    map['updated_at'] = _updatedAt;
    map['created_at'] = _createdAt;
    map['id'] = _id;
    return map;
  }

}